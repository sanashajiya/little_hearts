import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_mediaquery.dart';
import 'core/cubit/zone_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const LittleHeartsApp());
}

class LittleHeartsApp extends StatelessWidget {
  const LittleHeartsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ZoneCubit(),
      child: MaterialApp.router(
        title: 'Little Hearts',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        builder: (context, child) {
          AppMediaquery().init(context);
          return child!;
        },
        routerConfig: appRouter,
      ),
    );
  }
}
