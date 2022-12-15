

// void main() {
//   convenientTestMain(MyConvenientTestSlot(), () {
//     SearchRobot searchRobot;

//     group("Test no logged in user scenario", () {
//       tTestWidgets("Search word and see detail of word on detail page",
//           (t) async {
//         searchRobot = SearchRobot(tester: t.tester);

//         // Test displays the splash screen
//         // await splashScreenRobot.verifySplashScreenIsShown();

//         // Test search word "cicem" and see the detail of the word
//         await t.pump(const Duration(seconds: 2));
//         await searchRobot.searchWord("cicem");
//         await addDelay(1000);
//         await searchRobot.tapOnSearchResult("cicém");

//         // await searchRobot.verifySearchScreenIsShownUseConvenientTestDev();
//         // Test displays the search screen
//         // await searchRobot.searchWord("cicem");
//         // await searchRobot.tapOnSearchResult("cicém");

//         // Exit the app
//         await exit(t.tester);
//       });
//     });
//   });
// }

// class MyConvenientTestSlot extends ConvenientTestSlot {
//   @override
//   Future<void> appMain(AppMainExecuteMode mode) async => app.main();

//   @override
//   BuildContext? getNavContext(ConvenientTest t) {
//     return null;
//   }
// }
