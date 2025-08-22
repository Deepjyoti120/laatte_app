import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/model/prompt.dart';
import 'package:laatte/views/relate/matching_sheet.dart';

class RelateComment extends StatefulWidget {
  static const String route = "/RelateComment";
  const RelateComment({super.key, required this.prompt});
  final Prompt prompt;
  @override
  State<RelateComment> createState() => _RelateCommentState();
}

class _RelateCommentState extends State<RelateComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: DesignColor.latteCream,
      // appBar: AppBar(
      //   elevation: 0,
      //   title: const DesignText("Comments"),
      //   backgroundColor: DesignColor.latteCream,
      // ),
      body: Stack(
        children: [
          Image.asset(
            AssetsName.pngBg,
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20, 20, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DesignText.titleSemi(
                        "See who relates you",
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: widget.prompt.comments?.length,
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = widget.prompt.comments?[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          matchNow(index);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(26),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Image.network(
                                          data!.user!.profilePicture!,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    6.width,
                                    Flexible(
                                        child: DesignText(
                                      data.comment ?? "",
                                      color: Colors.white,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> matchNow(int index) async {
    return await showModalBottomSheet<bool>(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6))),
          isScrollControlled: true,
          isDismissible: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return MatchingSheet(
              comment: widget.prompt.comments![index],
              prompt: widget.prompt,
            );
          },
        ) ??
        false;
  }
}
