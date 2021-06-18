import 'package:flutter/material.dart';
import 'package:labsec_app/components/imagem_logo.dart';
import 'package:labsec_app/messages/home_messages.dart';
import 'package:labsec_app/screens/generate_key_screen.dart';
import 'package:labsec_app/screens/sign_list_screen.dart';
import 'package:labsec_app/screens/verify_signature_screen.dart';

import 'devices_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homeMsg['title']),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ImagemLogo(),
            Container(
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _toDevicesScreen(context),
                    child: Text(homeMsg['lbe_devices']),
                  ),
                  ElevatedButton(
                    onPressed: () => _toGenerateKeyScreen(context),
                    child: Text(homeMsg['gen_rsa_keys']),
                  ),
                  ElevatedButton(
                    onPressed: () => _toSignListScreen(context),
                    child: Text(homeMsg['sign_list']),
                  ),
                  ElevatedButton(
                    onPressed: () => _toVerifySignatureScreen(context),
                    child: Text(homeMsg['verify_sig']),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _toGenerateKeyScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GenerateKeyScreen();
    }));
  }

  _toDevicesScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DevicesScreen();
    }));
  }

  _toSignListScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SignListScreen();
    }));
  }

  _toVerifySignatureScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return VerifySignatureScreen();
    }));
  }
}
