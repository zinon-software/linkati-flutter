import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../../../models/post_model.dart';

Container bodyCard({required Posts post}) => Container(
      // height: 200,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20.0),
          Text(post.titel!),
          const SizedBox(height: 20.0),
          Center(
            child: Link(
              uri: Uri.parse(post.link!),
              target: LinkTarget.blank,
              builder: (BuildContext ctx, FollowLink? openLink) {
                return TextButton.icon(
                  onPressed: openLink,
                  label: Text('المتابعة الئ ${post.category!.name}'),
                  icon: const Icon(Icons.read_more),
                );
              },
            ),
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.visibility,
                        color: Colors.black26,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text('${post.views}'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text(timeago.format(post.createdDt!, locale: "ar")),
                    ],
                  ),
                )
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
