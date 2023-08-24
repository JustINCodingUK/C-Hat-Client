import 'package:flutter/material.dart';

extension WithPadding on Widget {

  Widget withPadding({double padding = 8}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: this,
    );
  }

}