import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../controllers/like_controller.dart';
import '../../../models/post_model.dart';

class LieksWidget extends StatefulWidget {
  const LieksWidget({
    Key? key,
    this.post,
  }) : super(key: key);
  final Posts? post;

  @override
  _LieksHendlerState createState() => _LieksHendlerState();
}

class _LieksHendlerState extends State<LieksWidget> {
  final LikeController fromPostController = Get.find();
  bool isLike = false;
  // ignore: non_constant_identifier_names
  int like_count = 0;

  @override
  void initState() {
    like_count = widget.post!.likes!.length;
    super.initState();
    setLiek();
  }

  void setLiek() {
    widget.post!.likes!.map((e) {
      if (e.id == prefs!.getInt('user_id')) {
        setState(() {
          isLike = !isLike;
        });
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: (isLike == false)
              ? const Icon(
                  Icons.favorite_border,
                  size: 30.0,
                )
              : const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30.0,
                ),
          onPressed: () {
            fromPostController.getData(postID: widget.post!.id.toString());
            if (isLike == false) {
              setState(() {
                isLike = !isLike;
                like_count += 1;
              });
            } else {
              setState(() {
                isLike = !isLike;
                like_count -= 1;
              });
            }
          },
        ),
        Text(
          like_count.toString() + ' إعجاب',
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ), // تعديل جديد
      ],
    );
  }
}
