
import 'package:cine_flow/core/utills/app_imports.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieModel>>> getTrendingMovies();

  Future<Either<Failure, List<MovieModel>>>  getTopRatedMovies() ;

  Future<Either<Failure, List<CastModel>>> getMoviesCast(
    int id,
  );

  Future<Either<Failure, MovieDetailModel>> getMovieDetails(int id); 

  Future<Either<Failure, List<MovieModel>>> getSimilarMovies(int id) ; 

  Future<Either<Failure, UpcommingMoviesModel>> getUpcommingMovies(); 

  Future<Either<Failure, UpcommingMoviesModel>>  getNowPlayingMovies(); 
   
  Future<Either<Failure, List<TrailerModel>>> getMovieTrailers(int id);  

  Future<Either<Failure, List<MovieModel>>> searchMovies(String query);

  Future<Either<Failure, List<MovieModel>>> getPopularMovies(); 
  
  Future<Either<Failure, List<MovieModel>>> getRecommendedMovies(int id); 

   
}
