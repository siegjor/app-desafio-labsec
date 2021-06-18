import 'package:flutter/material.dart';
import 'package:labsec_app/components/card_box.dart';
import 'package:labsec_app/components/go_back_button.dart';
import 'package:labsec_app/components/imagem_logo.dart';
import 'package:labsec_app/components/text/none_text.dart';
import 'package:labsec_app/components/text/normal_text.dart';
import 'package:labsec_app/messages/sign_list_messages.dart';
import 'package:labsec_app/models/key_pair.dart';
import 'package:labsec_app/providers/devices_provider.dart';
import 'package:labsec_app/providers/generate_key_provider.dart';
import 'package:labsec_app/providers/signature_provider.dart';
import 'package:provider/provider.dart';

class SignListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(signMsg['title']),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ImagemLogo(),
            CardBox(
              Consumer2<SignatureProvider, DevicesProvider>(
                  builder: (context, sigProvider, devicesProvider, child) {
                if (devicesProvider.validators['emptyList']) {
                  return Center(
                    child: NoneText(signMsg['empty_list']),
                  );
                } else if (sigProvider.signature != null) {
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Center(
                          child: NormalText(signMsg['signature']),
                        ),
                      ),
                      Text('${sigProvider.signature?.signedData}'),
                    ],
                  );
                } else {
                  return Center(
                    child: NoneText(signMsg['gen_none']),
                  );
                }
              }),
            ),
            Container(
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _signDevicesList(context),
                    child: Text(signMsg['button_text']),
                  ),
                  GoBackButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signDevicesList(BuildContext context) {
    final KeyPair? _keyPair =
        Provider.of<GenerateKeyProvider>(context, listen: false).myKeyPair;
    final List? _dataToSign =
        Provider.of<DevicesProvider>(context, listen: false)
            .scanData['devices'];
    if (_keyPair != null && _dataToSign != null) {
      if (_dataToSign.isNotEmpty) {
        Provider.of<SignatureProvider>(context, listen: false)
            .rsaSign(_keyPair.privateKey, _dataToSign.toString());
      }
    }
  }
}
