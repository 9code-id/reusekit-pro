# Architecture Guidelines

## Project Structure
```
lib
  model
    user.dart
  service
    auth_service.dart
  view
    login_view.dart
```

## Naming Conventions

### Views
- Follow view naming convention: `XxxView` (e.g., LoginView, ProductListView)
- View at the end is a must! for file name and class name (eg: login_view.dart and LoginView)
- Use the same page for both edit and create operations
- Do not use `part of` or `part` directives
- Views do not need explicit imports as everything is available in core.dart
- Class View tidak boleh mendefinisikan class argument

### File Organization
- Ketika membuat View, dan ternyata ada view lain yang belum tersedia, jangan dibuat di file yang sama ya. Saya akan membuatkan view itu nanti

## Import Rules

### Required Imports
Setiap membuat halaman baru wajib mengimport kedua hal ini:
```dart
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
```

### Service and Model Imports
- Jika ada service atau model, itu tidak perlu di import lagi, karena sudah ada di core.dart
- Tidak perlu mengimport class model.dart atau service.dart ketika dibutuhkan

## Component Usage

### Reuseable Widgets
- Semua widget yang di awali Q, misalnya QTextField, QButton, QCard, dll adalah widget yang reusable
- Cukup mengimport core.dart saja
- Dokumentasi penggunaannya ada di: .github/widget-docs.md
- Jangan gunakan argument yang tidak ada di dokumentasi

### Core Components
- Use components from `lib/core/widget/docs.dart`: navigation, contextless utilities, snackbar, button, form widgets
- Implement ReuseKit framework components throughout the project
- Follow the established theme configuration
