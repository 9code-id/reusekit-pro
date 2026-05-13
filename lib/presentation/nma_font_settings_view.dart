import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaFontSettingsView extends StatefulWidget {
  const NmaFontSettingsView({super.key});

  @override
  State<NmaFontSettingsView> createState() => _NmaFontSettingsViewState();
}

class _NmaFontSettingsViewState extends State<NmaFontSettingsView> {
  double fontSize = 16.0;
  double lineHeight = 1.6;
  double letterSpacing = 0.0;
  double wordSpacing = 0.0;
  
  String selectedFont = "System Default";
  List<Map<String, dynamic>> fontOptions = [
    {"name": "System Default", "family": "default"},
    {"name": "Roboto", "family": "Roboto"},
    {"name": "Open Sans", "family": "OpenSans"},
    {"name": "Lato", "family": "Lato"},
    {"name": "Merriweather", "family": "Merriweather"},
    {"name": "Playfair Display", "family": "PlayfairDisplay"},
    {"name": "Source Sans Pro", "family": "SourceSansPro"},
    {"name": "Ubuntu", "family": "Ubuntu"},
    {"name": "OpenDyslexic", "family": "OpenDyslexic"},
  ];
  
  String selectedWeight = "Normal";
  List<String> weightOptions = ["Light", "Normal", "Medium", "Bold"];
  
  bool enableDyslexicFont = false;
  bool enableSerifFont = false;
  bool enableHighContrast = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Font Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetToDefaults();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Font Size Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.format_size,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Font Size",
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
                          min: 12,
                          max: 28,
                          divisions: 16,
                          label: "${fontSize.round()}px",
                          onChanged: (value) {
                            fontSize = value;
                            setState(() {});
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
                    "Current size: ${fontSize.round()}px",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Font Family Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.font_download,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Font Family",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Column(
                    children: fontOptions.map((font) {
                      bool isSelected = selectedFont == font["name"];
                      return GestureDetector(
                        onTap: () {
                          selectedFont = font["name"]!;
                          setState(() {});
                          ss("Font changed to ${font["name"]}");
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(51) : disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      font["name"]!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        color: isSelected ? primaryColor : primaryColor,
                                        fontFamily: font["family"] != "default" ? font["family"] : null,
                                      ),
                                    ),
                                    Text(
                                      "The quick brown fox jumps over the lazy dog",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                        fontFamily: font["family"] != "default" ? font["family"] : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                  size: 20,
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
            SizedBox(height: spMd),

            // Font Weight Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.format_bold,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Font Weight",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: weightOptions.map((weight) {
                      bool isSelected = selectedWeight == weight;
                      return GestureDetector(
                        onTap: () {
                          selectedWeight = weight;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            weight,
                            style: TextStyle(
                              color: isSelected ? Colors.white : primaryColor,
                              fontWeight: _getFontWeight(weight),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Typography Spacing Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.format_line_spacing,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Typography Spacing",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Line Height
                  Row(
                    children: [
                      Text(
                        "Line Height",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${lineHeight.toStringAsFixed(1)}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: lineHeight,
                    min: 1.0,
                    max: 2.5,
                    divisions: 15,
                    onChanged: (value) {
                      lineHeight = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  
                  // Letter Spacing
                  Row(
                    children: [
                      Text(
                        "Letter Spacing",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${letterSpacing.toStringAsFixed(1)}px",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: letterSpacing,
                    min: -2.0,
                    max: 5.0,
                    divisions: 35,
                    onChanged: (value) {
                      letterSpacing = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  
                  // Word Spacing
                  Row(
                    children: [
                      Text(
                        "Word Spacing",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${wordSpacing.toStringAsFixed(1)}px",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: wordSpacing,
                    min: -5.0,
                    max: 10.0,
                    divisions: 15,
                    onChanged: (value) {
                      wordSpacing = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Accessibility Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
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
                  SizedBox(height: spSm),
                  
                  // Dyslexic Friendly Font
                  Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: enableDyslexicFont ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dyslexic-Friendly Font",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Easier to read for people with dyslexia",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: enableDyslexicFont,
                        onChanged: (value) {
                          enableDyslexicFont = value;
                          if (value) {
                            selectedFont = "OpenDyslexic";
                          }
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // High Contrast
                  Row(
                    children: [
                      Icon(
                        Icons.contrast,
                        color: enableHighContrast ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "High Contrast Mode",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Improves text visibility",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: enableHighContrast,
                        onChanged: (value) {
                          enableHighContrast = value;
                          setState(() {});
                          if (value) {
                            ss("High contrast mode enabled");
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Preview Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: enableHighContrast ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: enableHighContrast ? Colors.white : disabledOutlineBorderColor,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Font Preview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: enableHighContrast ? Colors.white : primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Text(
                    "Sample Article Headline",
                    style: TextStyle(
                      fontSize: fontSize + 4,
                      fontWeight: _getFontWeight(selectedWeight),
                      color: enableHighContrast ? Colors.white : primaryColor,
                      letterSpacing: letterSpacing,
                      height: lineHeight,
                      fontFamily: _getFontFamily(),
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Text(
                    "This is a sample paragraph that demonstrates how your selected font settings will appear in articles. The quick brown fox jumps over the lazy dog. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: _getFontWeight(selectedWeight),
                      color: enableHighContrast ? Colors.white : primaryColor,
                      letterSpacing: letterSpacing,
                      wordSpacing: wordSpacing,
                      height: lineHeight,
                      fontFamily: _getFontFamily(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Apply Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Font Settings",
                size: bs.md,
                onPressed: () {
                  ss("Font settings applied successfully");
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  FontWeight _getFontWeight(String weight) {
    switch (weight) {
      case "Light":
        return FontWeight.w300;
      case "Normal":
        return FontWeight.w400;
      case "Medium":
        return FontWeight.w500;
      case "Bold":
        return FontWeight.w700;
      default:
        return FontWeight.w400;
    }
  }

  String? _getFontFamily() {
    if (enableDyslexicFont) return "OpenDyslexic";
    
    final font = fontOptions.firstWhere(
      (font) => font["name"] == selectedFont,
      orElse: () => fontOptions.first,
    );
    
    return font["family"] != "default" ? font["family"] : null;
  }

  void _resetToDefaults() {
    fontSize = 16.0;
    lineHeight = 1.6;
    letterSpacing = 0.0;
    wordSpacing = 0.0;
    selectedFont = "System Default";
    selectedWeight = "Normal";
    enableDyslexicFont = false;
    enableSerifFont = false;
    enableHighContrast = false;
    setState(() {});
    ss("Font settings reset to defaults");
  }
}
