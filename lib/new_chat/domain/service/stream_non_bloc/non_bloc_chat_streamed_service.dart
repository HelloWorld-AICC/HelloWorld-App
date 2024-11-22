// import 'dart:async';
//
// import 'package:hello_world_mvp/new_chat/domain/model/chat_message.dart';
// import 'package:hello_world_mvp/new_chat/domain/service/chat_fetch_service.dart';
//
// import '../../../../core/value_objects.dart';
// import '../../../../fetch/fetch_service.dart';
// import '../../../infrastructure/repository/chat_repository.dart';
// import '../../chat_enums.dart';
// import 'non_bloc_chat_local_repository.dart';
//
// class NonBlocChatStreamedService {
//   final ChatFetchService fetchService;
//   final NonBlocChatLocalRepository chatRepository;
//   final StreamController<ChatMessage> _controller =
//       StreamController.broadcast();
//
//   NonBlocChatStreamedService(this.fetchService, this.chatRepository);
//
//   Stream<ChatMessage> get messageStream => _controller.stream;
//
//   void addUserMessage(ChatMessage message) {
//     _controller.add(message);
//     chatRepository.addChat(message);
//   }
//
//   void sendBotMessage(ChatMessage message, String roomId) async {
//     ChatMessage? botMessage;
//
//     final failureOrResponse = await fetchService.streamedRequest(
//       method: HttpMethod.post,
//       pathPrefix: '/webflux',
//       path: '/chat/ask',
//       bodyParam: {'content': message.content},
//       queryParams: {'roomId': roomId},
//     );
//
//     final streamed_response = failureOrResponse.fold(
//       (failure) {},
//       (lineStream) {
//         final finalResponse = StringBuffer();
//
//         final subscription = lineStream
//             // .transform(Utf8Decoder())
//             // .transform(LineSplitter())
//             .listen((line) {
//           if (line.startsWith('data:')) {
//             var temp = line.substring(5).trim();
//             if (temp.isEmpty) temp = ' ';
//
//             if (line.startsWith('data:Room ID: ')) {
//             } else {
//               if (temp == 'data:') {
//                 finalResponse.write('\n');
//               } else {
//                 finalResponse.write(temp);
//               }
//
//               if (botMessage == null) {
//                 botMessage = ChatMessage(
//                   sender: Sender.bot,
//                   content: StringVO(finalResponse.toString()),
//                 );
//
//                 // final updatedMessages =
//                 //     List<ChatMessage>.from(chatSessionBloc.state.messages)
//                 //       ..add(botMessage!);
//
//                 _controller.add(updatedMessages);
//               } else {
//                 // final updatedMessages =
//                 //     List<ChatMessage>.from(chatSessionBloc.state.messages)
//                 //       ..removeLast()
//                 //       ..add(botMessage!.copyWith(
//                 //         content: StringVO(finalResponse.toString()),
//                 //       ));
//                 final updatedMessages = [
//                   ...chatSessionHandler.getMessages().sublist(0, -1),
//                   botMessage!.copyWith(
//                     content: StringVO(finalResponse.toString()),
//                   )
//                 ];
//                 _messageStreamController.add(updatedMessages);
//                 // chatSessionBloc.add(
//                 //   UpdateMessagesEvent(
//                 //     messages: updatedMessages,
//                 //     isLoading: false,
//                 //     failure: null,
//                 //   ),
//                 // );
//                 chatSessionHandler.updateMessages(
//                   messages: updatedMessages,
//                   isLoading: false,
//                   failure: null,
//                 );
//               }
//             }
//           }
//         }, onDone: () {
//           // chatSessionBloc.add(
//           //   ChangeLoadingEvent(
//           //     isLoading: false,
//           //     failure: null,
//           //   ),
//           // );
//           chatSessionHandler.setLoading(isLoading: false, failure: null);
//         });
//         subscription.cancel();
//       },
//     );
//   }
// }
