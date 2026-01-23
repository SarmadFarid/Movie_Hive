import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:cine_flow/core/errors/failure.dart';
import 'package:cine_flow/core/services/storage_services.dart';
import 'package:cine_flow/features/movies/data/models/movie_model.dart';

class StorageServiceImpl implements StorageServices {
  final Box<MovieModel> _moviesBox;
  final Box<MovieModel> _topRatedMovies;
  StorageServiceImpl({Box<MovieModel>? box, Box<MovieModel>? topRatedBox})
    : _moviesBox = box ?? Hive.box<MovieModel>('movie_box'),
      _topRatedMovies = topRatedBox ?? Hive.box<MovieModel>("top_rated_movies");

  @override
  Future<Either<Failure, Unit>> cacheTrendingMovies(
    List<MovieModel> movies,
  ) async {
    try {
      await _moviesBox.clear();
      await _moviesBox.addAll(movies);
      return const Right(unit);
    } catch (e) {
      return Left(Failure('Cached error : ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> cacheTopRatedMovies(
    List<MovieModel> movies,
  ) async {
    try {
      await _topRatedMovies.clear();
      await _topRatedMovies.addAll(movies);
      return const Right(unit);
    } catch (e) {
      return Left(Failure('Cache error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> fetchCachedTrendingMovies() async {
    try {
      final data = _moviesBox.values.toList();
      return Right(data.cast<MovieModel>());
    } catch (e) {
      return Left(Failure("Cache fetch error : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> fetchCachedTopRatedMovies() async {
    try {
      final data = _topRatedMovies.values.toList();
      return Right(data.cast<MovieModel>());
    } catch (e) {
      return Left(Failure("Cache fetch error :  ${e.toString()}"));
    }
  }

  @override
  bool get hasData => _moviesBox.isNotEmpty;

  @override
  bool get hasTopRatedMovies => _topRatedMovies.isNotEmpty;
}
