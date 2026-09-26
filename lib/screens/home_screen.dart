import 'package:access_device_features/screens/device_info_screen.dart';
import 'package:access_device_features/screens/google_map_screen.dart';
import 'package:access_device_features/screens/image_picker_screen.dart';
import 'package:access_device_features/screens/profile_screen.dart';
import 'package:access_device_features/screens/record_screen.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<void> _authenticateAndNavigate() async {
    try {
      final bool canCheck = await _auth.canCheckBiometrics;
      final bool isSupported = await _auth.isDeviceSupported();

      if (!canCheck || !isSupported) {
        _showMessage(
          'Biometric authentication is not available on this device.',
        );
        return;
      }

      // Trigger the fingerprint prompt
      final bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to access your profile',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );

      // Only navigates if the fingerprint matched
      if (authenticated && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      } else if (mounted) {
        _showMessage('Authentication failed.');
      }
    } catch (e) {
      _showMessage('Error during authentication: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              _authenticateAndNavigate();
            },
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DeviceInfoScreen();
                    },
                  ),
                );
              },
              child: const Text('Device Info'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ImagePickerScreen();
                    },
                  ),
                );
              },
              child: const Text('Image Picker Gallery'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const GoogleMapScreen();
                    },
                  ),
                );
              },
              child: const Text('Google Maps'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const RecordScreen();
                    },
                  ),
                );
              },
              child: const Text('Recording Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
