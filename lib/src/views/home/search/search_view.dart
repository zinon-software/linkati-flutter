import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/users_controller.dart';
import '../profile/profile_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersController usersController = Get.find();
    late String searchString;

    void setSearchString(String value) {
      searchString = value;
      print(searchString);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: SearchBar(
          onChanged: setSearchString,
        ),
      ),
      body: Obx(
        () {
          return RefreshIndicator(
            onRefresh: () => usersController.getUsers(),
            child: ListView.builder(
              itemCount: usersController.userList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.to(() => ProfileView(
                      user: usersController.userList[index].user.id));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: ListTile(
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
                              image: NetworkImage(
                                  usersController.userList[index].avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: usersController.userList[index].name == null
                          ? Text(
                              usersController.userList[index].user.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              usersController.userList[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      subtitle: Row(
                        children: [
                          Text(
                              "يتابعة ${usersController.userList[index].followers.length.toString()}"),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              "عدد المنشورات ${usersController.userList[index].posts}"),
                        ],
                      ),
                      trailing: const Icon(Icons.more_horiz),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({required this.onChanged, Key? key}) : super(key: key);

  final Function(String) onChanged;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        onChanged: widget.onChanged,
        controller: _textEditingController,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          // contentPadding:
          //     kIsWeb ? const EdgeInsets.only(top: 10) : EdgeInsets.zero,
          prefixIconConstraints: const BoxConstraints(
            minHeight: 36,
            minWidth: 36,
          ),
          prefixIcon: const Icon(
            Icons.search,
          ),
          hintText: "Search for a product",
          suffixIconConstraints: const BoxConstraints(
            minHeight: 36,
            minWidth: 36,
          ),
          suffixIcon: IconButton(
            constraints: const BoxConstraints(
              minHeight: 36,
              minWidth: 36,
            ),
            splashRadius: 24,
            icon: const Icon(
              Icons.clear,
            ),
            onPressed: () {
              _textEditingController.clear();
              widget.onChanged(_textEditingController.text);
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ),
    );
  }
}
