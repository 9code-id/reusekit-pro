# TabBar Guidelines

## TabBar Implementation Rules

### Basic TabBar Structure
- TabBar should be used directly without wrapping in Container
- Do not modify default styling properties like `backgroundColor`, `indicatorColor`, `labelColor`, or `unselectedLabelColor`
- Only use `controller`, `tabs`, and `onTap` properties
- initialIndex is required in the TabController to set the default selected tab

### Tab Widget Rules
- Use `text:` and `icon:` properties instead of `child:`
- Both text and icon are optional but at least one should be provided

## Examples

### ❌ Wrong Implementation
```dart
Container(
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
    ),
    child: TabBar(
        controller: TabController(length: 4, vsync: this),
        labelColor: Colors.blue, // Don't modify these properties
        unselectedLabelColor: Colors.grey, // Don't modify these properties
        indicatorColor: Colors.red, // Don't modify these properties
        tabs: [
            Tab(child: Text("Overview")), // Don't use child property
            Tab(child: Icon(Icons.science)), // Don't use child property
        ],
        onTap: (index) {
            currentTab = index;
            setState(() {});
        },
    ),
),
```

### ✅ Correct Implementation
```dart
TabBar(
    controller: TabController(length: 4, vsync: this, initialIndex: currentTab),
    tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Lab Results", icon: Icon(Icons.science)),
        Tab(text: "AI Analysis", icon: Icon(Icons.psychology)),
        Tab(text: "Management", icon: Icon(Icons.healing)),
    ],
    onTap: (index) {
        currentTab = index;
        setState(() {});
    },
),
```

### Text-Only Tabs
```dart
TabBar(
    controller: _tabController,
    tabs: [
        Tab(text: "Active"),
        Tab(text: "Completed"),
        Tab(text: "Cancelled"),
    ],
    onTap: (index) {
        selectedTabIndex = index;
        setState(() {});
    },
),
```

### Icon-Only Tabs
```dart
TabBar(
    controller: _tabController,
    tabs: [
        Tab(icon: Icon(Icons.home)),
        Tab(icon: Icon(Icons.search)),
        Tab(icon: Icon(Icons.person)),
    ],
    onTap: (index) {
        activeTab = index;
        setState(() {});
    },
),
```

## Key Rules Summary

1. **No Container wrapping** - Use TabBar directly
2. **No custom styling** - Keep default colors and appearance
3. **Use text: and icon:** properties only in Tab widgets
4. **Avoid child:** property in Tab widgets
5. **Allowed properties**: `controller`, `tabs`, `onTap` only