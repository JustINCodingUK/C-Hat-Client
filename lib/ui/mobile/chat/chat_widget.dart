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
  bool areMessagesMarkedUnread = false;

  @override
  Widget build(BuildContext context) {

    return PlatformScaffold(widget.platform,
        appBar: AppBar(
          title: Text(widget.recipient.username),
        ),
        cupertinoBar: CupertinoNavigationBar(
          middle: Text(widget.recipient.username),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(buildWhen: (previous, current) {
          return current is MessagesReceivedFromDatabase ||
              current is MessageReceivedState ||
              current is LatestMessageReceived;
        }, builder: ((context, state) {
          if (state is MessagesReceivedFromDatabase) {
            messages = state.messages;
            context.read<ChatBloc>().add(MarkMessagesAsReadOfUserEvent(widget.recipient.clientId));
          }

          if (state is MessageReceivedState) {
            messages.add(state.message);
          }

          if (state is LatestMessageReceived) {
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
                        final loggedInUser =
                            context.read<ChatBloc>().loggedInUser;

                        final listSize = messages.length;
                        final content = messages.reversed.toList();

                        if (!areMessagesMarkedUnread) {
                          if (content[index].isUnread) {
                            if (index + 1 != listSize) {
                              if (!content[index + 1].isUnread) {
                                areMessagesMarkedUnread = true;
                                return _buildMessageWidget(
                                    loggedInUser, content[index], true);
                              } else {
                                return _buildMessageWidget(
                                    loggedInUser, content[index], false);
                              }
                            } else {
                              areMessagesMarkedUnread = true;
                              return _buildMessageWidget(
                                  loggedInUser, content[index], true);
                            }
                          } else {
                            return _buildMessageWidget(
                                loggedInUser, content[index], false);
                          }
                        } else {
                          return _buildMessageWidget(
                              loggedInUser, content[index], false);
                        }
                      }),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: PlatformTextField(widget.platform,
                          hint: "Enter your message for ${widget.recipient}",
                          controller: widget.controller),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: PlatformFilledButton(
                      widget.platform,
                      minimumWidth: 20,
                      onPressed: () {
                        var message = Message(
                          content: widget.controller.text,
                          author:
                              context.read<ChatBloc>().loggedInUser.clientId,
                          time: TimeOfDay.fromDateTime(DateTime.now())
                              .toString()
                              .replaceAll("TimeOfDay(", "")
                              .replaceAll(")", ""),
                          recipientClientId: widget.recipient.clientId,
                          isUnread: false,
                        );

                        context.read<ChatBloc>().add(MessageSentEvent(message));
                        widget.controller.clear();
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

  Widget _buildMessageWidget(
      User loggedInUser, Message message, bool markUnread) {
    if (message.author != loggedInUser.clientId) {
      return SizedBox(
          child: Align(
        alignment: Alignment.centerLeft,
        child: ChatMessageWidget(message: message, markUnread: markUnread),
      ));
    } else {
      return SizedBox(
          child: Align(
        alignment: Alignment.centerRight,
        child: ChatMessageWidget(message: message, markUnread: markUnread),
      ));
    }
  }
}
