 

import 'package:fpdart/fpdart.dart';
import 'package:cine_flow/core/errors/failure.dart';
import 'package:cine_flow/features/movies/data/models/movie_model.dart';

abstract class StorageServices {
 Future<Either<Failure, Unit>> cacheTrendingMovies(List<MovieModel> movies) ;  
 Future<Either<Failure, Unit>> cacheTopRatedMovies(List<MovieModel> movies) ;  
 Future<Either<Failure, List<MovieModel>>> fetchCachedTrendingMovies(); 
 Future<Either<Failure, List<MovieModel>>> fetchCachedTopRatedMovies(); 
 bool get hasData ;
 bool get hasTopRatedMovies ;
}
