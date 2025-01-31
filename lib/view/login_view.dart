import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/controller/login_viewmodel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginViewmodel = LoginController();
  final _formLoginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Widget automaatLogoSvg = SvgPicture(
      AssetBytesLoader('assets/automaat_logo_purple.svg.vec'));
  String? _errorMessage;

  void authenticate() async {
    if (_formLoginKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      var boolResult = await loginViewmodel.authenticate(
          context, email, password);

      if (!boolResult) {
        setState(() {
          _errorMessage = "Email/wachtwoord combinatie ongeldig";
        });
        _formLoginKey.currentState?.validate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    NetworkStateProvider networkStateProvider = Provider.of<NetworkStateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove shadow
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: <Widget>[
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
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (value) {
                      final RegExp emailRegex = RegExp(
                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)(?:\.[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)*");
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

                networkStateProvider.isConnected
                    ? ConfirmButton(
                  text: "Inloggen",
                  color: colorScheme.primary,
                  onColor: colorScheme.onPrimary,
                  onPressed: authenticate,
                  )
                : ConfirmButton(
                    text: "Inloggen",
                    color: colorScheme.tertiary,
                    onColor: colorScheme.onTertiary,
                    onPressed: () {},
                  ),

              ]
            ),
          ),
        ]
        ),
      ),
    );
  }
}
