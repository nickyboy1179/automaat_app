import 'package:flutter/material.dart';
import 'package:automaat_app/viewmodel/login_viewmodel.dart';
import 'package:flutter_svg/svg.dart';
import '../common/shared_widgets.dart';
import 'navigation_view.dart';
import 'package:vector_graphics/vector_graphics.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginViewmodel = LoginViewmodel();
  final _formLoginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Widget automaatLogoSvg = SvgPicture(AssetBytesLoader('assets/automaat_logo_purple.svg.vec'));
  String? _errorMessage;

  void authenticate() async {
    if (_formLoginKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      var boolResult = await loginViewmodel.authenticate(email, password);

      if (boolResult) {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Navigation()),
          );
        }
      } else {
        setState(() {
          _errorMessage = "Email/wachtwoord combinatie ongeldig";
        });
        _formLoginKey.currentState?.validate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
   return Container(
       color: SharedWidgets.backgroundColor,
       child: SafeArea(
       child: Padding(
       padding: EdgeInsets.only(top: 10.0),
    child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              width: 250,
              height: 250,
              child: automaatLogoSvg,
            ),
            Form(
              key: _formLoginKey,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                        validator: (value) {
                          final RegExp emailRegex =
                          RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*$');

                          if (value == null || value.isEmpty) {
                            return "Vul een e-mailadres in";
                          } else if (!emailRegex.hasMatch(value)) {
                            return "Vul een geldig e-mailadres in";
                          }
                          return null;
                        },
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        labelText: 'E-mailadres',
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        labelText: 'Wachtwoord',
                        errorText: _errorMessage,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 70,
                    width: 400,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      onPressed: authenticate,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF8E48C1),
                      ),
                      child: const Text(
                        'Inloggen',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      )
    )
    )
       )
   );
  }
}

