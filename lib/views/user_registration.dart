import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paye_ton_kawa/services/authentication_api.dart';
import 'package:paye_ton_kawa/services/secure_storage.dart';
import 'package:paye_ton_kawa/styles/custom_colors.dart';
import 'package:paye_ton_kawa/views/scanner_authentication.dart';
import 'package:paye_ton_kawa/widgets/custom_app_bar.dart';

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

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(
        isAuthent: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                width: width * 0.8,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                  child: Text(
                    'Renseignez votre adresse email pour obtenir un QR Code d\'authentification :',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
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
                        color: CustomColors.darkGold,
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
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () async {
                    _isValid = EmailValidator.validate(_emailController.text);
                    if (_isValid) {
                      await _secureStorage.setEmailAdress(_emailController.text);
                      //await AuthenticationApi().sendUserRegistration(_emailController.text);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ScannerAuthentication()));
                      Fluttertoast.showToast(
                        msg: "Email envoyé !",
                        textColor: Colors.green,
                        backgroundColor: CustomColors.lightBrown,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 18,
                      );
                    } else if (_emailController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'Entrez une adresse email !',
                        textColor: Colors.red,
                        backgroundColor: CustomColors.lightBrown,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 18,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Adresse email invalide !',
                        textColor: Colors.red,
                        backgroundColor: CustomColors.lightBrown,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 18,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}