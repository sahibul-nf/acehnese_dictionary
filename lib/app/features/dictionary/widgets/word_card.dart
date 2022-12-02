import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:acehnese_dictionary/app/utils/typography.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:unicons/unicons.dart';

class WordCard extends StatelessWidget {
  const WordCard(
      {Key? key,
      required this.language,
      required this.word,
      required this.imageUrl,
      this.marginVertical,
      this.marginHorizontal})
      : super(key: key);
  final String language;
  final String word;
  final String? imageUrl;
  final double? marginVertical;
  final double? marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal ?? 20, vertical: marginVertical ?? 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColor.secondary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: (imageUrl != null)
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Center(
                          child: LoadingAnimationWidget.threeArchedCircle(
                            color: AppColor.primary,
                            size: 20,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.broken_image_rounded);
                      },
                    )
                  : const Icon(
                      UniconsLine.image_v,
                      color: AppColor.secondary,
                    ),
            ),
          ),
          const SizedBox(width: 16),
          // Word value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.fontStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Word language
          Text(
            language,
            style: AppTypography.fontStyle(
              color: AppColor.secondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
