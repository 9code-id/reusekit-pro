# State Management Guidelines

## Preferred State Management Pattern

Saya prefer menggunakan kode seperti ini (contoh):
```dart
loading = true;
setState(() {});
```

Daripada: 
```dart
setState(() {
  loading = true;
});
```

## Loading States

### Page Loading
- Handle page loading manually with a boolean state variable and CircularProgressIndicator
- Never use showLoading/hideLoading for entire page loading, for example when getting data from API at the beginning of the page, please use bool loading state and CircularProgressIndicator instead

### Button Loading
- Only use showLoading/hideLoading when a button click requires loading

## Exception Handling

- Saya tidak ingin menggunakan finally sama sekali, jadi jangan gunakan finally
