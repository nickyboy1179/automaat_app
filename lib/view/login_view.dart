import 'package:automaat_app/view/navigation_view_v2.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/controller/login_viewmodel.dart';
import 'package:flutter_svg/svg.dart';
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
          toNavigationView(context);
        }
      } else {
        setState(() {
          _errorMessage = "Email/wachtwoord combinatie ongeldig";
        });
        _formLoginKey.currentState?.validate();
      }
    }
  }

  void toNavigationView(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Navigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: loginViewmodel.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return NavigationViewV2();
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0, // Remove shadow
              toolbarHeight: 0,
            ),
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
                              RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)(?:\.[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)*");
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

          );
        }
      },
    );
  }
}

