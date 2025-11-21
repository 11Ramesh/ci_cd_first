import 'package:flutter/material.dart';
import 'package:flutter_application_2/localization_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Third extends StatefulWidget {
  const Third({super.key});

  @override
  State<Third> createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
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
    return Scaffold(body: Center(child: Text(lan)));
  }
}
