// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final List<String> _languages = <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'nl',
    'pt'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences'),
        actions: <Widget>[
          FutureBuilder<String>(
              // get the languageCode, saved in the preferences
              future: SharedPreferencesHelper.getLanguageCode(),
              initialData: 'en',
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return snapshot.hasData
                    ? _buildFlag(snapshot.data!)
                    : Container();
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: _languages.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: _buildFlag(_languages[index]),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () async {
                // Save the user preference
                await SharedPreferencesHelper.setLanguageCode(
                    _languages[index]);
                // Refresh
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }

  // Returns the flag that corresponds to the languageCode
  // Flags are assets, added to the application
  Widget _buildFlag(String languageCode) {
    return Text(languageCode);
  }
}

class SharedPreferencesHelper {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static const String _kLanguageCode = "language";

  /// ------------------------------------------------------------
  /// Method that returns the user language code, 'en' if not set
  /// ------------------------------------------------------------
  static Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kLanguageCode) ?? 'en';
  }

  /// ----------------------------------------------------------
  /// Method that saves the user language code
  /// ----------------------------------------------------------
  static Future<bool> setLanguageCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kLanguageCode, value);
  }
}
