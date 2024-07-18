import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/authentication_service.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  Future signUp({required String email, required String password}) async {
    setBusy(true);

    await _authenticationService.signUpWithEmail(
        email: email, password: password);
    // setBusy(false);

    // if (result is bool) {
    //   if (result) {
    //     // _navigationService.navigateTo(HomeViewRoute);
    //   } else {
    //     // await _dialogService.showDialog(
    //     //   title: 'Sign Up Failure',
    //     //   description: 'General sign up failure. Please try again later',
    //     // );
    //   }
    // } else {
    //   // await _dialogService.showDialog(
    //   //   title: 'Sign Up Failure',
    //   //   description: result,
    //   // );
    // }
  }
}
