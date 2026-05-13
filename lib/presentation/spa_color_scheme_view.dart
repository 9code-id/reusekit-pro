import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaColorSchemeView extends StatefulWidget {
  const SpaColorSchemeView({super.key});

  @override
  State<SpaColorSchemeView> createState() => _SpaColorSchemeViewState();
}

class _SpaColorSchemeViewState extends State<SpaColorSchemeView> {
  String selectedScheme = "default";
  String selectedMood = "relaxing";
  bool autoAdjustBrightness = true;
  bool highContrastMode = false;
  bool colorBlindFriendly = false;
  double colorSaturation = 1.0;
  double colorBrightness = 1.0;
  double colorContrast = 1.0;
  
  Color customPrimary = Colors.blue;
  Color customSecondary = Colors.blueAccent;
  Color customBackground = Colors.white;
  Color customSurface = Colors.grey[50]!;
  Color customAccent = Colors.amber;
  
  List<Map<String, dynamic>> colorSchemes = [
    {
      "id": "default",
      "name": "Ocean Breeze",
      "description": "Calming blue tones",
      "primary": Colors.blue,
      "secondary": Colors.blueAccent,
      "background": Colors.white,
      "surface": Colors.blue[50],
      "accent": Colors.cyan,
    },
    {
      "id": "sunset",
      "name": "Sunset Glow",
      "description": "Warm orange and pink",
      "primary": Colors.orange,
      "secondary": Colors.deepOrange,
      "background": Color(0xFFFFF8F0),
      "surface": Colors.orange[50],
      "accent": Colors.amber,
    },
    {
      "id": "forest",
      "name": "Forest Fresh",
      "description": "Natural green palette",
      "primary": Colors.green,
      "secondary": Colors.lightGreen,
      "background": Color(0xFFF8FFF8),
      "surface": Colors.green[50],
      "accent": Colors.lime,
    },
    {
      "id": "lavender",
      "name": "Lavender Dream",
      "description": "Soothing purple hues",
      "primary": Colors.purple,
      "secondary": Colors.deepPurple,
      "background": Color(0xFFFAF8FF),
      "surface": Colors.purple[50],
      "accent": Colors.pink,
    },
    {
      "id": "rose_gold",
      "name": "Rose Gold",
      "description": "Elegant pink and gold",
      "primary": Colors.pink,
      "secondary": Color(0xFFE91E63),
      "background": Color(0xFFFFF8F8),
      "surface": Colors.pink[50],
      "accent": Colors.amber,
    },
    {
      "id": "midnight",
      "name": "Midnight Sky",
      "description": "Deep blue night theme",
      "primary": Color(0xFF1A237E),
      "secondary": Color(0xFF3F51B5),
      "background": Color(0xFF0F0F23),
      "surface": Color(0xFF1A1A3A),
      "accent": Colors.cyan,
    },
    {
      "id": "earth",
      "name": "Earth Tones",
      "description": "Natural brown palette",
      "primary": Colors.brown,
      "secondary": Color(0xFF8D6E63),
      "background": Color(0xFFFAF7F2),
      "surface": Colors.brown[50],
      "accent": Colors.orange,
    },
    {
      "id": "monochrome",
      "name": "Monochrome",
      "description": "Classic black and white",
      "primary": Colors.black,
      "secondary": Colors.grey[700],
      "background": Colors.white,
      "surface": Colors.grey[100],
      "accent": Colors.grey[600],
    },
  ];
  
