import 'dart:convert';
import 'package:cryptography/cryptography.dart';

final ecdh = X25519();
final aesGcm = AesGcm.with256bits();

Future<Map<String, dynamic>> encryptPassword(String password, SimplePublicKey serverPubKey) async {
  // Creating ECDH key pair
  final clientKeyPair = await ecdh.newKeyPair();
  final clientPubKey = await clientKeyPair.extractPublicKey();

  // Computing shared secret
  final sharedSecret = await ecdh.sharedSecretKey(
    keyPair: clientKeyPair,
    remotePublicKey: serverPubKey,
  );

  // Encrypting password using AES-GCM (nonce generated automatically)
  final secretBox = await aesGcm.encrypt(
    utf8.encode(password),
    secretKey: sharedSecret,
  );

  return {
    "encryptedPassword": base64Encode(secretBox.concatenation()),
    "nonce": base64Encode(secretBox.nonce),
    "clientPublicKey": base64Encode(clientPubKey.bytes),
  };
}
