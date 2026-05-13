# Layout Guidelines


## Scaffold body
Selalu berikan padding pada SingleChildScrollView di dalam Scaffold body. Gunakan `spMd` untuk padding. Contoh implementasinya:
```
Scaffold(
    body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        ...
    ),
),
```

Jika scaffold body diawali Container,
```
Scaffold(
    body: Container(
        padding: EdgeInsets.all(spMd),
        ...
    ),
)

```
## Horizontal List for Category Selection
- Jangan gunakan QCategoryPicker sebagai child dalam Row(), karena tidak cocok untuk layout horizontal tersebut.

Gunakan `QCategoryPicker` untuk memilih kategori secara horizontal. Ini adalah contoh implementasinya:

```
QCategoryPicker(
    label: "Select Category", //optional
    items: const [
    {
        "label": "Main Course",
        "value": "Main Course",
    },
    {
        "label": "Drink",
        "value": "Drink",
    },
    {
        "label": "Snack",
        "value": "Snack",
    },
    {
        "label": "Dessert",
        "value": "Dessert",
    }
    ],
    value: "Main Course",
    validator: Validator.required,
    onChanged: (index, label, value, item) {},
)
```

## Horizontal Scrolling
Jangan gunakan ListView dengan axis horizontal atau SingleChildScrollView manual. Sebagai gantinya, gunakan `QHorizontalScroll` yang sudah dibuat khusus untuk keperluan ini:

**Important**: Tidak perlu mendefinisikan width atau height untuk QHorizontalScroll, karena sudah diatur secara otomatis di dalam widget tersebut.

### ❌ Don't Use (Old Version)
```dart
Container(
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, //required
            children: List.generate(featuredServices.length, (index) {
                final service = featuredServices[index];
                return Container(
                    width: 280,
                    margin: EdgeInsets.only(
                        right: index < featuredServices.length - 1 ? spSm : 0,
                    ),
                    child: // your widget here
                );
            }),
        ),
    ),
)
```

### ✅ Do Use (New Version)
```dart
QHorizontalScroll(
  children: List.generate(featuredServices.length, (index) {
        final service = featuredServices[index];
        return ...
    }),
) 
```

## GridView Layout
- Jangan pernah gunakan GridView, selalu gunakan ResponsiveGridView!
ResponsiveGridView hanya memiliki 3 property: `padding`, `minItemWidth`, dan `children`. Contoh implementasinya:
```
ResponsiveGridView(
    padding: EdgeInsets.all(spSm),
    minItemWidth: 200, // minimum width-nya wajib di atur ke 200 saja
    children: filteredProducts.map((product) {
        return StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: StatisticCard(
            title: "title",
            value: 25,
            color: primaryColor,
            icon: Icons.fastfood,
        ),
        );
    }).toList(),
)
```

### Button Positioning in GridView Items
Untuk mencegah overflow pada GridView item, pastikan QButton selalu berada di posisi paling bawah dari Column dan berdiri sendiri:

#### ❌ Don't (Button in Row with other elements)
```dart
Row(
  children: [
    // Other elements like stats, ratings, etc.
    Spacer(),
    QButton(
      label: "Action Button",
      size: bs.sm,
      onPressed: () {},
    ),
  ],
)
```

#### ✅ Do (Button standalone at bottom)
```dart
// Other content like stats, ratings
Row(
  children: [
    // Stats or other info without button
  ],
),

// Book Button - Always at bottom
Container(
  width: double.infinity,
  child: QButton(
    label: "Action Button",
    size: bs.sm,
    onPressed: () {},
  ),
),
```

**Benefits:**
- Mencegah overflow ketika konten GridView item terlalu panjang
- Button selalu terlihat dan mudah diakses
- Layout lebih konsisten di berbagai ukuran layar
- Button memiliki ruang yang cukup untuk tap gesture

## Layout Rules

### Spacing

- Normal-nya, jika widget di dalam column/row/grid tidak memerlukan margin untuk memberikan jarak, gunakan property spacing di column/row
- spacing Column/Row/Grid menggunakan spSm

### Padding Guidelines

- Padding scaffold selalu spMd
- Padding card menggunakan spSm
- Jika ingin menambahkan padding/margin, gunakan spXs, spSm, spMd, spLg, spXl, sp2xl, sp3xl, sp4xl


### TabBar Guidelines
- Jika menggunakan widget Tab() tidak boleh menggunakan child, gunakan text: dan icon: saja.
- Jangan mengubah labelColor,unselectedLabelColor, indicatorColor dari TabBar, property yang boleh diubah hanya tabs dan controller saja.

