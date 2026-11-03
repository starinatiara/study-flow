import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Kerangka halaman Login & Register (header kuning + panel krem)
class AuthScaffold extends StatelessWidget {
  final String title, subtitle;
  final double topSpace;
  final Widget child;
  const AuthScaffold({super.key, required this.title, required this.subtitle, required this.child, this.topSpace = 60});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(children: [
        Container(height: 420, color: AppColors.yellow),
        Positioned(
          top: -40, right: -30,
          child: Container(width: 150, height: 150, decoration: const BoxDecoration(color: AppColors.orange, shape: BoxShape.circle)),
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: topSpace),
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.check, size: 30),
              ),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 420),
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: child,
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

class AppTextField extends StatelessWidget {
  final String label, hint;
  final IconData? icon;
  final bool obscure, multiline, readOnly;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final IconData? suffixIcon;
  const AppTextField({super.key, required this.label, required this.hint, this.icon, this.obscure = false, this.multiline = false, this.controller, this.readOnly = false, this.onTap, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          obscureText: obscure,
          maxLines: obscure ? 1 : (multiline ? 4 : 1),
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12, color: AppColors.grey),
            prefixIcon: icon == null ? null : Icon(icon, size: 18, color: AppColors.dark),
            suffixIcon: suffixIcon == null ? null : Icon(suffixIcon, size: 18, color: AppColors.dark),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.button, width: 1.5)),
          ),
        ),
      ]),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.button, foregroundColor: AppColors.dark, elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final String text;
  final Color bg, fg;
  const TagChip(this.text, this.bg, this.fg, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
        child: Text(text, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: fg)),
      );
}