import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/api_service.dart';
import 'navigation.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login page'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Automaat',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  fontFamily: 'inter',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Log in',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: 'inter',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'e-mailadres',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'wachtwoord',
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  //TODO wachtwoord vergeten pagina
                },
                child: const Text('Wachtwoord vergeten?')
            ),
            Container(
              height: 50,

              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  print(emailController.text);
                  print(passwordController.text);

                  String username = emailController.text;
                  String password = passwordController.text;

                  final dio = Dio();
                  final apiService = ApiService(dio);

                  try {
                    final authRequest = AuthRequest(
                      username: username,
                      password: password,
                      rememberMe: true,
                    );

                    final response = await apiService.authenticate(authRequest);
                    print(response.id_token);
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Navigation()),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Authentication failed: $e')),
                      );
                    }
                  }

                },
              ),
            ),
          ]
        ),
      )
    );
  }
}

