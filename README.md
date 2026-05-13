# ReuseKit Flutter Framework

A comprehensive Flutter framework with reusable components and standardized architecture for rapid Flutter app development.

## 📚 Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
  - [System Requirements](#system-requirements)
  - [FVM Setup (Recommended)](#fvm-setup-recommended)
  - [Project Setup](#project-setup)
- [Theme System](#theme-system)
- [Form Widgets](#form-widgets)
- [Media & File Widgets](#media--file-widgets)
- [Layout Components](#layout-components)
- [Scaffold Components](#scaffold-components)
- [Navigation & Utilities](#navigation--utilities)
- [Type Extensions](#type-extensions)
- [State Management](#state-management)
- [Best Practices](#best-practices)
- [Common Errors & Solutions](#common-errors--solutions)

## 🎯 Overview

ReuseKit is a Flutter framework designed to accelerate development by providing:

- **Reusable Components**: Pre-built widgets with consistent styling
- **Theme System**: Centralized color, spacing, and styling configuration
- **Navigation Utils**: Context-less navigation and dialog helpers
- **Form Widgets**: Standardized form components with validation
- **Layout Helpers**: Responsive grid and layout components
- **Type Extensions**: Enhanced functionality for common data types
- **Media Components**: Image pickers, file pickers, and attachment handlers

## 🚀 Getting Started

### System Requirements

Before starting with ReuseKit, ensure you have the following tools installed:

**Required Software:**
- **Flutter SDK**: Version 3.32.0 or higher (Latest stable)
- **Dart SDK**: Version 3.6.0 or higher (included with Flutter)
- **Java JDK**: Version 17 or higher for Android development
- **Android Studio**: Latest version with Android SDK
- **VS Code**: Recommended with Flutter and Dart extensions
- **FVM (Flutter Version Management)**: Recommended for managing Flutter versions

**Verify Installation:**
```bash
# Check Flutter version (should be 3.32.0 or higher)
flutter --version

# If using FVM (recommended for this project)
fvm flutter --version

# Check Java version (should be 17 or higher)
java --version

# Check Flutter environment and dependencies
flutter doctor

# Or with FVM
fvm flutter doctor
```

**Expected Output Example:**
```
Flutter 3.32.0 • channel stable
Framework • revision 7c1486319
Engine • revision cb4b5fff73  
Tools • Dart 3.6.0 • DevTools 2.40.2
```

### FVM Setup (Recommended)

FVM (Flutter Version Management) allows you to manage multiple Flutter versions easily. This project uses FVM to ensure consistent Flutter versions across all developers.

**Installing FVM:**

Using Dart (Recommended):
```bash
dart pub global activate fvm
```

Using Homebrew (macOS):
```bash
brew tap leoafarias/fvm
brew install fvm
```

Using Chocolatey (Windows):
```bash
choco install fvm
```

**Setting Up FVM for This Project:**

This project is configured to use Flutter version 3.32.0. Follow these steps:

```bash
# 1. Install the required Flutter version
fvm install 3.32.0

# 2. Use the Flutter version for this project
fvm use 3.32.0

# 3. Verify the version
fvm flutter --version

# 4. Run Flutter commands with FVM
fvm flutter doctor
fvm flutter pub get
```

**FVM Configuration:**

This project includes an `.fvmrc` file that automatically configures the Flutter version:
```json
{
  "flutter": "3.32.0"
}
```

The `.fvm/` directory is already added to `.gitignore` to avoid committing Flutter SDK files.

**IDE Configuration for FVM:**

**VS Code Setup:**
VS Code is already configured to use FVM. Check `.vscode/settings.json`:
```json
{
  "dart.flutterSdkPath": ".fvm/versions/3.32.0"
}
```

**Android Studio Setup:**
Configure Android Studio to use the FVM Flutter SDK:
1. Go to **File → Settings → Languages & Frameworks → Flutter**
2. Set Flutter SDK path to: `[project_root]/.fvm/versions/3.32.0`
3. Apply and restart Android Studio

### Project Setup

Follow these steps to set up and run a ReuseKit project:

**1. Clone or Create Project:**
```bash
# Clone existing project
git clone <your-project-url>
cd your-project-name

# Or create new Flutter project
flutter create my_reusekit_app
cd my_reusekit_app
```

**2. Install Dependencies:**

If using FVM (recommended for this project):
```bash
# Install Flutter version 3.32.0 if not already installed
fvm install 3.32.0

# Use the correct Flutter version for this project
fvm use 3.32.0

# Get Flutter packages with FVM
fvm flutter pub get

# Clean build cache (if needed)
fvm flutter clean
```

Or with regular Flutter installation:
```bash
# Get Flutter packages
flutter pub get

# Clean build cache (if needed)
flutter clean
```

**3. Run the Project:**

With FVM (recommended):
```bash
# Run on connected device/emulator
fvm flutter run

# Run on specific platform
fvm flutter run -d chrome      # Web
fvm flutter run -d windows     # Windows
fvm flutter run -d android     # Android
fvm flutter run -d ios         # iOS (macOS only)
```

Or with regular Flutter:
```bash
# Run on connected device/emulator
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d windows         # Windows
flutter run -d android         # Android
flutter run -d ios             # iOS (macOS only)
```

**4. Build for Production:**

With FVM (recommended):
```bash
# Build APK for Android
fvm flutter build apk --release

# Build AAB for Google Play Store
fvm flutter build appbundle --release

# Build for web
fvm flutter build web --release

# Build for Windows
fvm flutter build windows --release
```

Or with regular Flutter:
```bash
# Build APK for Android
flutter build apk --release

# Build AAB for Google Play Store
flutter build appbundle --release

# Build for web
flutter build web --release

# Build for Windows
flutter build windows --release
```

**Development Tips:**
- Use `fvm flutter hot reload` (r) for fast development
- Use `fvm flutter hot restart` (R) for state reset
- Run `fvm flutter doctor` to check environment issues
- Use `fvm flutter devices` to list available devices
- All commands can be run with `flutter` directly if not using FVM

### Import ReuseKit Core

Every new view/page must import these two essentials:

```dart
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
```

The `core.dart` file provides access to all ReuseKit components, utilities, and theme configurations.

### Basic View Structure

```dart
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Page"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Your content here
          ],
        ),
      ),
    );
  }
}
```

## 🎨 Theme System

### Color Palette

ReuseKit provides a standardized color system:

```dart
// Primary Colors
primaryColor      // #6366F1 - Main brand color
secondaryColor    // #E5E7EB - Secondary/neutral color

// Semantic Colors
successColor      // #10B981 - Success states
dangerColor       // #EF4444 - Error/danger states
infoColor         // #3B82F6 - Information
warningColor      // #F59E0B - Warning states

// Text & UI Colors
disabledBoldColor       // #6B7280 - Secondary text
disabledColor           // #9CA3AF - Disabled states
disabledOutlineBorderColor // #D1D5DB - Border colors
```

### Spacing System

Consistent spacing values for margins, padding, and gaps:

```dart
spXxs  // 4.0  - Extra extra small
spXs   // 6.0  - Extra small
spSm   // 8.0  - Small
spMd   // 12.0 - Medium (default for scaffold padding)
spLg   // 16.0 - Large
spXl   // 20.0 - Extra large
sp2xl  // 24.0 - 2x large
sp3xl  // 32.0 - 3x large
sp4xl  // 40.0 - 4x large
```

### Border Radius

```dart
radiusXxs  // 2.0
radiusXs   // 4.0
radiusSm   // 6.0
radiusMd   // 8.0
radiusLg   // 10.0
radiusXl   // 12.0
radius2xl  // 16.0
radius3xl  // 20.0
radius4xl  // 24.0
```

### Font Sizes

```dart
// Headings
fsH1  // 32.0 - Largest heading
fsH2  // 28.0
fsH3  // 24.0
fsH4  // 20.0
fsH5  // 18.0
fsH6  // 16.0 - Standard for card headers and section titles

// Regular text sizes
fsXxs  // 8.0
fsXs   // 10.0
fsSm   // 11.0
fsMd   // 12.0
fsLg   // 14.0
fsXl   // 16.0
fs2xl  // 18.0
fs3xl  // 20.0
fs4xl  // 22.0
```

### Shadows

Predefined shadow styles:

```dart
boxShadow: [shadowSm]  // Small shadow for cards
boxShadow: [shadowMd]  // Medium shadow
boxShadow: [shadowLg]  // Large shadow
// Available: shadowNone, shadowXxs, shadowXs, shadowSm, shadowMd, shadowLg, shadowXl, shadowXxl, shadow3xl, shadow4xl
```

### Button Sizes

```dart
bs.sm  // Small button
bs.md  // Medium button (default)
```

## 📝 Form Widgets

### QTextField - Text Input Field

```dart
QTextField(
  label: "Email Address",
  value: email,
  hint: "Enter your email",
  validator: Validator.required,
  onChanged: (value) {
    email = value;
    setState(() {});
  },
)
```

**Properties:**
- `label` (required): Field label
- `value` (required): Current value
- `hint`: Placeholder text
- `validator`: Validation function
- `obscureText`: For password fields
- `onChanged` (required): Value change callback

### QNumberField - Numeric Input

```dart
QNumberField(
  label: "Price (\$)",
  value: price.toString(),
  validator: Validator.required,
  onChanged: (value) {
    price = double.tryParse(value) ?? 0.0;
    setState(() {});
  },
)
```

### QMemoField - Multi-line Text Input

```dart
QMemoField(
  label: "Description",
  value: description,
  hint: "Enter detailed description",
  onChanged: (value) {
    description = value;
    setState(() {});
  },
)
```

### QDropdownField - Dropdown Selection

```dart
QDropdownField(
  label: "Category",
  items: [
    {"label": "Option 1", "value": "option1"},
    {"label": "Option 2", "value": "option2"},
  ],
  value: selectedCategory,
  onChanged: (value, label) {
    selectedCategory = value; // Always use value, not label
    setState(() {});
  },
)
```

### QDatePicker - Date Selection

```dart
QDatePicker(
  label: "Appointment Date",
  value: DateTime.parse(selectedDate), // Parse string to DateTime
  onChanged: (value) {
    selectedDate = value.toString();
    setState(() {});
  },
)
```

### QTimePicker - Time Selection

```dart
QTimePicker(
  label: "Appointment Time",
  value: TimeOfDay.fromDateTime(DateTime.parse(selectedTime)),
  onChanged: (value) {
    selectedTime = value!.kkmm; // Convert to string format
    setState(() {});
  },
)
```

### QSwitch - Toggle Switch

```dart
QSwitch(
  items: [
    {
      "label": "Enable Notifications",
      "value": true,
      "checked": enableNotifications,
    }
  ],
  value: [
    if (enableNotifications) {
      "label": "Enable Notifications",
      "value": true,
      "checked": true
    }
  ],
  onChanged: (values, ids) {
    enableNotifications = values.isNotEmpty;
    setState(() {});
  },
)
```

### QLocationPicker - Location Selection

```dart
QLocationPicker(
  label: "Location",
  latitude: latitude,
  longitude: longitude,
  hint: "Pick a location",
  onChanged: (lat, lng, address) {
    latitude = lat;
    longitude = lng;
    locationAddress = address;
    setState(() {});
  },
)
```

## 🎯 Media & File Widgets

### QImagePicker - Single Image Selection

```dart
String profileImage = "";

QImagePicker(
  label: "Profile Image",
  value: profileImage,
  hint: "Select your profile picture",
  helper: "Image will be uploaded to cloud storage",
  validator: Validator.required,
  onChanged: (value) {
    profileImage = value;
    setState(() {});
  },
)
```

### QMultiImagePicker - Multiple Image Selection

```dart
List<String> productImages = [];

QMultiImagePicker(
  label: "Product Images",
  value: productImages,
  maxImages: 5,
  hint: "Add product photos",
  helper: "You can upload up to 5 high-quality images",
  validator: (images) {
    if (images == null || images.isEmpty) {
      return "At least one image is required";
    }
    return null;
  },
  onChanged: (value) {
    productImages = value;
    setState(() {});
  },
)
```

### QCameraPicker - Camera Image Capture

```dart
String cameraImage = "";

QCameraPicker(
  label: "Take Photo",
  value: cameraImage,
  hint: "Capture image using camera",
  onChanged: (value) {
    cameraImage = value;
    setState(() {});
  },
)
```

### QFilePicker - Single File Selection

```dart
String documentFile = "";

QFilePicker(
  label: "Upload Document",
  value: documentFile,
  extensions: ['pdf', 'doc', 'docx'],
  hint: "Select a document file",
  onChanged: (value) {
    documentFile = value;
    setState(() {});
  },
)
```

### QFilesPicker - Multiple File Selection

```dart
List<String> attachments = [];

QFilesPicker(
  label: "Attachments",
  value: attachments,
  extensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
  attachmentType: AttachmentType.file,
  hint: "Select multiple files",
  onChanged: (value) {
    attachments = value;
    setState(() {});
  },
)
```

### QAttachmentPicker - Universal Attachment Handler

```dart
List<String> attachments = [];

QAttachmentPicker(
  label: "Attachments",
  value: attachments,
  hint: "Attach files to your message",
  helper: "Supports images, documents, videos, and audio files",
  maxAttachments: 10,
  allowedTypes: ['image', 'document', 'video', 'audio'],
  validator: (files) {
    if (files == null || files.isEmpty) {
      return "At least one file is required";
    }
    return null;
  },
  onChanged: (value) {
    attachments = value;
    setState(() {});
  },
)
```

### QChatField - Chat Input with Attachments

```dart
String message = "";
List<String> messageAttachments = [];

QChatField(
  label: "Message",
  value: message,
  hint: "Type your message...",
  helper: "Press and hold mic button to record voice message",
  maxLines: 5,
  maxLength: 1000,
  attachments: messageAttachments,
  showAttachmentButton: true,
  showEmojiButton: true,
  showVoiceButton: true,
  onChanged: (value) {
    message = value;
    setState(() {});
  },
  onSend: () {
    // Handle send message
    if (message.isNotEmpty || messageAttachments.isNotEmpty) {
      _sendMessage(message, messageAttachments);
      message = "";
      messageAttachments = [];
      setState(() {});
    }
  },
  onAttachmentsChanged: (value) {
    messageAttachments = value;
    setState(() {});
  },
)
```

## 🔘 Selection Widgets

### QCategoryPicker - Horizontal Category Selection

```dart
QCategoryPicker(
  label: "Select Category",
  items: [
    {"label": "Main Course", "value": "main_course"},
    {"label": "Drink", "value": "drink"},
    {"label": "Snack", "value": "snack"},
    {"label": "Dessert", "value": "dessert"},
  ],
  value: selectedCategory,
  validator: Validator.required,
  onChanged: (index, label, value, item) {
    selectedCategory = value;
    setState(() {});
  },
)
```

### QCategoryWrapPicker - Wrapped Category Selection

```dart
QCategoryWrapPicker(
  label: "Select Tags",
  items: [
    {"label": "Food", "value": "food"},
    {"label": "Drink", "value": "drink"},
    {"label": "Service", "value": "service"},
  ],
  value: selectedTag,
  onChanged: (index, label, value, item) {
    selectedTag = value;
    setState(() {});
  },
)
```

### QTagPicker - Tag Selection

```dart
QTagPicker(
  label: "Select Tags",
  items: [
    {"label": "Important", "value": "important"},
    {"label": "Urgent", "value": "urgent"},
    {"label": "Meeting", "value": "meeting"},
  ],
  value: selectedTag,
  onChanged: (index, label, value, item) {
    selectedTag = value;
    setState(() {});
  },
)
```

## 🔲 Button Components

### QButton - Primary Button

```dart
QButton(
  label: "Submit",
  icon: Icons.send, // Optional icon
  size: bs.md,     // Button size
  color: primaryColor, // Optional color override
  onPressed: () {
    // Handle button press
  },
)
```

**Available sizes:**
- `bs.sm` - Small button
- `bs.md` - Medium button (default)

**Button with icon only:**
```dart
QButton(
  icon: Icons.add,
  size: bs.sm,
  onPressed: () {},
)
```

## 📐 Layout Components

### ResponsiveGridView - Grid Layout

```dart
ResponsiveGridView(
  padding: EdgeInsets.all(spSm),
  minItemWidth: 200, // Minimum item width
  children: items.map((item) {
    return Container(
      // Grid item content
    );
  }).toList(),
)
```

### QHorizontalScroll - Horizontal Scrolling

```dart
QHorizontalScroll(
  children: List.generate(items.length, (index) {
    final item = items[index];
    return Container(
      width: 280,
      // Item content
    );
  }),
)
```

## 🏗️ Scaffold Components

### QTabBar - Tab Interface

```dart
QTabBar(
  title: "Dashboard",
  selectedIndex: currentTab,
  tabs: [
    Tab(text: "Overview", icon: Icon(Icons.dashboard)),
    Tab(text: "Analytics", icon: Icon(Icons.analytics)),
  ],
  tabChildren: [
    OverviewTabView(),
    AnalyticsTabView(),
  ],
  onInit: (tabController) {
    // Optional: Access to TabController
  },
)
```

**For embedded tabs (without AppBar):**
```dart
QTabBar(
  title: "Dashboard",
  withoutAppBar: true, // Removes AppBar
  selectedIndex: currentTab,
  tabs: [...],
  tabChildren: [...],
)
```

### QBottomBar - Bottom Navigation

```dart
QBottomBar(
  title: "App Title",
  selectedIndex: currentIndex,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: "Search",
    ),
  ],
  children: [
    HomeTabView(),
    SearchTabView(),
  ],
  onTap: (index) {
    currentIndex = index;
    setState(() {});
  },
)
```

## 🧭 Navigation & Utilities

### Context-less Navigation

Navigate between pages without requiring BuildContext:

```dart
// Navigate to new page
await to(const LoginView());

// Navigate and clear all previous routes
await offAll(const DashboardView());

// Go back to previous page
back();
```

### Snackbar Utilities

Display contextual messages:

```dart
ss("Success message");      // Green success snackbar
se("Error message");        // Red error snackbar
sw("Warning message");      // Orange warning snackbar
si("Info message");         // Blue info snackbar
```

### Dialog Utilities

```dart
// Confirmation dialog
bool isConfirmed = await confirm("Are you sure you want to delete this item?");
if (isConfirmed) {
  // Proceed with deletion
}

// Alert dialog
await alert("Information message");
```

### Loading Indicators

```dart
// Show loading (for button actions only)
showLoading();

// Hide loading
hideLoading();

// For page-level loading, use boolean state with CircularProgressIndicator
bool loading = false;

if (loading) {
  return Center(child: CircularProgressIndicator());
}
```

## 🔧 Type Extensions

### DateTime Extensions

```dart
// Date formatting
DateTime.now().dMMMy          // "15 Jan 2024"
DateTime.now().dMMMykkss      // "15 Jan 2024 14:30:45"
```

### TimeOfDay Extensions

```dart
// Time conversion
"14:30".timeOfDay             // TimeOfDay(14, 30)
TimeOfDay.now().kkmm          // "14:30"
```

### Currency Extension

```dart
// Currency formatting for different types
(123.45).currency             // "123.45"
(1000).currency               // "1,000"
"1234.56".currency            // "1,234.56"

// Always cast to double before using currency
((item["price"] as int).toDouble()).currency
```

## 📝 Form Handling

### Form Structure with Validation

```dart
final formKey = GlobalKey<FormState>();

Form(
  key: formKey,
  child: Column(
    spacing: spMd,
    children: [
      QTextField(
        label: "Email",
        value: email,
        validator: Validator.email,
        onChanged: (value) {
          email = value;
          setState(() {});
        },
      ),
      QTextField(
        label: "Password",
        value: password,
        validator: Validator.required,
        obscureText: true,
        onChanged: (value) {
          password = value;
          setState(() {});
        },
      ),
      QButton(
        label: "Submit",
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // Form is valid, proceed
          }
        },
      ),
    ],
  ),
)
```

### Available Validators

```dart
Validator.required       // Required field validation
Validator.email         // Email format validation
```

## 🔄 State Management

### Preferred State Pattern

Use this pattern for state updates:

```dart
// Preferred approach
loading = true;
setState(() {});

// Instead of
setState(() {
  loading = true;
});
```

### Loading States

**Page Loading (use boolean state):**
```dart
bool loading = false;

if (loading) {
  return Center(child: CircularProgressIndicator());
}
```

**Button Loading (use utility functions):**
```dart
QButton(
  label: "Submit",
  onPressed: () async {
    showLoading();
    
    try {
      // Perform operation
      await someAsyncOperation();
      ss("Operation completed successfully");
    } catch (e) {
      se("Operation failed");
    } finally {
      hideLoading();
    }
  },
)
```

## 🎯 Best Practices

### Import Rules

**Required imports for every new view:**
```dart
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
```

No need to import individual services or models - they're available through `core.dart`.

### Forbidden Widgets

**❌ Never use these widgets:**
- `TabBar`, `TabBarView`, `DefaultTabController` → Use `QTabBar`
- `ListTile` → Create custom layouts with Container, Row, Column
- `PageView` → Use alternative scroll solutions
- `CustomScrollView`, Sliver widgets → Use `SingleChildScrollView`
- `suffixIcon`, `prefixIcon` on TextFields → Use Row layouts with icons

### Layout Rules

**Scaffold Structure:**
```dart
Scaffold(
  appBar: AppBar(title: Text("Page Title")),
  body: SingleChildScrollView(
    padding: EdgeInsets.all(spMd), // Required padding
    child: Column(
      spacing: spMd, // Use spacing property instead of SizedBox
      children: [
        // Content
      ],
    ),
  ),
)
```

**TextField Layout Rules:**

In Row layouts, always wrap TextField with Expanded:
```dart
Row(
  children: [
    Expanded(
      child: QTextField(
        label: "First Name",
        value: firstName,
        onChanged: (value) => setState(() => firstName = value),
      ),
    ),
    SizedBox(width: spSm),
    Expanded(
      child: QTextField(
        label: "Last Name",
        value: lastName,
        onChanged: (value) => setState(() => lastName = value),
      ),
    ),
  ],
)
```

In Column layouts, no wrapping needed:
```dart
Column(
  children: [
    QTextField(
      label: "Email",
      value: email,
      onChanged: (value) => setState(() => email = value),
    ),
    QTextField(
      label: "Password",
      value: password,
      onChanged: (value) => setState(() => password = value),
    ),
  ],
)
```

### Type Safety & Casting

**Always cast map values before operations:**
```dart
// Wrong
item["price"] * item["qty"]

// Correct
(item["price"] as double) * (item["qty"] as int)
```

**Currency formatting (must be double):**
```dart
// Wrong
"\$${(item["price"] as int).currency}"

// Correct
"\$${((item["price"] as int).toDouble()).currency}"
```

**String interpolation required for UI:**
```dart
Text("${item["title"]}")
Image.network("${item["image_url"]}")
```

**Always cast to List before accessing index:**
```dart
// Wrong
"${product["images"][index]}"

// Correct
"${(product["images"] as List)[index]}"
```

## 🚨 Common Errors & Solutions

### TextField Width Constraints

**Error**: `InputDecorator cannot have unbounded width`

**Solution**: Always wrap TextFields in Row with Expanded:

```dart
// ❌ Wrong
Row(children: [QTextField(...)])

// ✅ Correct  
Row(children: [Expanded(child: QTextField(...))])
```

### RenderFlex Errors

**Error**: `RenderFlex children have non-zero flex but incoming height constraints are unbounded`

**Solution**: Never use Expanded in Column or ScrollView:

```dart
// ❌ Wrong
Column(children: [Expanded(child: Widget())])

// ✅ Correct
Column(children: [Container(width: double.infinity, child: Widget())])
```

### Type Casting Errors

**Error**: `type 'int' is not a subtype of type 'double'`

**Solution**: Always wrap casting in parentheses:

```dart
// ❌ Wrong
(item["price"] as double / 100)

// ✅ Correct
((item["price"] as double) / 100)
```

### Icon Restrictions

**Error**: `The named parameter 'suffixIcon' isn't defined`

**Solution**: Never use icon properties on QTextField, use Row layouts:

```dart
// ❌ Wrong
QTextField(
  label: "Password",
  suffixIcon: Icon(Icons.visibility),
)

// ✅ Correct
Row(
  children: [
    Expanded(
      child: QTextField(
        label: "Password",
        value: password,
        onChanged: (value) => setState(() => password = value),
      ),
    ),
    SizedBox(width: spSm),
    Icon(Icons.visibility),
  ],
)
```

## 📱 Project Structure

```
lib/
├── core.dart                    # Central exports file
├── core/
│   ├── theme/
│   │   └── theme_config.dart    # Theme configuration
│   ├── widget/
│   │   ├── button/              # Button components
│   │   ├── hyper_ui/form/       # Form widgets
│   │   ├── contextless/         # Navigation utilities
│   │   ├── responsive/          # Layout components
│   │   └── scaffold/            # Scaffold components
│   └── util/
│       ├── type_extension/      # Type extensions
│       └── validator/           # Form validators
└── presentation/                # Application views
    ├── login_view.dart
    ├── dashboard_view.dart
    └── ...
```

## 🤝 Contributing

When creating new views:

1. Follow the naming convention: `XxxView` (e.g., `LoginView`)
2. Import required dependencies (`material.dart` and `core.dart`)
3. Use ReuseKit components and theme system
4. Follow layout and state management guidelines
5. Ensure proper TextField constraint handling
6. Use appropriate file and media picker components
7. Follow type casting safety rules

---

**ReuseKit** - Accelerating Flutter development with reusable, well-designed components. 🚀
