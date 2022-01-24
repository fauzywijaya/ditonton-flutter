import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/item_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final Movie? movie;
  final TvShow? tvShow;
  final ItemEnum activeItem;
  final String routeName;

  const CardList({
    Key? key,
    required this.activeItem,
    this.movie,
    this.tvShow,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: kRichBlack,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeName,
              arguments: _getId(),
            );
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Card(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16 + 80 + 16,
                    bottom: 8,
                    right: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getTitle() ?? stringReplacement,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kHeading6,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _getOverview() ?? stringReplacement,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                ),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: "$baseImageUrl${_getPosterPath()}",
                    width: 80,
                    placeholder: (context, url) => const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getId() =>
      activeItem == ItemEnum.Movie ? movie?.id as int : tvShow?.id as int;

  String? _getTitle() =>
      activeItem == ItemEnum.Movie ? movie?.title : tvShow?.name;

  String _getPosterPath() => activeItem == ItemEnum.Movie
      ? movie?.posterPath as String
      : tvShow?.posterPath as String;

  String? _getOverview() =>
      activeItem == ItemEnum.Movie ? movie?.overview : tvShow?.overview;
}
