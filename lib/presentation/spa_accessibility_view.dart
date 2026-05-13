import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaAccessibilityView extends StatefulWidget {
  const SpaAccessibilityView({super.key});

  @override
  State<SpaAccessibilityView> createState() => _SpaAccessibilityViewState();
}

class _SpaAccessibilityViewState extends State<SpaAccessibilityView> {
  double fontSize = 16.0;
  double lineHeight = 1.5;
  bool highContrast = false;
  bool reducedMotion = false;
  bool screenReader = false;
  bool hapticFeedback = true;
  bool audioDescriptions = false;
  bool subtitles = true;
  bool magnifierEnabled = false;
  bool colorInversion = false;
  bool boldText = false;
  bool underlineLinks = true;
  
  String selectedColorScheme = "default";
  String selectedNavigationStyle = "standard";
  String selectedFocusIndicator = "blue_outline";
  String selectedClickTarget = "large";
  
  List<Map<String, dynamic>> colorSchemeItems = [
    {"label": "Default", "value": "default"},
    {"label": "High Contrast", "value": "high_contrast"},
    {"label": "Dark Mode", "value": "dark"},
    {"label": "Grayscale", "value": "grayscale"},
    {"label": "Blue Light Filter", "value": "blue_filter"},
  ];
  
  List<Map<String, dynamic>> navigationStyleItems = [
    {"label": "Standard Navigation", "value": "standard"},
    {"label": "Large Touch Targets", "value": "large_targets"},
    {"label": "Voice Navigation", "value": "voice"},
    {"label": "Gesture Navigation", "value": "gesture"},
  ];
  
  List<Map<String, dynamic>> focusIndicatorItems = [
    {"label": "Blue Outline", "value": "blue_outline"},
    {"label": "Red Outline", "value": "red_outline"},
    {"label": "Yellow Highlight", "value": "yellow_highlight"},
    {"label": "White Border", "value": "white_border"},
  ];
  
