import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaReadingModeView extends StatefulWidget {
  const NmaReadingModeView({super.key});

  @override
  State<NmaReadingModeView> createState() => _NmaReadingModeViewState();
}

class _NmaReadingModeViewState extends State<NmaReadingModeView> {
  bool isReadingMode = true;
  bool autoScrollEnabled = false;
  double scrollSpeed = 50.0;
  bool focusMode = false;
  bool nightMode = false;
  
  String selectedLayout = "Standard";
  List<String> layoutOptions = ["Standard", "Column", "Magazine", "Minimalist"];
  
  double lineHeight = 1.6;
  double marginSize = 16.0;
  double brightness = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nightMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: nightMode ? Colors.black : Colors.white,
        foregroundColor: nightMode ? Colors.white : primaryColor,
        title: Text("Reading Mode"),
        actions: [
          IconButton(
            icon: Icon(isReadingMode ? Icons.chrome_reader_mode : Icons.article),
            onPressed: () {
              isReadingMode = !isReadingMode;
              setState(() {});
              if (isReadingMode) {
                ss("Reading mode enabled");
              } else {
                si("Reading mode disabled");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showReadingModeSettings();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            padding: EdgeInsets.all(marginSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Reading Mode Toggle
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isReadingMode ? primaryColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chrome_reader_mode,
                        color: isReadingMode ? Colors.white : disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        isReadingMode ? "Reading Mode Active" : "Standard View",
                        style: TextStyle(
                          color: isReadingMode ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: isReadingMode,
                        onChanged: (value) {
                          isReadingMode = value;
                          setState(() {});
                        },
                        activeColor: Colors.white,
                        activeTrackColor: primaryColor.withAlpha(128),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                if (isReadingMode) ...[
                  // Reading Mode Features
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: nightMode ? Colors.grey[900] : disabledColor,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reading Mode Features",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: nightMode ? Colors.white : primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),

                        // Focus Mode
                        Row(
                          children: [
                            Icon(
                              Icons.center_focus_strong,
                              color: focusMode ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Focus Mode",
                                style: TextStyle(
                                  color: nightMode ? Colors.white : primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Switch(
                              value: focusMode,
                              onChanged: (value) {
                                focusMode = value;
                                setState(() {});
                                if (focusMode) {
                                  ss("Focus mode enabled");
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),

                        // Auto Scroll
                        Row(
                          children: [
                            Icon(
                              Icons.auto_stories,
                              color: autoScrollEnabled ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Auto Scroll",
                                style: TextStyle(
                                  color: nightMode ? Colors.white : primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Switch(
                              value: autoScrollEnabled,
                              onChanged: (value) {
                                autoScrollEnabled = value;
                                setState(() {});
                                if (autoScrollEnabled) {
                                  ss("Auto scroll enabled");
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),

                        // Night Mode
                        Row(
                          children: [
                            Icon(
                              Icons.nights_stay,
                              color: nightMode ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Night Mode",
                                style: TextStyle(
                                  color: nightMode ? Colors.white : primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Switch(
                              value: nightMode,
                              onChanged: (value) {
                                nightMode = value;
                                setState(() {});
                                if (nightMode) {
                                  ss("Night mode enabled");
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Auto Scroll Settings
                  if (autoScrollEnabled) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: nightMode ? Colors.grey[900] : disabledColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Auto Scroll Speed",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: nightMode ? Colors.white : primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.speed,
                                color: nightMode ? Colors.white : primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Slider(
                                  value: scrollSpeed,
                                  min: 10,
                                  max: 100,
                                  divisions: 9,
                                  label: "${scrollSpeed.round()} wpm",
                                  onChanged: (value) {
                                    scrollSpeed = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                              Text(
                                "${scrollSpeed.round()} wpm",
                                style: TextStyle(
                                  color: nightMode ? Colors.white : primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                  ],

                  // Layout Options
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: nightMode ? Colors.grey[900] : disabledColor,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reading Layout",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: nightMode ? Colors.white : primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: layoutOptions.map((layout) => GestureDetector(
                            onTap: () {
                              selectedLayout = layout;
                              setState(() {});
                              ss("Layout changed to ${layout}");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: selectedLayout == layout ? primaryColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                layout,
                                style: TextStyle(
                                  color: selectedLayout == layout ? Colors.white : (nightMode ? Colors.white : primaryColor),
                                  fontWeight: selectedLayout == layout ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Typography Controls
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: nightMode ? Colors.grey[900] : disabledColor,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Typography Settings",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: nightMode ? Colors.white : primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),

                        // Line Height
                        Row(
                          children: [
                            Icon(
                              Icons.format_line_spacing,
                              color: nightMode ? Colors.white : primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Line Height",
                              style: TextStyle(
                                color: nightMode ? Colors.white : primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${lineHeight.toStringAsFixed(1)}",
                              style: TextStyle(
                                color: nightMode ? Colors.white : primaryColor,
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

                        // Margin Size
                        Row(
                          children: [
                            Icon(
                              Icons.border_outer,
                              color: nightMode ? Colors.white : primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Margins",
                              style: TextStyle(
                                color: nightMode ? Colors.white : primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${marginSize.round()}px",
                              style: TextStyle(
                                color: nightMode ? Colors.white : primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: marginSize,
                          min: 8,
                          max: 32,
                          divisions: 6,
                          onChanged: (value) {
                            marginSize = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Sample Article Preview
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: nightMode ? Colors.grey[800] : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: nightMode ? Colors.grey[700]! : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Preview",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: nightMode ? Colors.white : primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Sample Article Title",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: nightMode ? Colors.white : primaryColor,
                            height: lineHeight,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "This is a sample paragraph to demonstrate how your reading settings will appear. The line height, margins, and color scheme will all be applied according to your preferences. You can adjust these settings to optimize your reading experience.",
                          style: TextStyle(
                            fontSize: 16,
                            color: nightMode ? Colors.white : primaryColor,
                            height: lineHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                if (!isReadingMode) ...[
                  // Standard View Info
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.article,
                          size: 48,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Standard View Mode",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Enable Reading Mode to access enhanced reading features including focus mode, auto-scroll, night mode, and customizable typography settings.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Enable Reading Mode",
                          size: bs.sm,
                          onPressed: () {
                            isReadingMode = true;
                            setState(() {});
                            ss("Reading mode enabled");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Focus Mode Overlay
          if (focusMode && isReadingMode)
            Positioned.fill(
              child: Container(
                color: Colors.black.withAlpha(128),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: nightMode ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.center_focus_strong,
                          size: 48,
                          color: primaryColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Focus Mode Active",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: nightMode ? Colors.white : primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Distractions minimized for better reading focus",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: nightMode ? Colors.grey[400] : disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Exit Focus Mode",
                          size: bs.sm,
                          onPressed: () {
                            focusMode = false;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showReadingModeSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: nightMode ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Settings",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: nightMode ? Colors.white : primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Row(
              children: [
                Icon(Icons.brightness_6, color: nightMode ? Colors.white : primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Brightness",
                  style: TextStyle(color: nightMode ? Colors.white : primaryColor),
                ),
                Expanded(
                  child: Slider(
                    value: brightness,
                    onChanged: (value) {
                      brightness = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Icon(Icons.text_fields, color: nightMode ? Colors.white : primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Font Settings",
                  style: TextStyle(color: nightMode ? Colors.white : primaryColor),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
              ],
            ),
            SizedBox(height: spSm),

            Row(
              children: [
                Icon(Icons.palette, color: nightMode ? Colors.white : primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Theme Settings",
                  style: TextStyle(color: nightMode ? Colors.white : primaryColor),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
              ],
            ),
            SizedBox(height: spSm),

            Row(
              children: [
                Icon(Icons.accessibility, color: nightMode ? Colors.white : primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Accessibility",
                  style: TextStyle(color: nightMode ? Colors.white : primaryColor),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