## Button Layout in Rows
When creating a Row with buttons and text/icons on the left side, always use `Expanded` widget for the text content instead of `Spacer()`.

### ❌ Don't (Version 1 - Using Spacer)



### Reuseable Widget inside Row
- Jika ingin membuat widget yang reusable di dalam Row, bungkus reuseable widget-nya dengan  `Expanded` untuk mengisi ruang yang tersedia. Contoh implementasinya:
```
Row(
    children: [
        Expanded(
        child: QSwitch(
            items: [
            {
                "label": "Remember me",
                "value": true,
                "checked": rememberMe,
            }
            ],
            value: [
            if (rememberMe)
                {
                "label": "Remember me",
                "value": true,
                "checked": true
                }
            ],
            onChanged: (values, ids) {
            setState(() {
                rememberMe = values.isNotEmpty;
            });
            },
        ),
        ),
        Spacer(),
        GestureDetector(
        onTap: () {},
        child: Text(
            "Forgot Password?",
            style: TextStyle(
            fontSize: 14,
            color: primaryColor,
            fontWeight: FontWeight.w600,
            ),
        ),
        ),
    ],
    )
    ```
- Berlaku juga untuk QTextField,QNumberField,QImagePicker dan yang lainnya jika di letakkan di dalam Row.

## Expanded Widget Usage Rules

### Critical: Expanded Widget Restrictions
- **Never use `Expanded` widget outside of `Row`, `Flex`, or horizontal layouts**
- `Expanded` widget **ONLY** works inside `Row` or `Flex` widgets
- Using `Expanded` in `Column`, `SingleChildScrollView`, or other vertical layouts will cause runtime errors

### ❌ Wrong Usage - Expanded in Column
```dart
Column(
  children: [
    Expanded(  // This will cause error!
      child: Container(...),
    ),
  ],
)
```

### ✅ Correct Usage - Expanded in Row
```dart
Row(
  children: [
    Expanded(  // This is correct
      child: Container(...),
    ),
    Expanded(
      child: Container(...),
    ),
  ],
)
```

### Solution Pattern
When creating reusable card widgets that may be used both in Row and Column:

```dart
// For use inside Row (with Expanded)
Widget _buildCard(String title, String value, {int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Container(...),
  );
}

// For use inside Column (without Expanded)
Widget _buildCardFull(String title, String value) {
  return Container(
    width: double.infinity,
    child: Container(...),
  );
}
```

### Quick Checklist
- ✅ Use `Expanded` inside `Row` widgets
- ✅ Use `Container` with `width: double.infinity` for full-width cards in `Column`
- ❌ Never use `Expanded` directly in `Column` children
- ❌ Never use `Expanded` in `SingleChildScrollView` children

## RenderFlex Error Prevention

### Understanding RenderFlex Errors
RenderFlex errors occur when there's a conflict between parent and child layout constraints. The most common cause is using `Expanded` widgets in inappropriate contexts.

### Common Error Messages to Watch For:
```
RenderFlex children have non-zero flex but incoming height constraints are unbounded.
RenderBox was not laid out: RenderFlex
Cannot hit test a render box that has never been laid out.
```

### Root Causes and Solutions

#### 1. **Expanded in ScrollView Context**
❌ **Problem**: Using `Expanded` in a `Column` that's inside `SingleChildScrollView`
```dart
SingleChildScrollView(
  child: Column(
    children: [
      Expanded(  // This causes RenderFlex error!
        child: Container(...),
      ),
    ],
  ),
)
```

✅ **Solution**: Remove `Expanded` or use `Container` with explicit sizing
```dart
SingleChildScrollView(
  child: Column(
    children: [
      Container(  // Use Container instead
        height: 200, // or width: double.infinity
        child: Container(...),
      ),
    ],
  ),
)
```

#### 2. **Reusable Widgets with Expanded**
❌ **Problem**: Creating reusable widgets that return `Expanded` but used in `Column`
```dart
Widget _buildCard() {
  return Expanded(  // Problem when used in Column
    child: Container(...),
  );
}

Column(
  children: [
    _buildCard(),  // This will cause error!
  ],
)
```

✅ **Solution**: Create separate methods for different contexts
```dart
// For Row usage
Widget _buildCard({int flex = 1}) {
  return Expanded(
    flex: flex,
    child: _buildCardContent(),
  );
}

// For Column usage
Widget _buildCardFull() {
  return Container(
    width: double.infinity,
    child: _buildCardContent(),
  );
}

// Shared content
Widget _buildCardContent() {
  return Container(...);
}
```

