import 'package:flutter/material.dart';
import 'package:ez_book/src/models/books.dart';
import 'package:ez_book/src/pages/detail/detail.dart';
import 'package:ez_book/src/pages/home/widget/category_title.dart';
import 'package:ez_book/src/settings/settings_controller.dart';

class TrendingMovies extends StatelessWidget {
  TrendingMovies({Key? key, required this.settingsController})
      : super(key: key);
  final List<Books> moviesTrendingList = Books.generateItemsList();
  final SettingsController settingsController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategoryTitle(title: "Trending Books"),
        ListView.separated(
          padding: const EdgeInsets.all(20),
          primary: false,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: moviesTrendingList.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    settingsController: settingsController,
                    books: moviesTrendingList[index],
                  ),
                ),
              ),
              child: SizedBox(
                height: 120,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Hero(
                        tag: moviesTrendingList[index],
                        child: Image.asset(
                          'assets/images/' +
                              moviesTrendingList[index].imgUrl.toString(),
                          fit: BoxFit.cover,
                          width: 90,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            moviesTrendingList[index].name.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            moviesTrendingList[index].desc.toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            moviesTrendingList[index].type!.join(", "),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
