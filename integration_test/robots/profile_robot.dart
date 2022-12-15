import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../app_test.dart';

class ProfileRobot {
  final WidgetTester tester;
  ProfileRobot({required this.tester});

  // Verify profile page is shown
  Future<void> verifyProfilePageIsShown() async {
    tester.printToConsole('Verify profile page is shown');

    final profilePageFinder = find.widgetWithText(AppBar, "Profile");
    expect(profilePageFinder, findsOneWidget);
  }

  // Tap on profile button on bottom navigation bar
  Future<void> tapOnProfileButton() async {
    tester.printToConsole('Tap on profile button on bottom navigation bar');

    final salomonBtnBar = find.byType(SalomonBottomBar);
    expect(salomonBtnBar, findsOneWidget);

    final profilePageFinder = find.byKey(const Key("profilePage"));
    await tester.ensureVisible(profilePageFinder);
    await tester.tap(profilePageFinder, warnIfMissed: false);

    await tester.pumpAndSettle();
  }

  // Tap on sign out button
  Future<void> tapOnSignOutButton() async {
    tester.printToConsole('Tap on sign out button');

    final signOutButtonFinder = find.byKey(const Key("signOutButton"));
    await tester.ensureVisible(signOutButtonFinder);
    await tester.tap(signOutButtonFinder, warnIfMissed: false);

    await addDelay(1000);
    await tester.pumpAndSettle();
  }

  // Verify profile page is shown not logged in state
  Future<void> verifyProfilePageIsShownNotLoggedInState() async {
    tester.printToConsole('Verify profile page is shown not logged in state');

    final profilePageFinder = find.widgetWithText(AppBar, "Profile");
    expect(profilePageFinder, findsOneWidget);

    final signInButtonFinder = find.byKey(const Key("noLoggedInScreen"));
    expect(signInButtonFinder, findsOneWidget);
  }
}
