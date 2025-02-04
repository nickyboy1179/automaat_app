import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/controller/register_controller.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  final RegisterController controller = RegisterController();
  final _formLoginKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final Widget automaatLogoSvg =
      SvgPicture(AssetBytesLoader('assets/automaat_logo_purple.svg.vec'));
  String? _errorMessage;

  Future<void> _register() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String passwordConfirm = _passwordConfirmController.text;

    await controller.register(firstName, lastName, email, password);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    NetworkStateProvider networkStateProvider =
        Provider.of<NetworkStateProvider>(context);

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
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: TextFormField(
                        obscureText: false,
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          labelText: 'Voornaam',
                          errorText: _errorMessage,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                      child: TextFormField(
                        obscureText: false,
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          labelText: 'Achternaam',
                          errorText: _errorMessage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
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
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordConfirmController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    labelText: 'Wachtwoord herhalen',
                    errorText: _errorMessage,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              networkStateProvider.isConnected
                  ? ConfirmButton(
                      text: "Registreren",
                      color: colorScheme.primary,
                      onColor: colorScheme.onPrimary,
                      onPressed: _register,
                    )
                  : ConfirmButton(
                      text: "Registreren",
                      color: colorScheme.tertiary,
                      onColor: colorScheme.onTertiary,
                      onPressed: () {},
                    ),
            ]),
          ),
        ]),
      ),
    );
  }
}
