import 'package:c_hat/dev/ext/widget_ext.dart';
import 'package:flutter/material.dart';
import 'package:c_hat/model/message/message.dart';

class ChatMessageWidget extends StatelessWidget {
  final Message message;
  final bool markUnread;

  const ChatMessageWidget(
      {Key? key,
      required this.message,
      required this.markUnread})
      : super(key: key);

  @override
  Widget build(BuildContext context) => _parent(context);

  Widget _body(BuildContext context) {
    return SizedBox(
      child: Card(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          message.content,
                          style: const TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(message.time,
                            style: const TextStyle(fontSize: 8)),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget _parent(BuildContext context) {
    return markUnread
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Divider(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "New messages",
                      style: TextStyle(color: Colors.red),
                    ).withPadding(),
                  ),
                  const Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              _body(context)
            ],
          )
        : _body(context);
  }
}
