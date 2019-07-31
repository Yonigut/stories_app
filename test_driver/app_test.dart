// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Story App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final emailFinder = find.byValueKey('log-in email');
    final passwordFinder = find.byValueKey('log-in password');
    final buttonFinder = find.byValueKey('log-in button');
    final homeFinder = find.byValueKey('home');
    final userIconFinder = find.byValueKey('user icon');
    final userPageFinder = find.byValueKey('user page');
    final deleteAccountFinder = find.byValueKey('delete account button');
    final signOutFinder = find.byValueKey('sign out button');
    final logInFinder = find.byValueKey('log-in');
    final signUpPageButtonFinder = find.byValueKey('sign-up page button');
    final signUpButtonFinder = find.byValueKey('sign-up button');
    final firstNameFieldFinder = find.byValueKey('sign-up first name');
    final lastNameFieldFinder = find.byValueKey('sign-up last name');
    final usernameFieldFinder = find.byValueKey('sign-up username');
    final emailFieldFinder = find.byValueKey('sign-up email');
    final passwordFieldFinder = find.byValueKey('sign-up password');
    final confirmPasswordFieldFinder = find.byValueKey('sign-up confirm password');
    final noAccountWithEmailFinder = find.byValueKey('no account with this email');


    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Create New Account', () async {
      // tap sign-up
      await driver.tap(signUpPageButtonFinder);
      // fill out first name
      await driver.tap(firstNameFieldFinder);
      await driver.enterText('Yoni');
      // fill out last name
      await driver.tap(lastNameFieldFinder);
      await driver.enterText('Gutenmacher');
      // fill out username
      await driver.tap(usernameFieldFinder);
      await driver.enterText('yogutt');
      // fill out email
      await driver.tap(emailFieldFinder);
      await driver.enterText('yonigg98@gmail.com');
      // fill out password
      await driver.tap(passwordFieldFinder);
      await driver.enterText('Yoniguten1!');
      // fill out confirm password
      await driver.tap(confirmPasswordFieldFinder);
      await driver.enterText('Yoniguten1!');
      // tap sign up
      await driver.tap(signUpButtonFinder);
      // go into the app
      // sign out and log-in with the same account
      await driver.waitFor(homeFinder);
      await driver.tap(userIconFinder);
      await driver.waitFor(userPageFinder);
      await driver.tap(signOutFinder);
      await driver.waitFor(logInFinder);
      await driver.tap(emailFinder);
      await driver.enterText('yonigg98@gmail.com');
      await driver.waitFor(find.text('yonigg98@gmail.com'));
      await driver.tap(passwordFinder);
      await driver.enterText('Yoniguten1!');
      await driver.tap(buttonFinder);
      await driver.waitFor(homeFinder);
      // sign out again
      await driver.tap(userIconFinder);
      await driver.waitFor(userPageFinder);
      await driver.tap(signOutFinder);
      await driver.waitFor(logInFinder);
    });

    test('Log-in: valid credentials', () async {
      await driver.tap(emailFinder);
      await driver.enterText('yonigg98@gmail.com');
      await driver.waitFor(find.text('yonigg98@gmail.com'));
      await driver.tap(passwordFinder);
      await driver.enterText('Yoniguten1!');
      await driver.tap(buttonFinder);
      await driver.waitFor(homeFinder);
    });


    test('Sign-out & Log Back In Same Account', () async {
      await driver.tap(userIconFinder);
      await driver.waitFor(userPageFinder);
      await driver.tap(signOutFinder);
      await driver.waitFor(logInFinder);
      await driver.tap(emailFinder);
      await driver.enterText('yonigg98@gmail.com');
      await driver.waitFor(find.text('yonigg98@gmail.com'));
      await driver.tap(passwordFinder);
      await driver.enterText('Yoniguten1!');
      await driver.tap(buttonFinder);
      await driver.waitFor(homeFinder);
      // sign out again
      await driver.tap(userIconFinder);
      await driver.waitFor(userPageFinder);
      await driver.tap(signOutFinder);
      await driver.waitFor(logInFinder);
    });

    test('Delete Account', () async {
      //sign-in
      await driver.tap(emailFinder);
      await driver.enterText('yonigg98@gmail.com');
      await driver.waitFor(find.text('yonigg98@gmail.com'));
      await driver.tap(passwordFinder);
      await driver.enterText('Yoniguten1!');
      await driver.tap(buttonFinder);
      await driver.waitFor(homeFinder);
      // delete the account
      await driver.tap(userIconFinder);
      await driver.waitFor(userPageFinder);
      await driver.tap(deleteAccountFinder);
      // try to log-in with same account
      await driver.waitFor(logInFinder);
      await driver.tap(emailFinder);
      await driver.enterText('yonigg98@gmail.com');
      await driver.waitFor(find.text('yonigg98@gmail.com'));
      await driver.tap(passwordFinder);
      await driver.enterText('Yoniguten1!');
      await driver.tap(buttonFinder);
      await driver.waitFor(noAccountWithEmailFinder);
    });

    // delete the account and try to sign in again

    // bad case with invalid credentials


});
}