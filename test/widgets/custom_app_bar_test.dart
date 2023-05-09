import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paye_ton_kawa/views/augmented_reality.dart';
import 'package:paye_ton_kawa/widgets/custom_app_bar.dart';

void main() {
  group('CustomAppBar widget tests', () {
    testWidgets('should find Text widget, IconButton and Icon widget if isAuthent = true', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CustomAppBar(isAuthent: true)));
      final text = find.byType(Text);
      final iconButton = find.byType(IconButton);
      final icon = find.byType(Icon);

      expect(text, findsOneWidget);
      expect(iconButton, findsOneWidget);
      expect(icon, findsOneWidget);
    });

    testWidgets('IconButton should redirect to AugmentedReality view', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CustomAppBar(isAuthent: true)));
      final iconButton = find.byType(IconButton);

      await tester.tap(iconButton);
      await tester.pumpWidget(MaterialApp(
        home: Navigator(
          onGenerateRoute: (_) {
            return MaterialPageRoute<Widget>(
              builder: (_) => const AugmentedReality(),
            );
          },
        ),
      ));
        
      expect(find.byType(AugmentedReality), findsOneWidget);
    });

    testWidgets('should only find Text widget if isAuthent = false', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CustomAppBar(isAuthent: false)));
      final text = find.byType(Text);
      final iconButton = find.byType(IconButton);

      expect(text, findsOneWidget);
      expect(iconButton, findsNothing);
    });
  });
  
}