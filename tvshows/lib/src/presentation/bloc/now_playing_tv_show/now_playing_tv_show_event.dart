part of 'now_playing_tv_show_bloc.dart';

@immutable
abstract class NowPlayingTvShowEvent extends Equatable {}

class OnNowPlayingTvShowCalled extends NowPlayingTvShowEvent {
  @override
  List<Object> get props => [];
}
