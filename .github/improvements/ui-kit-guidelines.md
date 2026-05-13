# UI Kit Development Guidelines

## When Creating UI Kits Only

- Tidak perlu cek file core.dart, intinya kamu cukup import core.dart dan material.dart saja jika bikin halaman, kalau ada error terkait import nanti akan saya handle sendiri
- Tidak perlu terlalu banyak penjelasan langsung buatkan saja yang saya minta
- Kalau ada error karena Class is not defined, biarkan saja, saya akan perbaiki itu nanti secara manual
- Jangan buat atau edit file selain yang saya minta
- Class View tidak boleh mendefinisikan class argument
- Tidak perlu membuat navigasi ke halaman lain, suatu halaman akan selalu independent
- Setiap View harus dapat berdiri sendiri tanpa ketergantungan pada halaman lain
- Fokus pada pembuatan UI yang lengkap dan fungsional dalam satu halaman
- Jangan implementasikan routing atau navigation logic antar halaman

## Design Principles

1. Always create unique, elegant, premium UIs
2. Avoid animations entirely
3. Do not use SliverWidgets
4. Add multiple sections to pages when appropriate
5. Avoid QCard components for now
6. Never use ListTile widgets
7. Don't implement BottomNavigationBar (TabBar is acceptable if you provide content for each tab)
8. In newer Flutter versions, use `.withAlpha(value)` instead of `.withOpacity(value)`
9. Prevent UI overflow and ensure comfortable display on mobile screens

## Core Components

- Use components from `lib/core/widget/docs.dart`: navigation, contextless utilities, snackbar, button, form widgets
- Implement ReuseKit framework components throughout the project
- Follow the established theme configuration
- Use ReuseKit form components (QTextField, QImagePicker, etc.)

## Design Target

- By default ketika saya membuat halaman itu diperuntukkan untuk mobile, kecuali saya meminta versi tablet atau desktop-nya

## Image Resources

Jika butuh image gunakan URL berikut:
https://picsum.photos/{width}/{height}?random={number}&keyword={keyword}
