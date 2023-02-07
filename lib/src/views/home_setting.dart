import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkati/src/controllers/Notification_controller.dart';

import '../../main.dart';
import 'admin/admin_view.dart';
import 'home/form/form_post_view.dart';
import 'home/main/main_view.dart';
import 'home/profile/profile_view.dart';
import 'home/search/search_view.dart';
import 'home/notification/notifiy_view.dart';

import 'package:badges/badges.dart';

class HomeScreenControl extends StatefulWidget {
  @override
  _HomeScreenControlState createState() => _HomeScreenControlState();
}

class _HomeScreenControlState extends State<HomeScreenControl> {
  final NotificationController notifyController = Get.find();

  var _selectedTab = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  final List<Widget> _children = [
    const MainView(),
    const SearchView(),
    const FromPostView(),
    const NotifiyView(),
    ProfileView(user: prefs!.getInt('user_id')),
    if (prefs!.getInt('user_id') == 1) const AdminView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[_selectedTab],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          margin: const EdgeInsets.only(left: 10, right: 10),
          currentIndex: _selectedTab,
          dotIndicatorColor: Colors.white,
          unselectedItemColor: Colors.grey[500],
          enableFloatingNavBar: (prefs!.getInt('user_id') != 1) ? true : false,
          onTap: _handleIndexChanged,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: const Color(0xff73544C),
            ),

            /// Search
            DotNavigationBarItem(
              icon: const Icon(Icons.search),
              selectedColor: const Color(0xff73544C),
            ),

            /// Add Post
              DotNavigationBarItem(
                icon: const Icon(Icons.add_link_sharp),
                selectedColor: const Color(0xff73544C),
              ),

            /// Likes
            DotNavigationBarItem(
              icon: Obx(
                () {
                  return notifyController.getNotifyCount > 0
                      ? Badge(
                          animationType: BadgeAnimationType.slide,
                          badgeContent: Text(
                              "${notifyController.getNotifyCount}",
                              style: const TextStyle(color: Colors.white)),
                          child: const Icon(Icons.notifications),
                        )
                      : const Icon(Icons.notifications);
                },
              ),
              selectedColor: const Color(0xff73544C),
            ),

            /// Profile
            DotNavigationBarItem(
              icon: const Icon(Icons.person),
              selectedColor: const Color(0xff73544C),
            ),

            /// Admin
            if (prefs!.getInt('user_id') == 1)
              DotNavigationBarItem(
                icon: const Icon(Icons.admin_panel_settings),
                selectedColor: const Color(0xff73544C),
              ),
          ],
        ),
      ),
    );
  }
}
