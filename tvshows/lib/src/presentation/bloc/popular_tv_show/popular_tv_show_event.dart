part of 'popular_tv_show_bloc.dart';

@immutable
abstract class PopularTvShowEvent extends Equatable {}

class OnPopularTvShowCalled extends PopularTvShowEvent {
  @override
  List<Object?> get props => [];
}
