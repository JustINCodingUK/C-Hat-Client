import 'package:c_hat/model/user/user.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_bloc.dart';
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
  final ChatWidgetBloc bloc;
  final Platform platform;

  final _clientIdController = TextEditingController();
  final _nameController = TextEditingController();

  UserListRoute(this.platform, this.bloc,
      {required this.loggedInUser, Key? key})
      : super(key: key);

  @override
  State<UserListRoute> createState() => _UserListRouteState();
}

class _UserListRouteState extends State<UserListRoute> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      widget.platform,
      appBar: AppBar(
        title: const Text("Friends and Groups"),
      ),
      cupertinoBar: const CupertinoNavigationBar(
        middle: Text("Friends and Groups"),
      ),
      body: BlocProvider<UserListBloc>.value(
        value: widget.listBloc,
        child: BlocBuilder<UserListBloc, List<User>>(
            builder: (blocContext, state) {
              blocContext.read<UserListBloc>().add(AllUsersRequestedFromDatabaseEvent());
              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return UserListElement(
                    widget.platform,
                    widget.bloc,
                    user: state[index],
                  );
                },
              );
            }),
      ),
      actionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
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
                                hint: "Name",
                                controller: widget._nameController),
                          ),
                          PlatformFilledButton(
                            widget.platform,
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
        },
      ),
    );
  }
}
