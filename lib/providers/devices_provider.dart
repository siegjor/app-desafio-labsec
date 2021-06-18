import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:intl/intl.dart';
import 'package:labsec_app/models/device.dart';

class DevicesProvider extends ChangeNotifier {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  final Map scanData = {
    'devices': [],
    'currentTime': null,
  };
  final Map validators = {
    'emptyList': false,
    'gotError': false,
    'bluetoothIsOn': true,
    'isLoading': false,
  };

  void scanDevices() {
    _disableButton();

    final Future scanResults =
        _flutterBlue.startScan(timeout: Duration(seconds: 4));

    scanResults.then((results) {
      if (results.isEmpty) {
        validators['emptyList'] = true;
        _enableButton();
        return;
      }

      for (ScanResult r in results) {
        final _device = Device(
          r.device.name.isEmpty ? '(sem nome)' : r.device.name,
          r.device.id,
        );
        scanData['devices'].add(_device);
      }

      scanData['currentTime'] = _getCurrentTime();
      _enableButton();
    }, onError: (error) {
      validators['gotError'] = true;
      _enableButton();
    });
  }

  void _disableButton() {
    scanData['devices'] = [];
    validators['emptyList'] = false;
    validators['onError'] = false;
    validators['isLoading'] = true;
    notifyListeners();
  }

  void _enableButton() {
    validators['isLoading'] = false;
    notifyListeners();
  }

  Future<bool> isBluetoothOn() async {
    final bool _isBluetoothOn = await _flutterBlue.isOn;
    _isBluetoothOn
        ? validators['bluetoothIsOn'] = true
        : validators['bluetoothIsOn'] = false;
    notifyListeners();
    return _isBluetoothOn;
  }

  String _getCurrentTime() {
    final currentTime = DateTime.parse(DateTime.now().toString());
    final DateFormat formatter = DateFormat('HH:mm:ss (dd/MM/yyyy)');
    final String formatted = formatter.format(currentTime);
    return formatted;
  }
}
