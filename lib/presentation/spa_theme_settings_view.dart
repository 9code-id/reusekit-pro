import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaThemeSettingsView extends StatefulWidget {
  const SpaThemeSettingsView({super.key});

  @override
  State<SpaThemeSettingsView> createState() => _SpaThemeSettingsViewState();
}

class _SpaThemeSettingsViewState extends State<SpaThemeSettingsView> {
  String selectedTheme = "light";
  String selectedAccentColor = "primary";
  String selectedBackgroundStyle = "default";
  double cornerRadius = 12.0;
  double shadowIntensity = 0.5;
  bool customColors = false;
  bool autoThemeSwitch = true;
  bool systemTheme = false;
  
  Color customPrimaryColor = Colors.blue;
  Color customSecondaryColor = Colors.blueAccent;
  Color customBackgroundColor = Colors.white;
  
  List<Map<String, dynamic>> themeItems = [
    {"label": "Light Theme", "value": "light"},
    {"label": "Dark Theme", "value": "dark"},
    {"label": "Auto (System)", "value": "system"},
    {"label": "Sepia", "value": "sepia"},
    {"label": "High Contrast", "value": "high_contrast"},
  ];
  
  List<Map<String, dynamic>> accentColorItems = [
    {"label": "Ocean Blue", "value": "primary", "color": Colors.blue},
    {"label": "Forest Green", "value": "green", "color": Colors.green},
    {"label": "Sunset Orange", "value": "orange", "color": Colors.orange},
    {"label": "Royal Purple", "value": "purple", "color": Colors.purple},
    {"label": "Rose Pink", "value": "pink", "color": Colors.pink},
    {"label": "Golden Yellow", "value": "amber", "color": Colors.amber},
    {"label": "Deep Red", "value": "red", "color": Colors.red},
    {"label": "Teal", "value": "teal", "color": Colors.teal},
  ];
  
