
import 'package:cine_flow/core/utills/app_imports.dart';
import 'package:dio/dio.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieModel>>> getTrendingMovies();

  Future<Either<Failure, List<MovieModel>>>  getTopRatedMovies() ;

  Future<Either<Failure, List<CastModel>>> getMoviesCast(
    int id,
    {CancelToken? cancelToken}
  );

  Future<Either<Failure, MovieDetailModel>> getMovieDetails(int id, {CancelToken? cancelToken}); 

  Future<Either<Failure, List<MovieModel>>> getSimilarMovies(int id, {CancelToken? cancelToken}) ; 

  Future<Either<Failure, UpcommingMoviesModel>> getUpcommingMovies(); 

  Future<Either<Failure, UpcommingMoviesModel>>  getNowPlayingMovies(); 
   
  Future<Either<Failure, List<TrailerModel>>> getMovieTrailers(int id, {CancelToken? cancelToken});  

  Future<Either<Failure, List<MovieModel>>> searchMovies(String query, {CancelToken? cancelToken});

  Future<Either<Failure, List<MovieModel>>> getPopularMovies(); 
  
  Future<Either<Failure, List<MovieModel>>> getRecommendedMovies(int id, {CancelToken? cancelToken}); 

   
}
