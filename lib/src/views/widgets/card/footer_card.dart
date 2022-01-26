import 'package:flutter/material.dart';

import '../../../models/post_model.dart';
import 'like_widget.dart';

Container footerCard({  Posts? post}) => Container(
  color: Colors.black.withOpacity(0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children:  [
              LieksWidget(post: post),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                // child: Icon(Icons.chat_bubble_outline),
              ),
              // const Icon(Icons.share),
            ],
          ),
          // const Icon(Icons.bookmark),
        ],
      ),
    );
