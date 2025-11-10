import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

import '../../search/widgets/movie_search_error.dart';
import '../cubit/movie_detail_cubit.dart';
import '../cubit/movie_detail_state.dart';
import '../widgets/movie_detail_content.dart';

class MovieDetailPage extends HookWidget {
  const MovieDetailPage({super.key, required this.imdbId, required this.title});

  final String imdbId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<MovieDetailCubit>(keys: <Object>[imdbId]);
    final state = useBlocBuilder<MovieDetailCubit, MovieDetailState>(cubit);

    useEffect(() {
      cubit.initialize(imdbId);
      return null;
    }, <Object>[cubit, imdbId]);

    Widget body;

    switch (state.status) {
      case MovieDetailStatus.initial:
      case MovieDetailStatus.loading:
        body = const Center(child: CircularProgressIndicator());
        break;
      case MovieDetailStatus.success:
        body = MovieDetailContent(movie: state.movie!);
        break;
      case MovieDetailStatus.failure:
        body = MovieSearchError(
          message: state.errorMessage ?? 'Unable to load movie details',
          onRetry: () => cubit.loadMovie(state.imdbId),
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body,
    );
  }
}
