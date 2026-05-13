import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsThemeView extends StatefulWidget {
  const BrsThemeView({super.key});

  @override
  State<BrsThemeView> createState() => _BrsThemeViewState();
}

class _BrsThemeViewState extends State<BrsThemeView> {
  String selectedTheme = "System";
  String selectedAccentColor = "Blue";
  bool darkModeEnabled = false;
  bool useSystemTheme = true;

  final List<Map<String, dynamic>> themeOptions = [
    {
      "name": "Light",
      "description": "Clean and bright interface",
      "icon": Icons.light_mode,
      "preview": Colors.white,
    },
    {
      "name": "Dark",
      "description": "Easy on the eyes in low light",
      "icon": Icons.dark_mode,
      "preview": Colors.grey[900],
    },
    {
      "name": "System",
      "description": "Follows your device settings",
      "icon": Icons.settings_brightness,
      "preview": Colors.grey[600],
    },
  ];

  final List<Map<String, dynamic>> accentColors = [
    {
      "name": "Blue",
      "color": Colors.blue,
      "isDefault": true,
    },
    {
      "name": "Green",
      "color": Colors.green,
      "isDefault": false,
    },
    {
      "name": "Purple",
      "color": Colors.purple,
      "isDefault": false,
    },
    {
      "name": "Orange",
      "color": Colors.orange,
      "isDefault": false,
    },
    {
      "name": "Red",
      "color": Colors.red,
      "isDefault": false,
    },
    {
      "name": "Teal",
      "color": Colors.teal,
      "isDefault": false,
    },
    {
      "name": "Pink",
      "color": Colors.pink,
      "isDefault": false,
    },
    {
      "name": "Indigo",
      "color": Colors.indigo,
      "isDefault": false,
    },
  ];

  void _selectTheme(String theme) {
    selectedTheme = theme;
    useSystemTheme = theme == "System";
    darkModeEnabled = theme == "Dark";
    setState(() {});
    
    ss("Theme changed to $theme");
  }

  void _selectAccentColor(String colorName, Color color) {
    selectedAccentColor = colorName;
    setState(() {});
    
    ss("Accent color changed to $colorName");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Theme Preview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Current Theme",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: themeOptions.firstWhere((t) => t["name"] == selectedTheme)["preview"],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: Icon(
                          themeOptions.firstWhere((t) => t["name"] == selectedTheme)["icon"],
                          color: selectedTheme == "Light" ? Colors.black : Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$selectedTheme Theme",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Accent: $selectedAccentColor",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Theme Selection
            Text(
              "Appearance Mode",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...List.generate(themeOptions.length, (index) {
              final theme = themeOptions[index];
              final isSelected = theme["name"] == selectedTheme;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: isSelected
                      ? Border.all(color: primaryColor, width: 2)
                      : null,
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(spSm),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: theme["preview"],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledBoldColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Icon(
                      theme["icon"] as IconData,
                      color: theme["name"] == "Light" ? Colors.black : Colors.white,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    "${theme["name"]} Theme",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  subtitle: Text(
                    "${theme["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 24,
                        )
                      : Icon(
                          Icons.radio_button_unchecked,
                          color: disabledBoldColor,
                          size: 24,
                        ),
                  onTap: () => _selectTheme(theme["name"]),
                ),
              );
            }),

            SizedBox(height: spLg),

            // Accent Color Selection
            Text(
              "Accent Color",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Choose your preferred accent color for buttons and highlights",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: accentColors.map((colorOption) {
                final isSelected = colorOption["name"] == selectedAccentColor;
                final color = colorOption["color"] as Color;

                return GestureDetector(
                  onTap: () => _selectAccentColor(colorOption["name"], color),
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: isSelected
                          ? Border.all(color: color, width: 2)
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                )
                              : null,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${colorOption["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? color : disabledBoldColor,
                                    ),
                                  ),
                                  if (colorOption["isDefault"] as bool) ...[
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "Default",
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                color.toString().split('(')[1].split(')')[0],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Advanced Theme Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Advanced Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),                  // Auto Dark Mode
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Follow System Theme",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Automatically switch between light and dark based on system settings",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "System Theme",
                              "value": true,
                              "checked": useSystemTheme,
                            }
                          ],
                          value: useSystemTheme ? [{"label": "System Theme", "value": true, "checked": true}] : [],
                          onChanged: (values, ids) {
                            useSystemTheme = values.isNotEmpty;
                            if (useSystemTheme) {
                              selectedTheme = "System";
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),                  // High Contrast
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "High Contrast Mode",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Increase contrast for better accessibility",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "High Contrast",
                              "value": true,
                              "checked": false,
                            }
                          ],
                          value: [],
                          onChanged: (values, ids) {
                            // Handle high contrast toggle
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Theme Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: infoColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Theme Information",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Theme changes apply immediately\n• System theme follows your device's dark/light mode setting\n• Accent colors affect buttons, links, and highlights\n• High contrast mode improves accessibility for visually impaired users\n• Your theme preferences are saved and synced across devices",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Reset to Default
            QButton(
              label: "Reset to Default Theme",
              onPressed: () async {
                bool confirmed = await confirm("Reset theme settings to default?");
                if (!confirmed) return;

                selectedTheme = "System";
                selectedAccentColor = "Blue";
                useSystemTheme = true;
                setState(() {});

                ss("Theme settings reset to default");
              },
            ),
          ],
        ),
      ),
    );
  }
}
