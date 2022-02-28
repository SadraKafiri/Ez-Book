import 'package:flutter/material.dart';
import 'package:ez_book/src/models/books.dart';
import 'package:ez_book/src/pages/read/read.dart';
import 'package:ez_book/src/settings/settings_controller.dart';
import 'package:readmore/readmore.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(
      {Key? key, required this.books, required this.settingsController})
      : super(key: key);
  final Books books;
  final SettingsController settingsController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/images/detail_bg.png',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  10, MediaQuery.of(context).padding.top, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey[900],
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.white,
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                      ),
                      iconSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: books,
                          child: Image.asset(
                            'assets/images/' + books.imgUrl.toString(),
                            fit: BoxFit.cover,
                            width: 150,
                            height: 220,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      books.name.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      books.auther.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          books.score.toString() + '(${books.review})',
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          numberFormat(int.parse(books.view.toString())) +
                              " Read",
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: books.type!
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Chip(
                                  label: Text(e),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    ReadMoreText(
                      books.desc.toString(),
                      trimLines: 5,
                      textAlign: TextAlign.justify,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      style: const TextStyle(color: Colors.grey),
                      moreStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      lessStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildEvelatedButton(
                            Icons.add, "Add To Library", Colors.grey.shade800,
                            () {
                          print("Add To Library.");
                        }),
                        const SizedBox(
                          width: 15,
                        ),
                        _buildEvelatedButton(Icons.menu_book, "Read Now",
                            const Color(0xFF6741FF), () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReadPage(
                                    books: books,
                                    settingsController: settingsController,
                                  )));
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
}

String numberFormat(int n) {
  String num = n.toString();
  int len = num.length;

  if (n >= 1000 && n < 1000000) {
    return num.substring(0, len - 3) +
        '.' +
        num.substring(len - 3, 1 + (len - 3)) +
        'k';
  } else if (n >= 1000000 && n < 1000000000) {
    return num.substring(0, len - 6) +
        '.' +
        num.substring(len - 6, 1 + (len - 6)) +
        'm';
  } else if (n > 1000000000) {
    return num.substring(0, len - 9) +
        '.' +
        num.substring(len - 9, 1 + (len - 9)) +
        'b';
  } else {
    return num.toString();
  }
}
