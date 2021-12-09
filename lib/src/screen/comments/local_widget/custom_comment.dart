import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/comments/local_model/comment_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomComment extends StatelessWidget {
  final CommentModel comment;
  const CustomComment(this.comment);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: comment.avatar == null
            ? null
            : CachedNetworkImageProvider(comment.avatar!),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: comment.name == null || comment.name!.isEmpty
                ? tr('comments.noName')
                : comment.name,
            fontWeight: FontWeight.w700,
            color: lightBlack,
            fontSize: 12,
          ),
          CustomText(
            text: comment.date,
            fontSize: 7,
            color: grey,
          ),
          RatingBar(
            initialRating: comment.rate.toDouble(),
            ignoreGestures: true,
            itemSize: 15,
            ratingWidget: RatingWidget(
              full: const Icon(Icons.star, color: amber),
              half: const Icon(Icons.star_border, color: amber),
              empty: const Icon(Icons.star_border, color: amber),
            ),
            onRatingUpdate: (rating) {},
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: comment.body,
            maxLines: 100,
            color: lightBlack,
          ),
        ],
      ),
    );
  }
}
