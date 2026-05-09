import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ui_farm/resources/resources.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ContactView extends StatelessWidget {
  const ContactView({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7EF),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -60,
              child: Container(
                width: 180,
                height: 180,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1D8C2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -90,
              left: -60,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAD1BB),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.brown, width: 2),
                        ),
                        child: Assets.images.logoPng.image(),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Contact with UI Farm',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                          child: Assets.images.banner.image(
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Contact with UI Farm',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Đặt may áo dài tại FB: UI Farm hoặc IG: @uifarm_2020. '
                                'Bạn có thể đặt online hoặc tới trực tiếp studio của UI để được tư vấn. '
                                'Chuẩn bị may ra tà áo đẹp nhất VN.',
                                style: TextStyle(color: Color(0xFF6B6B6B)),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: const [
                                  _TagChip(text: '#uifarm'),
                                  _TagChip(text: '#aodai'),
                                  _TagChip(text: '#aodaivietnam'),
                                  _TagChip(text: '#vietnam'),
                                  _TagChip(text: '#linen'),
                                  _TagChip(text: '#muongxanh'),
                                  _TagChip(text: '#silk'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          icon: Icons.facebook,
                          label: 'Facebook',
                          onTap: () => _openUrl('https://facebook.com'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SocialButton(
                          icon: Icons.camera_alt_rounded,
                          label: 'Instagram',
                          onTap: () => _openUrl('https://instagram.com'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEFE2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE9D3BE)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.brown,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE4D8CC)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.brown),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
