import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:paye_ton_kawa/services/secure_storage.dart';
import 'package:paye_ton_kawa/styles/custom_colors.dart';
import 'package:paye_ton_kawa/views/scanner_authentication.dart';
import 'package:paye_ton_kawa/widgets/custom_appBar.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {

  final Key _formKey = const Key('_formKey');
  final SecureStorage _secureStorage = SecureStorage();
  final _emailController = TextEditingController();
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(),
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
                      
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Email envoyé !',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: CustomColors.lightBrown,
                          duration: Duration(seconds: 1),
                        ),
                      );
                      await _secureStorage.setEmailAddress(_emailController.text);
                      //await AuthenticationApi().sendUserRegistration(_emailController.text);
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ScannerAuthentication()));
                      });
                    } else if (_emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Entrez une adresse email !',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: CustomColors.lightBrown,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Adresse email invalide !',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: CustomColors.lightBrown,
                          duration: Duration(seconds: 2),
                        ),
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