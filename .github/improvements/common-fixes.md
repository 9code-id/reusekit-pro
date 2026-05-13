# Common Code Issues and Fixes
- [UiKit] Never navigate from one page to other pages, just use comment
```
//navigateTo ( '' )
```
- Available radius: radiusXxs, radiusXs, radiusSm, radiusMd, radiusLg, radiusXl, radius2xl, radius3xl, radius4xl
```
always change radiusFull > radiusLg
```
- Jika parent dari QDropdownField adalah Row, maka QDropdownField wajib dibungkus Expanded
- Never fix or modify code at [Core Dart](../../lib/core.dart)
- Never fix or modify code at [Views Dart](../../lib/presentation.dart)
- Hati2 menggunakan .currency, pastikan sudah di casting dulu ke double
```
"\$${salesData[0]["revenue"].currency}", //Wrong
"\$${(salesData[0]["revenue"] as double).currency}", //Correct
```
- Jika hanya membuat UI Kit, jangan terapkan argument di class-nya.
- Jika hanya membuat UI Kit, jangan menambahkan halaman lain di dalam 1 file
- Jangan membuat/memodifikasi halaman selain yang saya minta

- Always casting to list before accessing index of Map item
```
// Wrong 
"${product["images"][index]}",
// Correct ways, always casting to List before accessing index of Map item
"${(product["images"] as List)[index]}",
```

## Forbidden Widgets and Their Alternatives

### ❌ NEVER Use These Widgets
The following widgets are completely forbidden and must be replaced with approved alternatives:

#### TabBar Restrictions
- ❌ **NEVER use `TabBar`** - Use `QTabBar` instead
- ❌ **NEVER use `TabBarView`** - Use `QTabBar` with `tabChildren` property
- ❌ **NEVER use `DefaultTabController`** - Use `QTabBar` which handles controller internally
- ❌ **NEVER use `SingleTickerProviderStateMixin`** - Not needed with `QTabBar`

#### ListTile Restrictions  
- ❌ **NEVER use `ListTile`** - Create custom layouts with Container, Row, Column
- ❌ **NEVER use any ListTile properties** like leading, trailing, title, subtitle

#### PageView Restrictions
- ❌ **NEVER use `PageView`** - Use alternative scroll solutions or static layouts
- ❌ **NEVER use `PageController`** - Not supported in our framework

#### CustomScrollView Restrictions
- ❌ **NEVER use `CustomScrollView`** - Use `SingleChildScrollView` instead
- ❌ **NEVER use any Sliver widgets** - Use regular widgets in `SingleChildScrollView`

### ✅ Correct Alternatives

#### Tab Functionality
```dart
// ❌ Wrong - Never use these
class MyPage extends StatefulWidget with SingleTickerProviderStateMixin {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Tab 1"),
            Tab(text: "Tab 2"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Widget1(),
          Widget2(),
        ],
      ),
    );
  }
}

// ✅ Correct - Use QTabBar
class MyPageView extends StatefulWidget {
  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Page Title",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Tab 1", icon: Icon(Icons.home)),
        Tab(text: "Tab 2", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        Tab1ContentView(),
        Tab2ContentView(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
```

#### List Item Layout
```dart
// ❌ Wrong - Never use ListTile
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    final item = items[index];
    return ListTile(
      leading: Icon(Icons.person),
      title: Text("${item["name"]}"),
      subtitle: Text("${item["description"]}"),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {},
    );
  },
)

// ✅ Correct - Use custom Container layout
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    final item = items[index];
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              // Handle tap
            },
            child: Icon(
              Icons.arrow_forward,
              color: disabledBoldColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  },
)
```

#### ScrollView Layout
```dart
// ❌ Wrong - Never use CustomScrollView
CustomScrollView(
  slivers: [
    SliverAppBar(title: Text("Title")),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(),
      ),
    ),
  ],
)

// ✅ Correct - Use SingleChildScrollView
Scaffold(
  appBar: AppBar(title: Text("Title")),
  body: SingleChildScrollView(
    padding: EdgeInsets.all(spMd),
    child: Column(
      children: [
        // Your content here
        ...List.generate(items.length, (index) {
          return Container(
            // Item content
          );
        }),
      ],
    ),
  ),
)
```

### Quick Fix Reference

When you encounter these violations:

1. **TabBar violations**: Replace with `QTabBar`
2. **ListTile violations**: Create custom `Container` layouts with `Row`/`Column`
3. **PageView violations**: Use `QHorizontalScroll`
3. **ListView Horizontal violations**: Use `QHorizontalScroll`
4. **CustomScrollView violations**: Use `SingleChildScrollView`
5. **SingleTickerProviderStateMixin violations**: Remove mixin, use `QTabBar`

