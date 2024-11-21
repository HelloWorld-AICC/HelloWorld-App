import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hello_world_mvp/center/domain/failure/center_failure.dart';
import 'package:hello_world_mvp/center/domain/model/center.dart';
import 'package:injectable/injectable.dart';

import '../../core/value_objects.dart';
import '../domain/repository/i_center_repository.dart';

part 'center_event.dart';

part 'center_state.dart';

@injectable
class CenterBloc extends Bloc<CenterEvent, CenterState> {
  final ICenterRepository centerRepository;

  CenterBloc({required this.centerRepository}) : super(CenterState.initial()) {
    on<GetCenter>((event, emit) async {
      print("CenterBloc :: GetCenter : event: $event");
      final centerOrFailure = await centerRepository.getCenters(
          DoubleVO(event.latitude),
          DoubleVO(event.longitude),
          IntVO(event.page),
          IntVO(event.size));

      emit(centerOrFailure.fold(
        (failure) {
          print("CenterBloc :: GetCenter : failure: $failure");
          return state.copyWith(
              failure: CenterFetchFailure(message: "센터 정보를 불러오는데 실패했습니다."));
        },
        (centers) => state.copyWith(centers: centers),
      ));
    });
  }
}
