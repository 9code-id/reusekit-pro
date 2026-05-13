import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSaturationVibranceView extends StatefulWidget {
  const PpaSaturationVibranceView({super.key});

  @override
  State<PpaSaturationVibranceView> createState() => _PpaSaturationVibranceViewState();
}

class _PpaSaturationVibranceViewState extends State<PpaSaturationVibranceView> {
  double saturation = 0.0;
  double vibrance = 0.0;
  double luminance = 0.0;
  double redChannel = 0.0;
  double greenChannel = 0.0;
  double blueChannel = 0.0;
  
  bool advancedMode = false;
  bool hasChanges = false;
  String selectedColorSpace = "HSL";

  List<String> colorSpaces = ["HSL", "RGB", "Lab"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saturation & Vibrance"),
        actions: [
          QButton(
            icon: advancedMode ? Icons.tune : Icons.settings,
            size: bs.sm,
            onPressed: () {
              advancedMode = !advancedMode;
              setState(() {});
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              _resetAll();
            },
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: hasChanges ? () {
              _applyChanges();
            } : null,
          ),
        ],
      ),
      body: Column(
        children: [
          // Photo Preview
          Container(
            height: 250,
            margin: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/400/250?random=12&keyword=flowers"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Color Info
                Positioned(
                  top: spMd,
                  left: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "S: ${(saturation * 100).round()}%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "V: ${(vibrance * 100).round()}%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Color Space Indicator
                Positioned(
                  top: spMd,
                  right: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      selectedColorSpace,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                // Color Wheel Toggle
                Positioned(
                  bottom: spMd,
                  right: spMd,
                  child: GestureDetector(
                    onTap: () {
                      ss("Color wheel view toggled");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.color_lens,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Color Space Selection
          if (advancedMode)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: QCategoryPicker(
                items: colorSpaces.map((space) => {
                  "label": space,
                  "value": space,
                }).toList(),
                value: selectedColorSpace,
                onChanged: (index, label, value, item) {
                  selectedColorSpace = value;
                  setState(() {});
                },
              ),
            ),
          
          if (advancedMode) SizedBox(height: spMd),
          
          // Adjustment Controls
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Color Enhancement",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  _buildSlider(
                    "Saturation",
                    saturation,
                    Icons.palette,
                    Colors.pink,
                    "Adjust overall color intensity",
                    (value) {
                      saturation = value;
                      _onAdjustmentChanged();
                    },
                  ),
                  
                  _buildSlider(
                    "Vibrance",
                    vibrance,
                    Icons.color_lens,
                    Colors.purple,
                    "Smart color enhancement",
                    (value) {
                      vibrance = value;
                      _onAdjustmentChanged();
                    },
                  ),
                  
                  _buildSlider(
                    "Luminance",
                    luminance,
                    Icons.brightness_6,
                    Colors.yellow,
                    "Color brightness",
                    (value) {
                      luminance = value;
                      _onAdjustmentChanged();
                    },
                  ),
                  
                  if (advancedMode) ...[
                    SizedBox(height: spLg),
                    
                    Text(
                      "Color Channels",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    _buildSlider(
                      "Red Channel",
                      redChannel,
                      Icons.circle,
                      Colors.red,
                      "Adjust red tones",
                      (value) {
                        redChannel = value;
                        _onAdjustmentChanged();
                      },
                    ),
                    
                    _buildSlider(
                      "Green Channel",
                      greenChannel,
                      Icons.circle,
                      Colors.green,
                      "Adjust green tones",
                      (value) {
                        greenChannel = value;
                        _onAdjustmentChanged();
                      },
                    ),
                    
                    _buildSlider(
                      "Blue Channel",
                      blueChannel,
                      Icons.circle,
                      Colors.blue,
                      "Adjust blue tones",
                      (value) {
                        blueChannel = value;
                        _onAdjustmentChanged();
                      },
                    ),
                  ],
                  
                  SizedBox(height: spLg),
                  
                  // Quick Presets
                  Text(
                    "Color Presets",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildPresetButton(
                          "Vivid",
                          Icons.auto_awesome,
                          Colors.pink,
                          () => _applyVivid(),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildPresetButton(
                          "Natural",
                          Icons.nature,
                          Colors.green,
                          () => _applyNatural(),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildPresetButton(
                          "Muted",
                          Icons.blur_on,
                          Colors.grey,
                          () => _applyMuted(),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildPresetButton(
                          "Dramatic",
                          Icons.tonality,
                          Colors.purple,
                          () => _applyDramatic(),
                        ),
                      ),
                    ],
                  ),
                  
                  if (!advancedMode) ...[
                    SizedBox(height: spLg),
                    
                    // Tips
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb,
                                color: infoColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Pro Tips",
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
                            "• Vibrance affects muted colors more than already saturated ones\n• Saturation affects all colors equally\n• Use luminance to brighten colors without affecting exposure",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    IconData icon,
    Color iconColor,
    String description,
    Function(double) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
              Container(
                width: 50,
                alignment: Alignment.centerRight,
                child: Text(
                  "${(value * 100).round()}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "-100",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Expanded(
                child: Slider(
                  value: value,
                  min: -1.0,
                  max: 1.0,
                  divisions: 200,
                  activeColor: iconColor,
                  inactiveColor: disabledColor,
                  onChanged: onChanged,
                ),
              ),
              Text(
                "+100",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPresetButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAdjustmentChanged() {
    hasChanges = true;
    setState(() {});
  }

  void _resetAll() {
    saturation = 0.0;
    vibrance = 0.0;
    luminance = 0.0;
    redChannel = 0.0;
    greenChannel = 0.0;
    blueChannel = 0.0;
    hasChanges = false;
    setState(() {});
    ss("All color adjustments reset");
  }

  void _applyChanges() {
    ss("Color adjustments applied successfully");
    hasChanges = false;
    setState(() {});
  }

  void _applyVivid() {
    saturation = 0.4;
    vibrance = 0.6;
    luminance = 0.1;
    _onAdjustmentChanged();
    ss("Vivid preset applied");
  }

  void _applyNatural() {
    saturation = 0.1;
    vibrance = 0.2;
    luminance = 0.05;
    _onAdjustmentChanged();
    ss("Natural preset applied");
  }

  void _applyMuted() {
    saturation = -0.3;
    vibrance = -0.2;
    luminance = -0.1;
    _onAdjustmentChanged();
    ss("Muted preset applied");
  }

  void _applyDramatic() {
    saturation = 0.6;
    vibrance = 0.8;
    luminance = 0.2;
    redChannel = 0.1;
    _onAdjustmentChanged();
    ss("Dramatic preset applied");
  }
}
