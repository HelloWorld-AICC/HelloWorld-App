import '../../../fetch/failure.dart';

class CenterFailure extends Failure {
  CenterFailure({required super.message});
}

class CenterFetchFailure extends CenterFailure {
  CenterFetchFailure({required super.message});
}
