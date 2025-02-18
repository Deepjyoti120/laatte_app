import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../views/responsive.dart';

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: Responsive.isMobile(context)
      //       ? 1
      //       : Responsive.isTablet(context)
      //           ? 2
      //           : 3,
      // ),
      // children: children,
      crossAxisCount: Responsive.isMobile(context)
          ? 1
          : Responsive.isTablet(context)
              ? 2
              : 3,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
    );
  }
}
