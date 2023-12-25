import 'package:erp/models/user_management/sign_in_dashboard_response.dart';
import 'package:erp/models/user_management/sign_in_response.dart';

class ApplicationState {
  // Current user language.
  final String? language;

  // // Current user profile.
  final SignInResultResponse? user;


  ApplicationState({
    this.language,
    this.user
  });

  ApplicationState copyWith({String? language,
    SignInResultResponse? user,
  }) =>
      ApplicationState(
        language: language ?? this.language,
        user:  user ?? this.user,
      );

  ApplicationState clearProfile() {
    return ApplicationState(language: language, user: user);
  }


  SignInResultResponse? get getUser => user;


  static ApplicationState get initialState => ApplicationState();
}
