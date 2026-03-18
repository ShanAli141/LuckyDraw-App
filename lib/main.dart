import 'package:flutter/widgets.dart';

import 'app.dart';
import 'core/utils/ad_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdService.initialize();
  await AdService.loadInterstitial();

  runApp(const LuckyWinnerApp());
}
