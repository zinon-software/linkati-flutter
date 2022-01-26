import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkati/src/models/post_model.dart';

import '../../../../main.dart';
import '../../../controllers/admin_contrroller.dart';
import '../../../controllers/post_controller.dart';
import '../../home/profile/profile_view.dart';

Padding headerCart({required Posts post}) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => ProfileView(user: post.createdBy?.id));
            },
            child: Row(
              children: [
                post.createdBy?.avatar == null
                    ? Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.04),
                        ),
                      )
                    : Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image(
                            height: 50.0,
                            width: 50.0,
                            image: NetworkImage(post.createdBy!.avatar!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  post.createdBy!.name ?? 'بدون اسم', 
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (prefs!.getInt('user_id') == post.createdBy!.id ||
              prefs!.getInt('user_id') == 1)
            PopupMenuButton(
              padding: const EdgeInsets.all(0),
              offset: const Offset(15, 65),
              // enabled: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return [
                  if (prefs!.getInt('user_id') == 1)
                    PopupMenuItem(
                      child: ListTile(
                        leading: Icon(
                          Icons.share_outlined,
                          color: Colors.blueAccent[400],
                        ),
                        title: const Text('نشر'),
                      ),
                      onTap: () {
                        final AdminController adminController = Get.find();

                        adminController.sharePostAdmin(post.id.toString());
                      },
                    ),
                  PopupMenuItem(
                    child: ListTile(
                        leading: Icon(
                          Icons.edit_outlined,
                          color: Colors.blueAccent[400],
                        ),
                        title: const Text('تعديل')),
                    onTap: () => print(1),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                        leading: Icon(
                          Icons.delete_forever,
                          color: Colors.blueAccent[400],
                        ),
                        title: const Text('حذف')),
                    onTap: () {
                      final PostController postController = Get.find();
                      postController.deleteGroup(groupID: post.id.toString());
                    },
                  ),
                ];
              },
            ),
        ],
      ),
    ); // end header