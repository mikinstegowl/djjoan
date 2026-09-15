import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

Widget createTestWidget(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    ),
  );
}

void main() {
  group('DJ Joan Color Scheme & Button Rules', () {
    test('AppColors contains exact Smoke Black and Gold codes', () {
      expect(AppColors.smokeBlack, const Color(0xFF100C08));
      expect(AppColors.gold, const Color(0xFFD4AF37));
      expect(AppColors.appButton, const Color(0xFFD4AF37));
      expect(AppColors.black, Colors.black);
      expect(AppColors.white, Colors.white);
    });

    testWidgets('Gold Button defaults to Black text', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        AppButtonWidget(
          btnColor: AppColors.appButton,
          btnName: 'ENTER',
          onPressed: () {},
        ),
      ));
      await tester.pumpAndSettle();

      final textFinder = find.byType(AppTextWidget);
      expect(textFinder, findsOneWidget);
      final AppTextWidget textWidget = tester.widget(textFinder);
      expect(textWidget.txtColor, AppColors.black);
    });

    testWidgets('Black Button defaults to Gold text', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        AppButtonWidget(
          btnColor: AppColors.black,
          btnName: 'LOGIN',
          onPressed: () {},
        ),
      ));
      await tester.pumpAndSettle();

      final textFinder = find.byType(AppTextWidget);
      expect(textFinder, findsOneWidget);
      final AppTextWidget textWidget = tester.widget(textFinder);
      expect(textWidget.txtColor, AppColors.appButton);
    });

    testWidgets('Named constructors AppButtonWidget.gold and AppButtonWidget.black work as expected',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        Column(
          children: [
            AppButtonWidget.gold(
              btnName: 'CREATE PROFILE',
              onPressed: () {},
            ),
            AppButtonWidget.black(
              btnName: 'CANCEL',
              onPressed: () {},
            ),
          ],
        ),
      ));
      await tester.pumpAndSettle();

      final textWidgets = tester.widgetList<AppTextWidget>(find.byType(AppTextWidget)).toList();
      expect(textWidgets.length, 2);
      // Gold button has Black text
      expect(textWidgets[0].txtColor, AppColors.black);
      // Black button has Gold text
      expect(textWidgets[1].txtColor, AppColors.appButton);
    });

    testWidgets('White Text Rollover triggers on hover for Gold button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        AppButtonWidget.gold(
          btnName: 'HOVER ME',
          onPressed: () {},
        ),
      ));
      await tester.pumpAndSettle();

      // Before hover: black text
      AppTextWidget textWidget = tester.widget(find.byType(AppTextWidget));
      expect(textWidget.txtColor, AppColors.black);

      // Simulate mouse hover
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await gesture.moveTo(tester.getCenter(find.byType(AppButtonWidget)));
      await tester.pumpAndSettle();

      // During hover: white text rollover!
      textWidget = tester.widget(find.byType(AppTextWidget));
      expect(textWidget.txtColor, AppColors.white);

      // Move away
      await gesture.moveTo(const Offset(500, 500));
      await tester.pumpAndSettle();

      // Restored: black text
      textWidget = tester.widget(find.byType(AppTextWidget));
      expect(textWidget.txtColor, AppColors.black);
    });

    testWidgets('White Text Rollover triggers on hover for Black button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        AppButtonWidget.black(
          btnName: 'HOVER BLACK',
          onPressed: () {},
        ),
      ));
      await tester.pumpAndSettle();

      // Before hover: gold text
      AppTextWidget textWidget = tester.widget(find.byType(AppTextWidget));
      expect(textWidget.txtColor, AppColors.appButton);

      // Simulate mouse hover
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await gesture.moveTo(tester.getCenter(find.byType(AppButtonWidget)));
      await tester.pumpAndSettle();

      // During hover: white text rollover!
      textWidget = tester.widget(find.byType(AppTextWidget));
      expect(textWidget.txtColor, AppColors.white);
    });
  });
}
