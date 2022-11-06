import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
import 'package:acehnese_dictionary/core/color.dart';
import 'package:acehnese_dictionary/core/typography.dart';
import 'package:flutter/material.dart';

import '../widgets/word_card.dart';

class WordListPage extends StatelessWidget {
  const WordListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  'Word List',
                  style: AppTypography.fontStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                floating: true,
                pinned: true,
                snap: true,
                bottom: TabBar(
                  labelColor: AppColor.primary,
                  indicatorColor: AppColor.primary,
                  unselectedLabelColor: AppColor.secondary,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2.0,
                  labelStyle: AppTypography.fontStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: 'Aceh'),
                    Tab(text: 'Indonesia'),
                    Tab(text: 'English'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              WordListBuilder(
                words: List.generate(
                  10,
                  (index) => Word(id: index, aceh: "aceh"),
                ),
                language: "Aceh",
              ),
              WordListBuilder(
                words: List.generate(
                  10,
                  (index) => Word(id: index, aceh: "aceh"),
                ),
                language: "Indonesia",
              ),
              WordListBuilder(
                words: List.generate(
                  10,
                  (index) => Word(id: index, aceh: "aceh"),
                ),
                language: "English",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WordListBuilder extends StatelessWidget {
  const WordListBuilder({Key? key, required this.words, required this.language})
      : super(key: key);
  final List<Word> words;
  final String language;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemCount: words.length,
      itemBuilder: (context, index) {
        return WordCard(
          word: words[index].aceh,
          language: language,
          imageUrl: "https://picsum.photos/200",
        );
      },
    );
  }
}
