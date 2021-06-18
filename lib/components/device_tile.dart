import 'package:flutter/material.dart';

class DeviceTile extends StatelessWidget {
  final String _deviceName;
  final String _deviceID;

  const DeviceTile(this._deviceName, this._deviceID);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.devices),
      title: Text(this._deviceName),
      subtitle: Text(this._deviceID),
    );
  }
}
