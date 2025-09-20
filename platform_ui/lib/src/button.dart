import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'platform_widget.dart';
import '../src/platform.dart';

class PlatformButton extends PlatformWidget {
  
  final void Function()? onPressed;
  final material.Widget child;
  final double minimumWidth;

  const PlatformButton(super.platform, {material.Key? key, required this.child, required this.onPressed, required this.minimumWidth}) : super(key: key);

  @override
  material.Widget build(material.BuildContext context) {
    switch(platform) {
      case Platform.android:
      case Platform.linux:
      case Platform.web:
        return material.TextButton(
          onPressed: onPressed, 
          child: child,
        );

      case Platform.windows: 
        return fluent.Button(onPressed: onPressed, child: child);

      case Platform.ios:
      case Platform.macos:
        return cupertino.CupertinoButton(onPressed: onPressed, child: child);
    }
  }
}

class PlatformFilledButton extends PlatformButton {

  final material.OutlinedBorder? shape;

  const PlatformFilledButton(super.platform, {material.Key? key, required super.minimumWidth, required super.child, required super.onPressed, this.shape}) : super(key: key);

  @override
  material.Widget build(material.BuildContext context) {
    switch(platform) {
      case Platform.android:
      case Platform.linux:
      case Platform.web:
        return material.ElevatedButton(
          style: material.ElevatedButton.styleFrom(
            backgroundColor: material.Theme.of(context).colorScheme.primary,
            foregroundColor: material.Theme.of(context).colorScheme.onPrimary,
            minimumSize: material.Size(minimumWidth, 40)
          ),
          onPressed: onPressed, 
          child: child
        );

      case Platform.windows: 
        return fluent.FilledButton(onPressed: onPressed, child: child);

      case Platform.ios:
      case Platform.macos:
        return cupertino.CupertinoButton.filled(onPressed: onPressed, child: child);
    }
  }
}