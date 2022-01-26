
import 'package:flutter/material.dart';

class BubbleStories extends StatelessWidget {
  const BubbleStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.04),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
           Container(
            height: 13,
            width: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.04),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
          )
        ],
      ),
    );
  }
}
