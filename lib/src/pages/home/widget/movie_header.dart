import 'package:flutter/material.dart';
import 'package:ez_book/src/models/books.dart';
import 'package:ez_book/src/pages/detail/detail.dart';
import 'package:ez_book/src/settings/settings_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

class MovieHeader extends StatefulWidget {
  MovieHeader({Key? key, required this.settingsController}) : super(key: key);

  final List<Books> moviesHeaderList = Books.generateHeaderList();
  final SettingsController settingsController;
  @override
  State<MovieHeader> createState() => _MovieHeaderState();
}

class _MovieHeaderState extends State<MovieHeader> {
  final _pageController = PageController(viewportFraction: 1, keepPage: true);

  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < widget.moviesHeaderList.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: _size.width > 900 ? 280 : 120,
      width: double.infinity,
      child: Stack(
        children: [
          PageView(
              controller: _pageController,
              children: widget.moviesHeaderList
                  .map((e) => GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              settingsController: widget.settingsController,
                              books: e,
                            ),
                          ),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Hero(
                                    tag: e,
                                    child: Image.asset(
                                      'assets/images/' + e.imgUrl.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.black, Colors.transparent],
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.name.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    Text(
                                      e.desc.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList()),
          Positioned(
              bottom: 15,
              left: 50,
              child: SmoothPageIndicator(
                onDotClicked: (index) {
                  _pageController.animateToPage(index,
                      duration: const Duration(microseconds: 300),
                      curve: Curves.easeInOut);
                },
                controller: _pageController,
                count: widget.moviesHeaderList.length,
                effect: const ExpandingDotsEffect(
                    expansionFactor: 4,
                    dotWidth: 8,
                    dotHeight: 8,
                    spacing: 4,
                    activeDotColor: Colors.white),
              ))
        ],
      ),
    );
  }
}
