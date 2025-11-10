import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

import '../../../data/models/movie_summary.dart';
import '../../detail/view/movie_detail_page.dart';
import '../cubit/movie_search_cubit.dart';
import '../cubit/movie_search_state.dart';
import '../widgets/movie_search_empty.dart';
import '../widgets/movie_search_error.dart';
import '../widgets/movie_search_list.dart';

class MovieSearchPage extends HookWidget {
  const MovieSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<MovieSearchCubit>();
    final state = useBlocBuilder<MovieSearchCubit, MovieSearchState>(cubit);
    final controller = useTextEditingController();
    final colorScheme = Theme.of(context).colorScheme;

    Widget body;

    switch (state.status) {
      case MovieSearchStatus.initial:
        body = _buildPlaceholder(context);
        break;
      case MovieSearchStatus.loading:
        body = const Center(child: CircularProgressIndicator());
        break;
      case MovieSearchStatus.success:
        body = MovieSearchList(
          results: state.results,
          onMovieTap: (movie) => _openDetail(context, movie),
        );
        break;
      case MovieSearchStatus.empty:
        body = const MovieSearchEmpty();
        break;
      case MovieSearchStatus.failure:
        body = MovieSearchError(
          message: state.errorMessage ?? 'Failed to fetch results',
          onRetry: () => cubit.search(state.query),
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Movie Explorer')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              onChanged: cubit.search,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search movies by title',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller,
                  builder: (context, value, _) {
                    if (value.text.isEmpty) return const SizedBox.shrink();
                    return IconButton(
                      onPressed: () {
                        controller.clear();
                        cubit.search('');
                      },
                      icon: const Icon(Icons.clear),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: body),
          ],
        ),
      ),
      backgroundColor: colorScheme.surface,
    );
  }
}

Widget _buildPlaceholder(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(Icons.local_movies_outlined, size: 72),
        const SizedBox(height: 12),
        Text('Find your next movie', style: textTheme.titleLarge),
        const SizedBox(height: 12),
        Text(
          'Start typing to search for your favourite titles.',
          style: textTheme.bodyMedium?.copyWith(
            color: textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

void _openDetail(BuildContext context, MovieSummary movie) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => MovieDetailPage(imdbId: movie.imdbId, title: movie.title),
    ),
  );
}