#### 3. **Method Naming Convention for Expanded Widgets**
When creating reusable widgets that might be used in both Row and Column:

✅ **Recommended Pattern**:
- `_buildXxx()` → Returns `Expanded` (for Row usage)
- `_buildXxxFull()` → Returns `Container` (for Column usage)
- `_buildXxxContent()` → Returns shared content

#### 4. **Debug Steps for RenderFlex Errors**
1. **Identify the widget**: Look for the creator information in error message
2. **Check parent context**: Is the `Expanded` widget inside a `Row` or `Column`?
3. **Trace the call stack**: Follow where the widget method is called from
4. **Apply appropriate fix**: Use `Expanded` only in `Row`, use `Container` in `Column`

#### 5. **Prevention Checklist**
Before using any widget that returns `Expanded`:
- ✅ Is this widget being used inside a `Row`? → OK to use `Expanded`
- ❌ Is this widget being used inside a `Column`? → Use `Container` instead
- ❌ Is this widget being used in `SingleChildScrollView`? → Use `Container` instead
- ❌ Is this widget being used in unbounded height context? → Use `Container` instead

#### 6. **Safe Patterns for Layout**
```dart
// Safe Pattern 1: Row with Expanded
Row(
  children: [
    Expanded(child: Widget1()),
    Expanded(child: Widget2()),
  ],
)

// Safe Pattern 2: Column with Container
Column(
  children: [
    Container(width: double.infinity, child: Widget1()),
    Container(width: double.infinity, child: Widget2()),
  ],
)

// Safe Pattern 3: Mixed usage with method variants
Row(
  children: [
    _buildCard(flex: 1),     // Uses Expanded internally
    _buildCard(flex: 2),     // Uses Expanded internally
  ],
),
SizedBox(height: spSm),
_buildCardFull(),            // Uses Container internally
```

### Quick Fix Reference
When you encounter RenderFlex errors:

1. **Find the problematic widget** in error stack trace
2. **Locate the method** that returns `Expanded`
3. **Check where it's called** from (`Row` vs `Column`)
4. **Create alternative method** if needed (`_buildXxxFull`)
5. **Update the call** to use appropriate method

### Common Mistake Patterns
❌ Using the same method for both Row and Column contexts
❌ Not checking parent widget type before using Expanded
❌ Ignoring unbounded height constraints in ScrollView
❌ Not creating separate methods for different layout contexts

This pattern prevents layout errors and ensures widgets work correctly in all contexts.

## InputDecorator (TextField) Width Constraint Errors

### Understanding InputDecorator Errors
InputDecorator errors occur when TextField widgets don't have proper width constraints. This happens when TextFields are placed in contexts where the parent widget doesn't provide finite width constraints.

### Common Error Messages to Watch For:
```
An InputDecorator, which is typically created by a TextField, cannot have an unbounded width.
This happens when the parent widget does not provide a finite width constraint.
constraints.maxWidth < double.infinity
```

### Root Causes and Solutions

#### 1. **TextField in Row Without Constraints**
❌ **Problem**: Using TextField directly in a Row without Expanded or SizedBox
```dart
Row(
  children: [
    QTextField(  // This causes InputDecorator error!
      label: "Name",
      value: name,
      onChanged: (value) {
        name = value;
        setState(() {});
      },
    ),
    QButton(label: "Submit"),
  ],
)
```

✅ **Solution**: Wrap TextField with Expanded or provide explicit width
```dart
Row(
  children: [
    Expanded(  // Provides width constraint
      child: QTextField(
        label: "Name",
        value: name,
        onChanged: (value) {
          name = value;
          setState(() {});
        },
      ),
    ),
    SizedBox(width: spSm),
    QButton(label: "Submit"),
  ],
)
```

#### 2. **TextField in Horizontal Scrollable Context**
❌ **Problem**: TextField inside SingleChildScrollView with horizontal scroll
```dart
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      QTextField(  // This causes error!
        label: "Search",
        value: searchQuery,
        onChanged: (value) => setState(() => searchQuery = value),
      ),
    ],
  ),
)
```

✅ **Solution**: Provide explicit width constraint
```dart
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      SizedBox(
        width: 200,  // Explicit width constraint
        child: QTextField(
          label: "Search",
          value: searchQuery,
          onChanged: (value) => setState(() => searchQuery = value),
        ),
      ),
    ],
  ),
)
```

