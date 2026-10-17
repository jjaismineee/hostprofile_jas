/// An event hosted by an organization.
class Event {
  const Event({
    required this.id,
    required this.title,
    required this.startsAt,
    required this.endsAt,
    required this.location,
    this.thumbnailUrl,
  });

  final String id;
  final String title;
  final DateTime startsAt;
  final DateTime endsAt;
  final String location;

  /// Optional. An `assets/...` path or a network URL.
  /// When null (or when loading fails) a placeholder is shown.
  final String? thumbnailUrl;
}