  List<Map<String, dynamic>> moodItems = [
    {"label": "Relaxing", "value": "relaxing"},
    {"label": "Energizing", "value": "energizing"},
    {"label": "Professional", "value": "professional"},
    {"label": "Playful", "value": "playful"},
    {"label": "Minimal", "value": "minimal"},
    {"label": "Luxury", "value": "luxury"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Color Scheme"),
        actions: [
          IconButton(
            icon: Icon(Icons.colorize),
            onPressed: () => _showColorTheory(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildColorPreview(),
            _buildSchemeSelection(),
            _buildMoodBasedSelection(),
            _buildColorAdjustments(),
            _buildCustomColorSection(),
            _buildAccessibilitySection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildColorPreview() {
    Map<String, dynamic> currentScheme = _getCurrentScheme();
    
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
            "Color Preview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: currentScheme["background"] as Color,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              children: [
                // App bar preview
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: currentScheme["primary"] as Color,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Row(
                      children: [
                        Icon(
                          Icons.spa,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${currentScheme["name"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                // Content preview
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: currentScheme["surface"] as Color,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: currentScheme["secondary"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sample Card",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Content preview",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 36,
                                decoration: BoxDecoration(
                                  color: currentScheme["accent"] as Color,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Center(
                                  child: Text(
                                    "Action",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Container(
                                height: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(color: currentScheme["primary"] as Color),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Center(
                                  child: Text(
                                    "Secondary",
                                    style: TextStyle(
                                      color: currentScheme["primary"] as Color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${currentScheme["description"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSchemeSelection() {
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
            "Color Schemes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: colorSchemes.map((scheme) {
              bool isSelected = selectedScheme == scheme["id"];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedScheme = scheme["id"];
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          _buildColorCircle(scheme["primary"] as Color),
                          SizedBox(width: spXs),
                          _buildColorCircle(scheme["secondary"] as Color),
                          SizedBox(width: spXs),
                          _buildColorCircle(scheme["accent"] as Color),
                        ],
                      ),
                      Text(
                        "${scheme["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
  
  Widget _buildColorCircle(Color color) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMoodBasedSelection() {
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
                Icons.mood,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Mood-Based Selection",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Mood",
            items: moodItems,
            value: selectedMood,
            onChanged: (value, label) {
              selectedMood = value;
              _applyMoodBasedScheme(value);
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
                  Icons.lightbulb,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    _getMoodDescription(selectedMood),
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
  
  Widget _buildColorAdjustments() {
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
            "Color Adjustments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildAdjustmentSlider(
            "Saturation",
            colorSaturation,
            0.0,
            2.0,
            (value) {
              colorSaturation = value;
              setState(() {});
            },
          ),
          _buildAdjustmentSlider(
            "Brightness",
            colorBrightness,
            0.5,
            1.5,
            (value) {
              colorBrightness = value;
              setState(() {});
            },
          ),
          _buildAdjustmentSlider(
            "Contrast",
            colorContrast,
            0.5,
            2.0,
            (value) {
              colorContrast = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildAdjustmentSlider(String label, double value, double min, double max, Function(double) onChanged) {
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
              "${(value * 100).toInt()}%",
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
          divisions: 20,
          activeColor: primaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
  
  Widget _buildCustomColorSection() {
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
            "Custom Colors",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildCustomColorPicker("Primary", customPrimary, (color) {
                customPrimary = color;
                setState(() {});
              }),
              _buildCustomColorPicker("Secondary", customSecondary, (color) {
                customSecondary = color;
                setState(() {});
              }),
              _buildCustomColorPicker("Background", customBackground, (color) {
                customBackground = color;
                setState(() {});
              }),
              _buildCustomColorPicker("Surface", customSurface, (color) {
                customSurface = color;
                setState(() {});
              }),
              _buildCustomColorPicker("Accent", customAccent, (color) {
                customAccent = color;
                setState(() {});
              }),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Apply Custom",
                  size: bs.sm,
                  onPressed: () => _applyCustomColors(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Palette",
                  size: bs.sm,
                  onPressed: () => _saveCustomPalette(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildCustomColorPicker(String label, Color color, Function(Color) onColorChanged) {
    return Column(
      spacing: spSm,
      children: [
        GestureDetector(
          onTap: () {
            si("Color picker for $label");
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
              boxShadow: [shadowSm],
            ),
            child: Icon(
              Icons.colorize,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
                "label": "Auto-adjust brightness",
                "value": true,
                "checked": autoAdjustBrightness,
              }
            ],
            value: [if (autoAdjustBrightness) {"label": "Auto-adjust brightness", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                autoAdjustBrightness = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "High contrast mode",
                "value": true,
                "checked": highContrastMode,
              }
            ],
            value: [if (highContrastMode) {"label": "High contrast mode", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                highContrastMode = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Color blind friendly",
                "value": true,
                "checked": colorBlindFriendly,
              }
            ],
            value: [if (colorBlindFriendly) {"label": "Color blind friendly", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                colorBlindFriendly = values.isNotEmpty;
                if (colorBlindFriendly) {
                  selectedScheme = "monochrome";
                }
              });
            },
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
            label: "Apply Color Scheme",
            size: bs.md,
            onPressed: () => _applyColorScheme(),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Reset to Default",
                size: bs.md,
                onPressed: () => _resetColors(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Export Palette",
                size: bs.md,
                onPressed: () => _exportPalette(),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Map<String, dynamic> _getCurrentScheme() {
    return colorSchemes.firstWhere(
      (scheme) => scheme["id"] == selectedScheme,
      orElse: () => colorSchemes[0],
    );
  }
  
  void _applyMoodBasedScheme(String mood) {
    switch (mood) {
      case "relaxing":
        selectedScheme = "lavender";
        break;
      case "energizing":
        selectedScheme = "sunset";
        break;
      case "professional":
        selectedScheme = "midnight";
        break;
      case "playful":
        selectedScheme = "rose_gold";
        break;
      case "minimal":
        selectedScheme = "monochrome";
        break;
      case "luxury":
        selectedScheme = "earth";
        break;
    }
  }
  
  String _getMoodDescription(String mood) {
    switch (mood) {
      case "relaxing":
        return "Soft, calming colors to reduce stress and promote relaxation";
      case "energizing":
        return "Vibrant, warm colors to boost energy and motivation";
      case "professional":
        return "Classic, sophisticated colors for business environments";
      case "playful":
        return "Fun, bright colors to inspire creativity and joy";
      case "minimal":
        return "Clean, simple colors for focus and clarity";
      case "luxury":
        return "Rich, elegant colors for premium experiences";
      default:
        return "Select a mood to see its description";
    }
  }
  
  void _showColorTheory() {
    si("Color theory and psychology guide available");
  }
  
  void _applyCustomColors() {
    selectedScheme = "custom";
    ss("Custom color palette applied");
  }
  
  void _saveCustomPalette() {
    ss("Custom color palette saved");
  }
  
  void _applyColorScheme() {
    ss("Color scheme applied successfully");
  }
  
  void _resetColors() async {
    bool isConfirmed = await confirm("Reset color scheme to default?");
    if (isConfirmed) {
      setState(() {
        selectedScheme = "default";
        selectedMood = "relaxing";
        autoAdjustBrightness = true;
        highContrastMode = false;
        colorBlindFriendly = false;
        colorSaturation = 1.0;
        colorBrightness = 1.0;
        colorContrast = 1.0;
      });
      ss("Color scheme reset to default");
    }
  }
  
  void _exportPalette() {
    si("Color palette exported");
  }
}
