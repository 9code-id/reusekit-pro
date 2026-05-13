import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaFontSizeView extends StatefulWidget {
  const SpaFontSizeView({super.key});

  @override
  State<SpaFontSizeView> createState() => _SpaFontSizeViewState();
}

class _SpaFontSizeViewState extends State<SpaFontSizeView> {
  double bodyFontSize = 16.0;
  double headingFontSize = 24.0;
  double subheadingFontSize = 18.0;
  double captionFontSize = 12.0;
  double buttonFontSize = 14.0;
  double lineHeight = 1.5;
  double letterSpacing = 0.0;
  
  String selectedFontFamily = "system";
  String selectedFontWeight = "normal";
  bool useSystemFontSize = false;
  bool dyslexiaFriendlyMode = false;
  
  List<Map<String, dynamic>> fontFamilyItems = [
    {"label": "System Default", "value": "system"},
    {"label": "Roboto", "value": "roboto"},
    {"label": "Open Sans", "value": "opensans"},
    {"label": "Lato", "value": "lato"},
    {"label": "Montserrat", "value": "montserrat"},
    {"label": "Poppins", "value": "poppins"},
    {"label": "Inter", "value": "inter"},
    {"label": "Source Sans Pro", "value": "sourcesans"},
  ];
  
  List<Map<String, dynamic>> fontWeightItems = [
    {"label": "Light", "value": "light"},
    {"label": "Normal", "value": "normal"},
    {"label": "Medium", "value": "medium"},
    {"label": "Semi Bold", "value": "semibold"},
    {"label": "Bold", "value": "bold"},
  ];
  
