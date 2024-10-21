part of 'chat_drawer_bloc.dart';

class ChatDrawerState extends Equatable {
  final bool loading;
  final bool isDrawerOpen;
  final String selectedRoomId;
  final List<ChatRoomInfo> chatRoomInfoList;

  ChatDrawerState(
      {required this.loading,
      required this.isDrawerOpen,
      required this.chatRoomInfoList,
      required this.selectedRoomId});

  factory ChatDrawerState.initial() {
    return ChatDrawerState(
        loading: false,
        isDrawerOpen: false,
        chatRoomInfoList: [],
        selectedRoomId: 'new-chat');
  }

  ChatDrawerState copyWith(
      {bool? loading,
      bool? isDrawerOpen,
      List<ChatRoomInfo>? chatRoomInfoList}) {
    return ChatDrawerState(
      loading: loading ?? this.loading,
      isDrawerOpen: isDrawerOpen ?? this.isDrawerOpen,
      chatRoomInfoList: chatRoomInfoList ?? this.chatRoomInfoList,
      selectedRoomId: selectedRoomId,
    );
  }

  @override
  List<Object?> get props =>
      [loading, isDrawerOpen, chatRoomInfoList, selectedRoomId];
}
