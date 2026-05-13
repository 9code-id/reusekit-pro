# Navigation Guidelines

## Context-less Navigation

Always use `await` for asynchronous navigation:

```dart
// Navigate to a new view (always use await)
await to(const LoginView());

// Navigate to a new view and clear the stack (always use await)  
await offAll(const LoginView());

// Go back to the previous view
back(); // no argument
```

## Navigation Widgets

### QNavigation
TabBar is acceptable, but avoid using BottomNavigationBar.

## Navigation Rules

- Tidak perlu membuat navigasi ke halaman lain (when creating UI kits only)
