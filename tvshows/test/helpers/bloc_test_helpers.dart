import 'package:core/core.dart'
    show
        GetNowPlayingTvShows,
        GetPopularTvShows,
        GetTvShowDetail,
        GetTvShowRecommendations,
        GetTopRatedTvShows,
        GetTvShowWatchlistStatus,
        GetWatchlistTvShows,
        SaveTvShowWatchlist,
        RemoveTvShowWatchlist;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetNowPlayingTvShows,
  GetPopularTvShows,
  GetTopRatedTvShows,
  GetTvShowWatchlistStatus,
  GetWatchlistTvShows,
  SaveTvShowWatchlist,
  RemoveTvShowWatchlist,
])
void main() {}
