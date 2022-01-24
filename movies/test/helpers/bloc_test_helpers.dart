import 'package:core/core.dart'
    show
        GetMovieDetail,
        GetMovieRecommendations,
        GetNowPlayingMovies,
        GetPopularMovies,
        GetWatchlistMovies,
        SaveWatchlist,
        RemoveWatchlist,
        GetWatchListStatus,
        GetTopRatedMovies;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetWatchListStatus,
  GetWatchlistMovies,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {}
