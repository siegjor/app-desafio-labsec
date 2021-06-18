import 'package:flutter/material.dart';
import 'package:labsec_app/components/card_box.dart';
import 'package:labsec_app/components/device_tile.dart';
import 'package:labsec_app/components/text/error_text.dart';
import 'package:labsec_app/components/go_back_button.dart';
import 'package:labsec_app/components/imagem_logo.dart';
import 'package:labsec_app/components/text/none_text.dart';
import 'package:labsec_app/components/text/normal_text.dart';
import 'package:labsec_app/messages/devices_messages.dart';
import 'package:labsec_app/models/device.dart';
import 'package:labsec_app/providers/devices_provider.dart';
import 'package:provider/provider.dart';

class DevicesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DevicesScreenState();
}

class DevicesScreenState extends State<DevicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(devicesMsg['title']),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ImagemLogo(),
            CardBox(
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<DevicesProvider>(
                      builder: (context, devicesProvider, child) {
                    final _currentTime =
                        devicesProvider.scanData['currentTime'];
                    return NormalText(
                        '${devicesMsg['last_update']} ${_currentTime ?? devicesMsg['none']}');
                  }),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: NormalText(devicesMsg['devices']),
                  ),
                  Expanded(
                    child: Consumer<DevicesProvider>(
                        builder: (context, devicesProvider, child) {
                      final _deviceList = devicesProvider.scanData['devices'];
                      if (!devicesProvider.validators['bluetoothIsOn']) {
                        return Center(
                          child: NoneText(devicesMsg['bluetooth_off']),
                        );
                      } else if (devicesProvider.validators['isLoading']) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (devicesProvider.validators['emptyList']) {
                        return Center(
                          child: NoneText(devicesMsg['found_none']),
                        );
                      } else if (devicesProvider.validators['gotError']) {
                        devicesProvider.validators['gotError'] = false;
                        return Center(
                          child: ErrorText(devicesMsg['scan_error']),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: _deviceList.length,
                          itemBuilder: (context, index) {
                            final Device device = _deviceList[index];
                            return DeviceTile(device.name, device.toStringId());
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
            Container(
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Consumer<DevicesProvider>(
                      builder: (context, devicesProvider, child) {
                    bool _isButtonEnabled =
                        !devicesProvider.validators['isLoading'];
                    return ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () => _updateDeviceList(devicesProvider)
                          : null,
                      child: Text(devicesMsg['button_text']),
                    );
                  }),
                  GoBackButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateDeviceList(DevicesProvider provider) {
    Future _isBluetoothOn = provider.isBluetoothOn();
    _isBluetoothOn.then((result) => {
          if (result) {provider.scanDevices()}
        });
  }
}
