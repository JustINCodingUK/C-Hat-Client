import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'platform_widget.dart';
import 'platform.dart';

class PlatformTextField extends PlatformWidget {
  final String hint;
  final double? width;
  final material.TextEditingController controller;
  final bool isPassword;
  final void Function(String)? onChanged;

  const PlatformTextField(super.platform,
      {required this.hint,
      this.width,
      required this.controller,
      material.Key? key,
      this.isPassword = false,
      this.onChanged})
      : super(key: key);

  @override
  material.Widget build(material.BuildContext context) {
    switch (platform) {
      case Platform.android:
      case Platform.linux:
      case Platform.web:
        return material.SizedBox(
          width: width,
          child: material.TextField(
            controller: controller,
            decoration: material.InputDecoration(
                border: const material.OutlineInputBorder(),
                label: material.Text(hint)),
            obscureText: isPassword,
            onChanged: onChanged,
          ),
        );

      case Platform.windows:
        return material.SizedBox(
          width: width,
          child: fluent.TextBox(
            placeholder: hint,
            onChanged: onChanged,
          ),
        );

      case Platform.ios:
      case Platform.macos:
        return material.SizedBox(
          width: width,
          child: cupertino.CupertinoTextField(
            placeholder: hint,
            onChanged: onChanged,
          ),
        );
    }
  }
}
