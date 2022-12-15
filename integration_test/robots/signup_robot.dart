import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../app_test.dart';

class SignUpRobot {
  final WidgetTester tester;
  SignUpRobot({required this.tester});

  Future<void> verifySignUpIsShown() async {
    tester.printToConsole('Sign up opens');

    final nameFinder = find.byKey(const Key("nameTextField"));
    final emailFinder = find.byKey(const Key("emailTextField"));
    final passwordFinder = find.byKey(const Key("passwordTextField"));

    await tester.ensureVisible(nameFinder);
    await tester.ensureVisible(emailFinder);
    await tester.ensureVisible(passwordFinder);

    expect(nameFinder, findsOneWidget);
    expect(emailFinder, findsOneWidget);
    expect(passwordFinder, findsOneWidget);

    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }

  // enter name, email and password
  Future<void> enterEmailAndPassword(
      String name, String email, String password) async {
    tester.printToConsole('Enter name, email and password');

    final nameFinder = find.byKey(const Key("nameTextField"));
    final emailFinder = find.byKey(const Key("emailTextField"));
    final passwordFinder = find.byKey(const Key("passwordTextField"));

    await tester.ensureVisible(nameFinder);
    await tester.ensureVisible(emailFinder);
    await tester.ensureVisible(passwordFinder);

    await tester.enterText(nameFinder, name);
    await tester.enterText(emailFinder, email);
    await tester.enterText(passwordFinder, password);

    await tester.pumpAndSettle();
  }

  // tap on sign up button
  Future<void> tapOnSignUpButton() async {
    tester.printToConsole('Tap on sign up button');

    final signUpButtonFinder = find.text("Sign Up");
    await tester.ensureVisible(signUpButtonFinder);
    await tester.tap(signUpButtonFinder);

    await addDelay(800);
    await tester.pumpAndSettle();
  }

  // tap on sign in button
  Future<void> tapOnSignInButton() async {
    tester.printToConsole('Tap on sign in button');

    final signInButtonFinder = find.text("Sign In");
    await tester.ensureVisible(signInButtonFinder);
    await tester.tap(signInButtonFinder);

    await tester.pumpAndSettle();
  }
}
