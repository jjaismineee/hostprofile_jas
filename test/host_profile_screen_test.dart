import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:host_profile/data/sample_data.dart';
import 'package:host_profile/models/event.dart';
import 'package:host_profile/models/host.dart';
import 'package:host_profile/screens/host_profile_screen.dart';

Widget _wrap({Host? host, List<Event>? hosting, List<Event>? past}) =>
    MaterialApp(
      home: HostProfileScreen(
        host: host ?? sampleHost,
        hostingEvents: hosting ?? sampleHostingEvents,
        pastEvents: past ?? samplePastEvents,
      ),
    );

/// A host and event with no images at all.
final _bareHost = Host(
  name: 'Bare Host',
  handle: 'bare',
  category: 'Test',
  joinedDate: DateTime(2020, 1, 1),
  hostedCount: 0,
);

Event _event({String? thumbnail, String? title}) => Event(
      id: 'e',
      title: title ?? 'Event',
      startsAt: DateTime(2026, 1, 1, 9),
      endsAt: DateTime(2026, 1, 1, 10),
      location: 'Somewhere',
      thumbnailUrl: thumbnail,
    );

void main() {
  testWidgets('shows header info and event titles', (tester) async {
    await tester.pumpWidget(_wrap());

    expect(find.text('Computer Science Society'), findsOneWidget);
    expect(find.text('@css'), findsOneWidget);
    expect(find.text('Hosting'), findsOneWidget);
    expect(find.text(sampleHostingEvents.first.title), findsOneWidget);
    expect(find.byKey(const ValueKey('back-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('more-button')), findsOneWidget);
  });

  test('every image path in the data exists and is declared as an asset', () {
    final paths = <String?>[
      sampleHost.bannerUrl,
      sampleHost.logoUrl,
      for (final e in [...sampleHostingEvents, ...samplePastEvents])
        e.thumbnailUrl,
    ];
    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, contains('assets/images/'));
    for (final p in paths) {
      expect(p, isNotNull);
      expect(File(p!).existsSync(), isTrue, reason: 'missing file: $p');
    }
  });

  testWidgets('scrolls vertically to reveal the last past event',
      (tester) async {
    tester.view.physicalSize = const Size(390, 600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_wrap());
    await tester.scrollUntilVisible(
      find.text(samplePastEvents.last.title),
      200,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('Past Events'), findsOneWidget);
  });

  testWidgets('missing images fall back to placeholders', (tester) async {
    await tester.pumpWidget(
      _wrap(host: _bareHost, hosting: [_event()], past: [_event()]),
    );
    expect(find.byKey(const ValueKey('image-placeholder')), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a broken asset path falls back to the placeholder',
      (tester) async {
    await tester.pumpWidget(_wrap(
      host: _bareHost,
      hosting: [_event(thumbnail: 'assets/images/does_not_exist.png')],
      past: const [],
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('image-placeholder')), findsWidgets);
  });

  testWidgets('very long event title does not overflow', (tester) async {
    final longEvent = Event(
      id: 'long',
      title: List.filled(40, 'Extremely long sample title').join(' '),
      startsAt: DateTime(2026, 1, 1, 9),
      endsAt: DateTime(2026, 1, 1, 10),
      location: List.filled(20, 'Very long sample location name').join(' '),
    );
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_wrap(hosting: [longEvent]));
    expect(tester.takeException(), isNull); // overflow errors surface here
  });

  testWidgets('empty sections show an empty state', (tester) async {
    await tester.pumpWidget(_wrap(hosting: const [], past: const []));
    expect(find.text('No events yet'), findsNWidgets(2));
  });
}
