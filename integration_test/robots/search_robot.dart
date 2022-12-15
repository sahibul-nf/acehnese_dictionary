import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class SearchRobot {
  final WidgetTester tester;
  SearchRobot({required this.tester});

  // tap on search icon to navigate to search page
  Future<void> tapOnSearchIcon() async {
    tester.printToConsole('Tap on search icon to navigate to search page');
    tester.printToConsole('Search Page opens');

    final searchIconFinder = find.byKey(const Key('searchPage'));
    await tester.ensureVisible(searchIconFinder);
    await tester.tap(searchIconFinder, warnIfMissed: false);

    await tester.pumpAndSettle();
  }

  Future<void> searchWord(String word) async {
    tester.printToConsole('Search word: $word');

    final searchFieldFinder = find.byKey(const Key('search_field'));
    await tester.ensureVisible(searchFieldFinder);
    await tester.enterText(searchFieldFinder, word);

    await tester.pumpAndSettle();
  }

  // tap on search result to navigate to detail page
  Future<void> tapOnSearchResult(String word) async {
    tester.printToConsole('Tap on search result: $word');

    final searchResultFinder = find.text(word);
    await tester.ensureVisible(searchResultFinder);
    await tester.tap(searchResultFinder, warnIfMissed: false);

    await tester.pumpAndSettle();
  }
}
