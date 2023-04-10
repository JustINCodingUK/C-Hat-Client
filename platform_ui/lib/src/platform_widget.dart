import 'package:flutter/material.dart';
import 'platform.dart';

abstract class PlatformWidget extends StatelessWidget {

  final Platform platform;

  const PlatformWidget(this.platform, {Key? key}) : super(key: key);

}
