import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  String _deviceModel = 'Loading...';
  String _osVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String model = 'Unknown';
    String osVersion = 'Unknown';

    try {
      if (kIsWeb) {
        final info = await deviceInfoPlugin.webBrowserInfo;
        model = info.browserName.name;
        osVersion = info.platform ?? 'Unknown';
      } else {
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            final info = await deviceInfoPlugin.androidInfo;
            model = '${info.manufacturer} ${info.model}';
            osVersion = 'Android ${info.version.release}';
            break;
          case TargetPlatform.iOS:
            final info = await deviceInfoPlugin.iosInfo;
            model = info.utsname.machine;
            osVersion = '${info.systemName} ${info.systemVersion}';
            break;
          case TargetPlatform.linux:
            final info = await deviceInfoPlugin.linuxInfo;
            model = info.prettyName;
            osVersion = info.versionId ?? 'Unknown';
            break;
          case TargetPlatform.windows:
            final info = await deviceInfoPlugin.windowsInfo;
            model = info.productName;
            osVersion = info.displayVersion;
            break;
          case TargetPlatform.macOS:
            final info = await deviceInfoPlugin.macOsInfo;
            model = info.model;
            osVersion = 'macOS ${info.osRelease}';
            break;
          case TargetPlatform.fuchsia:
            model = 'Unknown';
            osVersion = 'Fuchsia not supported';
            break;
        }
      }
    } on PlatformException {
      model = 'Unknown';
      osVersion = 'Failed to get platform version';
    }

    if (!mounted) return;

    setState(() {
      _deviceModel = model;
      _osVersion = osVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Model: $_deviceModel',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'OS Version: $_osVersion',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
