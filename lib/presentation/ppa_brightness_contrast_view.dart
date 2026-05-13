import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBrightnessContrastView extends StatefulWidget {
  const PpaBrightnessContrastView({super.key});

  @override
  State<PpaBrightnessContrastView> createState() => _PpaBrightnessContrastViewState();
}

class _PpaBrightnessContrastViewState extends State<PpaBrightnessContrastView> {
  double brightness = 0.5;
  double contrast = 0.5;
  bool autoAdjust = false;
  bool previewMode = true;
  String selectedPreset = "Custom";

  List<Map<String, dynamic>> presets = [
    {
      "label": "Custom",
      "value": "Custom",
      "brightness": 0.5,
      "contrast": 0.5,
    },
    {
      "label": "Bright",
      "value": "Bright",
      "brightness": 0.8,
      "contrast": 0.6,
    },
    {
      "label": "Dark",
      "value": "Dark",
      "brightness": 0.2,
      "contrast": 0.7,
    },
    {
      "label": "High Contrast",
      "value": "High Contrast",
      "brightness": 0.5,
      "contrast": 0.9,
    },
    {
      "label": "Low Contrast",
      "value": "Low Contrast",
      "brightness": 0.5,
      "contrast": 0.2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brightness & Contrast"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              brightness = 0.5;
              contrast = 0.5;
              selectedPreset = "Custom";
              setState(() {});
              ss("Settings reset to default");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPreviewSection(),
            _buildControlsSection(),
            _buildPresetsSection(),
            _buildOptionsSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusMd),
        child: ColorFiltered(
          colorFilter: ColorFilter.matrix([
            1 + (contrast - 0.5) * 2, 0, 0, 0, (brightness - 0.5) * 255,
            0, 1 + (contrast - 0.5) * 2, 0, 0, (brightness - 0.5) * 255,
            0, 0, 1 + (contrast - 0.5) * 2, 0, (brightness - 0.5) * 255,
            0, 0, 0, 1, 0,
          ]),
          child: Image.network(
            "https://picsum.photos/400/200?random=1&keyword=landscape",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget _buildControlsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.brightness_6, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Brightness",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${(brightness * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Slider(
            value: brightness,
            min: 0.0,
            max: 1.0,
            divisions: 100,
            onChanged: (value) {
              brightness = value;
              selectedPreset = "Custom";
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.contrast, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Contrast",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${(contrast * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Slider(
            value: contrast,
            min: 0.0,
            max: 1.0,
            divisions: 100,
            onChanged: (value) {
              contrast = value;
              selectedPreset = "Custom";
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPresetsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.palette, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Presets",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Preset",
            items: presets,
            value: selectedPreset,
            onChanged: (value, label) {
              selectedPreset = value;
              final preset = presets.firstWhere((p) => p["value"] == value);
              brightness = preset["brightness"] as double;
              contrast = preset["contrast"] as double;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Auto Adjust Based on Ambient Light",
                "value": true,
                "checked": autoAdjust,
              }
            ],
            value: [if (autoAdjust) {"label": "Auto Adjust Based on Ambient Light", "value": true, "checked": true}],
            onChanged: (values, ids) {
              autoAdjust = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Real-time Preview",
                "value": true,
                "checked": previewMode,
              }
            ],
            value: [if (previewMode) {"label": "Real-time Preview", "value": true, "checked": true}],
            onChanged: (values, ids) {
              previewMode = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: QButton(
            label: "Reset",
            color: disabledBoldColor,
            size: bs.md,
            onPressed: () {
              brightness = 0.5;
              contrast = 0.5;
              selectedPreset = "Custom";
              autoAdjust = false;
              previewMode = true;
              setState(() {});
              ss("Settings reset to default");
            },
          ),
        ),
        Expanded(
          child: QButton(
            label: "Apply Changes",
            size: bs.md,
            onPressed: () {
              ss("Brightness and contrast settings applied");
              //navigateTo('SettingsView')
            },
          ),
        ),
      ],
    );
  }
}
