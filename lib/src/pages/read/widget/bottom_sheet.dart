import 'package:flutter/material.dart';
import 'package:ez_book/src/settings/settings_controller.dart';

class BottomSheetWidget extends StatefulWidget {
  final Function(TextStyle) onClickedConfirm;
  final Function onClickedClose;
  final Map settings;
  final SettingsController settingsController;
  const BottomSheetWidget(
      {Key? key,
      required this.onClickedClose,
      required this.onClickedConfirm,
      required this.settings,
      required this.settingsController})
      : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  double _rating = 16;
  bool isSwitched = false;
  String _dropDownValue = 'Roboto';
  String _fontFamily = 'Roboto';

  getSetting() {
    _rating = widget.settings['size'];
    isSwitched = widget.settings['theme'];
    _dropDownValue = _getFontFamilyName(widget.settings['font_name']);
    _fontFamily = _getFontFamily(widget.settings['font_name']);
  }

  @override
  void initState() {
    super.initState();
    getSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.settings,
                size: 22,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Settings",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[800],
            height: 35,
          ),
          const Text(
            "Font",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButton<String>(
                isExpanded: true,
                iconSize: 16,
                value: _dropDownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _dropDownValue = newValue!;
                    _fontFamily = _getFontFamily(newValue);
                  });
                },
                items: <String>[
                  'Roboto',
                  'Gideon Roman',
                  'Noto Serif',
                  'Redressed'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: _builditemText(value));
                }).toList()),
          ),
          const Text(
            "Font size",
            textAlign: TextAlign.center,
          ),
          Slider(
            value: _rating,
            onChanged: (newRating) {
              setState(() {
                _rating = newRating;
              });
            },
            min: 12,
            max: 32,
            divisions: 12,
            label: '${_rating.floor()}',
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[800],
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text('Dark theme'),
                const Spacer(),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      widget.settingsController.updateThemeMode(
                          widget.settingsController.themeMode == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light);
                    });
                  },
                  activeTrackColor: const Color(0xFF6741FF),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEvelatedButton(Icons.cancel, "Close", Colors.grey.shade800,
                  () => widget.onClickedClose()),
              const SizedBox(
                width: 15,
              ),
              _buildEvelatedButton(
                  Icons.save,
                  "Save",
                  const Color(0xFF6741FF),
                  () => widget.onClickedConfirm(TextStyle(
                      fontSize: _rating,
                      fontWeight: FontWeight.normal,
                      fontFamily: _fontFamily))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEvelatedButton(
          IconData icon, String text, Color color, Function action) =>
      SizedBox(
        height: 40,
        width: 150,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () => action(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _builditemText(String value) {
    switch (value) {
      case 'Roboto':
        return Text(
          value,
          style: const TextStyle(fontFamily: 'Roboto'),
        );
      case 'Gideon Roman':
        return Text(
          value,
          style: const TextStyle(fontFamily: 'Gideon_Roman'),
        );
      case 'Noto Serif':
        return Text(
          value,
          style: const TextStyle(fontFamily: 'Noto_Serif'),
        );
      case 'Redressed':
        return Text(
          value,
          style: const TextStyle(fontFamily: 'Redressed'),
        );

      default:
        return const Text('null');
    }
  }
}

String _getFontFamily(String fontName) {
  switch (fontName) {
    case 'Roboto':
      return 'Roboto';

    case 'Gideon Roman':
      return 'Gideon_Roman';

    case 'Noto Serif':
      return 'Noto_Serif';

    case 'Redressed':
      return 'Redressed';

    default:
      return 'Roboto';
  }
}

String _getFontFamilyName(String fontName) {
  switch (fontName) {
    case 'Roboto':
      return 'Roboto';

    case 'Gideon_Roman':
      return 'Gideon Roman';

    case 'Noto_Serif':
      return 'Noto Serif';

    case 'Redressed':
      return 'Redressed';

    default:
      return 'Roboto';
  }
}
