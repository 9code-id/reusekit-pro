import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaWatermarkView extends StatefulWidget {
  const PpaWatermarkView({super.key});

  @override
  State<PpaWatermarkView> createState() => _PpaWatermarkViewState();
}

class _PpaWatermarkViewState extends State<PpaWatermarkView> {
  bool enableWatermark = true;
  String watermarkType = "Text";
  String watermarkText = "© 2025 My Photography";
  String logoImage = "";
  String position = "Bottom Right";
  double opacity = 0.7;
  double size = 0.3;
  String fontFamily = "Arial";
  String fontWeight = "Normal";
  String fontColor = "#FFFFFF";
  double rotation = 0.0;
  bool enableShadow = true;
  double shadowBlur = 2.0;

  List<Map<String, dynamic>> typeOptions = [
    {"label": "Text", "value": "Text"},
    {"label": "Logo", "value": "Logo"},
    {"label": "Both", "value": "Both"},
  ];

  List<Map<String, dynamic>> positionOptions = [
    {"label": "Top Left", "value": "Top Left"},
    {"label": "Top Center", "value": "Top Center"},
    {"label": "Top Right", "value": "Top Right"},
    {"label": "Center Left", "value": "Center Left"},
    {"label": "Center", "value": "Center"},
    {"label": "Center Right", "value": "Center Right"},
    {"label": "Bottom Left", "value": "Bottom Left"},
    {"label": "Bottom Center", "value": "Bottom Center"},
    {"label": "Bottom Right", "value": "Bottom Right"},
  ];

  List<Map<String, dynamic>> fontFamilyOptions = [
    {"label": "Arial", "value": "Arial"},
    {"label": "Helvetica", "value": "Helvetica"},
    {"label": "Times", "value": "Times"},
    {"label": "Georgia", "value": "Georgia"},
    {"label": "Verdana", "value": "Verdana"},
    {"label": "Impact", "value": "Impact"},
  ];

  List<Map<String, dynamic>> fontWeightOptions = [
    {"label": "Light", "value": "Light"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Bold", "value": "Bold"},
    {"label": "Extra Bold", "value": "Extra Bold"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watermark Settings"),
        actions: [
          QButton(
            icon: Icons.preview,
            size: bs.sm,
            onPressed: () {
              si("Preview watermark on sample image");
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
                        Icons.security,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Watermark Protection",
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
                        "label": "Enable Watermark",
                        "value": true,
                        "checked": enableWatermark,
                      }
                    ],
                    value: [
                      if (enableWatermark)
                        {
                          "label": "Enable Watermark",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableWatermark = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  if (enableWatermark) ...[
                    QDropdownField(
                      label: "Watermark Type",
                      items: typeOptions,
                      value: watermarkType,
                      onChanged: (value, label) {
                        watermarkType = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),
            if (enableWatermark) ...[
              if (watermarkType == "Text" || watermarkType == "Both") ...[
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
                            Icons.text_fields,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Text Watermark",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      QTextField(
                        label: "Watermark Text",
                        value: watermarkText,
                        hint: "Enter your watermark text",
                        onChanged: (value) {
                          watermarkText = value;
                          setState(() {});
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "Font Family",
                              items: fontFamilyOptions,
                              value: fontFamily,
                              onChanged: (value, label) {
                                fontFamily = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Font Weight",
                              items: fontWeightOptions,
                              value: fontWeight,
                              onChanged: (value, label) {
                                fontWeight = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      QTextField(
                        label: "Font Color (Hex)",
                        value: fontColor,
                        hint: "#FFFFFF",
                        onChanged: (value) {
                          fontColor = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
              if (watermarkType == "Logo" || watermarkType == "Both") ...[
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
                            Icons.image,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Logo Watermark",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      QImagePicker(
                        label: "Logo Image",
                        value: logoImage,
                        hint: "Select your logo image",
                        onChanged: (value) {
                          logoImage = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
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
                          Icons.place,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Position & Size",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Position",
                      items: positionOptions,
                      value: position,
                      onChanged: (value, label) {
                        position = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Opacity",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(opacity * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: opacity,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      onChanged: (value) {
                        opacity = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Size",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(size * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: size,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      onChanged: (value) {
                        size = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Rotation",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${rotation.toInt()}°",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: rotation,
                      min: 0,
                      max: 360,
                      divisions: 72,
                      onChanged: (value) {
                        rotation = value;
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
                          Icons.blur_on,
                          color: dangerColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Shadow Effects",
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
                          "label": "Enable Shadow",
                          "value": true,
                          "checked": enableShadow,
                        }
                      ],
                      value: [
                        if (enableShadow)
                          {
                            "label": "Enable Shadow",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        enableShadow = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (enableShadow) ...[
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Shadow Blur",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            shadowBlur.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: shadowBlur,
                        min: 0.0,
                        max: 10.0,
                        divisions: 20,
                        onChanged: (value) {
                          shadowBlur = value;
                          setState(() {});
                        },
                      ),
                    ],
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
                          Icons.preview,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Watermark Preview",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              "Sample Image",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha((opacity * 255).toInt()),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                watermarkText.isNotEmpty ? watermarkText : "© Watermark",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Container(
              width: double.infinity,
              child: QButton(
                label: enableWatermark ? "Apply Watermark Settings" : "Disable Watermark",
                onPressed: () {
                  if (enableWatermark) {
                    ss("Watermark settings applied");
                  } else {
                    si("Watermark disabled");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
