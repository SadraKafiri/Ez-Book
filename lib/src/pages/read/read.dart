import 'package:flutter/material.dart';
import 'package:ez_book/src/models/books.dart';
import 'package:ez_book/src/pages/read/widget/bottom_sheet.dart';
import 'package:ez_book/src/settings/settings_controller.dart';

class ReadPage extends StatefulWidget {
  const ReadPage(
      {Key? key, required this.books, required this.settingsController})
      : super(key: key);
  final SettingsController settingsController;
  final Books books;

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  bool show = false;
  TextStyle font = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Roboto');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        show == true ? show = false : show = true;
                      });
                    },
                    icon: const Icon(Icons.more_vert)),
                const SizedBox(
                  width: 12,
                ),
              ],
              floating: true,
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.books.name.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.books.auther.toString(),
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto')),
                ],
              ),
            ),
            _buildContent(context),
          ],
        ),
      ),
      bottomSheet: show == true
          ? BottomSheet(
              enableDrag: false,
              builder: (context) => BottomSheetWidget(
                settingsController: widget.settingsController,
                settings: {
                  'size': font.fontSize,
                  'theme': widget.settingsController.themeMode == ThemeMode.dark
                      ? true
                      : false,
                  'font_name': font.fontFamily,
                },
                onClickedClose: () => setState(() {
                  show = false;
                }),
                onClickedConfirm: (value) => setState(() {
                  font = value;
                  show = false;
                }),
              ),
              onClosing: () {},
            )
          : null,
    );
  }

  Widget _buildContent(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.books.content.toString(),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.justify,
              style: font,
            ),
          )
        ],
      ),
    );
  }
}
