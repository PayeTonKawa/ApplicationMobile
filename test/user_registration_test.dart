import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mockito/mockito.dart';
import 'package:paye_ton_kawa/main.dart';
import 'package:paye_ton_kawa/views/scanner_authentication.dart';
import 'package:paye_ton_kawa/views/user_registration.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

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
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(const MaterialApp(home: UserRegistration()));

        const formKey = Key('_formKey');
        await tester.enterText(find.byKey(formKey), 'test@gmail.com');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();
        verify(mockObserver.didPush(MaterialPageRoute(builder: (context) => const ScannerAuthentication()), MaterialPageRoute(builder: (context) => const UserRegistration())));
        expect(find.byType(ScannerAuthentication), findsOneWidget);;
      });
      testWidgets('should show \"Entrez une adresse email !\" in FlutterToast if email address is not given', (tester) async {
        await tester.pumpWidget(const MyApp());
        await tester.tap(find.byType(ElevatedButton));

        final flutterToast = find.byType(Fluttertoast);
        expect(flutterToast, findsOneWidget);
      });
    });
  });
  
}