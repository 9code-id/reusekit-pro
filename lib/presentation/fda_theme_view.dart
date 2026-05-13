import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaThemeView extends StatefulWidget {
  const FdaThemeView({super.key});

  @override
  State<FdaThemeView> createState() => _FdaThemeViewState();
}

class _FdaThemeViewState extends State<FdaThemeView> {
  String selectedTheme = "System";
  String selectedAccentColor = "Orange";
  double fontSize = 16.0;
  bool highContrast = false;
  bool reducedMotion = false;

  List<Map<String, dynamic>> themeOptions = [
    {
      "name": "Light",
      "description": "Light theme for day time use",
      "icon": Icons.light_mode,
      "preview_bg": Colors.white,
      "preview_text": Colors.black,
    },
    {
      "name": "Dark",
      "description": "Dark theme for night time use",
      "icon": Icons.dark_mode,
      "preview_bg": Colors.grey[900],
      "preview_text": Colors.white,
    },
    {
      "name": "System",
      "description": "Follow system theme settings",
      "icon": Icons.brightness_auto,
      "preview_bg": Colors.grey[300],
      "preview_text": Colors.black87,
    },
  ];

  List<Map<String, dynamic>> accentColors = [
    {
      "name": "Orange",
      "color": Colors.orange,
      "description": "Default orange theme",
    },
    {
      "name": "Blue",
      "color": Colors.blue,
      "description": "Cool blue accent",
    },
    {
      "name": "Green",
      "color": Colors.green,
      "description": "Natural green theme",
    },
    {
      "name": "Purple",
      "color": Colors.purple,
      "description": "Royal purple accent",
    },
    {
      "name": "Red",
      "color": Colors.red,
      "description": "Bold red theme",
    },
    {
      "name": "Teal",
      "color": Colors.teal,
      "description": "Modern teal accent",
    },
  ];

  @override
  Widget build(BuildContext context) {
    Color currentAccentColor = accentColors
        .firstWhere((color) => color["name"] == selectedAccentColor)["color"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Theme & Display"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Theme Preview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Theme Preview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: themeOptions
                          .firstWhere((theme) => theme["name"] == selectedTheme)["preview_bg"],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: Colors.grey.withAlpha(60)),
                    ),
                    child: Stack(
                      children: [
                        // Mock App Bar
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: currentAccentColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: spMd),
                              Icon(
                                Icons.restaurant,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Food Delivery",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Mock Content
                        Positioned(
                          top: 60,
                          left: spMd,
                          right: spMd,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 8,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: themeOptions
                                      .firstWhere((theme) => theme["name"] == selectedTheme)["preview_text"],
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: currentAccentColor.withAlpha(100),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Column(
                                    children: [
                                      Container(
                                        height: 6,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: themeOptions
                                              .firstWhere((theme) => theme["name"] == selectedTheme)["preview_text"],
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Container(
                                        height: 6,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Theme Selection
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Theme Selection",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...themeOptions.map((theme) {
                    bool isSelected = selectedTheme == theme["name"];
                    return GestureDetector(
                      onTap: () {
                        selectedTheme = theme["name"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(30) : Colors.grey.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(60),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.grey.withAlpha(60),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                theme["icon"],
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${theme["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? primaryColor : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${theme["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Accent Color
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Accent Color",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Choose your preferred accent color for buttons and highlights",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: accentColors.map((colorOption) {
                      bool isSelected = selectedAccentColor == colorOption["name"];
                      return GestureDetector(
                        onTap: () {
                          selectedAccentColor = colorOption["name"];
                          setState(() {});
                        },
                        child: Container(
                          width: 80,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? colorOption["color"].withAlpha(30) : Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? colorOption["color"] : Colors.grey.withAlpha(60),
                              width: isSelected ? 3 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: colorOption["color"],
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : null,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${colorOption["name"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? colorOption["color"] : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Font Size
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Font Size",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Adjust text size for better readability",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  // Font size preview
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Sample text - Pizza Margherita \$12.99",
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Font size slider
                  Row(
                    children: [
                      Text(
                        "Small",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: fontSize,
                          min: 12.0,
                          max: 24.0,
                          divisions: 6,
                          activeColor: currentAccentColor,
                          onChanged: (value) {
                            fontSize = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Text(
                        "Large",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Font size: ${fontSize.round()}px",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Accessibility Options
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Accessibility",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // High contrast
                  Row(
                    children: [
                      Icon(
                        Icons.contrast,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "High contrast",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Increase contrast for better visibility",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: highContrast,
                        onChanged: (value) {
                          highContrast = value;
                          setState(() {});
                        },
                        activeColor: currentAccentColor,
                      ),
                    ],
                  ),

                  // Reduced motion
                  Row(
                    children: [
                      Icon(
                        Icons.accessibility,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reduced motion",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Minimize animations and transitions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: reducedMotion,
                        onChanged: (value) {
                          reducedMotion = value;
                          setState(() {});
                        },
                        activeColor: currentAccentColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Reset to Default
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.restore,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Reset Theme",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Reset all theme settings to default values",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  QButton(
                    label: "Reset to Default",
                    icon: Icons.restore,
                    size: bs.sm,
                    onPressed: () {
                      selectedTheme = "System";
                      selectedAccentColor = "Orange";
                      fontSize = 16.0;
                      highContrast = false;
                      reducedMotion = false;
                      setState(() {});
                      si("Theme settings reset to default");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: QButton(
          label: "Apply Theme",
          onPressed: () {
            ss("Theme settings applied successfully");
            back();
          },
        ),
      ),
    );
  }
}
