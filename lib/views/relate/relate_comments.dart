import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
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
      appBar: AppBar(
        elevation: 0,
        title: const DesignText("Comments"),
      ),
      body: ListView.builder(
        itemCount: widget.prompt.comments?.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final data = widget.prompt.comments?[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                matchNow(index);
              },
              child: DesignContainer(
                blurRadius: 0,
                borderAllColor: DesignColor.grey300,
                bordered: true,
                isColor: true,
                color: DesignColor.grey50,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Optional: Add rounded corners
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5), // Adjust sigma for blur intensity
                          child: Image.network(
                            data!.user!.profilePicture!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      6.width,
                      Flexible(child: DesignText(data.comment ?? "")),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> matchNow(int index) async {
    return await showModalBottomSheet<bool>(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6))),
          isScrollControlled: true,
          isDismissible: false,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return MatchingSheet(
              comment: widget.prompt.comments![index],
            );
          },
        ) ??
        false;
  }
}
