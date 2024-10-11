import 'package:injectable/injectable.dart';

@module
abstract class HomeRegisterModule {
  @lazySingleton
  List<String> get texts => [];
}
