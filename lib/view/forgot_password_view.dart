import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:automaat_app/controller/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordController controller = ForgotPasswordController();
  final _formForgotPasswordKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final Widget automaatLogoSvg =
  SvgPicture(AssetBytesLoader('assets/automaat_logo_purple.svg.vec'));

  Future<void> _forgotPassword() async {
    if (_formForgotPasswordKey.currentState!.validate()) {
      String email = _emailController.text;

      await controller.forgotPassword(email);

      _navigateBackToLogin();
    }
  }

  void _navigateBackToLogin() {
    Navigator.pop(context);
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
            key: _formForgotPasswordKey,
            child: Column(children: [
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

              const SizedBox(height: 30),
              networkStateProvider.isConnected
                  ? ConfirmButton(
                text: "Vraag nieuw wachtwoord aan",
                color: colorScheme.primary,
                onColor: colorScheme.onPrimary,
                onPressed: () {
                  _forgotPassword();
                },
              )
                  : ConfirmButton(
                text: "Vraag nieuw wachtwoord aan",
                color: colorScheme.tertiary,
                onColor: colorScheme.onTertiary,
                onPressed: () {

                },
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
