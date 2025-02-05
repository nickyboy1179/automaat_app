import '../service/locator.dart';
import '../model/rest_model/about_me_model.dart';
import '../model/retrofit/rest_client.dart';

class ProfileViewmodel {
  final restClient = locator<RestClient>();

  Future<AboutMe> getUserInfo() async {
    AboutMe user = await restClient.getUserInfo();
    return user;
  }
}