import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/form_post_controller.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({Key? key}) : super(key: key);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  final FromPostController fromPostController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: const Color.fromARGB(255, 127, 196, 241),
      child: Obx(
        () {
          return DropdownButton(
            hint: const Text(" أختيار القسم"),
            items: fromPostController.dataSelection.map(
              (item) {
                return DropdownMenuItem(
                  child: Center(child: Text(item.name)),
                  value: item.id,
                );
              },
            ).toList(),
            onChanged: (newVal) {
              fromPostController.setSelected(newVal);

              setState(() {});
            },
            value: fromPostController.getSelection,
          );
        },
      ),
    );
  }
}
