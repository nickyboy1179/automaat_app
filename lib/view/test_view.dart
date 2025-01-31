import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/confirm_button.dart';
import '../provider/auth_provider.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  void logOut(BuildContext context) async {
    await context.read<AuthProvider>().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove shadow
        toolbarHeight: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
                context.watch<AuthProvider>().isAuthenticated.toString()
            ),
            ConfirmButton(
              text: 'Uitloggen',
              color: Theme.of(context).colorScheme.primary,
              onColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                logOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
