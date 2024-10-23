import 'package:flutter/material.dart';

class DashLines extends StatelessWidget {
  const DashLines(
      {super.key, this.width = 1, this.color = Colors.black, this.count = 3});

  final double width;
  final Color color;
  final int count;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
          children: List.generate(count, (_) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 2,
                  height: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color),
                  ),
                ),
                const SizedBox(
                  width: 2,
                  height: 5,
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
