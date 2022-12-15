import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../app_test.dart';

class WordListRobot {
  final WidgetTester tester;
  WordListRobot(this.tester);

  // verify word list item is shown
  Future<void> verifyWordListItemIsShown(String word) async {
    tester.printToConsole('Verify word list item is shown: $word');
    await addDelay(5000);
    await tester.pumpAndSettle();

    final wordFinder = find.text(word);
    await tester.ensureVisible(wordFinder);
    expect(wordFinder, findsOneWidget);

    await tester.pumpAndSettle();
  }

  // verify word list item by index is shown
  Future<void> verifyWordListItemByIndexIsShown(int index) async {
    tester.printToConsole('Verify word list item by index is shown: $index');
    await addDelay(5000);
    await tester.pumpAndSettle();

    final wordFinder = find.byKey(Key('wordList_$index'));
    await tester.ensureVisible(wordFinder);
    expect(wordFinder, findsOneWidget);
  }

  // tap on word list to navigate to detail page
  Future<void> tapOnWordList(String word) async {
    tester.printToConsole('Tap on word list: $word');

    final wordListFinder = find.text(word);
    await tester.ensureVisible(wordListFinder);
    await tester.tap(wordListFinder);

    await tester.pumpAndSettle();
  }

  // tap on word list by index to navigate to detail page
  Future<void> tapOnWordListByIndex(int index) async {
    tester.printToConsole('Tap on word list by index: $index');

    final wordListFinder = find.byKey(Key('wordList_$index'));
    await tester.ensureVisible(wordListFinder);
    await tester.tap(wordListFinder);

    await tester.pumpAndSettle();
  }

  Future<void> scrollThePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('wordListScrollView'));
    expect(scrollViewFinder, findsOneWidget);

    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 300), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -300), 10000);
      await tester.pumpAndSettle();
    }

    sleep(const Duration(seconds: 2));
  }

  // tap word list on navigation bar to navigate to word list page
  Future<void> tapOnWordListOnNavigationBar() async {
    tester.printToConsole('Tap on word list on navigation bar');

    final salomonBtnBar = find.byType(SalomonBottomBar);
    expect(salomonBtnBar, findsOneWidget);

    final wordListFinder = find.byKey(const Key("wordListPage"));
    await tester.ensureVisible(wordListFinder);
    await tester.tap(wordListFinder, warnIfMissed: false);

    await tester.pumpAndSettle();
  }
}
