import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../app_test.dart';

class SignInRobot {
  final WidgetTester tester;
  SignInRobot({required this.tester});

  Future<void> verifySignInIsShown() async {
    tester.printToConsole('Sign in opens');

    final emailFinder = find.byKey(const Key("email"));
    final passwordFinder = find.byKey(const Key("password"));

    await tester.ensureVisible(emailFinder);
    await tester.ensureVisible(passwordFinder);

    expect(emailFinder, findsOneWidget);
    expect(passwordFinder, findsOneWidget);

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  // enter email and password
  Future<void> enterEmailAndPassword(String email, String password) async {
    tester.printToConsole('Enter email and password');

    final emailFinder = find.byKey(const Key("email"));
    final passwordFinder = find.byKey(const Key("password"));

    await tester.ensureVisible(emailFinder);
    await tester.ensureVisible(passwordFinder);

    await tester.enterText(emailFinder, email);
    await tester.enterText(passwordFinder, password);

    await tester.pumpAndSettle();
  }

  // tap on sign in button
  Future<void> tapOnSignInButton() async {
    tester.printToConsole('Tap on sign in button');

    final signInButtonFinder = find.text("Sign In");
    await tester.ensureVisible(signInButtonFinder);
    await tester.tap(signInButtonFinder);

    await addDelay(800);
    await tester.pumpAndSettle();
  }

  // Tap on sign up button
  Future<void> tapOnSignUpButton() async {
    tester.printToConsole('Tap on sign up button');

    final signUpButtonFinder = find.text("Sign Up");
    await tester.ensureVisible(signUpButtonFinder);
    await tester.tap(signUpButtonFinder);

    await tester.pumpAndSettle();
  }
}
