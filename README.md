# Flutter v3 – Crossplattform Applikation

Detta projekt är en Flutter-applikation utvecklad för att köras både på **Android** och **Web**. Syftet är att visa hur en och samma kodbas i Dart kan kompileras och användas på flera plattformar utan att behöva skrivas om.

## Funktioner
- Två sidor (`HomePage` och `ProfilePage`) som navigeras mellan med `Navigator`.
- Tre interaktiva widgets:  
  - `TextFormField` för att skriva in användarnamn  
  - `Checkbox` för att acceptera villkor  
  - `ElevatedButton` för att navigera till profilsidan  
- Bildvisning från både lokal resurs (`Image.asset`) och webben (`Image.network`).
- Data sparas med `SharedPreferences` så att användarnamn och villkorsstatus finns kvar efter omstart.  
- Anpassad appikon för Android samt favicon för webben.

## Plattformsskillnader
På **Android** kompileras Dart-koden till **native ARM/ARM64-maskinkod** med AOT (Ahead-of-Time compilation). Flutter använder sin egen grafikmotor **Skia** för att rendera UI, vilket ger en app som känns som en vanlig mobilapplikation.  
På **Web** kompileras samma kod istället till **JavaScript** med `dart2js`. UI renderas i webbläsaren med **HTML/CSS** och **CanvasKit (WebGL)**. Data lagras i webbläsarens `localStorage` istället för filsystemet som på Android.

## Bygga projektet
- **APK:** `flutter build apk` → `build/app/outputs/flutter-apk/app-release.apk`  
- **Web:** `flutter build web` → `build/web/`  

Applikationen visar därmed tydligt styrkan i Flutter: **ett gemensamt kodbibliotek för flera plattformar.**
