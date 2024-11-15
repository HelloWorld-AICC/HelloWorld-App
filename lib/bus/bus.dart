import 'package:hello_world_mvp/bus/bus_message.dart';
import 'package:rxdart/rxdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Bus {
  final PublishSubject<BusMessage> _bus = PublishSubject<BusMessage>();

  publish(BusMessage message) {
    _bus.add(message);
  }

  subscribe(void Function(BusMessage message) onReceive) {
    return _bus.listen((BusMessage value) {
      onReceive(value);
    });
  }
}
