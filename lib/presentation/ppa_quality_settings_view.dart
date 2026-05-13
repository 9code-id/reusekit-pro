import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaQualitySettingsView extends StatefulWidget {
  const PpaQualitySettingsView({super.key});

  @override
  State<PpaQualitySettingsView> createState() => _PpaQualitySettingsViewState();
}

class _PpaQualitySettingsViewState extends State<PpaQualitySettingsView> {
  String selectedQuality = "High";
  String compression = "Medium";
  bool enableHDR = true;
  bool enableRAW = false;
  double resolutionScale = 1.0;
  String colorSpace = "sRGB";
  bool enableNoisereduction = true;
  String bitDepth = "8-bit";

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Ultra", "value": "Ultra"},
  ];

  List<Map<String, dynamic>> compressionOptions = [
    {"label": "None", "value": "None"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
  ];

  List<Map<String, dynamic>> colorSpaceOptions = [
    {"label": "sRGB", "value": "sRGB"},
    {"label": "Adobe RGB", "value": "Adobe RGB"},
    {"label": "DCI-P3", "value": "DCI-P3"},
    {"label": "Rec. 2020", "value": "Rec. 2020"},
  ];

  List<Map<String, dynamic>> bitDepthOptions = [
    {"label": "8-bit", "value": "8-bit"},
    {"label": "10-bit", "value": "10-bit"},
    {"label": "12-bit", "value": "12-bit"},
    {"label": "16-bit", "value": "16-bit"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quality Settings"),
        actions: [
          QButton(
            label: "Reset",
            size: bs.sm,
            onPressed: () {
              selectedQuality = "High";
              compression = "Medium";
              enableHDR = true;
              enableRAW = false;
              resolutionScale = 1.0;
              colorSpace = "sRGB";
              enableNoisereduction = true;
              bitDepth = "8-bit";
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
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.high_quality,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Image Quality",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Quality Level",
                    items: qualityOptions,
                    value: selectedQuality,
                    onChanged: (value, label) {
                      selectedQuality = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Resolution Scale",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${(resolutionScale * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: resolutionScale,
                    min: 0.5,
                    max: 2.0,
                    divisions: 15,
                    onChanged: (value) {
                      resolutionScale = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.compress,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Compression",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Compression Level",
                    items: compressionOptions,
                    value: compression,
                    onChanged: (value, label) {
                      compression = value;
                      setState(() {});
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: warningColor.withAlpha(50),
                        width: 1,
                      ),
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
                            "Higher compression reduces file size but may affect image quality",
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
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Color Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Color Space",
                    items: colorSpaceOptions,
                    value: colorSpace,
                    onChanged: (value, label) {
                      colorSpace = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Bit Depth",
                    items: bitDepthOptions,
                    value: bitDepth,
                    onChanged: (value, label) {
                      bitDepth = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Advanced Options",
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
                        "label": "Enable HDR Processing",
                        "value": true,
                        "checked": enableHDR,
                      }
                    ],
                    value: [
                      if (enableHDR)
                        {
                          "label": "Enable HDR Processing",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableHDR = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Save RAW Files",
                        "value": true,
                        "checked": enableRAW,
                      }
                    ],
                    value: [
                      if (enableRAW)
                        {
                          "label": "Save RAW Files",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableRAW = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Noise Reduction",
                        "value": true,
                        "checked": enableNoisereduction,
                      }
                    ],
                    value: [
                      if (enableNoisereduction)
                        {
                          "label": "Noise Reduction",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableNoisereduction = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: infoColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.storage,
                        color: infoColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Storage Impact",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Estimated file size:",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "~12.4 MB",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Processing time:",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "~3.2 seconds",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Settings",
                onPressed: () {
                  ss("Quality settings applied successfully");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
