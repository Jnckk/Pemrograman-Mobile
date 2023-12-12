import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/latihan/widget/login_page.dart';
// Run => flutter test test/latihan/page/login_page_test.dart

void main() {
  group('LoginPage Widget Test', () {
    testWidgets('UI components are rendered', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Verify if the widgets are rendered.
      expect(find.text('Login', skipOffstage: false), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.byType(ElevatedButton, skipOffstage: false), findsOneWidget);
      expect(find.byType(TextField, skipOffstage: false), findsNWidgets(2));
    });

    testWidgets('Login button tap triggers login logic',
        (WidgetTester tester) async {
      bool loginButtonPressed = false;

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(
            onPressed: () {
              loginButtonPressed = true;
            },
          ),
        ),
      );

      // Tap the login button and trigger login logic.
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify if the login logic is triggered.
      expect(loginButtonPressed, isTrue);
    });
  });
}
