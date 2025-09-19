// Importerar Flutter Material-paketet som innehåller färdiga UI-komponenter
import 'package:flutter/material.dart';
// Importerar SharedPreferences-paketet för att kunna lagra/hämta data lokalt
import 'package:shared_preferences/shared_preferences.dart';

// En sida (screen) som visar användarens profil
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key}); // super.key används för att unikt identifiera widgeten i widget-trädet

  @override
  _ProfilePageState createState() => _ProfilePageState(); // Kopplar widgeten till dess state (logik + UI)
}

// State-klassen innehåller själva logiken och gränssnittet för ProfilePage
class _ProfilePageState extends State<ProfilePage> {
  // Variabler för att lagra användarnamn och om villkoren är accepterade
  String _username = "";
  bool _acceptTerms = false;

  @override
  void initState() {
    super.initState();
    _loadData(); // När sidan skapas första gången, ladda sparad data
  }

  // Hämta data från SharedPreferences (lokal lagring)
  void _loadData() async {
    final prefs = await SharedPreferences.getInstance(); // Öppna instansen för SharedPreferences
    setState(() {
      // Uppdatera variablerna i UI med värdena från lagringen
      _username = prefs.getString('username') ?? ''; // Om inget finns, använd tom sträng
      _acceptTerms = prefs.getBool('acceptTerms') ?? false; // Om inget finns, använd false
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold är grundlayouten för sidan (med appbar + body)
    return Scaffold(
      appBar: AppBar(title: Text("Profil")), // Appens översta fält med titeln "Profil"
      body: Center( // Centrera allt innehåll på sidan
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Lägg allt i mitten vertikalt
          children: [
            // En bild från internet (picsum används som placeholder)
            Image.network("https://picsum.photos/200", height: 100),

            SizedBox(height: 20), // Skapar lite luft (20 pixlar) mellan elementen

            // Text som visar användarnamnet som hämtats från SharedPreferences
            Text(
              "Hej, $_username", // Dynamiskt: visar användarnamnet
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10), // Lite avstånd ner till nästa text

            // Text som visar om användaren har accepterat villkoren eller inte
            Text(
              _acceptTerms
                  ? "Du har accepterat villkoren ✅"
                  : "Du har inte accepterat villkoren ❌",
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20), // Ytterligare lite luft

            // En knapp som tar användaren tillbaka till föregående sida
            TextButton(
              onPressed: () => Navigator.pop(context), // Stänger denna sida och går tillbaka
              child: Text("Tillbaka"), // Texten på knappen
            ),
          ],
        ),
      ),
    );
  }
}
