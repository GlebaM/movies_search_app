import 'package:flutter/material.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

import '../../core/utils/dismiss_keyboard.dart';
import '../../di/injection.dart';
import '../../features/movies/presentation/search/view/movie_search_page.dart';
import '../theme/app_theme.dart';

class MoviesSearchApp extends StatelessWidget {
  const MoviesSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HookedBlocConfigProvider(
      injector: () => getIt,
      child: DismissKeyboard(
        child: MaterialApp(
          title: 'Movies Search',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          home: const MovieSearchPage(),
        ),
      ),
    );
  }
}
