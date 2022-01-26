import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ads/ads_controllers/rewarded_ad_controller.dart';
import '../../../controllers/form_post_controller.dart';
import '../../widgets/dropdown_widget.dart';
import '../../widgets/theConditions_widget.dart';

class FromPostView extends StatelessWidget {
  const FromPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FromPostController fromPostController = Get.find();
    fromPostController.isPost(false);

    final _formKey = GlobalKey<FormState>();
    // ignore: unused_field
    String? _titel, _link, _message;

    final RewardedAdController rewardedAdController =
        Get.put(RewardedAdController());

    _submit() async {
      if (rewardedAdController.myCoins.value! > 0) {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState?.save();
          fromPostController.postData(
            titel: _titel,
            link: _link!.trim(),
            message: _message,
          );
        }
      } else {
        _DailogCouns(rewardedAdController, "الحصول علئ نقاط");
      }
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: InkWell(
            onTap: () => theConditions(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "السياسة والشروط",
                  style: TextStyle(color: Colors.red),
                ),
                Icon(
                  Icons.report,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Obx(() {
                  return Text(
                    "${rewardedAdController.myCoins.value}",
                    style: const TextStyle(color: Colors.red, fontSize: 30),
                  );
                }),
                const Icon(Icons.monetization_on,
                    size: 36.0, color: Color.fromRGBO(218, 165, 32, 1.0)),
              ],
            ),
          ],
        ),
        body: Center(
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            if (rewardedAdController.myCoins.value! > 30) {
                              fromPostController.isPost(true);
                            } else {
                              _DailogCouns(rewardedAdController,
                                  "ليس لديك قدر كافي من النقاط. لمشاركة منشور تحتاج لي 30 نقطة");
                            }
                          },
                          child: const Text("هل ترغب بمشاركة منشور")),
                      const DropdownWidget(),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Obx(
                          () {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                    vertical: 10.0,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    onSaved: (input) => _titel = input,
                                    decoration: InputDecoration(
                                      labelText: fromPostController.isPost()
                                          ? "عنوان المنشور "
                                          : "عنوان المجموعة",
                                      hintText: "اكتب هنا العنوان",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    validator: (input) => input!.length < 4
                                        ? 'يجب  الا يقل العنوان عن 4 احرف'
                                        : null,
                                  ),
                                ),
                                if (fromPostController.isPost())
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0,
                                      vertical: 10.0,
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      onSaved: (input) => _message = input,
                                      decoration: const InputDecoration(
                                        hintText: "بم تفكر؟",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                    vertical: 10.0,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.url,
                                    onSaved: (input) => _link = input,
                                    decoration: InputDecoration(
                                      labelText: fromPostController.isPost()
                                          ? " (رابط صورة المنشور (قم باخذ الرابط من الانترنت"
                                          : " رابط المجموعة",
                                      hintText: "اضف هنا الرابط",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    validator: (input) =>
                                        !input!.contains('http')
                                            ? 'الرابط غير صحيح'
                                            : null,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      primary: Colors.black,
                                      backgroundColor: const Color.fromARGB(
                                          255, 127, 196, 241),
                                    ),
                                    onPressed: _submit,
                                    child: const Text(
                                      'مشاركة',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Billabong',
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void _DailogCouns(RewardedAdController rewardedAdController, String titel) =>
      Get.defaultDialog(
        title: titel,
        textCancel: "إغلاق",
        content: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "قم بمشاهدة الاعلان للحصول على نقاط المكافئة",
                  style: Get.textTheme.headline6,
                ),
                Obx(() {
                  return Row(
                    children: [
                      rewardedAdController.isAdReady()
                          ? ElevatedButton(
                              onPressed: () {
                                rewardedAdController.showRewardedAd();
                              },
                              child: const Text('مشاهدة'),
                            )
                          : ElevatedButton(
                              onPressed: () {},
                              child: const Text('جاري التحميل ...'),
                            ),
                      const SizedBox(width: 8),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      );
}
