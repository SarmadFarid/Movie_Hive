
import 'package:dio/dio.dart';
import 'package:cine_flow/core/utills/app_imports.dart';

class MoviesRepositoryImpl implements MovieRepository {
  final Dio _dio = DioClient().dio;

  @override
  Future<Either<Failure, List<MovieModel>>> getTrendingMovies() async {
    try {
      final response = await _dio.get(ApiEndpoints.trendingMovies);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data["results"];
        final movies = results
            .map((item) => MovieModel.fromJson(item))
            .toList();
        return Right(movies);
      } else {
        return Left(
          Failure(
            "Server error fetchcing trending movies: ${response.statusCode}",
          ),
        );
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptionHandler.parse(e);
      return Left(Failure(errorMessage));
    } catch (e) {
      return Left(Failure("Uncaught error : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getPopularMovies() async {
    try {
      final response = await _dio.get(ApiEndpoints.popular);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        final movies = results.map((e) => MovieModel.fromJson(e)).toList();
        return Right(movies);
      } else {
        return Left(
          Failure('server error fetching Popular : ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      final error = DioExceptionHandler.parse(e);
      return Left(Failure(error));
    } catch (e) {
      return Left(Failure('uncaught error : ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getTopRatedMovies() async {
    try {
      final response = await _dio.get(ApiEndpoints.topRatedMovies);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        final movies = results
            .map((movie) => MovieModel.fromJson(movie))
            .toList();
        return Right(movies);
      } else {
        return Left(
          Failure(
            'Server Error fetching topRated movies : ${response.statusCode}',
          ),
        );
      }
    } on DioException catch (e) {
      final errormessage = DioExceptionHandler.parse(e);
      return Left(Failure(errormessage));
    } catch (e) {
      return Left(Failure("Uncaught error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<CastModel>>> getMoviesCast(int id, {CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get('/movie/$id/credits', cancelToken: cancelToken);
      if (response.statusCode == 200) {
        final List<dynamic> result = response.data['cast'];
        final actors = result.map((i) => CastModel.fromJson(i)).toList();
        return Right(actors);
      } else {
        return Left(
          Failure('Server error fetching cast movies: ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      final error = DioExceptionHandler.parse(e);
      return Left(Failure(error));
    } catch (e) {
      return Left(Failure("Uncaught error  : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, MovieDetailModel>> getMovieDetails(int id,  {CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get('/movie/$id', cancelToken: cancelToken);
      if (response.statusCode == 200) {
        return Right(MovieDetailModel.fromJson(response.data));
      } else {
        return Left(
          Failure("Server Error fetching details : ${response.statusCode} "),
        );
      }
    } on DioException catch (e) {
      final error = DioExceptionHandler.parse(e);
      return Left(Failure(error));
    } catch (e) {
      return Left(Failure('Uncaught error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getSimilarMovies(int id,  {CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get('/movie/$id/similar', cancelToken: cancelToken);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        final movies = results
            .map((movie) => MovieModel.fromJson(movie))
            .toList();
        return Right(movies);
      } else {
        return Left(
          Failure('Server Error similar movies : ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      final errormessage = DioExceptionHandler.parse(e);
      return Left(Failure(errormessage));
    } catch (e) {
      return Left(Failure("Uncaught error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UpcommingMoviesModel>> getUpcommingMovies() async {
    try {
      final response = await _dio.get(ApiEndpoints.upcommingMovies);
      if (response.statusCode == 200) {
        final data = UpcommingMoviesModel.formJson(response.data);
        return right(data);
      } else {
        return Left(
          Failure(
            'Server error fetching upcomming movies :${response.statusCode}',
          ),
        );
      }
    } on DioException catch (e) {
      final error = DioExceptionHandler.parse(e);
      return Left(Failure(error));
    } catch (e) {
      return Left(Failure('Uncaught error : ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UpcommingMoviesModel>> getNowPlayingMovies() async {
    try {
      final response = await _dio.get(ApiEndpoints.nowPlaying);
      if (response.statusCode == 200) {
        final data = UpcommingMoviesModel.formJson(response.data);
        return Right(data);
      } else {
        return Left(
          Failure(
            "Server error fetching now playing movies : ${response.statusCode}",
          ),
        );
      }
    } on DioException catch (e) {
      final error = DioExceptionHandler.parse(e);
      return Left(Failure(error));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrailerModel>>> getMovieTrailers(int id,  {CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get("/movie/$id/videos", cancelToken: cancelToken);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        final data = results.map((e) => TrailerModel.fromJson(e)).toList();
        return Right(data);
      } else {
        return Left(
          Failure(
            'Server error fetching movie trailers : ${response.statusCode}',
          ),
        );
      }
    } on DioException catch (e) {
      final error = DioExceptionHandler.parse(e);
      return Left(Failure(error));
    } catch (e) {
      return Left(Failure('Uncaught error : ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> searchMovies(String query , {CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {'query': query, 'include_adult': false},
        cancelToken: cancelToken
      );
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        final movies = results.map((e) => MovieModel.fromJson(e)).toList();
        return Right(movies);
      } else {
        return Left(
          Failure('Server error fetching search : ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      if(CancelToken.isCancel(e)) {
       return left(Failure("Request Cancelled")); 
      }
      final error = DioExceptionHandler.parse(e);
      return Left(Failure(error));
    } catch (e) {
      return Left(Failure("Uncaught error : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getRecommendedMovies(int id,  {CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get("/movie/$id/recommendations", cancelToken: cancelToken);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        final movies = results.map((e) => MovieModel.fromJson(e)).toList();
        return Right(movies);
      } else {
        return Left(
          Failure('server error fetching recommended : ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      final error = DioExceptionHandler.parse(e);
      return Left(Failure(error));
    } catch (e) {
      return Left(Failure('uncaught error : ${e.toString()}'));
    }
  }
}
