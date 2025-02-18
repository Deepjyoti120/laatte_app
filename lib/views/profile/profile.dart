import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/utils/constants.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';
import '../../ui/theme/text.dart';
import '../../utils/design_colors.dart';
import '../widget/title_details.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = "/ProfileScreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserReportBloc>().state.userReport;
    if (user == null) {
      return Container();
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user.profilePicture != null)
              ClipRRect(
                child: Image.network(
                  user.profilePicture!,
                  height: 80,
                  width: 80,
                  errorBuilder: (context, error, stackTrace) {
                    return ClipRRect(
                      child: SvgPicture.network(
                        user.profilePicture!,
                        height: 80,
                        width: 80,
                        clipBehavior: Clip.antiAlias,
                      ),
                    );
                  },
                ),
              ),
            8.height,
            DesignContainer(
              blurRadius: 12,
              borderAllColor: DesignColor.grey300,
              bordered: true,
              isColor: true,
              color: DesignColor.grey50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DesignText(
                      "Profile Details",
                      fontSize: 18,
                    ),
                    const Divider(color: DesignColor.grey),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleDetailsCard(
                          title: "Name",
                          text: user.name,
                        ),
                        TitleDetailsCard(
                          title: "Role",
                          text: user.role?.toUpperCase(),
                        ),
                      ],
                    ),
                    TitleDetailsCard(
                      title: "Email",
                      text: user.email,
                    ),
                    TitleDetailsCard(
                      title: "Phone",
                      text: user.phone,
                    ),
                  ],
                ),
              ),
            ),
            12.height,
          ],
        ),
      ),
    );
  }
}
