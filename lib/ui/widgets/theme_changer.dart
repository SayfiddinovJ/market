import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubit/theme_cubit.dart';

class ThemeChanger extends StatelessWidget {
  const ThemeChanger({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            themeCubit.state == ThemeMode.light
                ? themeCubit.setDarkTheme()
                : themeCubit.setLightTheme();
          },
          icon: Icon(
            themeCubit.state == ThemeMode.light
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
          ),
        );
      },
    );
  }
}
