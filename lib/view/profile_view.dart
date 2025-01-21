import 'package:automaat_app/common/shared_widgets.dart';
import 'package:automaat_app/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../locator.dart';
import '../main.dart';
import '../model/rest_model/about_me_model.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final secureStorage = locator<FlutterSecureStorage>();
  final ProfileViewmodel profileViewmodel = ProfileViewmodel();

  void logOut(context) async {
    await secureStorage.delete(key: 'token');

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AutomaatApp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                      future: profileViewmodel.getUserInfo(),
                      builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No rental information available'));
                      } else {
                        AboutMe me = snapshot.data!;
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 48.0,
                                  color: Colors.purple,
                                ),
                                const SizedBox(height: 8.0),
                                 Text(
                                  "${me.firstName} ${me.lastName}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                 Text(
                                  '${me.systemUser.email}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      }
                  ),
              // User Info Card

                  ElevatedButton(
                    style: SharedWidgets.automaatConfirmButtonStyle,
                    onPressed: () => logOut(context),
                    child: Text(
                      "Uitloggen",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
            ]
            )
        )
    );
  }
}
