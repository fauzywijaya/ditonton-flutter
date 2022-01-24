library core;

// --------- DATA
// -> DATA SOURCES
// --> DB
export './data/datasources/db/database_helper.dart';

export './data/datasources/movie_local_data_source.dart';
export './data/datasources/movie_remote_data_source.dart';
export './data/datasources/tv_show_local_data_source.dart';
export './data/datasources/tv_show_remote_data_source.dart';

// -> MODELS
export './data/models/genre_model.dart';
export './data/models/movie_detail_model.dart';
export './data/models/movie_model.dart';
export './data/models/movie_response.dart';
export './data/models/movie_table.dart';
export './data/models/season_model.dart';
export './data/models/tv_show_detail_model.dart';
export './data/models/tv_show_model.dart';
export './data/models/tv_show_response.dart';
export './data/models/tv_show_table.dart';

// -> REPOSITORIES
export './data/repositories/movie_repository_impl.dart';
export './data/repositories/tv_show_repository_impl.dart';
// --------- END DATA

// --------- DOMAIN
// -> ENTITIES
export './domain/entities/genre.dart';
export './domain/entities/movie.dart';
export './domain/entities/movie_detail.dart';
export './domain/entities/season.dart';
export './domain/entities/tv_show.dart';
export './domain/entities/tv_show_detail.dart';

// -> REPOSITORIES
export './domain/repositories/movie_repository.dart';
export './domain/repositories/tv_show_repository.dart';

// -> USECASES
// --> MOVIE
export './domain/usecases/movie/get_movie_detail.dart';
export './domain/usecases/movie/get_movie_recommendations.dart';
export './domain/usecases/movie/get_now_playing_movies.dart';
export './domain/usecases/movie/get_popular_movies.dart';
export './domain/usecases/movie/get_top_rated_movies.dart';
export './domain/usecases/movie/get_watchlist_movies.dart';
export './domain/usecases/movie/get_watchlist_status.dart';
export './domain/usecases/movie/search_movies.dart';
export './domain/usecases/movie/remove_watchlist.dart';
export './domain/usecases/movie/save_watchlist.dart';

// --> TV SHOW
export './domain/usecases/tvshow/get_now_playing_tv_show.dart';
export './domain/usecases/tvshow/get_popular_tv_show.dart';
export './domain/usecases/tvshow/get_top_rated_tv_show.dart';
export './domain/usecases/tvshow/get_tv_show_detail.dart';
export './domain/usecases/tvshow/get_tv_show_recommendations.dart';
export './domain/usecases/tvshow/get_watchlist_tv_show.dart';
export './domain/usecases/tvshow/get_watchlist_tv_show_status.dart';
export './domain/usecases/tvshow/search_tv_show.dart';
export './domain/usecases/tvshow/remove_tv_show_watchlist.dart';
export './domain/usecases/tvshow/save_tv_show_watchlist.dart';
// -> END USECASE
// --------- DOMAIN

// --------- PRESENTATION
export './presentation/widgets/card_image.dart';
export './presentation/widgets/card_list.dart';
export './presentation/widgets/scrollable_sheet.dart';
export './presentation/widgets/sub_heading.dart';
// --------- END PRESENTATION

// --------- UTILS
export './utils/constants.dart';
export './utils/item_enum.dart';
export './utils/exception.dart';
export './utils/failure.dart';
export './utils/utils.dart';
export './utils/state_enum.dart';
// --------- END UTILS

// --------- STYLES
export './styles/colors.dart';
export './styles/text_styles.dart';
