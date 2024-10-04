import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../roomId/room_id_bloc.dart';
import '../../session/chat_session_bloc.dart';

part 'tab_navigation_event.dart';

part 'tab_navigation_state.dart';

@Injectable()
class TabNavigationBloc extends Bloc<TabNavigationEvent, TabNavigationState> {
  final ChatSessionBloc chatSessionBloc;
  final RoomIdBloc roomIdBloc;

  TabNavigationBloc(this.chatSessionBloc, this.roomIdBloc)
      : super(TabNavigationState.initial()) {
    on<TabChanged>(_onTabChanged);
  }

  Future<void> _onTabChanged(
      TabChanged event, Emitter<TabNavigationState> emit) async {
    emit(state.copyWith(currentIndex: event.newIndex));

    if (event.newIndex == 1) {
      final roomId = roomIdBloc.state.roomId;
      chatSessionBloc.add(LoadChatSessionEvent(roomId: roomId));
    }
  }
}
