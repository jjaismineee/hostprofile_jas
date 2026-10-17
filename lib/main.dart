
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'data/sample_data.dart';
import 'screens/host_profile_screen.dart';

void main() {
  DevicePreview.enable();
  runApp(const HostProfileApp());
}

class HostProfileApp extends StatelessWidget {
  const HostProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Host Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HostProfileScreen(
        host: sampleHost,
        hostingEvents: sampleHostingEvents,
        pastEvents: samplePastEvents,
      ),
    );
  }
}
