import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paye_ton_kawa/views/scanner_authentication.dart';
import 'package:paye_ton_kawa/views/user_registration.dart';


void main() {
  group('UserRegistration view tests', () {
    testWidgets('UserRegistration contains AppBar, Text, TextFormField and ElevatedButton', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: UserRegistration()));
      final appBar = find.byType(AppBar);
      final text = find.text('Renseignez votre adresse email pour obtenir un QR Code d\'authentification :');
      
      const formKey = Key('_formKey');
      final textFormField = find.byKey(formKey);
      final elevatedButton = find.byType(ElevatedButton);

      expect(appBar, findsOneWidget);
      expect(text, findsOneWidget);
      expect(textFormField, findsOneWidget);
      expect(elevatedButton, findsOneWidget);
    });

    group('UserRegistration ElevatedButton behaviours', () {
      testWidgets('should triggers navigation to ScannerAuthentication page', (tester) async {
        await tester.pumpWidget( const MaterialApp(home: UserRegistration()));

        const formKey = Key('_formKey');
        await tester.enterText(find.byKey(formKey), 'test@gmail.com');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpWidget(MaterialApp(
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const ScannerAuthentication(),
              );
            },
          ),
        ));
        
        expect(find.byType(ScannerAuthentication), findsOneWidget);
      });
      testWidgets('should show \"Email envoyé !\" in SnackBar if email address is valid', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: UserRegistration()));
        const formKey = Key('_formKey');
        await tester.enterText(find.byKey(formKey), 'test@gmail.com');
        expect(find.text('test@gmail.com'), findsOneWidget);
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Email envoyé !'), findsOneWidget);
      });

      testWidgets('should show \"Entrez une adresse email !\" in SnackBar if email address is not given', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: UserRegistration()));
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Entrez une adresse email !'), findsOneWidget);
      });

      testWidgets('should show \"Adresse email invalide !\" in SnackBar if email address is not valid', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: UserRegistration()));
        const formKey = Key('_formKey');
        await tester.enterText(find.byKey(formKey), 'test');
        expect(find.text('test'), findsOneWidget);
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Adresse email invalide !'), findsOneWidget);
      });
    });
  });
  
}