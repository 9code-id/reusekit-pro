import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaAccessibilityView extends StatefulWidget {
  const GeaAccessibilityView({Key? key}) : super(key: key);

  @override
  State<GeaAccessibilityView> createState() => _GeaAccessibilityViewState();
}

class _GeaAccessibilityViewState extends State<GeaAccessibilityView> {
  bool screenReaderEnabled = false;
  bool highContrastMode = false;
  bool largeTextEnabled = true;
  bool magnifierEnabled = false;
  bool voiceControlEnabled = false;
  bool reduceMotionEnabled = false;
  bool colorBlindnessSupport = false;
  bool audioDescriptionsEnabled = false;

  double fontSize = 16.0;
  double contrast = 0.0;
  String colorFilter = "None";
  String selectedLanguage = "English";
  String voiceSpeed = "Normal";

  List<String> colorFilters = [
    "None",
    "Protanopia",
    "Deuteranopia", 
    "Tritanopia",
    "Monochromacy"
  ];

  List<String> languages = [
    "English",
    "Spanish",
    "French",
    "German",
    "Chinese",
    "Japanese"
  ];

  List<String> voiceSpeeds = [
    "Slow",
    "Normal",
    "Fast",
    "Very Fast"
  ];

  List<Map<String, dynamic>> accessibilityFeatures = [
    {
      "title": "Screen Reader",
      "description": "Reads screen content aloud for visually impaired users",
      "icon": Icons.record_voice_over,
      "category": "Visual",
      "enabled": false
    },
    {
      "title": "High Contrast",
      "description": "Increases contrast for better visibility",
      "icon": Icons.contrast,
      "category": "Visual",
      "enabled": false
    },
    {
      "title": "Large Text",
      "description": "Increases font size throughout the app",
      "icon": Icons.text_fields,
      "category": "Visual",
      "enabled": true
    },
    {
      "title": "Magnifier",
      "description": "Magnifies content on screen",
      "icon": Icons.zoom_in,
      "category": "Visual",
      "enabled": false
    },
    {
      "title": "Voice Control",
      "description": "Control the app using voice commands",
      "icon": Icons.mic,
      "category": "Motor",
      "enabled": false
    },
    {
      "title": "Reduce Motion",
      "description": "Minimizes animations and transitions",
      "icon": Icons.motion_photos_off,
      "category": "Vestibular",
      "enabled": false
    },
  ];

