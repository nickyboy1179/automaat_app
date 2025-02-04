import 'package:automaat_app/model/rest_model/am_register_model.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';
import 'package:automaat_app/locator.dart';

class RegisterController {
  final RestClient _restClient = locator<RestClient>();

  Future<void> register(
      String firstName,
      String lastName,
      String email,
      String password) async {

    DateTime registerTime = DateTime.now();

    AmRegister account = AmRegister(
        id: null,
        login: email,
        firstName: firstName,
        lastName: lastName,
        email: email,
        imageUrl: '',
        activated: false,
        langKey: "en",
        createdBy: null,
        createdDate: registerTime,
        lastModifiedBy: null,
        lastModifiedDate: registerTime,
        authorities: [],
        password: password,
    );

    try {
      await _restClient.postAccount(account);
    } catch (e) {
      print(e);
    }
  }
}
