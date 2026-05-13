# Scaffold Guidelines

## Scaffold Widget Rules

### Standard Scaffold
Use the standard Scaffold widget for simple pages without bottom navigation or tab functionality:

```dart
Scaffold(
    appBar: AppBar(
        title: Text("Page Title"),
    ),
    body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
            children: [
                // Page content
            ],
        ),
    ),
)
```

### Bottom Navigation Bar Scaffold
Use `QBottomBar` for pages that require bottom navigation:

```dart
QBottomBar(
    title: "App Title",
    selectedIndex: currentIndex,
    items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
        ),
    ],
    children: [
        HomeTabView(),
        SearchTabView(),
        ProfileTabView(),
    ],
    onTap: (index) {
        currentIndex = index;
        setState(() {});
    },
)
```

### TabBar Scaffold
Use `QTabBar` for pages that require tab functionality:

```dart
QTabBar(
    title: "Dashboard",
    selectedIndex: currentTab,
    without
    tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Reports", icon: Icon(Icons.report)),
    ],
    tabChildren: [
        OverviewTabView(),
        AnalyticsTabView(),
        ReportsTabView(),
    ],
    onInit: (tabController) {
        // Optional: Access to TabController
    },
)
```

-- Jika menggunakan QTabBar tapi merupakan bagian dari sebuah halaman, gunakan property: withoutAppBar: true pada QTabBar untuk menghindari AppBar ganda.

## Key Properties

### QBottomBar
- **title**: Optional app bar title
- **actions**: Optional app bar actions
- **items**: List of BottomNavigationBarItem (required)
- **children**: List of Widget pages for each tab (required)
- **selectedIndex**: Initial selected tab index (default: 0)
- **onTap**: Callback when tab is tapped

### QTabBar
- **title**: Optional app bar title
- **actions**: Optional app bar actions
- **tabs**: List of Tab widgets
- **tabChildren**: List of Widget pages for each tab
- **selectedIndex**: Initial selected tab index (default: 0)
- **onInit**: Callback providing access to TabController

## Usage Rules

1. **Never use drawer** in any Scaffold implementation
2. **Never use DefaultTabController, TabBarView, or TabBar** directly in Scaffold body
3. **Always use QBottomBar** for bottom navigation functionality
4. **Always use QTabBar** for tab functionality
5. **Use standard Scaffold** only when no navigation bars or tabs are needed
6. **Never modify AppBar styling** (backgroundColor, foregroundColor, elevation, centerTitle)
7. **Never change Scaffold backgroundColor** - use default

## Content Padding

Always provide padding for Scaffold body content:

```dart
// For SingleChildScrollView
body: SingleChildScrollView(
    padding: EdgeInsets.all(spMd),
    child: // content
),

// For Container
body: Container(
    padding: EdgeInsets.all(spMd),
    child: // content
),
```

## State Management

When using navigation scaffolds, manage selected index in parent widget:

```dart
int currentIndex = 0;
int currentTab = 0;

// Update index when navigation occurs
onTap: (index) {
    currentIndex = index;
    setState(() {});
},
```