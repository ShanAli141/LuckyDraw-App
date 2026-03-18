import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luckywinner/features/participants/presentation/bloc/participants_cubit.dart';

import 'core/theme/app_theme.dart';
import 'config/routes.dart';
import 'features/participants/data/participants_local_data_source.dart';

class LuckyWinnerApp extends StatelessWidget {
  const LuckyWinnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ParticipantsCubit(ParticipantsLocalDataSource())..load(),
        ),
      ],
      child: MaterialApp(
        title: 'Lucky Winner: Random Picker',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: AppRoutes.initialRoute,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}