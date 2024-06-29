import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('General'),
          ),
          Divider(),
          ListTile(
            title: Text('Use English'),
            trailing: Checkbox(
              value: true,  // contoh pengaturan yang sudah dipilih
              onChanged: (bool? value) {
                // kode untuk mengubah pengaturan
              },
            ),
          ),
        ],
      ),
    );
  }
}
