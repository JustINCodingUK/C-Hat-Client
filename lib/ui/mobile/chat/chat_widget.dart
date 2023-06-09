import 'package:c_hat/ui/shared/chat_bloc/chat_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_event.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:c_hat/model/message/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/ui/mobile/chat/chat_message_widget.dart';

import '../../../model/user/user.dart';

class ChatWidget extends StatefulWidget {
  final Platform platform;
  final User recipient;
  final controller = TextEditingController();

  ChatWidget(this.platform, {required this.recipient, Key? key})
      : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(widget.platform,
        appBar: AppBar(
          title: Text(widget.recipient.username),
        ),
        cupertinoBar: CupertinoNavigationBar(
          middle: Text(widget.recipient.username),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
            buildWhen: (previous, current) {
              return current is MessagesReceivedFromDatabase ||
              current is MessageReceivedState ||
              current is LatestMessageReceived;
            },
            builder: ((context, state) {
          if(state is MessagesReceivedFromDatabase) {
            messages = state.messages;
          }

          if(state is MessageReceivedState) {
            messages.add(state.message);
          }

          if(state is LatestMessageReceived) {
            messages.add(state.message);
          }
    
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {

                      String messageUsername;
                      if(context.read<ChatBloc>().loggedInUser.clientId == messages.reversed.toList()[index].author) {
                        messageUsername = context.read<ChatBloc>().loggedInUser.username;
                      } else {
                        messageUsername = widget.recipient.username;
                      }

                      return ChatMessageWidget(
                        message: messages.reversed.toList()[index],
                        username: messageUsername,
                      );
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: PlatformTextField(widget.platform,
                          hint:
                              "Enter your message for ${widget.recipient}",
                          controller: widget.controller),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: PlatformFilledButton(
                      widget.platform,
                      onPressed: () {
                        var message = Message(
                            content: widget.controller.text,
                            author: context.read<ChatBloc>().loggedInUser.clientId,
                            time: TimeOfDay.fromDateTime(DateTime.now())
                                .toString()
                                .replaceAll("TimeOfDay(", "")
                                .replaceAll(")", ""),
                            recipientClientId: widget.recipient.clientId,
                            isUnread: true
                          );
                        
                        context.read<ChatBloc>().add(MessageSentEvent(message));
                        widget.controller.text = "";
                      },
                      child: const Icon(Icons.send),
                    ),
                  ),
                ],
              )
            ],
          );
        })));
  }
}
