import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppHorizontalCardList extends StatelessWidget {
  const AppHorizontalCardList({
    super.key,
    required this.children,
    this.height = 300,
    this.cardWidth = 280,
  });

  final List<Widget> children;
  final double height;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    final items = children.take(5).toList();

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: context.spacingS,
          );
        },
        itemBuilder: (context, index) {
          return SizedBox(
            width: cardWidth,
            child: items[index],
          );
        },
      ),
    );
  }
}