/// A social link shown as an icon under the host's stats.
enum SocialPlatform { facebook, instagram }

class SocialLink {
  const SocialLink({required this.platform, required this.url});

  final SocialPlatform platform;
  final String url;
}

/// Host / organization shown on the profile screen.
class Host {
  const Host({
    required this.name,
    required this.handle,
    required this.category,
    required this.joinedDate,
    required this.hostedCount,
    this.logoUrl,
    this.bannerUrl,
    this.socialLinks = const [],
  });

  final String name;

  /// Short abbreviation, shown as "@css" in the header.
  final String handle;

  /// Compact label such as "Departmental Organization".
  final String category;

  final DateTime joinedDate;
  final int hostedCount;

  /// Optional. An `assets/...` path or a network URL.
  /// When null (or when loading fails) a placeholder is shown.
  final String? logoUrl;
  final String? bannerUrl;

  final List<SocialLink> socialLinks;
}
