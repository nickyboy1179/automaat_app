import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Container(
          height: 100,
          width: 300,
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.secondary),
              shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16))),
            ),
            onPressed: () => {},
            child: Text(
              context.watch<NetworkStateProvider>().isConnected.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            )
          ),
        ),
      ),
    );
  }
}
