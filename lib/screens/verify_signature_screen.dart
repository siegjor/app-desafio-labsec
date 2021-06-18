import 'package:flutter/material.dart';
import 'package:labsec_app/components/card_box.dart';
import 'package:labsec_app/components/text/error_text.dart';
import 'package:labsec_app/components/go_back_button.dart';
import 'package:labsec_app/components/imagem_logo.dart';
import 'package:labsec_app/components/text/none_text.dart';
import 'package:labsec_app/components/text/success_text.dart';
import 'package:labsec_app/messages/verify_signature_messages.dart';
import 'package:labsec_app/providers/devices_provider.dart';
import 'package:labsec_app/providers/generate_key_provider.dart';
import 'package:labsec_app/providers/signature_provider.dart';
import 'package:labsec_app/styles/custom_colors.dart';
import 'package:provider/provider.dart';

class VerifySignatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(verifyMsg['title']),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ImagemLogo(),
            CardBox(
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Consumer<SignatureProvider>(
                      builder: (context, sigProvider, child) {
                    if (sigProvider.validators['isLoading']) {
                      return CircularProgressIndicator();
                    } else if (sigProvider.validators['isSignatureValid'] !=
                        null) {
                      final _isValid =
                          sigProvider.validators['isSignatureValid'];
                      if (_isValid) {
                        return ListTile(
                          leading: Icon(
                            Icons.check,
                            color: myColors.success,
                            size: 30,
                          ),
                          title: SuccessText(verifyMsg['valid_sig']),
                        );
                      } else {
                        return ListTile(
                          leading: Icon(
                            Icons.error_outline,
                            color: myColors.error,
                            size: 30,
                          ),
                          title: ErrorText(verifyMsg['invalid_sig']),
                        );
                      }
                    } else {
                      return Center(
                        child: NoneText(verifyMsg['unverified_sig']),
                      );
                    }
                  }),
                ],
              ),
            ),
            Container(
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _verifySignature(context),
                    child: Text(verifyMsg['button_text']),
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

  void _verifySignature(context) {
    final _keyPair =
        Provider.of<GenerateKeyProvider>(context, listen: false).myKeyPair;
    final _originalData = Provider.of<DevicesProvider>(context, listen: false)
        .scanData['devices'];
    final _signedData = Provider.of<SignatureProvider>(context, listen: false)
        .signature
        ?.signedData;
    if (_keyPair != null && _signedData != null) {
      Provider.of<SignatureProvider>(context, listen: false).fakeTimer();
      Provider.of<SignatureProvider>(context, listen: false)
          .rsaVerify(_keyPair.publicKey, _originalData.toString(), _signedData);
    }
  }
}
