import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../ui/theme/text.dart';
import '../../../utils/design_colors.dart';
import '../../../viewmodel/cubit/app_cubit.dart';

class DrawerItem extends StatefulWidget {
  const DrawerItem(
      {super.key,
      required this.title,
      this.items,
      this.onTap,
      this.iconData,
      this.customIcon});
  final String title;
  final List<DrawerListItem>? items;
  final Function()? onTap;
  final IconData? iconData;
  final Widget? customIcon;
  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return Column(
      children: [
        ListTile(
          trailing: widget.items?.isEmpty ?? true
              ? null
              : isExpanded
                  ? const Icon(
                      FontAwesomeIcons.chevronUp,
                      size: 14,
                    )
                  : const Icon(
                      FontAwesomeIcons.chevronDown,
                      size: 14,
                    ),
          title: DesignText.body(
            widget.title,
            color: appState.isDarkMode ? Colors.white : null,
            // color: DesignColor.colorPrimary2,
          ),
          leading: Container(
            width: 24,
            height: 24,
            padding: const EdgeInsets.only(top: 2),
            alignment: Alignment.center,
            child: widget.customIcon ??
                Icon(
                  widget.iconData ?? FontAwesomeIcons.house,
                  size: 16,
                  color: DesignColor.teal,
                ),
          ),
          onTap: () {
            if (widget.items?.isEmpty ?? true) {
              widget.onTap!();
            } else {
              setState(() {
                isExpanded = !isExpanded;
              });
            }
          },
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutBack,
          child: Visibility(
            maintainState: true,
            visible: isExpanded,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.items?.length ?? 0,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int subIndex) {
                final subTitle = widget.items![subIndex];
                return ListTile(
                  title: DesignText.body(
                    subTitle.title,
                  ),
                  onTap: subTitle.onTap,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DrawerListItem {
  final String title;
  final Function() onTap;
  DrawerListItem({
    required this.title,
    required this.onTap,
  });
}
