import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

void main() {
  group(
    "Form button tests",
    () {
      testWidgets(
        "Enabled State",
        (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(
            const Directionality(
              textDirection: TextDirection.ltr,
              child: FormButton(disabled: false),
            ),
          );
          expect(find.text("Next"), findsOneWidget);
          expect(
            widgetTester
                .firstWidget<AnimatedDefaultTextStyle>(
                    find.byType(AnimatedDefaultTextStyle))
                .style
                .color,
            Colors.white,
          );
        },
      );
    },
  );
}
