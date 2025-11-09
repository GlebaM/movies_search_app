import 'package:flutter/material.dart';

import '../../features/movies/presentation/search/view/movie_search_page.dart';
import '../theme/app_theme.dart';
import '../../core/utils/dismiss_keyboard.dart';

class MoviesSearchApp extends StatelessWidget {
  const MoviesSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        title: 'Movies Search',
        theme: buildAppTheme(),
        home: const MovieSearchPage(),
      ),
    );
  }
}
