
import 'package:RDSH/store/auth.dart';

class AppState {
  final AuthState auth;

  AppState({
    required this.auth,
  });
  AppState.initialState()
      : auth = new AuthState();
}
