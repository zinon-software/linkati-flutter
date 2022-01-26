import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_contrroller.dart';
import '../widgets/card/body_card.dart';
import '../widgets/card/footer_card.dart';
import '../widgets/card/header_cart.dart';
import '../widgets/card/not_found_card.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminController adminController =
        Get.put(AdminController(), permanent: true);

    return Scaffold(
      body: Obx(
        () {
          return RefreshIndicator(
            onRefresh: () => adminController.getData(),
            child: adminController.adminPostsList.isEmpty
                ? notFoundCard // getter not found card
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: adminController.adminPostsList.length,
                    itemBuilder: (context, index) => InkWell(
                      // onTap: press,
                      child: Column(
                        children: [
                          headerCart(
                              post: adminController.adminPostsList[index]),
                          bodyCard(post: adminController.adminPostsList[index]),
                          footerCard(
                              post: adminController.adminPostsList[index]),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
