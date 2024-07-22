import 'dart:math';

import 'package:flutter/material.dart';

class CustomSliverPersistentHeader extends StatelessWidget {
  final Widget child;
  final bool includePadding;
  final bool pinned;
  final bool floating;
  const CustomSliverPersistentHeader({
    super.key,
    required this.child,
    this.includePadding = true,
    this.pinned = true,
    this.floating = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: pinned,
      floating: floating,
      delegate: CustomSliverPersistentHeaderDelegate(
        minHeight: kToolbarHeight,
        maxHeight: kToolbarHeight,
        child: Container(
          color: Theme.of(context).colorScheme.background,
          padding: includePadding
              ? const EdgeInsets.symmetric(horizontal: 16)
              : const EdgeInsets.all(0),
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: [
              SliverFillRemaining(hasScrollBody: false, child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  CustomSliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(CustomSliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
