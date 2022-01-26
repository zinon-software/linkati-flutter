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
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          height: 50.0,
                          width: 50.0,
                          image: usersController.userList[index].avatar == ''
                              ? const NetworkImage(
                                  'https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/5146d1dbf9146c4d12a7249e72065a58.png')
                              : NetworkImage(
                                  usersController.userList[index].avatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        usersController.userList[index].name == null
                            ? Text(
                                usersController.userList[index].user.username)
                            : Text(usersController.userList[index].name),
                        Text(
                            "يتابعة ${usersController.userList[index].followers.length.toString()}"),
                      ],
                    ),
                    trailing: const Icon(Icons.more_vert),
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
