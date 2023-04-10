import 'package:c_hat/app/bloc/app_event.dart';
import 'package:c_hat/app/bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  AppBloc() : super(LoginCheckAwaits()) {

    on<AppStartedEvent>((event, emit) async {
      final sharedPrefs = await SharedPreferences.getInstance();
      if(sharedPrefs.getBool("isLoggedIn") == null) {
        await sharedPrefs.setBool("isLoggedIn", false);
      }

      if(sharedPrefs.getBool("isLoggedIn") == true) {
        emit(
          UserIsLoggedIn(
            password: sharedPrefs.getString("loggedInUser.password")!, 
            mailId: sharedPrefs.getString("loggedInUser.mailId")!,
            wsUrl: sharedPrefs.getString("serverIP")!
          )
        );
      } else {
        emit(UserIsNotLoggedIn());
      }
    }); 
  }
}