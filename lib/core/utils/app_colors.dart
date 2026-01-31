import 'package:flutter/material.dart';

class AppColors {
  // --- SHADCN RED PALETTE ---
  // Dùng cho Light Mode Primary (Red 600)
  static const Color red600 = Color(0xFFDC2626);
  // Dùng cho Dark Mode Primary (Red 500)
  static const Color red500 = Color(0xFFEF4444);
  // Dùng cho text trên nền đỏ (thường là trắng)
  static const Color white = Colors.white;

  // --- AMBER / YELLOW PALETTE (Client UI) ---
  static const Color amber600 = Color(0xFFD97706); // Dark Yellow
  static const Color amber500 = Color(0xFFF59E0B); // Yellow
  static const Color amber400 = Color(0xFFFBBF24); // Light Yellow

  // --- NEUTRALS (STONE/ZINC) ---

  // LIGHT MODE COLORS
  static const Color lightBackground = Color(0xFFF6F6F6);
  static const Color lightForeground = Color(0xFF0C0A09); // Stone 950
  static const Color lightMuted = Color(0xFFF5F5F4); // Stone 100
  static const Color lightMutedForeground = Color(0xFF78716C); // Stone 500
  static const Color lightBorder = Color(0xFFE7E5E4); // Stone 200

  // DARK MODE COLORS
  static const Color darkBackground = Color(0xFF0C0A09); // Stone 950 (Đen sâu)
  static const Color darkForeground = Color(0xFFFAFAFA); // Stone 50 (Trắng ngà)
  static const Color darkMuted = Color(0xFF1C1917); // Stone 900
  static const Color darkMutedForeground = Color(0xFFA8A29E); // Stone 400
  static const Color darkBorder = Color(0xFF292524); // Stone 800

  // --- SEMANTIC ALIASES (Dùng cái này cho các widget ngoài Forui) ---
  // Ví dụ: Container(color: AppColors.primary)
  static Color get primary => red600;
  static Color get error => const Color(0xFF7F1D1D); // Red 900
}
