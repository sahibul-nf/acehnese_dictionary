import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WordDetailRobot {
  final WidgetTester tester;
  WordDetailRobot(this.tester);

  Future<void> verifyWordDetailIsShown(String word) async {
    tester.printToConsole('Word detail opens');
    sleep(const Duration(seconds: 3));

    final wordFinder = find.text(word);
    await tester.ensureVisible(wordFinder);
    expect(wordFinder, findsOneWidget);

    await tester.pumpAndSettle();
  }

  // scroll the page view to right or left
  Future<void> scrollPageViewToRight() async {
    tester.printToConsole('Scroll page view to right');

    final pageViewFinder = find.byKey(const Key("pageview"));
    expect(pageViewFinder, findsOneWidget);
    await tester.drag(pageViewFinder, const Offset(300.0, 0.0));

    await tester.pump(const Duration(seconds: 3));
  }

  Future<void> scrollPageViewToLeft() async {
    tester.printToConsole('Scroll page view to left');

    final pageViewFinder = find.byType(PageView);
    expect(pageViewFinder, findsOneWidget);
    await tester.drag(pageViewFinder, const Offset(-300.0, 0.0));

    await tester.pump(const Duration(seconds: 3));
  }

  // tap switch language button to change language
  Future<void> tapOnSwitchLanguageButton() async {
    tester.printToConsole('Tap on switch language button');

    final switchLanguageButtonFinder = find.byKey(const Key('switch_language_button'));
    await tester.ensureVisible(switchLanguageButtonFinder);
    await tester.tap(switchLanguageButtonFinder);

    await tester.pumpAndSettle();
  }

  // tap on bookmark button to bookmark the word or unbookmark the word
  Future<void> tapOnBookmarkButton() async {
    tester.printToConsole('Tap on bookmark button');

    final bookmarkButtonFinder = find.byKey(const Key('bookmark_button'));
    await tester.ensureVisible(bookmarkButtonFinder);
    await tester.tap(bookmarkButtonFinder);

    await tester.pumpAndSettle();
  }

  // tap on login button to navigate to login page
  Future<void> tapOnLoginButton() async {
    tester.printToConsole('Tap on login button');

    final loginButtonFinder = find.byKey(const Key('login_button'));
    await tester.ensureVisible(loginButtonFinder);
    await tester.tap(loginButtonFinder);

    await tester.pumpAndSettle();
  }

  // back to search page
  Future<void> tapOnBackButton() async {
    tester.printToConsole('Tap on back button');

    final backButtonFinder = find.byKey(const Key('back_button'));
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);

    await tester.pumpAndSettle();
  }
}
