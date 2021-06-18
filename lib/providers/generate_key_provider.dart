import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:labsec_app/models/key_pair.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/asymmetric/api.dart';

class GenerateKeyProvider extends ChangeNotifier {
  KeyPair? myKeyPair;
  final Map validators = {
    'wasGenerated': false,
    'isLoading': false,
    'isDeviceListEmpty': false,
  };

  void generateRSAKeyPair(int bitLength) {
    validators['isBitLengthValid'] = true;

    final SecureRandom _mySecureRandom = _secureRandomGenerator();
    final _keyGen = RSAKeyGenerator();
    final _rsaParams =
        RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64);
    final paramsWithRnd = ParametersWithRandom(_rsaParams, _mySecureRandom);
    _keyGen.init(paramsWithRnd);

    final _pair = _keyGen.generateKeyPair();
    final _publicKey = _pair.publicKey as RSAPublicKey;
    final _privateKey = _pair.privateKey as RSAPrivateKey;
    myKeyPair = KeyPair(_publicKey, _privateKey);
    notifyListeners();
    // return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(publicKey, privateKey);
  }

  SecureRandom _secureRandomGenerator() {
    final FortunaRandom _secureRandom = FortunaRandom();

    final Random _seedSource = Random.secure();
    final List<int> _seeds = <int>[];
    for (int i = 0; i < 32; i++) {
      _seeds.add(_seedSource.nextInt(255));
    }
    _secureRandom.seed(KeyParameter(Uint8List.fromList(_seeds)));
    return _secureRandom;
  }
}
