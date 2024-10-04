import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'room_id_event.dart';

part 'room_id_state.dart';

@Injectable()
class RoomIdBloc extends Bloc<RoomIdEvent, RoomIdState> {
  RoomIdBloc() : super(const RoomIdState("new-chat")) {
    on<UpdateRoomIdEvent>(_onUpdateRoomId);
  }

  void _onUpdateRoomId(UpdateRoomIdEvent event, Emitter<RoomIdState> emit) {
    emit(RoomIdState(event.newRoomId));
  }
}
