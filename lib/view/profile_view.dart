import 'package:automaat_app/controller/profile_controller.dart';
import 'package:automaat_app/database/database.dart';
import 'package:automaat_app/service/notification_service.dart';
import 'package:automaat_app/view/developer_options_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/provider/auth_provider.dart';
import 'package:automaat_app/service/locator.dart';


class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController controller = ProfileController();
  final NotificationService _notificationService = locator<NotificationService>();
  final AppDatabase _database = locator<AppDatabase>();

  void logOut(BuildContext context) async {
    await _notificationService.cancelAllNotifications();
    await _database.customerDao.clearTable();
    await _database.rentalDao.clearTable();
    if (!context.mounted) return;
    await context.read<AuthProvider>().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConfirmButton(
              text: 'Uitloggen',
              color: Theme.of(context).colorScheme.primary,
              onColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                logOut(context);
              },
            ),
            SizedBox(height: 16,),
            ConfirmButton(
              text: 'Developer opties',
              color: Theme.of(context).colorScheme.primary,
              onColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeveloperOptionsView(),
                  ),
                );
              },
            ),
          ],
        )
      )
    );
  }
}
