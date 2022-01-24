part of 'tv_show_detail_bloc.dart';

@immutable
abstract class TvShowDetailEvent extends Equatable {}

class OnTvShowDetailCalled extends TvShowDetailEvent {
  final int id;

  OnTvShowDetailCalled(this.id);

  @override
  List<Object> get props => [id];
}
