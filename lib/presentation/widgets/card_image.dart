import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/item_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    Key? key,
    required this.activeDrawerItem,
    required this.routeNameDestination,
    this.movie,
    this.tvShow,
  }) : super(key: key);

  final Movie? movie;
  final TvShow? tvShow;
  final ItemEnum activeDrawerItem;
  final String routeNameDestination;

  @override
  Widget build(BuildContext context) {
    final id =
        activeDrawerItem == ItemEnum.Movie ? movie?.id : tvShow?.id as int;
    final posterPath = activeDrawerItem == ItemEnum.Movie
        ? movie?.posterPath
        : tvShow?.posterPath as String;

    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            routeNameDestination,
            arguments: id,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: CachedNetworkImage(
            imageUrl: '$BASE_IMAGE_URL$posterPath',
            placeholder: (context, url) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
