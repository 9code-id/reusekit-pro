
# Icon Usage Guidelines

## Icon Selection Rules

### ❌ Forbidden Icon Patterns
- **Never use outlined icons that don't exist** in Material Icons Flutter
- **Never use non-existent icons** without checking Material Icons documentation
- **Avoid custom icon names** that aren't part of the standard Flutter icon set

### ✅ Required Icon Practices
- **Always use solid/filled icons** as the primary choice
- **Use closest available alternative** when specific icon doesn't exist
- **Verify icon existence** in Material Icons Flutter before implementation

## Common Icon Replacements

### Navigation Icons
```dart
// ❌ Wrong - Non-existent outlined versions
Icons.home_outlined        → Icons.home
Icons.search_outlined      → Icons.search
Icons.person_outline       → Icons.person
Icons.notifications_outline → Icons.notifications
```

### Action Icons
```dart
// ❌ Wrong - Non-existent or deprecated icons
Icons.generate_outlined    → Icons.auto_awesome  // or Icons.settings
Icons.local_amenities     → Icons.location_on    // or Icons.place
Icons.road                → Icons.directions     // or Icons.navigation
Icons.google              → Icons.g_mobiledata   // or Icons.login
```

### Business & Feature Icons
```dart
// ❌ Wrong - Non-standard icons
Icons.business_outlined    → Icons.business
Icons.store_outlined       → Icons.store
Icons.shopping_outlined    → Icons.shopping_cart
Icons.payment_outlined     → Icons.payment
```

## Icon Validation Checklist

Before using any icon, verify:
- [ ] Icon exists in Material Icons Flutter
- [ ] Icon name is correctly spelled
- [ ] Icon follows solid/filled pattern preference
- [ ] Icon semantically matches the intended function

## Alternative Icon Sources

If Material Icons don't have the needed icon:
1. **First choice**: Use closest semantic Material Icon
2. **Second choice**: Use `material_design_icons_flutter` package
3. **Third choice**: Use `font_awesome_flutter` package

### Example Usage
```dart
// ✅ Correct Material Icons usage
Icon(Icons.home)           // Standard home icon
Icon(Icons.settings)       // Settings/configuration
Icon(Icons.notifications)  // Notification bell
Icon(Icons.person)         // User profile
Icon(Icons.location_on)    // Location/place marker
```

## Error Prevention

### Common Icon Errors
- `Icons.xxx_outlined` doesn't exist → Use `Icons.xxx`
- `Icons.xxx_filled` doesn't exist → Use `Icons.xxx`
- Custom icon names → Use Material Icons standard names

### Quick Fix Pattern
When encountering icon errors:
1. Remove `_outlined` or `_filled` suffix
2. Check Material Icons documentation
3. Use semantic alternative if icon doesn't exist
4. Test icon rendering before finalizing
