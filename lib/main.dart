import 'package:flutter/material.dart';
import 'package:flutter_application_2/newScreen.dart';
import 'package:flutter_application_2/third.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => Home(), '/second': (context) => NextScreen(), '/third': (context) => Third()},
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String lan = "";
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initialized();
  }

  Future<void> initialized() async {
    final pref = await SharedPreferences.getInstance();
    String savedLang = pref.getString("language") ?? "en";

    List<String> langList = appLocalization.getLanguages();
    selectedIndex = langList.indexOf(savedLang);
    print("selectedIndex: $selectedIndex");

    setState(() {
      appLocalization.changeLanguage(savedLang);
      lan = appLocalization.translate("language");
    });
  }

  Future<void> saveLanguage(String langCode) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("language", langCode);
  }

  @override
  Widget build(BuildContext context) {
    List<String> languages = appLocalization.getLanguages();

    return Scaffold(
      appBar: AppBar(title: Text(appLocalization.translate("welcome"))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appLocalization.translate("welcome"),
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 20),

            DropdownButton<int>(
              value: selectedIndex,
              items: List.generate(languages.length, (index) {
                return DropdownMenuItem(
                  value: index,
                  child: Text(
                    appLocalization.languageNames[languages[index]].toString(),
                  ), // single language string
                );
              }),

              onChanged: (value) {
                if (value != null) {
                  print(languages);
                  setState(() {
                    selectedIndex = value;

                    String selectedLang = languages[value];

                    appLocalization.changeLanguage(selectedLang);
                    saveLanguage(selectedLang);

                    lan = appLocalization.translate("language");
                  });
                }
              },
            ),

            const SizedBox(height: 30),

            Text(
              lan,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/second");
              },
              child: Text("next"),
            ),
          ],
        ),
      ),
    );
  }
}