  List<Map<String, dynamic>> shortcuts = [
    {
      "action": "Navigate Back",
      "shortcut": "Alt + Left Arrow",
      "description": "Go to previous screen"
    },
    {
      "action": "Open Menu",
      "shortcut": "Alt + M",
      "description": "Open navigation menu"
    },
    {
      "action": "Search",
      "shortcut": "Ctrl + F",
      "description": "Open search function"
    },
    {
      "action": "Settings",
      "shortcut": "Ctrl + ,",
      "description": "Open app settings"
    },
    {
      "action": "Help",
      "shortcut": "F1",
      "description": "Open help documentation"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accessibility"),
        actions: [
          QButton(
            icon: Icons.accessibility,
            size: bs.sm,
            onPressed: () {
              _runAccessibilityCheck();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildAccessibilityOverview(),
            _buildQuickToggles(),
            _buildTextAndDisplay(),
            _buildColorAndContrast(),
            _buildAudioSettings(),
            _buildMotorSettings(),
            _buildKeyboardShortcuts(),
            _buildAccessibilityTests(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.accessibility_new,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Accessibility Center",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Make the app more accessible with customizable settings for visual, auditory, and motor impairments.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.verified_user,
                color: successColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "WCAG 2.1 AA Compliant",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickToggles() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Quick Toggles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            minItemWidth: 150,
            children: [
              _buildQuickToggle(
                "Screen Reader",
                Icons.record_voice_over,
                screenReaderEnabled,
                (value) => setState(() => screenReaderEnabled = value),
              ),
              _buildQuickToggle(
                "High Contrast",
                Icons.contrast,
                highContrastMode,
                (value) => setState(() => highContrastMode = value),
              ),
              _buildQuickToggle(
                "Large Text",
                Icons.text_fields,
                largeTextEnabled,
                (value) => setState(() => largeTextEnabled = value),
              ),
              _buildQuickToggle(
                "Reduce Motion",
                Icons.motion_photos_off,
                reduceMotionEnabled,
                (value) => setState(() => reduceMotionEnabled = value),
              ),
            ],
          ),
          SizedBox(height: spMd),
        ],
      ),
    );
  }

  Widget _buildQuickToggle(
    String title,
    IconData icon,
    bool enabled,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: enabled ? primaryColor.withAlpha(10) : Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: enabled ? primaryColor.withAlpha(50) : disabledColor,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            icon,
            color: enabled ? primaryColor : disabledBoldColor,
            size: 28,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: enabled ? primaryColor : disabledBoldColor,
            ),
          ),
          Switch(
            value: enabled,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTextAndDisplay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Text & Display",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Font Size",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "A",
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
                        divisions: 12,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() => fontSize = value);
                        },
                      ),
                    ),
                    Text(
                      "A",
                      style: TextStyle(
                        fontSize: 20,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Sample text at ${fontSize.toInt()}px",
                  style: TextStyle(
                    fontSize: fontSize,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(
                  Icons.text_fields,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Bold Text",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Make text bold throughout the app",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: largeTextEnabled,
                  onChanged: (value) {
                    setState(() => largeTextEnabled = value);
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorAndContrast() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Color & Contrast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.contrast,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "High Contrast Mode",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Increase contrast for better visibility",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: highContrastMode,
                  onChanged: (value) {
                    setState(() => highContrastMode = value);
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Color Blind Support",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                QDropdownField(
                  label: "Color Filter",
                  items: colorFilters.map((filter) => {
                    "label": filter,
                    "value": filter,
                  }).toList(),
                  value: colorFilter,
                  onChanged: (value, label) {
                    colorFilter = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Audio & Speech",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.record_voice_over,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Audio Descriptions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Describe visual content with audio",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: audioDescriptionsEnabled,
                  onChanged: (value) {
                    setState(() => audioDescriptionsEnabled = value);
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Voice Speed",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                QDropdownField(
                  label: "Speech Rate",
                  items: voiceSpeeds.map((speed) => {
                    "label": speed,
                    "value": speed,
                  }).toList(),
                  value: voiceSpeed,
                  onChanged: (value, label) {
                    voiceSpeed = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Language",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                QDropdownField(
                  label: "Screen Reader Language",
                  items: languages.map((lang) => {
                    "label": lang,
                    "value": lang,
                  }).toList(),
                  value: selectedLanguage,
                  onChanged: (value, label) {
                    selectedLanguage = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotorSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Motor & Navigation",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.mic,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Voice Control",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Navigate using voice commands",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: voiceControlEnabled,
                  onChanged: (value) {
                    setState(() => voiceControlEnabled = value);
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(
                  Icons.zoom_in,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Magnifier",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Magnify screen content",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: magnifierEnabled,
                  onChanged: (value) {
                    setState(() => magnifierEnabled = value);
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardShortcuts() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Keyboard Shortcuts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...shortcuts.asMap().entries.map((entry) {
            final index = entry.key;
            final shortcut = entry.value;
            final isLast = index == shortcuts.length - 1;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${shortcut["action"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${shortcut["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: disabledColor),
                    ),
                    child: Text(
                      "${shortcut["shortcut"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAccessibilityTests() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Accessibility Testing",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Text(
              "Test accessibility features to ensure they work correctly with your preferences.",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Test Screen Reader",
                    size: bs.sm,
                    onPressed: () {
                      si("Testing screen reader functionality");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Test Voice Control",
                    size: bs.sm,
                    onPressed: () {
                      si("Testing voice control features");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _runAccessibilityCheck() {
    si("Running accessibility compliance check...");
    
    // Simulate accessibility check
    Future.delayed(Duration(seconds: 2), () {
      ss("Accessibility check completed - All features working correctly");
    });
  }
}
