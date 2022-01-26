import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/post_model.dart';
import '../../home/post/post_view.dart';
import 'body_card.dart';
import 'footer_card.dart';
import 'header_cart.dart';
import 'like_widget.dart';

Widget _buildPost({required Posts post}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: Container(
      width: double.infinity,
      height: 560.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x73000000),
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          height: 50.0,
                          width: 50.0,
                          image: NetworkImage(post.createdBy!.avatar!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    post.createdBy!.name ?? "بدون اسم",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(timeago.format(post.createdDt!, locale: "ar")),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_horiz),
                    color: Colors.black,
                    onPressed: () => print('More'),
                  ),
                ),
                InkWell(
                  onDoubleTap: () => print('Like post'),
                  onTap: () {
                    Get.to(() => PostView(post: post));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    height: 400.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 5),
                          blurRadius: 8.0,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(post.link!),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          LieksWidget(post: post),
                          const SizedBox(width: 20.0),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.chat),
                                iconSize: 30.0,
                                onPressed: () {
                                  Get.to(() => PostView(post: post));
                                },
                              ),
                              const Text(
                                '350',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        iconSize: 30.0,
                        onPressed: () => print('Save post'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget cardWidget({required Posts post}) {
  return post.dataType == "POST"
      ? _buildPost(post: post)
      : InkWell(
          // onTap: press,
          child: Column(
            children: [
              headerCart(post: post),
              bodyCard(post: post),
              footerCard(post: post),
            ],
          ),
        );
}
