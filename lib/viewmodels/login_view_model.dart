import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/authentication_service.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future login({required String email, required String password}) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
        email: email, password: password);

    setBusy(false);

    if (result is bool) {
      if (result) {
        // _navigationService.navigateTo(HomeViewRoute);
      } else {
        // await _dialogService.showDialog(
        //   title: 'Login Failure',
        //   description: 'Couldn\'t login at this moment. Please try again later',
        // );
      }
    } else {
      // await _dialogService.showDialog(
      //   title: 'Login Failure',
      //   description: result,
      // );
    }
  }
}
