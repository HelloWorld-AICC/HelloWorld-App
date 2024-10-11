import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_mvp/core/value_objects.dart';
import 'package:hello_world_mvp/new_chat/domain/chat_enums.dart';
import 'package:hello_world_mvp/new_chat/domain/model/chat_message.dart';
import 'package:hello_world_mvp/new_chat/presentation/widgets/message_list_widget.dart';

void main() {
  testWidgets('ChatScreen displays messages correctly',
      (WidgetTester tester) async {
    final messages = [
      ChatMessage(sender: Sender.user, content: StringVO('Hello!')),
      ChatMessage(sender: Sender.bot, content: StringVO('Hi!')),
      ChatMessage(sender: Sender.user, content: StringVO('How are you?')),
      ChatMessage(
          sender: Sender.bot, content: StringVO('I am fine, thank you!')),
    ];

    await tester.pumpWidget(MaterialApp(
      home: MessageListWidget(messages: messages),
    ));

    // expect(find.text('User'), findsNWidgets(2)); // User 메시지가 2번 나오는지 확인
    // expect(find.text('Bot'), findsNWidgets(2)); // Bot 메시지가 2번 나오는지 확인
    expect(find.text('Hello!'), findsOneWidget); // 'Hello!' 메시지 확인
    expect(find.text('Hi!'), findsOneWidget); // 'Hi!' 메시지 확인
    expect(find.text('How are you?'), findsOneWidget); // 'How are you?' 메시지 확인
    expect(find.text('I am fine, thank you!'),
        findsOneWidget); // 'I am fine, thank you!' 메시지 확인
  });
}
