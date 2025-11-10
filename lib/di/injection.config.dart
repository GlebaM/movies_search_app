// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movies_search_app/di/network_module.dart' as _i393;
import 'package:movies_search_app/features/movies/data/clients/omdb_api_client.dart'
    as _i568;
import 'package:movies_search_app/features/movies/data/repositories/omdb_movie_repository.dart'
    as _i512;
import 'package:movies_search_app/features/movies/domain/repositories/movie_repository.dart'
    as _i323;
import 'package:movies_search_app/features/movies/domain/usecases/get_movie_detail.dart'
    as _i928;
import 'package:movies_search_app/features/movies/domain/usecases/search_movies.dart'
    as _i541;
import 'package:movies_search_app/features/movies/presentation/detail/cubit/movie_detail_cubit.dart'
    as _i955;
import 'package:movies_search_app/features/movies/presentation/search/cubit/movie_search_cubit.dart'
    as _i837;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i568.OmdbApiClient>(
      () => _i568.OmdbApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i323.MovieRepository>(
      () => _i512.OmdbMovieRepository(apiClient: gh<_i568.OmdbApiClient>()),
    );
    gh.factory<_i928.GetMovieDetail>(
      () => _i928.GetMovieDetail(repository: gh<_i323.MovieRepository>()),
    );
    gh.factory<_i541.SearchMovies>(
      () => _i541.SearchMovies(repository: gh<_i323.MovieRepository>()),
    );
    gh.factory<_i955.MovieDetailCubit>(
      () => _i955.MovieDetailCubit(gh<_i928.GetMovieDetail>()),
    );
    gh.factory<_i837.MovieSearchCubit>(
      () => _i837.MovieSearchCubit(gh<_i541.SearchMovies>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i393.NetworkModule {}
