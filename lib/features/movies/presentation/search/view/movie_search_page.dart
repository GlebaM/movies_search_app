import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/movie_repository.dart';
import '../../../data/models/movie_summary.dart';
import '../../detail/view/movie_detail_page.dart';
import '../cubit/movie_search_cubit.dart';
import '../cubit/movie_search_state.dart';
import '../widgets/movie_search_empty.dart';
import '../widgets/movie_search_error.dart';
import '../widgets/movie_search_list.dart';

class MovieSearchPage extends StatelessWidget {
  const MovieSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieSearchCubit>(
      create: (context) =>
          MovieSearchCubit(RepositoryProvider.of<MovieRepository>(context)),
      child: const _MovieSearchView(),
    );
  }
}

class _MovieSearchView extends StatefulWidget {
  const _MovieSearchView();

  @override
  State<_MovieSearchView> createState() => _MovieSearchViewState();
}

class _MovieSearchViewState extends State<_MovieSearchView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Movie Explorer')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              onChanged: context.read<MovieSearchCubit>().search,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search movies by title',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (context, value, _) {
                    if (value.text.isEmpty) return const SizedBox.shrink();
                    return IconButton(
                      onPressed: () {
                        _controller.clear();
                        context.read<MovieSearchCubit>().search('');
                      },
                      icon: const Icon(Icons.clear),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<MovieSearchCubit, MovieSearchState>(
                builder: (context, state) {
                  switch (state.status) {
                    case MovieSearchStatus.initial:
                      return _buildPlaceholder(context);
                    case MovieSearchStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case MovieSearchStatus.success:
                      return MovieSearchList(
                        results: state.results,
                        onMovieTap: (movie) => _openDetail(context, movie),
                      );
                    case MovieSearchStatus.empty:
                      return const MovieSearchEmpty();
                    case MovieSearchStatus.failure:
                      return MovieSearchError(
                        message:
                            state.errorMessage ?? 'Failed to fetch results',
                        onRetry: () => context.read<MovieSearchCubit>().search(
                          state.query,
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: colorScheme.surface,
    );
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
        builder: (_) =>
            MovieDetailPage(imdbId: movie.imdbId, title: movie.title),
      ),
    );
  }
}
