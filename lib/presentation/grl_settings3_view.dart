import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSettings3View extends StatefulWidget {
  @override
  State<GrlSettings3View> createState() => _GrlSettings3ViewState();
}

class _GrlSettings3ViewState extends State<GrlSettings3View> {
  String selectedTheme = "System";
  String selectedFont = "Default";
  String selectedLanguage = "English";
  double fontSize = 16.0;
  bool reducedMotion = false;
  bool highContrast = false;
  bool largeCursor = false;
  bool screenReader = false;
  
  List<Map<String, dynamic>> themeOptions = [
    {"label": "Light", "value": "Light"},
    {"label": "Dark", "value": "Dark"},
    {"label": "System", "value": "System"},
  ];
  
  List<Map<String, dynamic>> fontOptions = [
    {"label": "Default", "value": "Default"},
    {"label": "Roboto", "value": "Roboto"},
    {"label": "Open Sans", "value": "OpenSans"},
    {"label": "Lato", "value": "Lato"},
    {"label": "Montserrat", "value": "Montserrat"},
  ];
  
  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "English"},
    {"label": "Español", "value": "Spanish"},
    {"label": "Français", "value": "French"},
    {"label": "Deutsch", "value": "German"},
    {"label": "Italiano", "value": "Italian"},
    {"label": "Português", "value": "Portuguese"},
    {"label": "Русский", "value": "Russian"},
    {"label": "中文", "value": "Chinese"},
    {"label": "日本語", "value": "Japanese"},
    {"label": "한국어", "value": "Korean"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display & Accessibility"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              _resetToDefaults();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Theme Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
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
                        "Theme Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "App Theme",
                    items: themeOptions,
                    value: selectedTheme,
                    onChanged: (value, label) {
                      selectedTheme = value;
                      setState(() {});
                      si("Theme changed to ${label}");
                    },
                  ),
                  
                  // Theme Preview
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      spacing: spSm,
                      children: [
                        _buildThemePreview("Light", Colors.white, Colors.black),
                        _buildThemePreview("Dark", Colors.black, Colors.white),
                        _buildThemePreview("Auto", Colors.grey.shade300, Colors.grey.shade700),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Typography Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.text_fields,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Typography",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "Font Family",
                    items: fontOptions,
                    value: selectedFont,
                    onChanged: (value, label) {
                      selectedFont = value;
                      setState(() {});
                    },
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Font Size: ${fontSize.toInt()}px",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Slider(
                        value: fontSize,
                        min: 12.0,
                        max: 24.0,
                        divisions: 12,
                        onChanged: (value) {
                          fontSize = value;
                          setState(() {});
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Small", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          Text("Large", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                        ],
                      ),
                    ],
                  ),
                  
                  // Font Preview
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Preview Text",
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "This is how your text will appear in the app with the selected font and size settings.",
                          style: TextStyle(
                            fontSize: fontSize,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Language Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Language & Region",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "App Language",
                    items: languageOptions,
                    value: selectedLanguage,
                    onChanged: (value, label) {
                      selectedLanguage = value;
                      setState(() {});
                      si("Language changed to ${label}");
                    },
                  ),
                  
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
                          Icons.info,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "App will restart to apply language changes",
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
            ),

            // Accessibility Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.accessibility,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Accessibility",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildAccessibilityToggle(
                    Icons.motion_photos_off,
                    "Reduce Motion",
                    "Minimize animations and transitions",
                    reducedMotion,
                    (value) {
                      reducedMotion = value;
                      setState(() {});
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildAccessibilityToggle(
                    Icons.contrast,
                    "High Contrast",
                    "Increase color contrast for better visibility",
                    highContrast,
                    (value) {
                      highContrast = value;
                      setState(() {});
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildAccessibilityToggle(
                    Icons.mouse,
                    "Large Cursor",
                    "Use larger cursor for better visibility",
                    largeCursor,
                    (value) {
                      largeCursor = value;
                      setState(() {});
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildAccessibilityToggle(
                    Icons.record_voice_over,
                    "Screen Reader Support",
                    "Enable enhanced screen reader compatibility",
                    screenReader,
                    (value) {
                      screenReader = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Advanced Display Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.display_settings,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Advanced Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  _buildSettingsItem(
                    Icons.color_lens,
                    "Color Calibration",
                    "Adjust screen colors",
                    () {
                      si("Color calibration feature coming soon");
                    },
                  ),
                  
                  _buildSettingsItem(
                    Icons.zoom_in,
                    "Display Zoom",
                    "Adjust overall display size",
                    () {
                      si("Display zoom feature coming soon");
                    },
                  ),
                  
                  _buildSettingsItem(
                    Icons.brightness_6,
                    "Auto Brightness",
                    "Automatically adjust screen brightness",
                    () {
                      si("Auto brightness feature coming soon");
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Apply All Changes",
                    size: bs.md,
                    onPressed: () {
                      ss("Display settings applied successfully");
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Reset to Defaults",
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Reset all display settings to default values?");
                      if (isConfirmed) {
                        _resetToDefaults();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePreview(String label, Color backgroundColor, Color textColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radiusXs),
          border: Border.all(color: disabledOutlineBorderColor),
        ),
        child: Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: textColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilityToggle(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _resetToDefaults() {
    selectedTheme = "System";
    selectedFont = "Default";
    selectedLanguage = "English";
    fontSize = 16.0;
    reducedMotion = false;
    highContrast = false;
    largeCursor = false;
    screenReader = false;
    setState(() {});
    ss("Settings reset to defaults");
  }
}
