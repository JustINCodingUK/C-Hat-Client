import 'package:flutter/material.dart' as m3;
import 'package:flutter/cupertino.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/theme/material/material_theme.dart';
import 'package:c_hat/ui/desktop/login_widget.dart';
import 'package:universal_io/io.dart' as io show Platform;

class DesktopApplication extends StatelessWidget {
  const DesktopApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (io.Platform.isWindows) {
      return FluentApp(
        theme: FluentThemeData(
            brightness: Brightness.light,
            accentColor: Colors.accentColors[7],
            activeColor: lightColorScheme.primary),
        darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: Colors.accentColors[7],
            activeColor: darkColorScheme.primary),
        themeMode: ThemeMode.light,
        home: LoginRoute(Platform.windows),
      );
    } else if (io.Platform.isMacOS) {
      return CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: lightColorScheme.primary,
        ),
        home: LoginRoute(Platform.macos),
      );
    } else if (io.Platform.isLinux) {
      return m3.MaterialApp(
        theme: m3.ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
        darkTheme:
            m3.ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
        themeMode: ThemeMode.light,
        home: LoginRoute(Platform.linux),
      );
    } else {
      throw Exception("Undefined Platform");
    }
  }
}
