import 'package:automaat_app/controller/profile_controller.dart';
import 'package:automaat_app/database/database.dart';
import 'package:automaat_app/model/rest_model/about_me_model.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:automaat_app/service/notification_service.dart';
import 'package:automaat_app/view/developer_options_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/provider/auth_provider.dart';
import 'package:automaat_app/service/locator.dart';
import '';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController controller = ProfileController();
  final NotificationService _notificationService =
      locator<NotificationService>();
  final AppDatabase _database = locator<AppDatabase>();

  void logOut(BuildContext context) async {
    await _notificationService.cancelAllNotifications();
    await _database.customerDao.clearTable();
    await _database.rentalDao.clearTable();
    if (!context.mounted) return;
    await context.read<AuthProvider>().logout(context);
  }

  Future<dynamic> getUserInfo(BuildContext context) async {
    final NetworkStateProvider network =
        Provider.of<NetworkStateProvider>(context, listen: false);
    if (network.isConnected) {
      return await controller.getUserInfo();
    } else {
      return await controller.getUserInfoLocal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profiel",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FutureBuilder(
                    future: getUserInfo(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (!snapshot.hasData) {
                        return Center(
                            child:
                                Text("Geen gebruikersInformatie beschikbaar"));
                      } else {
                        return _infoCard(context, snapshot.data);
                      }
                    }),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.4,),
                ConfirmButton(
                  text: 'Uitloggen',
                  color: Colors.red,
                  onColor: Colors.white,
                  onPressed: () {
                    logOut(context);
                  },
                ),
                SizedBox(
                  height: 16,
                ),
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
            )));
  }

  Widget _infoCard(BuildContext context, dynamic userInfo) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person, size: 50, color: colorScheme.primary),
            SizedBox(height: 8),
            Text(
              '${userInfo.firstName} ${userInfo.lastName}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
