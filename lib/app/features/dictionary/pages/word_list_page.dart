import 'package:acehnese_dictionary/app/features/dictionary/controllers/dictionary_controller.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:acehnese_dictionary/app/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../widgets/word_card.dart';

class WordListPage extends StatelessWidget {
  WordListPage({Key? key}) : super(key: key);

  final dictionaryController = Get.put(DictionaryController());

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
              Obx(() {
                return dictionaryController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : WordListBuilder(
                        words: dictionaryController.dictionaries,
                        language: "Aceh",
                      );
              }),
              Obx(() {
                return dictionaryController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : WordListBuilder(
                        words: dictionaryController.dictionaries,
                        language: "Indonesia",
                      );
              }),
              Obx(() {
                return dictionaryController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : WordListBuilder(
                        words: dictionaryController.dictionaries,
                        language: "English",
                      );
              }),
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
    // sorting by alphabet in ascending order (A-Z) based on language
    if (language == "Aceh") {
      words.sort((a, b) => a.aceh.compareTo(b.aceh));
    } else if (language == "Indonesia") {
      words.sort((a, b) => a.indonesia!.compareTo(b.indonesia!));
    } else if (language == "English") {
      words.sort((a, b) => a.english!.compareTo(b.english!));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemCount: words.length,
      itemBuilder: (context, index) {
        var word = "";
        if (language == "Aceh") {
          word = words[index].aceh;
        } else if (language == "Indonesia") {
          word = words[index].indonesia!;
        } else if (language == "English") {
          word = words[index].english!;
        }

        return WordCard(
          word: word,
          language: language,
          imageUrl: words[index].imageUrl,
        );
      },
    );
  }
}
