import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:labsec_app/models/my_signature.dart';
import 'package:pointycastle/export.dart';

class SignatureProvider extends ChangeNotifier {
  MySignature? signature;
  final Map validators = {'isSignatureValid': null, 'isLoading': false};

  void rsaSign(RSAPrivateKey privateKey, String dataToSign) {
    final _signer = RSASigner(SHA256Digest(), '0609608648016503040201');
    _signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

    final _signedBytes =
        _signer.generateSignature(Uint8List.fromList(dataToSign.codeUnits));

    final _signedData = base64Encode(_signedBytes.bytes);
    signature = MySignature(privateKey, _signedData);
    notifyListeners();
  }

  void rsaVerify(
      RSAPublicKey publicKey, String originalData, String signedData) {
    final _signature = RSASignature(base64Decode(signedData));
    final _verifier = RSASigner(SHA256Digest(), '0609608648016503040201');

    _verifier.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));
    validators['isSignatureValid'] = _verifier.verifySignature(
        Uint8List.fromList(originalData.codeUnits), _signature);
    notifyListeners();
  }

  void fakeTimer() {
    validators['isLoading'] = true;
    notifyListeners();
    Timer(Duration(milliseconds: 100), () {
      validators['isLoading'] = false;
      notifyListeners();
    });
  }
}
