import 'package:flutter/material.dart';
import 'package:paye_ton_kawa/services/secure_storage.dart';
import 'package:paye_ton_kawa/views/products_list.dart';
import 'package:paye_ton_kawa/views/user_registration.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    final emailAddress = _secureStorage.getEmailAddress();

    return Scaffold(
      body: FutureBuilder(
        future: emailAddress,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const ProductsList();
          }
          else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const UserRegistration();
        }),
      ),
    );
  }
}