### Common Error Messages to Watch For:
- "TabBar is not supported"
- "ListTile is forbidden" 
- "PageView is not allowed"
- "CustomScrollView is forbidden"
- "SingleTickerProviderStateMixin not needed"

Always replace with the approved alternatives shown above.

## TextField Icon Restrictions

### ❌ NEVER Use suffixIcon or prefixIcon
- Jangan pernah menggunakan `suffixIcon` atau `prefixIcon` pada QTextField atau TextField manapun
- Reusable widget QTextField tidak mendukung icon properties
- Semua implementasi icon harus menggunakan alternatif layout

### ❌ Wrong Implementation
```dart
// WRONG - Never use suffixIcon or prefixIcon
QTextField(
    label: "Password",
    value: password,
    suffixIcon: IconButton(  // ❌ FORBIDDEN
        icon: Icon(Icons.visibility),
        onPressed: () {},
    ),
),

QTextField(
    label: "Email",
    value: email,
    prefixIcon: Icon(Icons.email),  // ❌ FORBIDDEN
),

// WRONG - Any icon property on QTextField
QTextField(
    label: "Search",
    value: searchQuery,
    icon: Icons.search,  // ❌ FORBIDDEN - QTextField doesn't have icon property
),
```

### ✅ Correct Alternatives

#### Option 1: Use Row Layout for Icon + TextField
```dart
Row(
    children: [
        Icon(
            Icons.email,
            color: primaryColor,
            size: 20,
        ),
        SizedBox(width: spSm),
        Expanded(
            child: QTextField(
                label: "Email",
                value: email,
                onChanged: (value) {
                    email = value;
                    setState(() {});
                },
            ),
        ),
    ],
),
```

#### Option 2: Use Column Layout for Toggle Functions
```dart
// For password visibility toggle
Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        QTextField(
            label: "Password",
            value: password,
            obscureText: obscurePassword,
            onChanged: (value) {
                password = value;
                setState(() {});
            },
        ),
        SizedBox(height: spXs),
        Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: () {
                    obscurePassword = !obscurePassword;
                    setState(() {});
                },
                child: Text(
                    obscurePassword ? "Show" : "Hide",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                    ),
                ),
            ),
        ),
    ],
),
```

#### Option 3: Use Container Wrapper with Positioned Icons
```dart
Stack(
    children: [
        QTextField(
            label: "Search",
            value: searchQuery,
            onChanged: (value) {
                searchQuery = value;
                setState(() {});
            },
        ),
        Positioned(
            right: spSm,
            top: 12,
            child: Icon(
                Icons.search,
                color: disabledBoldColor,
                size: 20,
            ),
        ),
    ],
),
```

#### Option 4: Use Separate Action Button
```dart
Row(
    children: [
        Expanded(
            child: QTextField(
                label: "Search",
                value: searchQuery,
                onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                },
            ),
        ),
        SizedBox(width: spSm),
        QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {
                // Perform search
            },
        ),
    ],
),
```

### 🚫 Forbidden Properties on QTextField
- `suffixIcon` - Use Row/Column layout instead
- `prefixIcon` - Use Row/Column layout instead
- `icon` - QTextField doesn't have this property
- `suffix` - Use Row layout instead
- `prefix` - Use Row layout instead
- `leading` - Use Row layout instead
- `trailing` - Use Row layout instead

### ✅ Allowed QTextField Properties Only
```dart
QTextField(
    label: "Field Label",           // ✅ Required
    value: fieldValue,              // ✅ Required
    hint: "Hint text",              // ✅ Optional
    validator: Validator.required,  // ✅ Optional
    obscureText: true,              // ✅ Optional (for passwords)
    onChanged: (value) {            // ✅ Required
        fieldValue = value;
        setState(() {});
    },
),
```

### 📝 Quick Fix Checklist
When you see icon-related errors in TextField:

1. ❌ Remove any `suffixIcon` or `prefixIcon` properties
2. ✅ Use Row layout with Icon + Expanded(QTextField)
3. ✅ Use separate QButton for actions
4. ✅ Use Column layout with toggle text for password visibility
5. ✅ Never add icon properties that don't exist in QTextField

### Common Error Messages to Watch For:
- "The named parameter 'suffixIcon' isn't defined"
- "The named parameter 'prefixIcon' isn't defined"  
- "The named parameter 'icon' isn't defined"
- "Too many positional arguments"

When you see these errors, always replace with the approved layout alternatives above.

## Button Implementation
- Always use QButton for buttons, and avoid using outlined!
- Don't make a button from Container, please always use QButton
- Available button sizes: bs.sm, bs.md
- Dont use bs.xs, bs.lg, bs.xl, only use bs.sm, bs.md

