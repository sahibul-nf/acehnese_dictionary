import 'package:flutter_test/flutter_test.dart';

class SplashScreenRobot {
  final WidgetTester tester;

  SplashScreenRobot({required this.tester});

  Future<void> verifySplashScreenIsShown() async {
    tester.printToConsole('Splase screen opens');
    await tester.pump(const Duration(seconds: 3));

    final acehneseFinder = find.text("Acehnese");
    final dictionaryFinder = find.text("Dictionary");

    await tester.ensureVisible(acehneseFinder);
    await tester.ensureVisible(dictionaryFinder);

    expect(acehneseFinder, findsOneWidget);
    expect(dictionaryFinder, findsOneWidget);

    await tester.pumpAndSettle();
  }
}
