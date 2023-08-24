import 'package:c_hat/dev/ext/widget_ext.dart';
import 'package:c_hat/model/user/user.dart';
import 'package:c_hat/ui/mobile/login/login_widget.dart';
import 'package:c_hat/ui/mobile/user/user_widget.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_event.dart';
import 'package:c_hat/ui/shared/user_list_bloc/user_list_bloc.dart';
import 'package:c_hat/ui/shared/user_list_bloc/user_list_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/ui/mobile/user_list/user_list_element.dart';

class UserListRoute extends StatefulWidget {
  final UserListBloc listBloc = UserListBloc();
  final User loggedInUser;
  final Platform platform;

  final _clientIdController = TextEditingController();
  final _nameController = TextEditingController();

  UserListRoute(this.platform, {required this.loggedInUser, Key? key})
      : super(key: key);

  @override
  State<UserListRoute> createState() => _UserListRouteState();
}

class _UserListRouteState extends State<UserListRoute> {

  var _screenIndex = 0;

  Widget _body() {
    switch (_screenIndex) {
      case 0:
        return _UserList(widget.platform, listBloc: widget.listBloc);
      case 1:
        return _AboutMe(widget.platform);
      default:
        return _UserList(widget.platform, listBloc: widget.listBloc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      widget.platform,
      appBar: AppBar(
        title: const Text("Friends and Groups"),
        actions: [
          IconButton(onPressed: (){
            showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  content: const SizedBox(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: Text("Are you sure you wanna log out? This will delete all your messages"),
                    ),
                  ),

                  actions: [
                    TextButton(onPressed: () {
                      context.read<ChatBloc>().add(LogoutEvent());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginRoute(widget.platform))
                      );
                    }, child: const Text("Yes")),

                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text("No")),
                  ],
                );
              }
            );
          }, icon: const Icon(Icons.logout))
        ],
      ),
      cupertinoBar: const CupertinoNavigationBar(
        middle: Text("Friends and Groups"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screenIndex,
        onTap: (index) {
          setState(() {
            _screenIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "You")
        ]
      ),
      body: _body(),
      fabLocation: FloatingActionButtonLocation.centerDocked,
      actionButton: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16)
        ),
        child: FloatingActionButton(onPressed: onUserAddButtonPressed, child: const Icon(Icons.person_add),
      ).withPadding())
    );
  }

  void onUserAddButtonPressed() {
    showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 300,
            child: AlertDialog(
                content: SizedBox(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: PlatformTextField(widget.platform,
                          hint: "Client ID",
                          controller: widget._clientIdController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: PlatformTextField(widget.platform,
                          hint: "Name", controller: widget._nameController),
                    ),
                    PlatformFilledButton(
                      widget.platform,
                      minimumWidth: 50,
                      onPressed: () {
                        widget.listBloc.add(UserAddEvent(User(
                            clientId: widget._clientIdController.text,
                            username: widget._nameController.text)));
                        Navigator.pop(context);
                      },
                      child: const Text("Add"),
                    )
                  ],
                ),
              ),
            )),
          );
        });
  }
}

class _UserList extends StatelessWidget {

  final UserListBloc listBloc;
  final Platform platform;

  const _UserList(this.platform, {required this.listBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserListBloc>.value(
        value: listBloc..add(AllUsersRequestedFromDatabaseEvent()),
        child: BlocBuilder<UserListBloc, List<User>>(
            builder: (blocContext, userState) {
          return ListView.builder(
            itemCount: userState.length,
            itemBuilder: (context, index) {
              return UserListElement(platform, user: userState[index]);
            },
          );
        }),
      );
  }
}

class _AboutMe extends StatelessWidget {

  final Platform platform;

  const _AboutMe(this.platform);

  @override
  Widget build(BuildContext context) {
    return UserView(platform, user: context.read<ChatBloc>().loggedInUser);
  }
}
