
import 'package:RDSH/models/app_state.dart';
import 'package:RDSH/store/auth.dart';


AppState appReducer(AppState state, action) {  
  return AppState(
    auth: authReducer(state.auth, action),
  );
}



