import 'package:flutter/material.dart';

/// Shows [url] if present; otherwise (or on load error) a neutral placeholder.
class ImageWithPlaceholder extends StatelessWidget {
  const ImageWithPlaceholder({
    super.key,
    required this.url,
    this.placeholderIcon = Icons.image_outlined,
    this.fit = BoxFit.cover,
    this.cacheWidth,
  });

  /// An `assets/...` path (loaded from the app bundle) or a network URL.
  final String? url;

  /// Decode width in physical pixels; keeps large source images light.
  final int? cacheWidth;
  final IconData placeholderIcon;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      key: const ValueKey('image-placeholder'),
      color: const Color(0xFFD9D9D9),
      alignment: Alignment.center,
      child: Icon(placeholderIcon, color: Colors.black38),
    );

    final u = url;
    if (u == null || u.isEmpty) return placeholder;

    if (u.startsWith('assets/')) {
      return Image.asset(
        u,
        fit: fit,
        cacheWidth: cacheWidth,
        errorBuilder: (_, __, ___) => placeholder,
      );
    }

    return Image.network(
      u,
      fit: fit,
      cacheWidth: cacheWidth,
      errorBuilder: (_, __, ___) => placeholder,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : placeholder,
    );
  }
}
