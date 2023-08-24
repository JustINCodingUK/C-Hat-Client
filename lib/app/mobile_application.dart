import 'package:c_hat/app/bloc/app_bloc.dart';
import 'package:c_hat/app/bloc/app_event.dart';
import 'package:c_hat/app/bloc/app_state.dart';
import 'package:c_hat/ui/mobile/splash_screen.dart';
import 'package:c_hat/ui/mobile/user_list/user_list_widget.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_event.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/theme/material/material_theme.dart';
import 'package:c_hat/ui/mobile/login/login_widget.dart';
import 'package:universal_io/io.dart' as io show Platform;

class MobileApplication extends StatelessWidget {
  const MobileApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (io.Platform.isAndroid || io.Platform.isLinux) {
      return BlocProvider<AppBloc>(
        create: (context) => AppBloc()..add(AppStartedEvent()),
        child: MaterialApp(
          theme: ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
          darkTheme:
              ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
          themeMode: ThemeMode.light,
          home: _buildMainWidgetForPlatform(Platform.android)
        ),
      );
    } else if (io.Platform.isIOS) {
      return BlocProvider<AppBloc>(
        create: (_) => AppBloc()..add(AppStartedEvent()),
        child: CupertinoApp(
            theme: CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: lightColorScheme.primary,
            ),
            home: _buildMainWidgetForPlatform(Platform.ios)
          ),
      );
    } else {
      throw Exception("Undefined Platform");
    }
  }

  Widget _buildMainWidgetForPlatform(Platform platform) {
    return BlocBuilder<AppBloc, AppState>(
      builder: ((context, state) {
        if (state is LoginCheckAwaits) {
          return const SplashScreen();
        } else if (state is UserIsLoggedIn) {
          context.read<ChatBloc>()
            .add(InitiateConnectionEvent(
                mailId: state.mailId,
                wsUrl: state.wsUrl,
                password: state.password));

          return BlocBuilder<ChatBloc, ChatState>(
            buildWhen: (previous, current) {
              return current is LoginSuccess || current is LoginFailed;
            },
            builder: ((chatContext, state) {
              if (state is LoginSuccess) {
                return UserListRoute(platform,
                    loggedInUser: state.user);
              } else {
                return const SplashScreen();
              }
            }),
          );
        } else {
          return LoginRoute(platform);
        }
      }),
    );
  }
}
