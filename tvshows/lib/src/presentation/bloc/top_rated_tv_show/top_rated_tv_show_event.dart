part of 'top_rated_tv_show_bloc.dart';

@immutable
abstract class TopRatedTvShowEvent extends Equatable {}

class OnTopRatedTvShowCalled extends TopRatedTvShowEvent {
  @override
  List<Object> get props => [];
}
