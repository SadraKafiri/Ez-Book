import 'package:flutter/material.dart';
import 'package:ez_book/src/settings/settings_controller.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.settingsController})
      : super(key: key);
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                prefixIcon: const Icon(Icons.search_outlined),
                hintText: 'Search movie here..'),
          )),
          IconButton(
            onPressed: () {
              settingsController.updateThemeMode(
                  settingsController.themeMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light);
            },
            icon: Icon(settingsController.themeMode == ThemeMode.light
                ? Icons.dark_mode_rounded
                : Icons.light_mode_rounded),
          )
        ],
      ),
    );
  }
}