## Interpolation and String Usage
- When casting data from a map, always use parentheses to ensure correct type conversion.
- Pastikan setelah casting pasti ada symbol ), (item["data"] as int)
```
//Wrong
episodeData["plays"] as int / 1000
//Correct
(episodeData["plays"] as int) / 1000
```

## Parentheses Error Prevention - "Expected to find ')'"
- Most common cause is improper parentheses around type casting in arithmetic operations
- Always wrap individual casting operations in parentheses
- For complex expressions, wrap the entire operation in additional parentheses

### ❌ Common Parentheses Errors
```dart
// Wrong - Missing parentheses around casting in arithmetic
"${(item["price"] as double / 100).toStringAsFixed(2)}"
"${(list.reduce((a, b) => a + b) as int / 1000).toInt()}K"

// Wrong - Complex nested operations without proper grouping
left: (item["longitude"] as double + offset) * scale
```

### ✅ Correct Parentheses Usage
```dart
// Correct - Wrap casting in parentheses before arithmetic
"${((item["price"] as double) / 100).toStringAsFixed(2)}"
"${((list.reduce((a, b) => a + b) as int) / 1000).toInt()}K"

// Correct - Proper grouping of operations
left: ((item["longitude"] as double) + offset) * scale
```

## Arithmetic Operations with Casting
- Always wrap map value casting in parentheses when performing arithmetic operations
- This prevents "Expected to find ')'" errors

### ❌ Wrong Casting in Arithmetic
```dart
// Wrong - Missing parentheses around casting
left: (barber["longitude"] as double + 122.4194) * 1000,
top: (37.7749 - barber["latitude"] as double) * 2000 + 200,

// Wrong - Operations without proper casting parentheses
price = item["price"] as double * quantity,
total = baseAmount as int + tax as int,

// Wrong - Complex calculations without proper parentheses
"${(course["students"] as int / 1000).toStringAsFixed(1)}K"
"${(courses.map((c) => c["students"] as int).reduce((a, b) => a + b) / 1000).toInt()}K"
```

### ✅ Correct Casting in Arithmetic
```dart
// Correct - Proper parentheses around casting
left: ((barber["longitude"] as double) + 122.4194) * 1000,
top: (37.7749 - (barber["latitude"] as double)) * 2000 + 200,

// Correct - Each cast wrapped in parentheses
price = (item["price"] as double) * quantity,
total = (baseAmount as int) + (tax as int),

// Correct - Complex calculations with proper parentheses
"${((course["students"] as int) / 1000).toStringAsFixed(1)}K"
"${((courses.map((c) => c["students"] as int).reduce((a, b) => a + b)) / 1000).toInt()}K"
```

## List Reduce Operations with Casting
- Always cast elements inside reduce operations for type safety
- Use proper parentheses around each casting operation
- When performing arithmetic on reduce results, wrap the entire reduce operation in parentheses

### ❌ Wrong Reduce Operations
```dart
// Wrong - Missing casting inside reduce operations
final maxPrice = priceHistory.reduce((a, b) => a > b ? a : b) as double;
final minPrice = priceHistory.reduce((a, b) => a < b ? a : b) as double;

// Wrong - Type comparison without casting
final maxValue = items.reduce((a, b) => a["value"] > b["value"] ? a : b);

// Wrong - Arithmetic operations without proper parentheses around reduce
"${(courses.map((c) => c["students"] as int).reduce((a, b) => a + b) / 1000).toInt()}K"
```

### ✅ Correct Reduce Operations
```dart
// Correct - Cast each element inside reduce operations
final maxPrice = (priceHistory
    .reduce((a, b) => (a as double) > (b as double) ? a : b) as double);
final minPrice = (priceHistory
    .reduce((a, b) => (a as double) < (b as double) ? a : b) as double);

// Correct - Cast map values for comparison
final maxValue = items.reduce((a, b) => 
    (a["value"] as double) > (b["value"] as double) ? a : b);

// Correct - Wrap entire reduce operation in parentheses before arithmetic
"${((courses.map((c) => c["students"] as int).reduce((a, b) => a + b)) / 1000).toInt()}K"
```


### ❌ Don't
```dart
QButton(
    label: 'View Details',
    variant: QButtonVariant.outlined,
    size: QButtonSize.small, //QButtonSize or ButtonSize is wrong, use bs.sm, bs.md, bs.lg, bs.xl
    onPressed: () => _viewRentalDetails(rental),
),

QButton( //Correct way to use QButton with icon, no need to use QButton.icon()
    icon: Icons.more_vert,
    color: primaryColor,
    size: bs.sm,
    onPressed: () {},
),
```
Remember, QButton hanya memiliki propertyicon, color, size dan onPressed, tidak ada property lain selain itu!

