part of 'center_bloc.dart';

sealed class CenterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetCenter extends CenterEvent {
  final double longitude;
  final double latitude;
  final int page;
  final int size;

  GetCenter(this.longitude, this.latitude, this.page, this.size);

  @override
  List<Object> get props => [];
}
