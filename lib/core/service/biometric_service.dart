import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class BiometricSupport {
  final bool isSupported;
  final bool canCheckBiometrics;
  final List<BiometricType> availableBiometrics;

  BiometricSupport(
    this.isSupported,
    this.canCheckBiometrics,
    this.availableBiometrics,
  );
  @override
  String toString() =>
      "supported=$isSupported, canCheck=$canCheckBiometrics, available=$availableBiometrics";
}

class BiometricService {
  final _auth = LocalAuthentication();

  Future<BiometricSupport> checkBiometricSupport() async {
    try {
      final isSupported = await _auth.isDeviceSupported();
      final canCheckBiometrics = await _auth.canCheckBiometrics;
      final availableBiometrics = await _auth.getAvailableBiometrics();
      debugPrint('[Bio] $isSupported $canCheckBiometrics $availableBiometrics');
      return BiometricSupport(
        isSupported,
        canCheckBiometrics,
        availableBiometrics,
      );
    } catch (e) {
      debugPrint('[Bio] Error checking biometric support: $e');
      return BiometricSupport(false, false, []);
    }
  }

  Future<(bool ok, String reason)> authenticate({
    String reason = "Verify to Continue",
    bool biometricOnly = false,
    bool allowDeviceCredentials = true,
    bool sensitiveTransaction = true,
    bool persistAcrossBackgrounding = true,
  }) async {
    try {
      final useBiometricOnly = biometricOnly && !allowDeviceCredentials;
      final ok = await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: useBiometricOnly,
        sensitiveTransaction: sensitiveTransaction,
        persistAcrossBackgrounding: persistAcrossBackgrounding,

        authMessages: [
          AndroidAuthMessages(
            signInTitle: 'Biometric authentication',
            signInHint: 'Use fingerprint/face',
            cancelButton: 'Cancel',
          ),
          IOSAuthMessages(
            cancelButton: 'Cancel',
            localizedFallbackTitle: 'Use Passcode',
          ),
        ],
      );
      return (ok, ok ? '' : 'Authentication failed or canceled by user.');
    } on PlatformException catch (e) {
      final why = switch (e.code) {
        'notEnrolled' => 'No biometrics enrolled on device',
        'notAvailable' => 'Biometrics not available on this device',
        'passcodeNotSet' => 'Device lock screen not set',
        'lockedOut' => 'Too many attempts. Try again later',
        'permanentlyLockedOut' => 'Biometrics locked. Use device passcode',
        'no_fragment_activity' =>
          'Host activity must extend FlutterFragmentActivity',
        _ => e.message ?? e.code,
      };
      debugPrint(
        '[Bio] PlatformException during authentication: ${e.code} - ${e.message}',
      );
      return (false, 'Authentication error: $why');
    } catch (e) {
      debugPrint('[Bio] Error during authentication: $e');
      return (false, e.toString());
    }
  }

  Future<void> cancel() async {
    try {
      await _auth.stopAuthentication();
    } catch (_) {}
  }

  String suggestedLabel(List<BiometricType> type) {
    if (Platform.isIOS && type.contains(BiometricType.face)) {
      return "Face ID";
    }
    if (type.contains(BiometricType.strong)) {
      return "Fingerprint";
    }

    return "Biometric";
  }
}
