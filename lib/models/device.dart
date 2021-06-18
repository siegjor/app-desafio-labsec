import 'package:flutter_blue/flutter_blue.dart';

class Device {
  final String _name;
  final DeviceIdentifier _id;

  Device(this._name, this._id);

  String get name => _name;

  DeviceIdentifier get id => _id;

  String toStringId() {
    return 'ID: $_id';
  }
}
