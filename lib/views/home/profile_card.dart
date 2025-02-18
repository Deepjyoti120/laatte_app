import 'package:flutter/material.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, this.user});

  final UserReport? user;

  @override
  Widget build(BuildContext context) {
    return DesignContainer(
      blurRadius: 0,
      borderAllColor: DesignColor.grey300,
      bordered: true,
      isColor: true,
      color: DesignColor.grey50,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            _buildProfileImage(),
            6.width,
            _buildUserDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return user?.profilePicture != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              user!.profilePicture!,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ).animate().fadeIn(duration: 600.ms)
        : const SizedBox(
            height: 80,
            width: 80,
          );
  }

  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DesignText.titleSemiBold(user?.name ?? ""),
        DesignText.body(user?.designation?.title ?? ""),
        DesignText.body("ID: ${user?.username ?? ""}"),
      ],
    );
  }
}
