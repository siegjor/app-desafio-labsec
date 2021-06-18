import 'dart:convert';

import 'package:asn1lib/asn1lib.dart';
import 'package:pointycastle/asymmetric/api.dart';

class KeyPair {
  final RSAPublicKey _publicKey;
  final RSAPrivateKey _privateKey;

  KeyPair(this._publicKey, this._privateKey);

  RSAPublicKey get publicKey => _publicKey;

  RSAPrivateKey get privateKey => _privateKey;

  String encodePublicKeyToPemPKCS1() {
    final sequence = ASN1Sequence();

    sequence.add(ASN1Integer(_publicKey.modulus!));
    sequence.add(ASN1Integer(_publicKey.exponent!));

    final dataBase64 = base64.encode(sequence.encodedBytes);
    return """-----BEGIN PUBLIC KEY-----\r\n$dataBase64\r\n-----END PUBLIC KEY-----""";
  }

  String encodePrivateKeyToPemPKCS1() {
    final sequence = ASN1Sequence();

    final version = ASN1Integer(BigInt.from(0));
    final modulus = ASN1Integer(_privateKey.n!);
    final publicExponent = ASN1Integer(_privateKey.exponent!);
    final privateExponent = ASN1Integer(_privateKey.privateExponent!);
    final p = ASN1Integer(_privateKey.p!);
    final q = ASN1Integer(_privateKey.q!);
    final dP = _privateKey.privateExponent! % (_privateKey.p! - BigInt.from(1));
    final exp1 = ASN1Integer(dP);
    final dQ = _privateKey.privateExponent! % (_privateKey.q! - BigInt.from(1));
    final exp2 = ASN1Integer(dQ);
    final iQ = _privateKey.q!.modInverse(_privateKey.p!);
    final co = ASN1Integer(iQ);

    sequence.add(version);
    sequence.add(modulus);
    sequence.add(publicExponent);
    sequence.add(privateExponent);
    sequence.add(p);
    sequence.add(q);
    sequence.add(exp1);
    sequence.add(exp2);
    sequence.add(co);

    final dataBase64 = base64.encode(sequence.encodedBytes);

    return """-----BEGIN PRIVATE KEY-----\r\n$dataBase64\r\n-----END PRIVATE KEY-----""";
  }
}
