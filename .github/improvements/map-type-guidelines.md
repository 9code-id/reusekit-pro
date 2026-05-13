# Map Type Guidelines

## Map Operations and Type Safety

### Map Data Casting
Always cast map values to their expected types before performing operations:

```dart
// Wrong
item["price"] * item["qty"]

// Correct
(item["price"] as double) * (item["qty"] as int)
```

### Arithmetic Operations with Maps
When performing arithmetic operations on map values, always cast first:

```dart
// Wrong
episodeData["plays"] as int / 1000

// Correct
(episodeData["plays"] as int) / 1000
```

### Complex Calculations
For complex calculations, ensure proper parentheses and casting:

```dart
// Wrong
'\$${(product['revenue'] as int / 1000).toStringAsFixed(1)}K'

// Correct
'\$${((product['revenue'] as int) / 1000).toStringAsFixed(1)}K'
```

## List Access from Maps

Always cast to List before accessing index:

```dart
// Wrong
"${product["images"][index]}"

// Correct
"${(product["images"] as List)[index]}"
```

## String Interpolation with Maps

Use string interpolation for all map values in UI:

```dart
// Text values
Text("${item["title"]}")

// Image URLs
Image.network("${item["image_url"]}")

// Numeric values with formatting
Text("\$${(item["price"] as double).currency}")
```

## Color and Object Casting

Cast map values to specific object types when needed:

```dart
// Color casting
Container(
    color: item["color"] as Color,
)

// DateTime casting
Text(
    "${(item["created_at"] as DateTime).dMMMy}",
)
```

## Safe Type Conversion

Use safe conversion methods for nullable or uncertain types:

```dart
// Safe double conversion
double price = double.tryParse("${item["price"]}") ?? 0.0;

// Safe int conversion
int quantity = int.tryParse("${item["qty"]}") ?? 0;
```

## Currency Formatting

Always cast to double before using currency formatting:

```dart
// Wrong
"\$${item["price"].currency}"

// Correct
"\$${(item["price"] as double).currency}"
```

## Best Practices

1. **Always cast map values** before performing operations
2. **Use parentheses** around cast expressions in calculations
3. **String interpolation** is required for all UI text from maps
4. **Safe conversion** methods for user input or uncertain data
5. **Consistent casting** throughout the application for type safety