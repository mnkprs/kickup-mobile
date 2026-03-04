import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
        foregroundColor: colorScheme.onSurface,
        disabledForegroundColor: colorScheme.onSurface.withOpacity(0.6),
        minimumSize: const Size.fromHeight(44),
        side: BorderSide(
          color: colorScheme.outlineVariant,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGoogleIcon(),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(
        painter: _GoogleIconPainter(),
      ),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Simplified approximation of Google Icon using paths to avoid asset dependency for now
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Using simple colored circles/rectangles as a fallback if you don't want to add the exact SVG path
    // For a production app, it's better to use flutter_svg or add an image asset.
    // Here we'll draw a rough representation since the prompt didn't specify adding assets yet.
    
    // G color approximations
    paint.color = const Color(0xFFEA4335); // Red
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), 3.14, 1.57, true, paint);
    
    paint.color = const Color(0xFFFBBC05); // Yellow
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), 1.57, 1.57, true, paint);
    
    paint.color = const Color(0xFF34A853); // Green
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), 0, 1.57, true, paint);
    
    paint.color = const Color(0xFF4285F4); // Blue
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), 4.71, 1.57, true, paint);
    
    // Inner white circle to make a 'C' shape
    paint.color = Colors.white; // Or background color
    paint.blendMode = BlendMode.clear;
    canvas.drawCircle(Offset(size.width/2, size.height/2), size.width/3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}