  List<Map<String, dynamic>> backgroundStyleItems = [
    {"label": "Default", "value": "default"},
    {"label": "Gradient", "value": "gradient"},
    {"label": "Pattern", "value": "pattern"},
    {"label": "Minimal", "value": "minimal"},
    {"label": "Textured", "value": "textured"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () => _previewTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildThemePreview(),
            _buildThemeSelectionSection(),
            _buildColorCustomizationSection(),
            _buildAppearanceSection(),
            _buildAdvancedSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildThemePreview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spMd,
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
                "Theme Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: _getPreviewBackgroundColor(),
              borderRadius: BorderRadius.circular(cornerRadius),
              boxShadow: shadowIntensity > 0 ? [
                BoxShadow(
                  color: Colors.black.withAlpha((shadowIntensity * 50).toInt()),
                  blurRadius: shadowIntensity * 10,
                  offset: Offset(0, shadowIntensity * 4),
                ),
              ] : [],
              gradient: selectedBackgroundStyle == "gradient" ? LinearGradient(
                colors: [
                  _getAccentColor(),
                  _getAccentColor().withAlpha(100),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ) : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sample App Bar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getPreviewTextColor(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(selectedTheme == "dark" ? 30 : 255),
                      borderRadius: BorderRadius.circular(cornerRadius * 0.7),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.spa,
                          color: _getAccentColor(),
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Sample Content Card",
                            style: TextStyle(
                              fontSize: 14,
                              color: selectedTheme == "dark" ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getAccentColor(),
                      borderRadius: BorderRadius.circular(cornerRadius * 0.7),
                    ),
                    child: Center(
                      child: Text(
                        "Sample Button",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildThemeSelectionSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Theme Selection",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Theme Mode",
            items: themeItems,
            value: selectedTheme,
            onChanged: (value, label) {
              selectedTheme = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Auto theme switching (based on time)",
                "value": true,
                "checked": autoThemeSwitch,
              }
            ],
            value: [if (autoThemeSwitch) {"label": "Auto theme switching (based on time)", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                autoThemeSwitch = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Follow system theme",
                "value": true,
                "checked": systemTheme,
              }
            ],
            value: [if (systemTheme) {"label": "Follow system theme", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                systemTheme = values.isNotEmpty;
                if (systemTheme) selectedTheme = "system";
              });
            },
          ),
          if (autoThemeSwitch)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Light theme: 6:00 AM - 6:00 PM\nDark theme: 6:00 PM - 6:00 AM",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildColorCustomizationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Color Customization",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Accent Color",
            items: accentColorItems,
            value: selectedAccentColor,
            onChanged: (value, label) {
              selectedAccentColor = value;
              setState(() {});
            },
          ),
          Container(
            height: 60,
            child: QHorizontalScroll(
              children: accentColorItems.map((item) {
                bool isSelected = selectedAccentColor == item["value"];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAccentColor = item["value"];
                    });
                  },
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: item["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: isSelected ? 3 : 0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${item["label"]}".split(" ")[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable custom colors",
                "value": true,
                "checked": customColors,
              }
            ],
            value: [if (customColors) {"label": "Enable custom colors", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                customColors = values.isNotEmpty;
              });
            },
          ),
          if (customColors)
            Column(
              spacing: spSm,
              children: [
                _buildColorPicker("Primary Color", customPrimaryColor, (color) {
                  customPrimaryColor = color;
                  setState(() {});
                }),
                _buildColorPicker("Secondary Color", customSecondaryColor, (color) {
                  customSecondaryColor = color;
                  setState(() {});
                }),
                _buildColorPicker("Background Color", customBackgroundColor, (color) {
                  customBackgroundColor = color;
                  setState(() {});
                }),
              ],
            ),
        ],
      ),
    );
  }
  
  Widget _buildColorPicker(String label, Color color, Function(Color) onColorChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Color picker would open here
            si("Color picker for $label");
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildAppearanceSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Appearance Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Background Style",
            items: backgroundStyleItems,
            value: selectedBackgroundStyle,
            onChanged: (value, label) {
              selectedBackgroundStyle = value;
              setState(() {});
            },
          ),
          Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Corner Radius: ${cornerRadius.toInt()}px",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Slider(
                value: cornerRadius,
                min: 0.0,
                max: 24.0,
                divisions: 24,
                activeColor: primaryColor,
                onChanged: (value) {
                  cornerRadius = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Text("Sharp", style: TextStyle(fontSize: 12)),
                  Spacer(),
                  Text("Rounded", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shadow Intensity: ${(shadowIntensity * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Slider(
                value: shadowIntensity,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                activeColor: primaryColor,
                onChanged: (value) {
                  shadowIntensity = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Text("None", style: TextStyle(fontSize: 12)),
                  Spacer(),
                  Text("Strong", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildAdvancedSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
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
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export Theme",
                  size: bs.sm,
                  onPressed: () => _exportTheme(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Import Theme",
                  size: bs.sm,
                  onPressed: () => _importTheme(),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Theme changes will be applied immediately. Some changes may require app restart.",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Apply Theme",
            size: bs.md,
            onPressed: () => _applyTheme(),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Reset to Default",
                size: bs.md,
                onPressed: () => _resetTheme(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Save as Preset",
                size: bs.md,
                onPressed: () => _savePreset(),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Color _getAccentColor() {
    Map<String, dynamic> colorItem = accentColorItems.firstWhere(
      (item) => item["value"] == selectedAccentColor,
      orElse: () => accentColorItems[0],
    );
    return customColors ? customPrimaryColor : (colorItem["color"] as Color);
  }
  
  Color _getPreviewBackgroundColor() {
    if (customColors) return customBackgroundColor;
    
    switch (selectedTheme) {
      case "dark":
        return Colors.grey[900]!;
      case "sepia":
        return Color(0xFFF4F1E8);
      case "high_contrast":
        return Colors.black;
      default:
        return Colors.white;
    }
  }
  
  Color _getPreviewTextColor() {
    switch (selectedTheme) {
      case "dark":
      case "high_contrast":
        return Colors.white;
      default:
        return Colors.black;
    }
  }
  
  void _previewTheme() {
    si("Theme preview mode activated");
  }
  
  void _applyTheme() {
    ss("Theme applied successfully");
  }
  
  void _resetTheme() async {
    bool isConfirmed = await confirm("Reset theme to default settings?");
    if (isConfirmed) {
      setState(() {
        selectedTheme = "light";
        selectedAccentColor = "primary";
        selectedBackgroundStyle = "default";
        cornerRadius = 12.0;
        shadowIntensity = 0.5;
        customColors = false;
        autoThemeSwitch = true;
        systemTheme = false;
        customPrimaryColor = Colors.blue;
        customSecondaryColor = Colors.blueAccent;
        customBackgroundColor = Colors.white;
      });
      ss("Theme reset to default");
    }
  }
  
  void _savePreset() {
    ss("Theme saved as custom preset");
  }
  
  void _exportTheme() {
    si("Theme configuration exported");
  }
  
  void _importTheme() {
    si("Import theme from file");
  }
}
