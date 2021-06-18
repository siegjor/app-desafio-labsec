import 'package:flutter/material.dart';
import 'package:labsec_app/components/card_box.dart';
import 'package:labsec_app/components/go_back_button.dart';
import 'package:labsec_app/components/imagem_logo.dart';
import 'package:labsec_app/components/text/none_text.dart';
import 'package:labsec_app/components/text/normal_text.dart';
import 'package:labsec_app/messages/generate_key_messages.dart';
import 'package:labsec_app/providers/generate_key_provider.dart';
import 'package:labsec_app/screens/generate_new_key_screen.dart';
import 'package:provider/provider.dart';

class GenerateKeyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(genKeyMsg['title']),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ImagemLogo(),
            CardBox(
              Consumer<GenerateKeyProvider>(
                  builder: (context, genKeyProvider, child) {
                final _keyPair = genKeyProvider.myKeyPair;
                if (_keyPair != null) {
                  String _myPublic = _keyPair.encodePublicKeyToPemPKCS1();
                  String _myPrivate = _keyPair.encodePrivateKeyToPemPKCS1();
                  return ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: NormalText(genKeyMsg['public_key']),
                          ),
                          Text(_myPublic),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 32, bottom: 16),
                            child: NormalText(genKeyMsg['private_key']),
                          ),
                          Text(_myPrivate),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: NoneText(genKeyMsg['gen_none']),
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
                    onPressed: () => _toGenerateNewKeyScreen(context),
                    child: Text(genKeyMsg['button_text']),
                  ),
                  GoBackButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _toGenerateNewKeyScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GenerateNewKeyScreen();
    }));
  }
}
