import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/comments/local_widget/custom_comment.dart';
import 'package:daily_client/src/widget/custom_company_info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommentsScreen extends StatefulWidget {
  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late CommentsProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<CommentsProvider>();
    final commentList = provider.isLoading && provider.comments.isEmpty
        ? const Center(child: SpinKitRipple(color: Colors.black))
        : !provider.isLoading && provider.comments.isEmpty
            ? Center(
                child: CustomText(
                  tag: 'comments.noComments',
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.5),
                ),
              )
            : ListView.builder(
                controller: provider.commentScrollController,
                itemBuilder: (context, index) => CustomComment(provider.comments[index]),
                itemCount: provider.comments.length,
              );

    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              CustomImageAppBar(provider.company.cover),
              const CustomBack(withRowPosition: true),
            ],
          ),
          CustomForm(
            form: Column(
              children: [
                const SizedBox(height: 8),
                CustomCompanyInfo(provider.company),
                Expanded(child: commentList),
              ],
            ),
            image: provider.company.avatar,
            imageRadius: 35,
          ),
        ],
      ),
    );
  }
}
