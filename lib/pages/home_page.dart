// Importerar Flutter Material-paketet som innehåller alla UI-komponenter
import 'package:flutter/material.dart';
// Importerar SharedPreferences-paketet för lokal lagring (spara/hämta data)
import 'package:shared_preferences/shared_preferences.dart';

// Första sidan i appen, där användaren kan skriva sitt namn och acceptera villkor
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(); // Kopplar widgeten till dess state
}

// State-klassen innehåller logiken och gränssnittet för HomePage
class _HomePageState extends State<HomePage> {
  // Controller för textfältet, gör att vi kan läsa och skriva text
  TextEditingController _controller = TextEditingController();
  // Boolean som håller koll på om användaren har kryssat i checkboxen
  bool _acceptTerms = false;

  @override
  void initState() {
    super.initState();
    _loadData(); // När sidan laddas första gången: hämta sparad data
  }

  // Ladda sparad data från SharedPreferences
  void _loadData() async {
    final prefs = await SharedPreferences.getInstance(); // Öppna instansen
    setState(() {
      _controller.text = prefs.getString('username') ?? ''; // Ladda namn eller tomt
      _acceptTerms = prefs.getBool('acceptTerms') ?? false; // Ladda checkbox eller false
    });
  }

  // Spara data i SharedPreferences
  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _controller.text); // Spara texten
    await prefs.setBool('acceptTerms', _acceptTerms); // Spara checkboxen
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold = grundlayout för sidan (appbar + body)
    return Scaffold(
      appBar: AppBar(title: Text("Hem")), // AppBar med titeln "Hem"
      body: SingleChildScrollView( // ✅ Gör sidan scrollbar om innehållet blir för stort
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Ger luft runt allt innehåll
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Centrera horisontellt
            children: [
              // En bild som visas från projektets assets-mapp
              Center(
                child: Image.asset("assets/icon.png", height: 100),
              ),

              SizedBox(height: 20), // Skapar avstånd

              // Textfält där användaren kan skriva sitt namn
              TextFormField(
                controller: _controller, // Kopplar till vår textcontroller
                decoration: InputDecoration(labelText: "Skriv ditt namn"), // Ledtext
                onChanged: (value) => _saveData(), // Sparar när texten ändras
              ),

              SizedBox(height: 20),

              // Checkbox + text på samma rad
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms, // Nuvarande värde (true/false)
                    onChanged: (val) { // Körs när användaren klickar
                      setState(() => _acceptTerms = val!); // Uppdatera state
                      _saveData(); // Spara värdet
                    },
                  ),
                  // Expanded gör att texten tar upp resten av utrymmet på raden
                  Expanded(child: Text("Jag accepterar villkoren")),
                ],
              ),

              SizedBox(height: 20),

              // En knapp som leder vidare till ProfilePage
              ElevatedButton(
                onPressed: () {
                  _saveData(); // Spara datan innan man byter sida
                  Navigator.pushNamed(context, '/profile'); // Byt sida med Navigator
                },
                child: Text("Gå till profil"), // Texten på knappen
              ),
            ],
          ),
        ),
      ),
    );
  }
}
