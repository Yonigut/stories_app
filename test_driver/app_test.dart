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

    test('Log-in: valid credentials', () async {
      await driver.tap(emailFinder);
      await driver.enterText('yonigg98@gmail.com');
      await driver.waitFor(find.text('yonigg98@gmail.com'));
      await driver.tap(passwordFinder);
      await driver.enterText('Yoniguten1!');
      await driver.tap(buttonFinder);
      await driver.waitFor(homeFinder);
//      Health health = await driver.checkHealth();
//      print(health.status);
    });


    test('Sign-out', () async {
      await driver.tap(userIconFinder);
      await driver.waitFor(userPageFinder);
      await driver.tap(deleteAccountFinder);
      await.driver.
      await driver.waitFor(find.text('yonigg98@gmail.com'));
      await driver.tap(passwordFinder);
      await driver.enterText('Yoniguten1!');
      await driver.tap(buttonFinder);
      await driver.waitFor(homeFinder);
//      Health health = await driver.checkHealth();
//      print(health.status);
    });

});
}