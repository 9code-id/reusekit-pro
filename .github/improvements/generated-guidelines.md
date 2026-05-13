# Generated Guidelines

## Type Casting Safety

### Map Value Casting Rules
When working with map values, always use consistent and safe type casting patterns:

#### ❌ Wrong Type Casting Patterns
```dart
// Wrong - Casting int as double directly
if ((plan["monthlyPrice"] as double) > 0)

// Wrong - Complex nested casting without proper parentheses
"${((alert["percentage"] as num).toDouble()) >= 0 ? '+' : ''}${((alert["percentage"] as num).toDouble()).toStringAsFixed(1)}%"

// Wrong - Assuming type without checking
(item["price"] as double).currency
```

#### ✅ Correct Type Casting Patterns
```dart
// Correct - Use num for mixed numeric types
if ((plan["monthlyPrice"] as num) > 0)

// Correct - Simplified casting for percentage display
"${(alert["percentage"] as num) >= 0 ? '+' : ''}${(alert["percentage"] as num).toStringAsFixed(1)}%"

// Correct - Safe conversion for currency
((item["price"] as int).toDouble()).currency
```

### Arithmetic Operations with Map Values
Always wrap casting operations in parentheses when performing arithmetic:

```dart
// ❌ Wrong
total = item["price"] as double * item["qty"] as int

// ✅ Correct  
total = (item["price"] as double) * (item["qty"] as int)
```

## InputDecorator Error Prevention

### TextField Width Constraint Rules
TextField widgets must have finite width constraints. Common violations:

#### ❌ Common TextField Error Patterns
```dart
// Wrong - TextField in Row without width constraint
Row(
  children: [
    QTextField(label: "Name", value: name, onChanged: (v) => {}),
    QButton(label: "Submit"),
  ],
)

// Wrong - TextField in horizontal scroll without width
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: QTextField(label: "Search", value: search, onChanged: (v) => {}),
)
```

#### ✅ Correct TextField Patterns
```dart
// Correct - TextField in Row with Expanded
Row(
  children: [
    Expanded(
      child: QTextField(label: "Name", value: name, onChanged: (v) => {}),
    ),
    SizedBox(width: spSm),
    QButton(label: "Submit"),
  ],
)

// Correct - TextField with explicit width in horizontal context
SizedBox(
  width: 200,
  child: QTextField(label: "Search", value: search, onChanged: (v) => {}),
)
```

## RenderFlex Error Prevention

### Expanded Widget Usage Rules
Expanded widgets can only be used inside Row, Flex, or horizontal layouts:

#### ❌ Problematic Expanded Usage
```dart
// Wrong - Expanded in Column (causes RenderFlex error)
Column(
  children: [
    Expanded(child: Container()),
  ],
)

// Wrong - Expanded in SingleChildScrollView
SingleChildScrollView(
  child: Column(
    children: [
      Expanded(child: Container()),
    ],
  ),
)
```

#### ✅ Safe Expanded Usage
```dart
// Correct - Expanded in Row
Row(
  children: [
    Expanded(child: Container()),
    Expanded(child: Container()),
  ],
)

// Correct - Container with width in Column
Column(
  children: [
    Container(
      width: double.infinity,
      child: Container(),
    ),
  ],
)
```

### Widget Method Design Patterns
Create separate methods for different layout contexts:

```dart
// For Row usage (returns Expanded)
Widget _buildCard({int flex = 1}) {
  return Expanded(
    flex: flex,
    child: _buildCardContent(),
  );
}

// For Column usage (returns Container)
Widget _buildCardFull() {
  return Container(
    width: double.infinity,
    child: _buildCardContent(),
  );
}

// Shared content
Widget _buildCardContent() {
  return Container(
    // Shared widget content
  );
}
```

## Layout Overflow Prevention

### Column Height Management
Prevent infinite height issues in scrollable contexts:

#### ❌ Problematic Layout Patterns
```dart
// Wrong - Unbounded height in Column
Column(
  children: [
    ListView.builder(...), // Can cause overflow
  ],
)
```

#### ✅ Safe Layout Patterns
```dart
// Correct - Bounded height with Expanded
Column(
  children: [
    Expanded(
      child: ListView.builder(...),
    ),
  ],
)

// Correct - Explicit height constraint
Column(
  children: [
    Container(
      height: 300,
      child: ListView.builder(...),
    ),
  ],
)
```

## Error Detection Checklist

### Before Submitting Code
- [ ] All map values cast with proper parentheses in arithmetic operations
- [ ] Use `num` type for mixed numeric data (int/double)
- [ ] TextField widgets in Row wrapped with Expanded or SizedBox
- [ ] No Expanded widgets inside Column or SingleChildScrollView
- [ ] ListView/GridView inside Column has height constraint or Expanded
- [ ] Complex casting expressions simplified for readability

### Quick Fix Reference
| Error Type | Common Cause | Quick Fix |
|------------|--------------|-----------|
| Type cast error | `as double` on int | Use `as num` or `.toDouble()` |
| InputDecorator width | TextField in Row | Wrap with `Expanded` |
| RenderFlex error | Expanded in Column | Use `Container` instead |
| Layout overflow | Unbounded height | Add `Expanded` or height constraint |

## Type Safety Best Practices

### Currency Formatting
Always convert to double before using .currency extension:

```dart
// ❌ Wrong
"${(item["price"] as int).currency}"

// ✅ Correct
"${((item["price"] as int).toDouble()).currency}"
```

### Percentage Handling
Use num type for mixed percentage data:

```dart
// ❌ Wrong
(data["percentage"] as double).toStringAsFixed(1)

// ✅ Correct
(data["percentage"] as num).toStringAsFixed(1)
```