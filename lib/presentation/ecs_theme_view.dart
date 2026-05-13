import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsThemeView extends StatefulWidget {
  const EcsThemeView({super.key});

  @override
  State<EcsThemeView> createState() => _EcsThemeViewState();
}

class _EcsThemeViewState extends State<EcsThemeView> {
  String selectedTheme = "light";
  bool loading = false;
  bool autoTheme = false;

  List<Map<String, dynamic>> themes = [
    {
      "id": "light",
      "name": "Light Mode",
      "description": "Clean and bright interface",
      "icon": Icons.light_mode,
      "preview_bg": 0xFFFFFFFF,
      "preview_card": 0xFFF5F5F5,
      "preview_text": 0xFF333333,
      "preview_accent": 0xFF2196F3,
    },
    {
      "id": "dark",
      "name": "Dark Mode",
      "description": "Easy on the eyes in low light",
      "icon": Icons.dark_mode,
      "preview_bg": 0xFF121212,
      "preview_card": 0xFF1E1E1E,
      "preview_text": 0xFFFFFFFF,
      "preview_accent": 0xFF64B5F6,
    },
    {
      "id": "system",
      "name": "System Default",
      "description": "Follow device settings",
      "icon": Icons.phone_android,
      "preview_bg": 0xFF424242,
      "preview_card": 0xFF616161,
      "preview_text": 0xFFFFFFFF,
      "preview_accent": 0xFFFFB74D,
    },
  ];

  List<Map<String, dynamic>> accentColors = [
    {"name": "Blue", "color": 0xFF2196F3, "id": "blue"},
    {"name": "Green", "color": 0xFF4CAF50, "id": "green"},
    {"name": "Purple", "color": 0xFF9C27B0, "id": "purple"},
    {"name": "Orange", "color": 0xFFFF9800, "id": "orange"},
    {"name": "Red", "color": 0xFFF44336, "id": "red"},
    {"name": "Teal", "color": 0xFF009688, "id": "teal"},
  ];

  String selectedAccentColor = "blue";

  void _changeTheme(String themeId) async {
    if (selectedTheme == themeId) return;

    loading = true;
    selectedTheme = themeId;
    setState(() {});

    // Simulate theme change process
    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});

    var theme = themes.firstWhere((t) => t["id"] == themeId);
    ss("Theme changed to ${theme["name"]}");
  }

  void _changeAccentColor(String colorId) {
    selectedAccentColor = colorId;
    setState(() {});
    
    var color = accentColors.firstWhere((c) => c["id"] == colorId);
    ss("Accent color changed to ${color["name"]}");
  }

  Widget _buildThemePreview(Map<String, dynamic> theme) {
    bool isSelected = selectedTheme == theme["id"];

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
          width: isSelected ? 3 : 1,
        ),
        boxShadow: [shadowMd],
      ),
      child: GestureDetector(
        onTap: () => _changeTheme(theme["id"] as String),
        child: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              // Theme Preview
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(theme["preview_bg"] as int),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Stack(
                  children: [
                    // Mock App Bar
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(theme["preview_accent"] as int),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusSm),
                            topRight: Radius.circular(radiusSm),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: spXs),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(200),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(200),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            SizedBox(width: spXs),
                          ],
                        ),
                      ),
                    ),

                    // Mock Content Cards
                    Positioned(
                      top: 40,
                      left: spXs,
                      right: spXs,
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                            margin: EdgeInsets.only(bottom: spXs),
                            decoration: BoxDecoration(
                              color: Color(theme["preview_card"] as int),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Container(
                            height: 15,
                            margin: EdgeInsets.only(bottom: spXs),
                            decoration: BoxDecoration(
                              color: Color(theme["preview_card"] as int),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Color(theme["preview_card"] as int),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                width: 30,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Color(theme["preview_accent"] as int),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Selection Indicator
                    if (isSelected)
                      Positioned(
                        top: spXs,
                        right: spXs,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: spSm),

              // Theme Info
              Row(
                children: [
                  Icon(
                    theme["icon"] as IconData,
                    color: isSelected ? primaryColor : disabledBoldColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${theme["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : primaryColor,
                          ),
                        ),
                        Text(
                          "${theme["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccentColorItem(Map<String, dynamic> colorData) {
    bool isSelected = selectedAccentColor == colorData["id"];

    return GestureDetector(
      onTap: () => _changeAccentColor(colorData["id"] as String),
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(colorData["color"] as int),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  width: isSelected ? 3 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    )
                  : null,
            ),
            SizedBox(height: spXs),
            Text(
              "${colorData["name"]}",
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? primaryColor : disabledBoldColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Theme"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Applying theme...",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Theme Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.palette,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Current theme: ${themes.firstWhere((t) => t["id"] == selectedTheme)["name"]}",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Theme Selection Header
            Text(
              "Choose Your Theme",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            Text(
              "Select how you want the app to look and feel",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),

            SizedBox(height: spMd),

            // Themes
            Column(
              children: themes.map((theme) => _buildThemePreview(theme)).toList(),
            ),

            // Auto Theme Toggle
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_mode,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Auto Theme",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Automatically switch between light and dark",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: autoTheme,
                    onChanged: (value) {
                      autoTheme = value;
                      setState(() {});
                      if (value) {
                        ss("Auto theme enabled");
                      } else {
                        si("Auto theme disabled");
                      }
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Accent Colors
            Text(
              "Accent Color",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            Text(
              "Choose your preferred accent color",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),

            SizedBox(height: spMd),

            QHorizontalScroll(
              children: accentColors.map((color) => _buildAccentColorItem(color)).toList(),
            ),

            SizedBox(height: spMd),

            // Theme Benefits
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Theme Benefits",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Light Mode: Better for daytime use and bright environments\n• Dark Mode: Reduces eye strain in low light and saves battery\n• System Default: Automatically adapts to your device settings\n• Auto Theme: Switches based on time of day",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Performance Note
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.speed,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Theme changes take effect immediately. App may briefly reload for optimal performance.",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
