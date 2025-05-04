# Termly Consent State – GTM Custom Variable Template (Official)

This Google Tag Manager (GTM) custom variable template retrieves user consent states from the [Termly](https://termly.io/) Consent Management Platform (CMP). It’s especially helpful when:

- Termly is installed **outside GTM** (e.g., directly in your site's code).
- You're implementing **Basic or Advanced Consent Mode**.
- You want to create **exception triggers** based on specific consent categories.

> Developed by **Jude Nwachukwu Onyejewe** for [DumbData](https://dumbdata.co/)

---

## 🛠️ How to Use This Template


## 📦 Import the Template

1. Open Google Tag Manager.
2. Go to **Templates** → **Variable Templates**.
3. Click the **New** button and select **Import**.
4. Upload the `.tpl` file for this template.

## 🎛️ Configuration Options

### 1. **Select Consent State Check Type**

Use the dropdown **“Select Consent State Check Type”** to define the behavior:

- **All Consent State Check** – Returns an object with all category consent states.
- **Specific Consent State** – Returns a single consent category value.

### 2. **Select Consent Category**

(Visible when **Specific Consent State** is selected)

Available options in **“Select Consent Category”**:

- Performance and Functionality  
- Necessary (always returns `true`)  
- Advertising  
- Analytics  
- Social Networking  
- Unclassified  

### 3. **Enable Optional Output Transformation**

Enables transformation of consent values into formats more compatible with GTM triggers.

#### Sub-options:

- **Transform "True"**: Convert `true` to:
  - `granted`
  - `accept`

- **Transform "Deny"**: Convert `false` to:
  - `denied`
  - `deny`

- **Also transform "undefined" to "denied"**: Useful for uninitialized categories.

## 🔍 How It Works

- Consent states are retrieved using `Termly.getConsentState()` via the GTM sandbox.
- When a category value is missing or undefined, it can be transformed to `"denied"` if configured.
- The `"Necessary"` category always returns `true` (or its transformed equivalent).

## 🧰 Use Cases

- Blocking or enabling tags using consent signals
- Integrating Termly with GTM-based **Consent Mode**
- Setting up GTM exceptions for advertising or analytics tags

---

> 🔐 This variable helps align your GTM deployment with Termly’s user consent signals—especially when Termly isn’t loaded through GTM.
