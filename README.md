Big fun - GitHub / Codemagic ready Flutter project
=================================================

What is included
- App name: Big fun
- Package name: com.bigfun.app
- Keystore: android/app/upload_keystore.jks (already included)
- Key alias: bigfun
- Passwords: Bigfun@2580 (store & key password)
- assets/images/logo.png -> simple launcher/splash image
- Demo UI: lib/main.dart

How to use
1. Unzip and push to a GitHub repository.
2. On Codemagic, connect the GitHub repo and enable the workflow (codemagic.yaml).
3. Add these Secrets in Codemagic dashboard (Environment variables):
   - KEYSTORE_BASE64 : (base64 of your my-release-key.jks) OR upload keystore as secure file
   - KEYSTORE_PASSWORD : Bigfun@2580
   - KEY_PASSWORD : Bigfun@2580
   - KEYSTORE_ALIAS : bigfun
4. Optional: Replace android/app/google-services.json with your real Firebase file to enable OTP auth.
5. Trigger build on Codemagic -> you'll get signed AAB/APK.

Notes
- iOS support is scaffolded but not fully configured; you can add iOS signing later.
- This project contains demo scaffolding for OTP, voice rooms and gifting — you'll need to add your Firebase and Agora credentials for full functionality.
