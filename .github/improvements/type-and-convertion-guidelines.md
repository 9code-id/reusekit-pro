# Type and Conversion Guidelines

## Data Type Handling

### Map Operations
- Kalau melakukan operasi aritmatika terhadap variabel yang ada di map, misalnya item["price"] * item["qty"], Kamu wajib mengcasting variabel tersebut, misalnya: item["price"] as double * item["qty"] as double
- Object di Map, wajib menggunakan casting jika diperlukan, contoh: item["color"] as Color
- Setiap casting, jangan lupa di kurung, contoh: (item["color"] as Color)

### Casting Examples

Contoh yang salah:
```dart
'\$${(product['revenue'] as int / 1000).toStringAsFixed(1)}K'
```

Mestinya:
```dart
'\$${((product['revenue'] as int) / 1000).toStringAsFixed(1)}K'
```

- Setiap data Map yang diakses, harus di casting terlebih dahulu jika diperlukan, misalnya:
```dart
(item["price"] as double) * (item["qty"] as double)
```

## Type Casting Safety Guidelines

### Currency Extension Type Safety
The `.currency` extension only works with `double` type. Always convert to `double` before using:

```dart
// ❌ Wrong - .currency expects double but gets int
"\$${(item["price"] as int).currency}"

// ✅ Correct - Convert int to double first
"\$${((item["price"] as int).toDouble()).currency}"

// ✅ Also correct - Cast directly as double if you know it's a number
"\$${(item["price"] as double).currency}"
```

### Arithmetic Operations with Mixed Types
When performing arithmetic operations with map values, ensure type consistency:

```dart
// ❌ Wrong - fold expects consistent types
.fold(0, (sum, item) => sum + (item["value"] as int))

// ✅ Correct - Use double for accumulator and convert values
.fold(0.0, (sum, item) => sum + (item["value"] as int).toDouble())
```

### Percentage and Numeric Value Handling
For values that might be either `int` or `double`, use `num` type and convert safely:

```dart
// ❌ Wrong - Assumes value is always double
"${(item["percentage"] as double).toStringAsFixed(1)}%"

// ✅ Correct - Handle both int and double safely
"${((item["percentage"] as num).toDouble()).toStringAsFixed(1)}%"
```

### Safe Type Conversion Patterns

#### Pattern 1: Currency Formatting
```dart
// For int prices
"\$${((item["price"] as int).toDouble()).currency}"

// For double prices
"\$${(item["price"] as double).currency}"

// For unknown numeric types
"\$${((item["price"] as num).toDouble()).currency}"
```

#### Pattern 2: Arithmetic Operations
```dart
// Wrong - Type mismatch
total = (item["price"] as int) * (item["qty"] as double)

// Correct - Consistent types
total = (item["price"] as int).toDouble() * (item["qty"] as double)
```

#### Pattern 3: Fold Operations with Type Safety
```dart
// Wrong
.fold(0, (sum, item) => sum + (item["value"] as int))

// Correct
.fold(0.0, (sum, item) => sum + (item["value"] as int).toDouble())
```

### Common Type Casting Errors and Fixes

#### Error: "type 'int' is not a subtype of type 'double' in type cast"
**Cause**: Trying to cast an `int` value as `double` or using `int` where `double` is expected.

**Fix**: Use `.toDouble()` conversion or cast as `num` first:
```dart
// Wrong
(item["value"] as double)

// Right
(item["value"] as int).toDouble()
// OR
(item["value"] as num).toDouble()
```

#### Error: Type mismatch in fold operations
**Cause**: Accumulator type doesn't match the values being added.

**Fix**: Ensure consistent types throughout the operation:
```dart
// Wrong
.fold(0, (sum, item) => sum + (item["price"] as int))

// Right
.fold(0.0, (sum, item) => sum + (item["price"] as int).toDouble())
```

## Data Type Conversion

String to TimeOfDay:
```dart
TimeOfDay = "10:00".timeOfDay;
```

Double to money:
```dart
(double.tryParse("{value}") ?? 0).currency;
(item["price"] as double).currency; 
```

Kalau variabelnya ada di map, misalnya item["price"], mesti di casting dulu as double | int, baru bisa menggunakan property .currency

## String Interpolation

### Correct Usage
```dart
//Wrong
"On orders $50+"

//Correct
"On orders \$50+"
```

### Text Widget Values
```dart
Text(
    "${image["title"]}", //interpolated string is required
    style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
    ),
),
```

### Image Source URLs
```dart
Image.network(
    "${image["url"]}", //interpolated string is required
    ...
),
```