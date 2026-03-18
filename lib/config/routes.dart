import 'package:flutter/material.dart';
import 'package:luckywinner/features/result/pages/result_page.dart';
import 'package:luckywinner/features/participants/pages/participants_page.dart';
import 'package:luckywinner/features/result/presentation/pages/spin_wheel_page.dart';
import 'package:luckywinner/features/random_picker/pages/random_picker_page.dart';

import '../features/home/presentation/pages/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String participants = '/participants';
  static const String randomPicker = '/random-picker';
  static const String spinWheel = '/spin-wheel';
  static const String result = '/result';

  static String get initialRoute => home;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case participants:
        return MaterialPageRoute(builder: (_) => const ParticipantsPage());
      case randomPicker:
        return MaterialPageRoute(builder: (_) => const RandomPickerPage());
      case spinWheel:
        return MaterialPageRoute(builder: (_) => const SpinWheelPage());
      case result:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ResultPage(arguments: args));
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
