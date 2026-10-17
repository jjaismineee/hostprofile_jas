import 'package:flutter/material.dart';

import '../models/host.dart';
import '../utils/date_format.dart';
import 'network_image_with_placeholder.dart';

/// Banner + overlapping logo + name, handle, category chip, joined date,
/// hosted count and social icons.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.host,
    this.onBack,
    this.onMore,
  });

  final Host host;
  final VoidCallback? onBack;
  final VoidCallback? onMore;

  static const double _bannerHeight = 140;
  static const double _logoSize = 92;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    final bannerTotal = _bannerHeight + topInset; // banner extends under status bar

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Banner, nav buttons and overlapping logo.
        SizedBox(
          height: bannerTotal + _logoSize / 2,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: bannerTotal,
                child: ImageWithPlaceholder(
                  url: host.bannerUrl,
                  placeholderIcon: Icons.panorama_outlined,
                  cacheWidth: 1200,
                ),
              ),
              Positioned(
                top: topInset + 8,
                left: 16,
                child: _CircleButton(
                  key: const ValueKey('back-button'),
                  icon: Icons.arrow_back,
                  tooltip: 'Back',
                  onPressed: onBack ?? () => Navigator.maybePop(context),
                ),
              ),
              Positioned(
                top: topInset + 8,
                right: 16,
                child: _CircleButton(
                  key: const ValueKey('more-button'),
                  icon: Icons.more_horiz,
                  tooltip: 'More options',
                  onPressed: onMore,
                ),
              ),
              Positioned(
                left: 16,
                bottom: 0,
                child: Container(
                  width: _logoSize,
                  height: _logoSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: ClipOval(
                    child: ImageWithPlaceholder(
                      url: host.logoUrl,
                      placeholderIcon: Icons.groups_outlined,
                      cacheWidth: 300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                host.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                '@${host.handle}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              _CategoryChip(label: host.category),
              const SizedBox(height: 10),
              _InfoRow(
                icon: Icons.calendar_today_outlined,
                text: 'Joined ${formatMonthYear(host.joinedDate)}',
              ),
              const SizedBox(height: 6),
              _InfoRow(
                icon: Icons.groups_2_outlined,
                text: '${host.hostedCount} Hosted',
                bold: true,
              ),
              if (host.socialLinks.isNotEmpty) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    for (final link in host.socialLinks)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(_iconFor(link.platform), size: 20),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // Material icons stand in for brand glyphs to avoid extra dependencies.
  // Swap for font_awesome_flutter or SVG assets if you want exact brand icons.
  static IconData _iconFor(SocialPlatform p) => switch (p) {
        SocialPlatform.facebook => Icons.facebook,
        SocialPlatform.instagram => Icons.camera_alt_outlined,
      };
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 1,
      child: IconButton(
        icon: Icon(icon, size: 20),
        tooltip: tooltip,
        onPressed: onPressed ?? () {},
        constraints: const BoxConstraints.tightFor(width: 40, height: 40),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFBDBDBD),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.corporate_fare, size: 14),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text, this.bold = false});

  final IconData icon;
  final String text;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