### ✅ Do
bs.xs is button extra small
bs.sm is button small
bs.md is button medium
bs.lg is button large
bs.xl is button extra large

```dart
QButton(
    label: 'View Details',
    // variant: QButtonVariant.solid, //Never use outlined button styles
    size: bs.sm, // bs.sm, bs.md, bs.lg, bs.xl  || dont define something like spSm here,you must use bs.sm
    icon: Icons.add, //if u need an icon, there's no suffix or prefix property, just use icon property
    onPressed: () {},
),
```

## Date/Time Picker Implementation


### TextField
Jangan pernah memberikan icon pada QTextField, baik itu suffix maupun prefix.
```
QTextField(
    label: "Current Medications",
    value: currentMedications,
    // maxLines: 2, //maxLines is not needed, if you want to use more than one line just use QMemoField 
    hint: "List all medications you are currently taking", //not helper: but hint
    onChanged: (value) {
        currentMedications = value;
        setState(() {});
    },
),
```

### NumberField
Correct way to use QNumberField:
```
QNumberField(
    label: "Price (\$)",
    value: price.toString(),
    validator: Validator.required,
    onChanged: (value) {
        price = double.tryParse("$value") ?? 0.0;
        setState(() {});
    },
)
```
### DatePicker
```dart
QDatePicker(
    label: 'Appointment Date',
    value: DateTime.parse(selectedDate), //If the value is a string, parse it to DateTime first
    onChanged: (value) { //value is DateTime
        selectedDate = value;
        setState(() {});
    },
),
```

### TimePicker
```dart
QTimePicker(
    label: 'Appointment Time',
    value: TimeOfDay.fromDateTime(DateTime.parse(selectedTime)), //If the value is a string, parse it to DateTime first and then convert to TimeOfDay
    onChanged: (value) { //value is TimeOfDay
        selectedTime = value!.kkmm;
        setState(() {});
    },
),
```

### Text text value
```
Text(
    "${image["title"]}", //interpolated string is required
    style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
    ),
),
```

### Image Source
```
Image.network(
    "${image["url"]}", //interpolated string is required
    ...
),
```

## Flutter Version Updates

### Color Opacity (Flutter 3.24+)
Always change:
```dart
// Old way
.withValues(n)

// New way
.withValues(alpha: n)
```

### Material Button Colors
Always change:
```dart
// Old way
primary: 

// New way
backgroundColor:
```


### Positioned wrong usage
Don't
```
Positioned(
center: Positioned.center,
```
Do
```
Aligned(
  alignment: Alignment.center,
  child: // your widget here
),
```

### Confirm Dialog
- Variable name must be `isConfirmed`
```
bool isConfirmed = await confirm("Apakah Anda yakin ingin menghapus data ini?");
```

### Import Path
- Kalau perlu segala sesuatu terkait math, gunakan dart:math dengan alias di import-nya
- Misalnya butuh pow, mestinya diterapkan dengan Math.pow
- Misalnya butuh cos, mestinya diterapkan dengan Math.cos
- Misalnya butuh sin, mestinya diterapkan dengan Math.sun
- Begitu juga method2 lain yang ada di dart:math, harus menggunakan alias Math.
```
import 'dart:math' as Math;
```


### textAlign at Text widget
```
Text(
    "Weather conditions are favorable for farming activities",
    textAlign: TextAlign.center, //text align is here, before style
    style: TextStyle(
        color: disabledBoldColor,
    ),
),
```

### 
TextStyle tidak memiliki property textAlign, jadi jangan gunakan textAlign di dalam TextStyle, tapi gunakan itu di Text, contoh:
```
Text(
    "Weather conditions are favorable for farming activities",
    textAlign: TextAlign.center, //text align is here, before style
    style: TextStyle(
        color: disabledBoldColor,
    ),
),
```

## QDropdownField/QSwitch Conditional Callback
When you need conditional logic in QDropdownField onChanged, never use null conditional operator. Instead, use if statement inside the callback:

```dart
// ❌ Wrong - Never use conditional null operator
QDropdownField(
    label: "Default Reminder Time",
    items: timeOptions,
    value: appointmentReminderTime,
    onChanged: appointmentReminders
        ? (value, label) {
            appointmentReminderTime = value;
            setState(() {});
          }
        : null,
),

// ✅ Correct - Use if statement inside callback
QDropdownField(
    label: "Default Reminder Time",
    items: timeOptions,
    value: appointmentReminderTime,
    onChanged: (value, label) {
      if (appointmentReminders) {
        appointmentReminderTime = value; //always use value, not label
        setState(() {});
      }
    },
),
```