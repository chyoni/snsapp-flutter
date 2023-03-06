import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok/common/repo/common_config_repo.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/firebase_options.dart';
import 'package:tiktok/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAuth.instance.signOut();
  });

  testWidgets("Create Account Flow", (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final pref = await SharedPreferences.getInstance();
    pref.setBool("darkMode", false);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          commonConfigProvider.overrideWith(
            () => CommonConfigViewModel(
              CommonConfigRepository(pref),
            ),
          ),
        ],
        child: const TikTokApp(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text("Sign up for TikTok"), findsOneWidget);
    final login = find.text("Log in");
    expect(login, findsOneWidget);
    await tester.tap(login);
    await tester.pumpAndSettle();

    final signUp = find.text("Sign up");
    expect(signUp, findsOneWidget);
    await tester.tap(signUp);
    await tester.pumpAndSettle();
    final emailBtn = find.text("Use email & password");
    expect(emailBtn, findsOneWidget);
    await tester.tap(emailBtn);
    await tester.pumpAndSettle();

    final usernameInput = find.byType(TextField).first;
    await tester.enterText(usernameInput, "test");
    await tester.pumpAndSettle();
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    final emailInput = find.byType(TextField).first;
    await tester.enterText(emailInput, "test@testing.com");
    await tester.pumpAndSettle();
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    final passwordInput = find.byType(TextField).first;
    await tester.enterText(passwordInput, "qwer1234!@");
    await tester.pumpAndSettle();
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Next"));

    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 15));
    expect(find.text("Choose your interests"), findsOneWidget);
  });
}
