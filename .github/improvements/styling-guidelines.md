# Styling Guidelines

## General Styling Rules
- Never use Sliver widgets anywhere in the application, eg: CustomSCrollView, SliverAppBar, SliverList, SliverGrid, etc, semuanya yang berawalan Sliver.
- Avoid animations entirely for consistent performance
- Follow established color scheme and spacing guidelines

### Available Colorset
Jangan gunakan warna lain selain yang sudah didefinisikan di bawah ini. Gunakan warna-warna ini untuk styling aplikasi:
```dart
primaryColor
secondaryColor
successColor
dangerColor
infoColor
warningColor
disabledBoldColor
disabledColor
disabledOutlineBorderColor

### Radius
Untuk radius, gunakan radiusXxs, radiusXs, radiusSm, radiusMd, radiusLg, radiusXl, radius2xl, radius3xl, radius4xl
```dart
borderRadius: BorderRadius.circular(radiusMd),
```

### Shadow
Never define shadow manually, please use predefined shadows:
```dart
boxShadow: [
  shadowMd, // shadowNone, shadowXxs, shadowXs, shadowSm, shadowMd, shadowLg, shadowXl, shadowXxl, shadow3xl, shadow4xl
],
```

### Layout & Spacing
- Use `.withAlpha(value)` instead of `.withOpacity(value)`
- Prefer the `spacing` property in Column/Row over multiple SizedBox widgets
- Create visually balanced layouts with appropriate padding and margins
- Use consistent spacing throughout the application

### CONST Usage
- Don't use const if u using spLg, spMd, or spSm

## AppBar Styling
Never change the `backgroundColor`, `foregroundColor`, `elevation`, or `centerTitle` of the AppBar. Please just use default properties.
Never change text or icon color of widget in AppBar, always use default color.

## Scaffold Styling
Never change the `backgroundColor` of the Scaffold. Use the default color.

## Border Implementation
Penerapkan borderSide yang benar:
```dart
border: Border(
  left: BorderSide(
    width: 4,
    color: statusColor,
  ),
),
```

## Text Styling
- TextStyle tidak perlu didefinisikan dengan const

## Color Rules
- Warna icon, text secondaryButton selalu menggunakan disabledBoldColor

## Icon
- Jangan gunakan outlined icon sama sekali!
- Gunakan Icons. bawaan flutter,jika icon-nya tidak ada, gunakan Icons dari material_design_icons_flutter atau font_awesome_flutter

## Text Heading
For text headings, use these predefined font sizes:
- Card header always use fsH6
- Section header always use fsH6

```dart
// Heading 1 - Largest heading
fontSize: fsH1, // 32.0

// Heading 2 - Second largest
fontSize: fsH2, // 28.0

// Heading 3 - Third level heading
fontSize: fsH3, // 24.0

// Heading 4 - Fourth level heading
fontSize: fsH4, // 20.0

// Heading 5 - Fifth level heading
fontSize: fsH5, // 18.0

// Heading 6 - Smallest heading
fontSize: fsH6, // 16.0
```

Example usage:
```dart
Text(
  "Main Title",
  style: TextStyle(
    fontSize: fsH1,
    fontWeight: FontWeight.bold,
  ),
),
```

### Card Header
- always use cardHeaderMaxHeight for the height