  List<Map<String, dynamic>> presetSizes = [
    {
      "name": "Small",
      "description": "Compact text for more content",
      "body": 14.0,
      "heading": 20.0,
      "subheading": 16.0,
      "caption": 10.0,
      "button": 12.0,
    },
    {
      "name": "Default",
      "description": "Standard reading size",
      "body": 16.0,
      "heading": 24.0,
      "subheading": 18.0,
      "caption": 12.0,
      "button": 14.0,
    },
    {
      "name": "Large",
      "description": "Easier reading experience",
      "body": 18.0,
      "heading": 28.0,
      "subheading": 20.0,
      "caption": 14.0,
      "button": 16.0,
    },
    {
      "name": "Extra Large",
      "description": "Maximum readability",
      "body": 20.0,
      "heading": 32.0,
      "subheading": 24.0,
      "caption": 16.0,
      "button": 18.0,
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Font Size Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.text_fields),
            onPressed: () => _showFontGuide(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPreviewSection(),
            _buildQuickPresetsSection(),
            _buildFontSizeSection(),
            _buildFontStyleSection(),
            _buildAdvancedSettingsSection(),
            _buildAccessibilitySection(),
            _buildActionButtons(),
          ],
        ),
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
          Row(
            children: [
              Icon(
                Icons.preview,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Font Preview",
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
                "Main Heading",
                style: TextStyle(
                  fontSize: headingFontSize,
                  fontWeight: _getFontWeight(),
                  height: lineHeight,
                  letterSpacing: letterSpacing,
                  fontFamily: _getFontFamily(),
                ),
              ),
              Text(
                "Subheading Text",
                style: TextStyle(
                  fontSize: subheadingFontSize,
                  fontWeight: _getFontWeight(),
                  height: lineHeight,
                  letterSpacing: letterSpacing,
                  fontFamily: _getFontFamily(),
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "This is body text that shows how your content will look with the selected font size and styling. The text should be comfortable to read and not strain your eyes.",
                style: TextStyle(
                  fontSize: bodyFontSize,
                  fontWeight: _getFontWeight(),
                  height: lineHeight,
                  letterSpacing: letterSpacing,
                  fontFamily: _getFontFamily(),
                ),
              ),
              Text(
                "Caption or small text",
                style: TextStyle(
                  fontSize: captionFontSize,
                  fontWeight: _getFontWeight(),
                  height: lineHeight,
                  letterSpacing: letterSpacing,
                  fontFamily: _getFontFamily(),
                  color: disabledBoldColor,
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Text(
                    "Button Text",
                    style: TextStyle(
                      fontSize: buttonFontSize,
                      fontWeight: FontWeight.w600,
                      letterSpacing: letterSpacing,
                      fontFamily: _getFontFamily(),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickPresetsSection() {
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
            "Quick Presets",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: presetSizes.map((preset) {
              bool isSelected = bodyFontSize == preset["body"];
              return GestureDetector(
                onTap: () => _applyPreset(preset),
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${preset["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? primaryColor : Colors.black,
                        ),
                      ),
                      Text(
                        "${preset["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Aa",
                        style: TextStyle(
                          fontSize: (preset["body"] as double),
                          color: isSelected ? primaryColor : Colors.black,
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
    );
  }
  
  Widget _buildFontSizeSection() {
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
            "Font Sizes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildSlider(
            "Body Text",
            bodyFontSize,
            12.0,
            32.0,
            (value) {
              bodyFontSize = value;
              setState(() {});
            },
          ),
          _buildSlider(
            "Heading",
            headingFontSize,
            18.0,
            48.0,
            (value) {
              headingFontSize = value;
              setState(() {});
            },
          ),
          _buildSlider(
            "Subheading",
            subheadingFontSize,
            14.0,
            36.0,
            (value) {
              subheadingFontSize = value;
              setState(() {});
            },
          ),
          _buildSlider(
            "Caption",
            captionFontSize,
            8.0,
            20.0,
            (value) {
              captionFontSize = value;
              setState(() {});
            },
          ),
          _buildSlider(
            "Button",
            buttonFontSize,
            10.0,
            24.0,
            (value) {
              buttonFontSize = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildSlider(String label, double value, double min, double max, Function(double) onChanged) {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              "${value.toInt()}px",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: ((max - min) / 2).toInt(),
          activeColor: primaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
  
  Widget _buildFontStyleSection() {
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
            "Font Style",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Font Family",
            items: fontFamilyItems,
            value: selectedFontFamily,
            onChanged: (value, label) {
              selectedFontFamily = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Font Weight",
            items: fontWeightItems,
            value: selectedFontWeight,
            onChanged: (value, label) {
              selectedFontWeight = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildAdvancedSettingsSection() {
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
          _buildSlider(
            "Line Height",
            lineHeight,
            1.0,
            3.0,
            (value) {
              lineHeight = value;
              setState(() {});
            },
          ),
          _buildSlider(
            "Letter Spacing",
            letterSpacing,
            -1.0,
            3.0,
            (value) {
              letterSpacing = value;
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
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Typography Tips",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Line height 1.4-1.6 is ideal for body text\n• Increase letter spacing for better readability\n• Test different combinations to find what works best",
                  style: TextStyle(
                    fontSize: 11,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAccessibilitySection() {
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
          QSwitch(
            items: [
              {
                "label": "Use system font size",
                "value": true,
                "checked": useSystemFontSize,
              }
            ],
            value: [if (useSystemFontSize) {"label": "Use system font size", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                useSystemFontSize = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Dyslexia-friendly mode",
                "value": true,
                "checked": dyslexiaFriendlyMode,
              }
            ],
            value: [if (dyslexiaFriendlyMode) {"label": "Dyslexia-friendly mode", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                dyslexiaFriendlyMode = values.isNotEmpty;
                if (dyslexiaFriendlyMode) {
                  selectedFontFamily = "opensans";
                  letterSpacing = 0.5;
                  lineHeight = 1.6;
                }
              });
            },
          ),
          if (useSystemFontSize)
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
                    Icons.warning,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Using system font size will override your custom settings with the device's accessibility settings.",
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
            label: "Apply Font Settings",
            size: bs.md,
            onPressed: () => _applySettings(),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Reset to Default",
                size: bs.md,
                onPressed: () => _resetToDefault(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Save Preset",
                size: bs.md,
                onPressed: () => _saveCustomPreset(),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  void _applyPreset(Map<String, dynamic> preset) {
    setState(() {
      bodyFontSize = preset["body"];
      headingFontSize = preset["heading"];
      subheadingFontSize = preset["subheading"];
      captionFontSize = preset["caption"];
      buttonFontSize = preset["button"];
    });
    ss("${preset["name"]} preset applied");
  }
  
  FontWeight _getFontWeight() {
    switch (selectedFontWeight) {
      case "light":
        return FontWeight.w300;
      case "normal":
        return FontWeight.w400;
      case "medium":
        return FontWeight.w500;
      case "semibold":
        return FontWeight.w600;
      case "bold":
        return FontWeight.w700;
      default:
        return FontWeight.w400;
    }
  }
  
  String? _getFontFamily() {
    if (selectedFontFamily == "system") return null;
    return selectedFontFamily;
  }
  
  void _showFontGuide() {
    si("Font size and readability guide available");
  }
  
  void _applySettings() {
    ss("Font settings applied successfully");
  }
  
  void _resetToDefault() async {
    bool isConfirmed = await confirm("Reset all font settings to default?");
    if (isConfirmed) {
      setState(() {
        bodyFontSize = 16.0;
        headingFontSize = 24.0;
        subheadingFontSize = 18.0;
        captionFontSize = 12.0;
        buttonFontSize = 14.0;
        lineHeight = 1.5;
        letterSpacing = 0.0;
        selectedFontFamily = "system";
        selectedFontWeight = "normal";
        useSystemFontSize = false;
        dyslexiaFriendlyMode = false;
      });
      ss("Font settings reset to default");
    }
  }
  
  void _saveCustomPreset() {
    ss("Custom font preset saved");
  }
}
