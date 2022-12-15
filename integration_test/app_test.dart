import 'package:acehnese_dictionary/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/bookmark_robot.dart';
import 'robots/profile_robot.dart';
import 'robots/search_robot.dart';
import 'robots/signin_robot.dart';
import 'robots/signup_robot.dart';
import 'robots/splash_screen_robot.dart';
import 'robots/word_detail_robot.dart';
import 'robots/word_list_robot.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  SplashScreenRobot splashScreenRobot;
  SearchRobot searchRobot;
  WordDetailRobot wordDetailRobot;
  SignInRobot signInRobot;
  SignUpRobot signUpRobot;
  WordListRobot wordListRobot;
  BookmarkRobot bookmarkRobot;
  ProfileRobot profileRobot;

  group("End to End Testing - Registered user", () {
    testWidgets('Whole app', (WidgetTester tester) async {
      // Build the app and trigger a frame
      app.main();

      splashScreenRobot = SplashScreenRobot(tester: tester);
      searchRobot = SearchRobot(tester: tester);
      wordDetailRobot = WordDetailRobot(tester);
      signInRobot = SignInRobot(tester: tester);
      wordListRobot = WordListRobot(tester);
      bookmarkRobot = BookmarkRobot(tester: tester);
      profileRobot = ProfileRobot(tester: tester);

      const email = "snf1123@gmail.com";
      const password = "snf";

      // ====================== System Testing ======================
      // Display the splash screen
      await splashScreenRobot.verifySplashScreenIsShown();

      // Search word "cicem" and see the detail of the word
      await tester.pump(const Duration(seconds: 2));
      await searchRobot.searchWord("cicem");
      await addDelay(1000);
      await searchRobot.tapOnSearchResult("cicém");

      // Display the word detail page and explore the page
      await wordDetailRobot.verifyWordDetailIsShown("cicém");
      await wordDetailRobot.scrollPageViewToLeft();
      await wordDetailRobot.scrollPageViewToRight();
      await addDelay(2000);
      await wordDetailRobot.tapOnSwitchLanguageButton();
      await addDelay(2000);
      await wordDetailRobot.tapOnSwitchLanguageButton();
      await addDelay(2000);
      await wordDetailRobot.tapOnBookmarkButton();
      await addDelay(1000);
      await wordDetailRobot.tapOnLoginButton();

      // Test sign in
      await signInRobot.verifySignInIsShown();
      await signInRobot.enterEmailAndPassword(email, password);
      await signInRobot.tapOnSignInButton();
      await tester.pump(const Duration(seconds: 4));

      // Test displays the word list page
      await wordListRobot.tapOnWordListOnNavigationBar();
      await wordListRobot.verifyWordListItemByIndexIsShown(0);
      await wordListRobot.scrollThePage();
      await wordListRobot.scrollThePage(scrollUp: true);
      await wordListRobot.tapOnWordListByIndex(0);
      await wordDetailRobot.tapOnBackButton();
      await addDelay(1000);

      // Test displays the bookmarks page
      await bookmarkRobot.tapOnBookmarkButtonOnBtnNavBar();
      await bookmarkRobot.verifyBookmarkPageIsShown();
      await addDelay(3000);

      // Test displays the profile page
      await profileRobot.tapOnProfileButton();
      await profileRobot.verifyProfilePageIsShown();
      await addDelay(3000);

      // Mark the word as bookmark
      await wordListRobot.tapOnWordListOnNavigationBar();
      await wordListRobot.verifyWordListItemByIndexIsShown(0);
      await wordListRobot.tapOnWordListByIndex(0);
      await wordDetailRobot.tapOnBookmarkButton();
      await addDelay(3000);
      await wordDetailRobot.tapOnBackButton();
      await addDelay(1000);

      // Go to search page and search word and bookmark it
      await searchRobot.tapOnSearchIcon();
      await addDelay(2000);
      await searchRobot.searchWord("manook");
      await addDelay(1000);
      await searchRobot.tapOnSearchResult("manok");
      await wordDetailRobot.verifyWordDetailIsShown("manok");
      await wordDetailRobot.tapOnBookmarkButton();
      await addDelay(3000);
      await wordDetailRobot.tapOnBackButton();
      await addDelay(1000);

      await searchRobot.searchWord("rimung");
      await addDelay(2000);
      await searchRobot.tapOnSearchResult("rimueng");
      await wordDetailRobot.verifyWordDetailIsShown("rimueng");
      await wordDetailRobot.tapOnBookmarkButton();
      await addDelay(3000);
      await wordDetailRobot.tapOnBackButton();
      await addDelay(1000);

      await searchRobot.searchWord("bo apel");
      await addDelay(2000);
      await searchRobot.tapOnSearchResult("boh apel");
      await wordDetailRobot.verifyWordDetailIsShown("boh apel");
      await wordDetailRobot.tapOnBookmarkButton();
      await addDelay(3000);
      await wordDetailRobot.tapOnBackButton();
      await addDelay(1000);

      await searchRobot.searchWord("cicem");
      await addDelay(2000);
      await searchRobot.tapOnSearchResult("cicém");
      await wordDetailRobot.verifyWordDetailIsShown("cicém");
      await wordDetailRobot.tapOnBookmarkButton();
      await addDelay(3000);
      await wordDetailRobot.tapOnBackButton();
      await addDelay(1000);

      // Test remove bookmark item
      await bookmarkRobot.tapOnBookmarkButtonOnBtnNavBar();
      await bookmarkRobot.verifyBookmarkPageIsShown();
      await bookmarkRobot.verifyBookmarkListItemByIndexIsShown(0);
      await bookmarkRobot.scrollBookmarkListItemToRightOrLeft(
        isSwipeLeft: true,
        index: 1,
      );
      await bookmarkRobot.scrollBackBookmarkListItemToRightOrLeft(
        isSwipeLeft: true,
        index: 1,
      );
      await addDelay(1000);
      await bookmarkRobot.scrollBookmarkListItemToRightOrLeft();
      await addDelay(500);
      await bookmarkRobot.tapOnTrashIconOnBookmarkListItemToDeleteBookmark(
        index: 0,
      );
      await bookmarkRobot.tapDeleteButtonOnDialogToDeleteBookmark();
      await addDelay(3000);

      // Test remove all bookmark items
      await bookmarkRobot.tapOnTrashIconOnAppBarToDeleteAllBookmark();
      await bookmarkRobot.tapDeleteButtonOnDialogToDeleteBookmark();
      await addDelay(3000);
      await bookmarkRobot.verifyBookmarkListItemIsEmpty();
      await addDelay(2000);

      // Test sign out
      await profileRobot.tapOnProfileButton();
      await profileRobot.verifyProfilePageIsShown();
      await profileRobot.tapOnSignOutButton();
      await addDelay(3000);

      // Verify bookmark page is shown no logged in state
      await bookmarkRobot.tapOnBookmarkButtonOnBtnNavBar();
      await bookmarkRobot.verifyBookmarkPageIsShown();
      await bookmarkRobot.verifyBookmarkPageIsShownNoLoggedInState();
      await addDelay(3000);

      // Verify profile page is shown no logged in state
      await profileRobot.tapOnProfileButton();
      await profileRobot.verifyProfilePageIsShown();
      await profileRobot.verifyProfilePageIsShownNotLoggedInState();
      await addDelay(3000);

      // Delay for 3 seconds before exit
      await exit(tester);
    });
  });

  group("End to end test - Unregistered user", () {
    testWidgets("Whole app", (tester) async {
      // Build the app and trigger a frame
      app.main();

      splashScreenRobot = SplashScreenRobot(tester: tester);
      searchRobot = SearchRobot(tester: tester);
      wordDetailRobot = WordDetailRobot(tester);
      signInRobot = SignInRobot(tester: tester);
      signUpRobot = SignUpRobot(tester: tester);
      wordListRobot = WordListRobot(tester);
      bookmarkRobot = BookmarkRobot(tester: tester);
      profileRobot = ProfileRobot(tester: tester);

      const name = "Sahibul";
      const email = "snf@gmail.com";
      const password = "snf";

      // ====================== System Testing ======================
      // Test displays the splash screen
      await splashScreenRobot.verifySplashScreenIsShown();

      // Test search word "cicem" and see the detail of the word
      await tester.pump(const Duration(seconds: 2));
      await searchRobot.searchWord("cicem");
      await addDelay(1000);
      await searchRobot.tapOnSearchResult("cicém");

      // Test displays the word detail page
      await wordDetailRobot.verifyWordDetailIsShown("cicém");
      await wordDetailRobot.scrollPageViewToLeft();
      await wordDetailRobot.scrollPageViewToRight();
      await addDelay(2000);
      await wordDetailRobot.tapOnSwitchLanguageButton();
      await addDelay(2000);
      await wordDetailRobot.tapOnSwitchLanguageButton();
      await addDelay(2000);
      await wordDetailRobot.tapOnBookmarkButton();
      await addDelay(1000);
      await wordDetailRobot.tapOnLoginButton();

      // Test sign in
      await signInRobot.verifySignInIsShown();
      await signInRobot.tapOnSignUpButton();

      // Test sign up
      await signUpRobot.verifySignUpIsShown();
      await signUpRobot.enterEmailAndPassword(name, email, password);
      await signUpRobot.tapOnSignUpButton();
      await tester.pump(const Duration(seconds: 4));

      // Test sign in
      await signInRobot.verifySignInIsShown();
      await signInRobot.enterEmailAndPassword(email, password);
      await signInRobot.tapOnSignInButton();

      await tester.pump(const Duration(seconds: 4));

      // Test displays the word list page
      await wordListRobot.tapOnWordListOnNavigationBar();
      await wordListRobot.verifyWordListItemIsShown("'ap");
      await wordListRobot.scrollThePage();
      await wordListRobot.scrollThePage(scrollUp: true);
      await wordListRobot.tapOnWordList("'ap");
      await wordDetailRobot.tapOnBackButton();
      await addDelay(1000);

      // Test displays the bookmarks page
      await bookmarkRobot.tapOnBookmarkButtonOnBtnNavBar();
      await bookmarkRobot.verifyBookmarkPageIsShown();
      await bookmarkRobot.verifyBookmarkListItemIsEmpty();
      await addDelay(3000);

      // Test mark a word as bookmark on word detail page
      await wordListRobot.tapOnWordListOnNavigationBar();
      await wordListRobot.verifyWordListItemIsShown("'ap");
      await wordListRobot.tapOnWordList("'ap");
      await wordDetailRobot.tapOnBookmarkButton();
      await addDelay(3000);
      await wordDetailRobot.tapOnBackButton();
      await addDelay(1000);

      // Verify marked word is shown on bookmark page
      await bookmarkRobot.tapOnBookmarkButtonOnBtnNavBar();
      await bookmarkRobot.verifyBookmarkPageIsShown();
      await bookmarkRobot.verifyBookmarkListItemIsShown("'ap");
      await addDelay(1000);
      await bookmarkRobot.scrollBookmarkListItemToRightOrLeft();
      await bookmarkRobot.scrollBackBookmarkListItemToRightOrLeft();
      await addDelay(800);

      // Test displays the profile page
      await profileRobot.tapOnProfileButton();
      await profileRobot.verifyProfilePageIsShown();
      await addDelay(3000);

      // Test sign out
      await profileRobot.tapOnProfileButton();
      await profileRobot.verifyProfilePageIsShown();
      await profileRobot.tapOnSignOutButton();
      await addDelay(3000);

      // Verify bookmark page is shown no logged in state
      await bookmarkRobot.tapOnBookmarkButtonOnBtnNavBar();
      await bookmarkRobot.verifyBookmarkPageIsShown();
      await bookmarkRobot.verifyBookmarkPageIsShownNoLoggedInState();
      await addDelay(3000);

      // Verify profile page is shown no logged in state
      await profileRobot.tapOnProfileButton();
      await profileRobot.verifyProfilePageIsShown();
      await profileRobot.verifyProfilePageIsShownNotLoggedInState();
      await addDelay(3000);

      // Delay for 3 seconds before exit
      await exit(tester);
    });
  });
}

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

Future<void> exit(WidgetTester tester) async {
  tester.printToConsole("==================================");
  tester.printToConsole("All test passed");
  tester.printToConsole("==================================");
  tester.printToConsole("Exit in 3 seconds");
  await addDelay(3000);
}
