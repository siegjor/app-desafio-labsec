import 'package:pointycastle/asymmetric/api.dart';

class MySignature {
  final RSAPrivateKey _privateKey;
  final String _signedData;

  MySignature(this._privateKey, this._signedData);

  String get signedData => _signedData;

  RSAPrivateKey get privateKey => _privateKey;
}