  List<Map<String, dynamic>> clickTargetItems = [
    {"label": "Small (44px)", "value": "small"},
    {"label": "Medium (48px)", "value": "medium"},
    {"label": "Large (56px)", "value": "large"},
    {"label": "Extra Large (64px)", "value": "extra_large"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accessibility Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showAccessibilityGuide(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildAccessibilityOverview(),
            _buildVisualAccessibilitySection(),
            _buildTextAccessibilitySection(),
            _buildMotionAccessibilitySection(),
            _buildAudioAccessibilitySection(),
            _buildNavigationAccessibilitySection(),
            _buildPreviewSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAccessibilityOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.accessibility,
                color: primaryColor,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Accessibility Overview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Customize the app to meet your accessibility needs",
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
          Row(
            children: [
              Expanded(
                child: _buildAccessibilityScore(),
              ),
              SizedBox(width: spMd),
              QButton(
                label: "Quick Setup",
                size: bs.sm,
                onPressed: () => _quickAccessibilitySetup(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildAccessibilityScore() {
    int enabledFeatures = 0;
    if (highContrast) enabledFeatures++;
    if (reducedMotion) enabledFeatures++;
    if (screenReader) enabledFeatures++;
    if (boldText) enabledFeatures++;
    if (fontSize > 16) enabledFeatures++;
    
    double score = (enabledFeatures / 5) * 100;
    Color scoreColor = score >= 60 ? successColor : score >= 30 ? warningColor : infoColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: scoreColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            "Accessibility Score",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${score.toInt()}%",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: scoreColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildVisualAccessibilitySection() {
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
          Row(
            children: [
              Icon(
                Icons.visibility,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Visual Accessibility",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildAccessibilityToggle(
            "High Contrast Mode",
            "Increase contrast for better visibility",
            highContrast,
            Icons.contrast,
            (value) {
              highContrast = value;
              setState(() {});
            },
          ),
          _buildAccessibilityToggle(
            "Color Inversion",
            "Invert colors for light sensitivity",
            colorInversion,
            Icons.invert_colors,
            (value) {
              colorInversion = value;
              setState(() {});
            },
          ),
          _buildAccessibilityToggle(
            "Magnifier",
            "Enable screen magnification",
            magnifierEnabled,
            Icons.zoom_in,
            (value) {
              magnifierEnabled = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Color Scheme",
            items: colorSchemeItems,
            value: selectedColorScheme,
            onChanged: (value, label) {
              selectedColorScheme = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Focus Indicator Style",
            items: focusIndicatorItems,
            value: selectedFocusIndicator,
            onChanged: (value, label) {
              selectedFocusIndicator = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextAccessibilitySection() {
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
          Row(
            children: [
              Icon(
                Icons.text_fields,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Text Accessibility",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Font Size: ${fontSize.toInt()}px",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Slider(
                value: fontSize,
                min: 12.0,
                max: 24.0,
                divisions: 12,
                activeColor: primaryColor,
                onChanged: (value) {
                  fontSize = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Text("Small", style: TextStyle(fontSize: 12)),
                  Spacer(),
                  Text("Large", style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Line Height: ${lineHeight.toStringAsFixed(1)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Slider(
                value: lineHeight,
                min: 1.0,
                max: 2.5,
                divisions: 15,
                activeColor: primaryColor,
                onChanged: (value) {
                  lineHeight = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Text("Tight", style: TextStyle(fontSize: 12)),
                  Spacer(),
                  Text("Spacious", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          _buildAccessibilityToggle(
            "Bold Text",
            "Make all text bold for better readability",
            boldText,
            Icons.format_bold,
            (value) {
              boldText = value;
              setState(() {});
            },
          ),
          _buildAccessibilityToggle(
            "Underline Links",
            "Add underlines to all clickable links",
            underlineLinks,
            Icons.link,
            (value) {
              underlineLinks = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildMotionAccessibilitySection() {
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
          Row(
            children: [
              Icon(
                Icons.motion_photos_off,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Motion & Haptics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildAccessibilityToggle(
            "Reduce Motion",
            "Minimize animations and transitions",
            reducedMotion,
            Icons.motion_photos_pause,
            (value) {
              reducedMotion = value;
              setState(() {});
            },
          ),
          _buildAccessibilityToggle(
            "Haptic Feedback",
            "Enable vibration feedback for interactions",
            hapticFeedback,
            Icons.vibration,
            (value) {
              hapticFeedback = value;
              setState(() {});
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
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Reduced motion settings help users with vestibular disorders or motion sensitivity.",
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
  
  Widget _buildAudioAccessibilitySection() {
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
          Row(
            children: [
              Icon(
                Icons.hearing,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Audio Accessibility",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildAccessibilityToggle(
            "Screen Reader Support",
            "Enable compatibility with screen readers",
            screenReader,
            Icons.record_voice_over,
            (value) {
              screenReader = value;
              setState(() {});
            },
          ),
          _buildAccessibilityToggle(
            "Audio Descriptions",
            "Enable audio descriptions for visual content",
            audioDescriptions,
            Icons.audiotrack,
            (value) {
              audioDescriptions = value;
              setState(() {});
            },
          ),
          _buildAccessibilityToggle(
            "Subtitles",
            "Show subtitles for audio content",
            subtitles,
            Icons.subtitles,
            (value) {
              subtitles = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavigationAccessibilitySection() {
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
          Row(
            children: [
              Icon(
                Icons.navigation,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Navigation Accessibility",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Navigation Style",
            items: navigationStyleItems,
            value: selectedNavigationStyle,
            onChanged: (value, label) {
              selectedNavigationStyle = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Touch Target Size",
            items: clickTargetItems,
            value: selectedClickTarget,
            onChanged: (value, label) {
              selectedClickTarget = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildPreviewSection() {
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
          Text(
            "Preview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: highContrast ? Colors.black : primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: highContrast ? Colors.white : primaryColor.withAlpha(50),
                width: selectedFocusIndicator == "white_border" ? 2 : 1,
              ),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sample Text Preview",
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: boldText ? FontWeight.bold : FontWeight.normal,
                    color: highContrast ? Colors.white : (colorInversion ? Colors.white : Colors.black),
                    height: lineHeight,
                    decoration: underlineLinks ? TextDecoration.underline : null,
                  ),
                ),
                Container(
                  height: _getTargetSize(),
                  width: 120,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Text(
                      "Button",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize * 0.9,
                        fontWeight: boldText ? FontWeight.bold : FontWeight.normal,
                      ),
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
  
  Widget _buildAccessibilityToggle(String title, String description, bool value, IconData icon, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: value ? primaryColor : disabledBoldColor,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  description,
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
            activeColor: primaryColor,
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
            label: "Save Accessibility Settings",
            size: bs.md,
            onPressed: () => _saveSettings(),
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Reset to Default",
            size: bs.md,
            onPressed: () => _resetSettings(),
          ),
        ),
      ],
    );
  }
  
  double _getTargetSize() {
    switch (selectedClickTarget) {
      case "small":
        return 44.0;
      case "medium":
        return 48.0;
      case "large":
        return 56.0;
      case "extra_large":
        return 64.0;
      default:
        return 56.0;
    }
  }
  
  void _showAccessibilityGuide() {
    si("Accessibility guide and tips available");
  }
  
  void _quickAccessibilitySetup() {
    si("Quick accessibility setup wizard available");
  }
  
  void _saveSettings() {
    ss("Accessibility settings saved successfully");
  }
  
  void _resetSettings() async {
    bool isConfirmed = await confirm("Reset all accessibility settings to default?");
    if (isConfirmed) {
      setState(() {
        fontSize = 16.0;
        lineHeight = 1.5;
        highContrast = false;
        reducedMotion = false;
        screenReader = false;
        hapticFeedback = true;
        audioDescriptions = false;
        subtitles = true;
        magnifierEnabled = false;
        colorInversion = false;
        boldText = false;
        underlineLinks = true;
        selectedColorScheme = "default";
        selectedNavigationStyle = "standard";
        selectedFocusIndicator = "blue_outline";
        selectedClickTarget = "large";
      });
      ss("Accessibility settings reset to default");
    }
  }
}
