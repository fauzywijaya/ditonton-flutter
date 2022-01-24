import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart'
    show ItemEnum, Movie, TvShow, baseImageUrl, kRichBlack;
import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    Key? key,
    required this.activeItem,
    required this.routeNameDestination,
    this.movie,
    this.tvShow,
  }) : super(key: key);

  final Movie? movie;
  final TvShow? tvShow;
  final ItemEnum activeItem;
  final String routeNameDestination;

  @override
  Widget build(BuildContext context) {
    final id = activeItem == ItemEnum.Movie ? movie?.id : tvShow?.id as int;
    final posterPath = activeItem == ItemEnum.Movie
        ? movie?.posterPath
        : tvShow?.posterPath as String;

    return Container(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: kRichBlack,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeNameDestination,
              arguments: id,
            );
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: '$baseImageUrl$posterPath',
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
