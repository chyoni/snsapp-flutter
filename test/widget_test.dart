import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok/common/repo/common_config_repo.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

void main() {
  group(
    "Form button tests",
    () {
      testWidgets(
        "Enabled State",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            Theme(
              data: ThemeData(primaryColor: Colors.red),
              child: const Directionality(
                textDirection: TextDirection.ltr,
                child: FormButton(disabled: false),
              ),
            ),
          );
          expect(find.text("Next"), findsOneWidget);
          expect(
            tester
                .firstWidget<AnimatedDefaultTextStyle>(
                    find.byType(AnimatedDefaultTextStyle))
                .style
                .color,
            Colors.white,
          );
          expect(
            (tester
                    .firstWidget<AnimatedContainer>(
                        find.byType(AnimatedContainer))
                    .decoration as BoxDecoration)
                .color,
            Colors.red,
          );
        },
      );

      testWidgets(
        "Disabled State",
        (WidgetTester tester) async {
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
              child: const Directionality(
                textDirection: TextDirection.ltr,
                child: FormButton(disabled: true),
              ),
            ),
          );
          expect(find.text("Next"), findsOneWidget);

          expect(
            tester
                .firstWidget<AnimatedDefaultTextStyle>(
                    find.byType(AnimatedDefaultTextStyle))
                .style
                .color,
            Colors.grey.shade500,
          );
        },
      );

      testWidgets(
        "Disabled State Darkmode",
        (WidgetTester tester) async {
          SharedPreferences.setMockInitialValues({});
          final pref = await SharedPreferences.getInstance();
          pref.setBool("darkMode", true);

          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                commonConfigProvider.overrideWith(
                  () => CommonConfigViewModel(
                    CommonConfigRepository(pref),
                  ),
                ),
              ],
              child: const Directionality(
                textDirection: TextDirection.ltr,
                child: FormButton(disabled: true),
              ),
            ),
          );

          expect(
            (tester
                    .firstWidget<AnimatedContainer>(
                        find.byType(AnimatedContainer))
                    .decoration as BoxDecoration)
                .color,
            Colors.grey.shade800,
          );
        },
      );

      testWidgets(
        "Disabled State LightMode",
        (WidgetTester tester) async {
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
              child: const Directionality(
                textDirection: TextDirection.ltr,
                child: FormButton(disabled: true),
              ),
            ),
          );

          expect(
            (tester
                    .firstWidget<AnimatedContainer>(
                        find.byType(AnimatedContainer))
                    .decoration as BoxDecoration)
                .color,
            Colors.grey.shade200,
          );
        },
      );
    },
  );
}
