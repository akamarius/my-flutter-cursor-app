import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        ScaleEffect(
          duration: 200.ms,
          curve: Curves.easeOut,
        ),
        ShakeEffect(
          duration: 500.ms,
          curve: Curves.easeInOut,
        ),
      ],
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            else if (icon != null)
              Icon(icon)
                  .animate()
                  .fadeIn(duration: 200.ms)
                  .scale(delay: 100.ms),
            if (icon != null) const SizedBox(width: 8),
            Text(text)
                .animate()
                .fadeIn(duration: 200.ms)
                .slideX(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }
}

class AnimatedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;

  const AnimatedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: size)
          .animate()
          .scale(
            duration: 200.ms,
            curve: Curves.easeOut,
          )
          .then()
          .shake(
            duration: 500.ms,
            curve: Curves.easeInOut,
          ),
    );
  }
}

class AnimatedCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.2, end: 0)
        .then()
        .shimmer(duration: 1200.ms);
  }
}

class AnimatedListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leading;
  final IconData? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const AnimatedListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading != null
          ? Icon(leading)
              .animate()
              .fadeIn(duration: 200.ms)
              .scale(delay: 100.ms)
          : null,
      title: Text(title)
          .animate()
          .fadeIn(duration: 200.ms)
          .slideX(begin: 0.2, end: 0),
      subtitle: subtitle != null
          ? Text(subtitle!)
              .animate()
              .fadeIn(duration: 200.ms)
              .slideX(begin: 0.2, end: 0, delay: 100.ms)
          : null,
      trailing: trailing != null
          ? Icon(trailing)
              .animate()
              .fadeIn(duration: 200.ms)
              .scale(delay: 200.ms)
          : null,
      onTap: onTap,
      tileColor: backgroundColor,
    );
  }
} 