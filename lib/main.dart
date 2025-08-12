import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/cubit/theme_cubit.dart';
import 'package:market/data/storage/storage_repository.dart';
import 'package:market/repository/product_repo.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/utils/constants/supabase_keys.dart';
import 'package:market/utils/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  await Supabase.initialize(url: supABaseUrl, anonKey: supABaseKey);
  final themeCubit = ThemeCubit();
  await themeCubit.loadTheme();
  runApp(App(themeCubit: themeCubit));
}

class App extends StatelessWidget {
  const App({super.key, required this.themeCubit});

  final ThemeCubit themeCubit;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => ProductRepo())],
      child: MultiBlocProvider(
        providers: [BlocProvider.value(value: themeCubit)],
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              onGenerateRoute: AppRoutes.generateRoute,
              initialRoute: RouteNames.splashScreen,
            );
          },
        );
      },
    );
  }
}