#### 3. **TextField in Complex Layout Scenarios**
❌ **Problem**: Multiple TextFields in Row without proper constraints
```dart
Row(
  children: [
    QTextField(label: "First Name"),  // Error!
    QTextField(label: "Last Name"),   // Error!
  ],
)
```

✅ **Solution**: Use Expanded for each TextField
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

### TextField Width Constraint Rules

#### 1. **Always Wrap TextField in Row with Expanded**
```dart
// ✅ Correct Pattern
Row(
  children: [
    Expanded(
      child: QTextField(
        label: "Field Label",
        value: fieldValue,
        onChanged: (value) => setState(() => fieldValue = value),
      ),
    ),
    // Other widgets...
  ],
)
```

#### 2. **Use SizedBox for Fixed Width TextFields**
```dart
// ✅ For specific width requirements
SizedBox(
  width: 150,
  child: QTextField(
    label: "Code",
    value: code,
    onChanged: (value) => setState(() => code = value),
  ),
)
```

#### 3. **Multiple TextFields in Row**
```dart
// ✅ Multiple TextFields with equal width
Row(
  children: [
    Expanded(
      child: QTextField(label: "Field 1", value: field1, onChanged: (v) => setState(() => field1 = v)),
    ),
    SizedBox(width: spSm),
    Expanded(
      child: QTextField(label: "Field 2", value: field2, onChanged: (v) => setState(() => field2 = v)),
    ),
  ],
)

// ✅ Multiple TextFields with different flex ratios
Row(
  children: [
    Expanded(
      flex: 2,
      child: QTextField(label: "Name", value: name, onChanged: (v) => setState(() => name = v)),
    ),
    SizedBox(width: spSm),
    Expanded(
      flex: 1,
      child: QTextField(label: "Code", value: code, onChanged: (v) => setState(() => code = v)),
    ),
  ],
)
```

### Form Layout Best Practices

#### 1. **Standard Form Layout (Column)**
```dart
// ✅ TextFields in Column don't need Expanded
Column(
  children: [
    QTextField(
      label: "Email",
      value: email,
      onChanged: (value) => setState(() => email = value),
    ),
    SizedBox(height: spSm),
    QTextField(
      label: "Password",
      value: password,
      onChanged: (value) => setState(() => password = value),
    ),
  ],
)
```

#### 2. **Inline Form Fields (Row)**
```dart
// ✅ TextFields in Row must be wrapped with Expanded
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

#### 3. **Search Bar in AppBar or Horizontal Context**
```dart
// ✅ Search field with button
Row(
  children: [
    Expanded(
      child: QTextField(
        label: "Search...",
        value: searchQuery,
        onChanged: (value) => setState(() => searchQuery = value),
      ),
    ),
    SizedBox(width: spSm),
    QButton(
      icon: Icons.search,
      size: bs.sm,
      onPressed: () => _performSearch(),
    ),
  ],
)
```

### Quick Fix Reference for TextField Errors

1. **Identify TextField location**: Look for QTextField, QNumberField, QMemoField in error trace
2. **Check parent widget**: Is it inside a Row or horizontal layout?
3. **Apply constraint**: Wrap with Expanded or SizedBox with explicit width
4. **Test the fix**: Ensure the layout renders correctly

### Common TextField Constraint Patterns

#### ❌ Wrong Patterns (Will Cause Errors)
```dart
Row(children: [QTextField(...)]);  // Missing Expanded
Stack(children: [QTextField(...)]); // No width constraint
SingleChildScrollView(scrollDirection: Axis.horizontal, child: QTextField(...)); // No width
```

#### ✅ Correct Patterns
```dart
Row(children: [Expanded(child: QTextField(...))]);  // With Expanded
Column(children: [QTextField(...)]);  // Column provides width
SizedBox(width: 200, child: QTextField(...));  // Explicit width
```

### Prevention Checklist for TextField Usage

Before adding any TextField widget:
- ✅ Is this TextField in a Column? → No constraint needed
- ❌ Is this TextField in a Row? → Must wrap with Expanded or SizedBox
- ❌ Is this TextField in horizontal ScrollView? → Must provide explicit width
- ❌ Is this TextField in Stack without positioning? → Must provide width constraint
- ✅ Is this TextField standalone in Scaffold body? → No constraint needed

This prevents InputDecorator width constraint errors and ensures proper TextField rendering.