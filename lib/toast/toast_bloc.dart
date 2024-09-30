import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'toast_event.dart';

part 'toast_state.dart';

@singleton
class ToastBloc extends Bloc<ToastEvent, ToastState> {
  EventTransformer<T> interval<T>(Duration duration) {
    return (events, mapper) => events.interval(duration).asyncExpand(mapper);
  }

  ToastBloc() : super(ToastState.initial()) {
    on<Show>(
      (event, emit) async {
        if (state.isShowing == true) {
          if (state.message != event.message) {
            add(InsertQueue(message: event.message));
          }
          return;
        }

        emit(state.copyWith(
          message: event.message,
          updatedAt: DateTime.now(),
          isShowing: true,
        ));

        await Future.delayed(const Duration(milliseconds: 1500));
        emit(state.copyWith(
          isShowing: false,
          updatedAt: DateTime.now(),
          message: event.message,
        ));
      },
    );

    on<InsertQueue>(
      (event, emit) async {
        emit(state.copyWith(
          message: event.message,
          updatedAt: DateTime.now(),
        ));
      },
      transformer: interval(const Duration(microseconds: 1500)),
    );

    on<Reset>((event, emit) async {
      emit(ToastState.initial());
    });
  }
}
