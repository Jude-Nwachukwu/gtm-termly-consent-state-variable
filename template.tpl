___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "DD Termly Consent State (Unofficial)",
  "categories": [
    "TAG_MANAGEMENT"
  ],
  "description": "Use with the Termly CMP to identify the individual website user\u0027s consent state and configure when tags should execute.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "termlyConsentStateCheckType",
    "displayName": "Select Consent State Check Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "termlyAllConsentState",
        "displayValue": "All Consent State Check"
      },
      {
        "value": "termlySpecificConsentState",
        "displayValue": "Specific Consent State"
      }
    ],
    "simpleValueType": true,
    "help": "Select the type of consent state check you want to perform—either a specific consent category or all consent categories, based on Termly."
  },
  {
    "type": "RADIO",
    "name": "termlyConsentCategoryCheck",
    "displayName": "Select Consent Category",
    "radioItems": [
      {
        "value": "termlyPerformanceFunctional",
        "displayValue": "Performance and Functionality"
      },
      {
        "value": "termlyNecessary",
        "displayValue": "Necessary"
      },
      {
        "value": "termlyAdvertising",
        "displayValue": "Advertising"
      },
      {
        "value": "termlyAnalytics",
        "displayValue": "Analytics"
      },
      {
        "value": "termlySocialNetworking",
        "displayValue": "Social Networking"
      },
      {
        "value": "termlyUnclassified",
        "displayValue": "Unclassified"
      }
    ],
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "termlyConsentStateCheckType",
        "paramValue": "termlySpecificConsentState",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "termlyEnableOptionalConfig",
    "checkboxText": "Enable Optional Output Transformation",
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "termlyOptionalConfig",
    "displayName": "Termly Consent State Value Transformation",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SELECT",
        "name": "termlyTrue",
        "displayName": "Transform \"True\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "termlyTrueGranted",
            "displayValue": "granted"
          },
          {
            "value": "termlyTrueAccept",
            "displayValue": "accept"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "SELECT",
        "name": "termlyFalse",
        "displayName": "Transform \"False\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "termlyFalseDenied",
            "displayValue": "denied"
          },
          {
            "value": "termlyFalseDeny",
            "displayValue": "deny"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "termlyUndefined",
        "checkboxText": "Also transform \"undefined\" to \"denied\"",
        "simpleValueType": true
      }
    ],
    "enablingConditions": [
      {
        "paramName": "termlyEnableOptionalConfig",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const callInWindow = require('callInWindow');
const getType = require('getType');
const makeString = require('makeString');

const checkType = data.termlyConsentStateCheckType;
const categoryKey = data.termlyConsentCategoryCheck;
const enableTransform = data.termlyEnableOptionalConfig;
const transformTrue = data.termlyTrue;
const transformFalse = data.termlyFalse;
const transformUndefined = data.termlyUndefined;

const categoryMap = {
  termlyPerformanceFunctional: 'performance',
  termlyNecessary: 'essential',
  termlyAdvertising: 'advertising',
  termlyAnalytics: 'analytics',
  termlySocialNetworking: 'social_networking',
  termlyUnclassified: 'unclassified'
};

const categoryList = [
  'essential',
  'advertising',
  'analytics',
  'performance',
  'social_networking',
  'unclassified'
];

function transformValue(val) {
  if (!enableTransform) return val;

  if (val === true) {
    return transformTrue === 'termlyTrueGranted' ? 'granted' : 'accept';
  }

  if (val === false) {
    return transformFalse === 'termlyFalseDenied' ? 'denied' : 'deny';
  }

  if (getType(val) === 'undefined' && transformUndefined) {
    return 'denied';
  }

  return val;
}

function getConsentData() {
  return callInWindow('Termly.getConsentState');
}

const consentData = getConsentData();
if (getType(consentData) !== 'object') return undefined;

if (checkType === 'termlyAllConsentState') {
  const result = {};
  categoryList.forEach(function (key) {
    const value = getType(consentData[key]) !== 'undefined' ? consentData[key] : undefined;
    result[key] = transformValue(value);
  });
  return result;

} else if (checkType === 'termlySpecificConsentState') {
  const mappedKey = categoryMap[categoryKey];
  if (!mappedKey) return undefined;

  if (mappedKey === 'essential') {
    return transformValue(true);
  }

  const value = getType(consentData[mappedKey]) !== 'undefined' ? consentData[mappedKey] : undefined;
  return transformValue(value);
}

return undefined;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "Termly.getConsentState"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 5/20/2025, 9:42:57 AM


