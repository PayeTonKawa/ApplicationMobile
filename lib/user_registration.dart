import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paye_ton_kawa/authentication_api.dart';
import 'package:paye_ton_kawa/secure_storage.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {

  final GlobalKey<FormFieldState> _formKey = GlobalKey();
  final SecureStorage _secureStorage = SecureStorage();
  final _emailController = TextEditingController();
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: width * 0.8,
              child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Text('Renseignez votre adresse email pour obtenir un QR Code d\'authentification :'),          
              ),
            ),
            SizedBox(
              width: width * 0.8,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                /* child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Entrez votre adresse email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => EmailValidator.validate(value!) ? null : 'Veuillez saisir une adresse email valide !',
                ), */
                child: TextFormField(
                  key: _formKey,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.black,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 17.0,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: ElevatedButton(
                child: const Text(
                  'Valider',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  _isValid = EmailValidator.validate(_emailController.text);
                  if (_isValid) {
                    await _secureStorage.setEmailAdress(_emailController.text);
                    await AuthenticationApi().sendUserRegistration(_emailController.text);
                    Fluttertoast.showToast(
                        msg: "Email envoyé !",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  } else if (_emailController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Entrez une adresse email !',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Adresse email invalide !',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}