// Host and event data for the Computer Science Society profile.
//
// Images and event details below were supplied by the organization.
// Fields marked UNCONFIRMED are still the earlier sample values and have not
// been verified; replace them once the real details are available.
// (File and variable names are unchanged so existing imports keep working.)

import '../models/event.dart';
import '../models/host.dart';

const String _img = 'assets/images';

final Host sampleHost = Host(
  name: 'Computer Science Society',
  handle: 'css',
  category: 'Departmental Organization', // label from the reference screenshot
  joinedDate: DateTime(2018, 5, 1), // UNCONFIRMED (sample value)
  hostedCount: 41, // UNCONFIRMED (sample value)
  bannerUrl: '$_img/css_coverpage.png',
  logoUrl: '$_img/css_profile.jpg',
  socialLinks: const [
    // UNCONFIRMED: placeholder URLs, no real links supplied yet.
    SocialLink(platform: SocialPlatform.facebook, url: 'https://example.com/facebook'),
    SocialLink(platform: SocialPlatform.instagram, url: 'https://example.com/instagram'),
  ],
);

final List<Event> sampleHostingEvents = [
  Event(
    id: 'startup-pitching-2026-02-13',
    title: "Turning Ideas Into Investment: A Student's Guide To Start-Up Pitching",
    startsAt: DateTime(2026, 2, 13, 13, 0),
    endsAt: DateTime(2026, 2, 13, 16, 0),
    location: 'Saint Beatrice Ballroom',
    thumbnailUrl: '$_img/css_startupevent.jpg',
  ),
];

final List<Event> samplePastEvents = [
  Event(
    id: 'iris-dataset-2026-02-12',
    title: 'Unpacking The Iris Dataset: Machine Learning In Python',
    startsAt: DateTime(2026, 2, 12, 13, 30),
    endsAt: DateTime(2026, 2, 12, 16, 30),
    location: 'Milagros Limaco 207',
    thumbnailUrl: '$_img/css_unpackingevent.jpg',
  ),
  Event(
    id: 'commit-push-collaborate-2026-01-30',
    title: 'Commit. Push. Collaborate. The Foundations Of Development: '
        'A Hands-On Seminar',
    startsAt: DateTime(2026, 1, 30, 13, 0),
    endsAt: DateTime(2026, 1, 30, 16, 0),
    location: 'Milagros Limaco 207',
    thumbnailUrl: '$_img/css_commitevent.jpg',
  ),
];
