# Utility Functions

## Snackbar Functions

Display brief messages to users with different styling:

```dart
// SUCCESS
ss("Data berhasil disimpan");

// ERROR  
se("Data gagal disimpan");

// WARNING
sw("Data sudah ada sebelumnya");

// INFO
si("Data sudah diperbarui");
```

## Confirmation Dialog
```dart
bool isConfirmed = await confirm("Apakah Anda yakin ingin menghapus data ini?");
```

## Dismissible Actions

Gunakan rowAction untuk dismissible, dan jangan gunakan dismissible langsung:

```dart
rowAction(
    onDismiss: () {},
    child: ListTile(...),
)
```

## Date Formatting

### DateTime Extensions
```dart
date.dMMMy
date.dMMMykkss
```

## Loading Indicators

### Global Loading (for button actions only)
```dart
showLoading(); // Display loading indicator
hideLoading(); // Hide loading indicator
```

**Important**: Only use these for short-term actions like button clicks. For page-level loading, use boolean state with CircularProgressIndicator.


### String interpolation
```
//Wrong
"On orders $50+"

//Correct
"On orders \$50+"
```