import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../app_test.dart';

class BookmarkRobot {
  final WidgetTester tester;
  BookmarkRobot({required this.tester});

  // Verify bookmark page is shown
  Future<void> verifyBookmarkPageIsShown() async {
    tester.printToConsole('Verify bookmark page is shown');

    final bookmarkPageFinder = find.widgetWithText(AppBar, "Bookmark");
    expect(bookmarkPageFinder, findsOneWidget);
  }

  // Verify bookmark list item is shown
  Future<void> verifyBookmarkListItemIsShown(String word) async {
    tester.printToConsole('Verify bookmark list item is shown');
    await addDelay(3000);
    await tester.pumpAndSettle();

    final bookmarkListItemFinder = find.text(word);
    await tester.ensureVisible(bookmarkListItemFinder);
    expect(bookmarkListItemFinder, findsOneWidget);
  }

  // Verify bookmark list item by index is shown
  Future<void> verifyBookmarkListItemByIndexIsShown(int index) async {
    tester.printToConsole('Verify bookmark list item by index is shown');
    await addDelay(3000);
    await tester.pumpAndSettle();

    final bookmarkListItemFinder = find.byKey(Key('slidable_$index'));
    await tester.ensureVisible(bookmarkListItemFinder);
    expect(bookmarkListItemFinder, findsOneWidget);
  }

  // Tap on bookmark button on bottom navigation bar
  Future<void> tapOnBookmarkButtonOnBtnNavBar() async {
    tester.printToConsole('Tap on bookmark button on bottom navigation bar');

    final salomonBtnBar = find.byType(SalomonBottomBar);
    expect(salomonBtnBar, findsOneWidget);

    final bookmarkPageFinder = find.byKey(const Key("bookmarkPage"));
    await tester.ensureVisible(bookmarkPageFinder);
    await tester.tap(bookmarkPageFinder, warnIfMissed: false);

    await tester.pumpAndSettle();
  }

  // Scroll bookmark list item to right or left
  Future<void> scrollBookmarkListItemToRightOrLeft({
    bool isSwipeLeft = false,
    int index = 0,
  }) async {
    final slidableFinder = find.byKey(Key("slidable_$index"));
    expect(slidableFinder, findsOneWidget);

    if (isSwipeLeft) {
      tester.printToConsole('Scroll bookmark list item to left');

      await tester.fling(slidableFinder, const Offset(50.0, 0.0), 500.0);
    } else {
      tester.printToConsole('Scroll bookmark list item to right');

      await tester.fling(slidableFinder, const Offset(-50.0, 0.0), 500.0);
    }

    await tester.pump(const Duration(seconds: 2));
  }

  // Scroll back bookmark list item to right or left
  Future<void> scrollBackBookmarkListItemToRightOrLeft({
    bool isSwipeLeft = false,
    int index = 0,
  }) async {
    final slidableFinder = find.byKey(Key("slidable_$index"));
    expect(slidableFinder, findsOneWidget);

    if (isSwipeLeft) {
      tester.printToConsole('Scroll back bookmark list item to left');

      await tester.fling(slidableFinder, const Offset(-50.0, 0.0), 500.0);
    } else {
      tester.printToConsole('Scroll back bookmark list item to right');

      await tester.fling(slidableFinder, const Offset(50.0, 0.0), 500.0);
    }

    await tester.pump(const Duration(seconds: 2));
  }

  // Tap on trash icon on bookmark list item to delete bookmark
  Future<void> tapOnTrashIconOnBookmarkListItemToDeleteBookmark({
    required int index,
  }) async {
    tester.printToConsole(
        'Tap on trash icon on bookmark list item to delete bookmark');

    final trashIconFinder = find.byKey(Key("slidable_action_$index"));
    expect(trashIconFinder, findsOneWidget);
    await tester.tap(trashIconFinder);

    await tester.pumpAndSettle();
  }

  // Tap Delete button on dialog to delete bookmark
  Future<void> tapDeleteButtonOnDialogToDeleteBookmark() async {
    tester.printToConsole('Tap Delete button on dialog to delete bookmark');

    final deleteButtonFinder = find.widgetWithText(TextButton, "Delete");
    await tester.ensureVisible(deleteButtonFinder);
    await tester.tap(deleteButtonFinder);

    await tester.pumpAndSettle();
  }

  // Tap Cancel button on dialog to cancel delete bookmark
  Future<void> tapCancelButtonOnDialogToCancelDeleteBookmark() async {
    tester.printToConsole(
        'Tap Cancel button on dialog to cancel delete bookmark');

    final cancelButtonFinder = find.widgetWithText(TextButton, "Cancel");
    await tester.ensureVisible(cancelButtonFinder);
    await tester.tap(cancelButtonFinder);

    await tester.pumpAndSettle();
  }

  // Verify bookmark list item is empty
  Future<void> verifyBookmarkListItemIsEmpty() async {
    tester.printToConsole('Verify bookmark list item is empty');

    final bookmarkListItemFinder = find.byKey(const Key('empty_bookmark'));
    expect(bookmarkListItemFinder, findsOneWidget);
  }

  // Verify bookmark page is shown no logged in screen
  Future<void> verifyBookmarkPageIsShownNoLoggedInState() async {
    tester.printToConsole('Verify bookmark page is shown no logged in state');

    final bookmarkPageFinder = find.widgetWithText(AppBar, "Bookmark");
    expect(bookmarkPageFinder, findsOneWidget);

    final noLoggedInScreenFinder = find.byKey(const Key('noLoggedInScreen'));
    expect(noLoggedInScreenFinder, findsOneWidget);
  }

  // tap on trash icon on app bar to delete all bookmark
  Future<void> tapOnTrashIconOnAppBarToDeleteAllBookmark() async {
    tester
        .printToConsole('Tap on trash icon on app bar to delete all bookmark');

    final trashIconFinder = find.byKey(const Key('delete_all_bookmark'));
    await tester.ensureVisible(trashIconFinder);
    await tester.tap(trashIconFinder);

    await tester.pumpAndSettle();
  }
}
