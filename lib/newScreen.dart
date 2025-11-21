import 'package:flutter/material.dart';
import 'package:flutter_application_2/localization_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextScreen extends StatefulWidget {
  const NextScreen({super.key});

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  String lan = "Language";
  @override
  void initState() {
    initialized();
    super.initState();
  }

  Future<void> initialized() async {
    final pref = await SharedPreferences.getInstance();
    String savedLang = pref.getString("language") ?? "en";

    setState(() {
      appLocalization.changeLanguage(savedLang);
      lan = appLocalization.translate("language");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appLocalization.translate("welcome"))),
      body: Center(
        child: Column(
          children: [
            Text(lan),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/third");
              },
              child: Text("next"),
            ),
          ],
        ),
      ),
    );
  }
}
