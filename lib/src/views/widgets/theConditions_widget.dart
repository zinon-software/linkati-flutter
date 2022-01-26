import 'package:flutter/material.dart';
import 'package:get/get.dart';

theConditions() {
    return Get.defaultDialog(
      title: "السياسة والشروط",
      textCancel: "Okay",
      content:  SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(
                height: 20.0 / 3,
              ),
              Text("بسم الله الرحمن الرحيم"),
              SizedBox(
                height: 20.0 / 3,
              ),
              Icon(Icons.report),
              Text(" قم بتعبئة جميع الحقول "),
              SizedBox(
                height: 20.0 / 3,
              ),
              Text(" لن يتم عرض الرابط المنشٌُور الا بعد التاكد من صحته "),
              SizedBox(
                height: 20.0 / 3,
              ),
              Text(
                  " لاتقم بتكرار الرابط عند تعقبنا لتكرار يتم حذف جميع الروابط "),
              SizedBox(
                height: 20.0 / 3,
              ),
              Text(" احرص علئ ان يحصل الرابط الخاص بك على اعلى نسب المشاهدة "),
              SizedBox(
                height: 20.0 / 3,
              ),
              Text("تاكد بان حقل الرابط لا يحتوي على احرف او كلمات زائدة "),
              SizedBox(
                height: 20.0 / 3,
              ),
              Text(
                  "يمكنك نشر جميع حسابتك من مختلف منصات التواصل الاجتماعي مثلاً  Tik Tok   يوتيوب سناب واتساب.... "),
            ],
          ),
        ),
        
    );
  }