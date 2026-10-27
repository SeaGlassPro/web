# Plan: Multi-Provider Authentication for SeaGlassPro

## Overview
Implement a multi-provider "Login" system (Google, Apple, and Microsoft) for the SeaGlassPro landing page using Firebase Authentication. This allows users to authenticate via their preferred professional or personal identity provider without requiring a custom backend, while maintaining a professional, high-end aesthetic.

## Implementation Steps

### 1. Infrastructure Setup (Manual)
- [ ] Create a project in the [Firebase Console](https://console.firebase.google.com/).
- [ ] **Enable Sign-in Methods** in "Build > Authentication":
    - [ ] **Google**: Enable and save.
    - [ ] **Microsoft**: Enable (requires Azure AD App registration).
    - [ ] **Apple**: Enable (requires paid Apple Developer Program membership and Service ID configuration).
- [ ] Register a **Web App** and copy the `firebaseConfig` object.
- [ ] **Security Configuration**: Add `seaglasspro.com` and `localhost` to the **Authorized Domains** list in Firebase settings to prevent API key misuse.

### 2. UI Modifications (`index.html`)
- [ ] **Navigation Bar**: Change the `#auth-btn` to trigger a login modal rather than a direct action.
- [ ] **Login Modal**:
    - Create a hidden, centered modal with a "frosted glass" effect (matching site aesthetic: `--mist` background, `backdrop-filter: blur(8px)`).
    - Add three branded buttons: **Continue with Google**, **Continue with Apple**, and **Continue with Microsoft**.
    - Add a "Close" button to return to the page.
- [ ] **Styling**: Use CSS variables (`--seafoam`, `--mist`) to ensure the modal feels native to the design.

### 3. Logic Implementation (`index.html`)
- [ ] **SDK Integration**: Import Firebase App and Auth modules via CDN.
- [ ] **Initialization**: Initialize Firebase using the project configuration.
- [ ] **Authentication Flow**:
    - Map each modal button to its respective `OAuthProvider` (Google, Apple, Microsoft).
    - Use `signInWithPopup()` for all three flows.
- [ ] **State Management**:
    - Implement `onAuthStateChanged` to detect active sessions.
    - Update the nav bar button to show "Welcome, [Name]" or "Logout" when authenticated.

### 4. Protected Content (`auth.html`)
- [ ] **Creation**: Create a new `auth.html` page for authenticated users.
- [ ] **Client-Side Guard**:
    - Implement a JavaScript check at the top of the `<head>` to verify the user's authentication state before the body renders.
    - Redirect unauthenticated users back to `index.html` immediately.
- [ ] **Token-Based Data**: Ensure any sensitive data displayed on this page is fetched from Firebase using the user's secure JWT, rather than hard-coded in HTML.

---

## Security Architecture

### How the connection is secured

Since the site is hosted as a static project on GitHub Pages, the connection to Firebase is secured through several layers:

#### 1. HTTPS (Transport Layer Security)
Firebase SDKs communicate exclusively via HTTPS. All data sent between the browser and Firebase servers is encrypted in transit.

#### 2. API Key Restrictions & Domain Whitelisting
The `apiKey` is a public identifier. Security is enforced via the **Authorized Domains** list in the Firebase Console. 
- Firebase checks the `Origin` header of every request.
- Requests from any domain not on the allowlist (e.g., a hacker's site) are rejected with a `403 Forbidden` error, even if they have the correct API key.

#### 3. JWT (JSON Web Tokens)
Upon login, the provider issues a cryptographically signed Identity Token (JWT).
- The token is stored securely in the browser (IndexedDB).
- It is signed by the provider's private key, making identity forgery impossible.

#### 4. The "Client-Side Guard"
Because static sites lack a server-side middleware, `auth.html` uses a JavaScript redirect guard. While the raw HTML is technically accessible to users who disable JS, the **actual data** fetched from Firebase remains secure because the Firebase backend requires a valid JWT to release any information.

---

## Cost Analysis
- **Firebase Auth**: Free for social logins (Google, Apple, Microsoft).
- **Firebase Hosting/Storage**: Free Tier is sufficient for this site's traffic.
- **Apple Developer Program**: Mandatory $99/year fee for Apple Sign-In.
- **Microsoft Azure**: Free for basic App Registration.
