import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/cubit/app_cubit.dart';
import '../../views/home/dwawer/app_drawer.dart';
import '../../views/responsive.dart';
import '../animation/custom_animation.dart';

class ResponsiveDrawer extends StatelessWidget {
  const ResponsiveDrawer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return Scaffold(
      body: Flex(
        direction: Axis.horizontal,
        children: [
          if (Responsive.isTablet(context))
            DAnimation(
              visible: appState.isOpenDrawer,
              child: Container(
                color: Colors.white,
                height: double.infinity,
                child: const AppDrawer(),
              ),
            ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
