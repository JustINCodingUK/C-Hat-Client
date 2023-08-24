import 'package:c_hat/model/user/user.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_event.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:c_hat/ui/mobile/chat/chat_widget.dart';
import 'package:c_hat/ui/mobile/user/user_widget.dart';

// ignore: must_be_immutable
class UserListElement extends StatefulWidget {
  final User user;
  final Platform platform;

  UserListElement(this.platform, {required this.user, Key? key})
      : super(key: key);

  var _unreadMessages = 0;

  @override
  State<UserListElement> createState() => _UserListElementState();
}

class _UserListElementState extends State<UserListElement> {
  @override
  Widget build(BuildContext context) {
    context
        .read<ChatBloc>()
        .add(NumberOfUnreadMessagesRequestedEvent(widget.user.clientId));
    return GestureDetector(
      onLongPress: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    UserView(widget.platform, user: widget.user))));
      },
      onTap: () {
        context
            .read<ChatBloc>()
            .add(MessagesRequestedEvent(widget.user.clientId));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    ChatWidget(widget.platform, recipient: widget.user))));
      },
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        elevation: 0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        "assets/images/user_avatar.png",
                        height: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.user.username,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: BlocBuilder<ChatBloc, ChatState>(
                      buildWhen: (previous, current) {
                        return (current is NumberOfUnreadMessagesReceived) &&
                            (current.clientId == widget.user.clientId) &&
                            (current.numberOfUnreadMessages != 0);
                      },
                      builder: (context, state) {
                        if (state is NumberOfUnreadMessagesReceived) {
                          widget._unreadMessages =
                              (state)
                                  .numberOfUnreadMessages;

                          if (widget._unreadMessages != 0) {
                            return Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(
                                widget._unreadMessages.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
