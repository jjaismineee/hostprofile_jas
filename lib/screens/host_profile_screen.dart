import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/event.dart';
import '../models/host.dart';
import '../widgets/event_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/section_header.dart';

/// Host Profile screen. Pure UI: all data comes in through the constructor.
class HostProfileScreen extends StatelessWidget {
  const HostProfileScreen({
    super.key,
    required this.host,
    required this.hostingEvents,
    required this.pastEvents,
    this.onSeeAllHosting,
    this.onSeeAllPast,
    this.onEventTap,
  });

  final Host host;
  final List<Event> hostingEvents;
  final List<Event> pastEvents;
  final VoidCallback? onSeeAllHosting;
  final VoidCallback? onSeeAllPast;
  final ValueChanged<Event>? onEventTap;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark, // dark status bar icons over light banner
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeader(host: host),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
              ..._section('Hosting', hostingEvents, onSeeAllHosting),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
              ..._section('Past Events', pastEvents, onSeeAllPast),
              SizedBox(height: 24 + MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _section(String title, List<Event> events, VoidCallback? onSeeAll) {
    return [
      SectionHeader(title: title, onSeeAll: onSeeAll),
      if (events.isEmpty)
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: Text('No events yet',
              style: TextStyle(fontSize: 12, color: Colors.black54)),
        )
      else
        for (final e in events)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: EventCard(event: e, onTap: () => onEventTap?.call(e)),
          ),
    ];
  }
}
