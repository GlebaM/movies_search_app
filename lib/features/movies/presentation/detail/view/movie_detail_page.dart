import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/movie_repository.dart';
import '../../search/widgets/movie_search_error.dart';
import '../cubit/movie_detail_cubit.dart';
import '../cubit/movie_detail_state.dart';
import '../widgets/movie_detail_content.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.imdbId, required this.title});

  final String imdbId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailCubit>(
      create: (context) =>
          MovieDetailCubit(RepositoryProvider.of<MovieRepository>(context))
            ..loadMovie(imdbId),
      child: _MovieDetailView(title: title),
    );
  }
}

class _MovieDetailView extends StatelessWidget {
  const _MovieDetailView({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          switch (state.status) {
            case MovieDetailStatus.initial:
            case MovieDetailStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case MovieDetailStatus.success:
              final movie = state.movie!;
              return MovieDetailContent(movie: movie);
            case MovieDetailStatus.failure:
              return MovieSearchError(
                message: state.errorMessage ?? 'Unable to load movie details',
                onRetry: () =>
                    context.read<MovieDetailCubit>().loadMovie(state.imdbId),
              );
          }
        },
      ),
    );
  }
}
