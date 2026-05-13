import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaHdrModeView extends StatefulWidget {
  const PpaHdrModeView({super.key});

  @override
  State<PpaHdrModeView> createState() => _PpaHdrModeViewState();
}

class _PpaHdrModeViewState extends State<PpaHdrModeView> {
  bool isHdrEnabled = false;
  String hdrMode = "auto";
  double hdrIntensity = 0.5;
  bool showPreview = true;
  bool autoDetectScenes = true;
  bool saveOriginal = false;
  String processingQuality = "high";

  List<Map<String, dynamic>> hdrModeOptions = [
    {
      "label": "Auto HDR",
      "value": "auto",
      "description": "Automatically detects high contrast scenes",
      "icon": Icons.auto_awesome,
    },
    {
      "label": "Always On",
      "value": "on",
      "description": "Apply HDR to all photos",
      "icon": Icons.hdr_on,
    },
    {
      "label": "Manual",
      "value": "manual",
      "description": "Control HDR settings manually",
      "icon": Icons.tune,
    },
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "High Quality", "value": "high"},
    {"label": "Balanced", "value": "balanced"},
    {"label": "Fast Processing", "value": "fast"},
  ];

  List<Map<String, dynamic>> hdrExamples = [
    {
      "title": "Sunset Scene",
      "original": "https://picsum.photos/300/200?random=1&keyword=sunset",
      "hdr": "https://picsum.photos/300/200?random=2&keyword=sunset",
      "improvement": "Enhanced sky detail and foreground visibility",
    },
    {
      "title": "Interior Shot",
      "original": "https://picsum.photos/300/200?random=3&keyword=interior",
      "hdr": "https://picsum.photos/300/200?random=4&keyword=interior",
      "improvement": "Balanced window light and room details",
    },
    {
      "title": "Landscape",
      "original": "https://picsum.photos/300/200?random=5&keyword=landscape",
      "hdr": "https://picsum.photos/300/200?random=6&keyword=landscape",
      "improvement": "Better shadow and highlight detail",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HDR Mode"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("HDR combines multiple exposures for better dynamic range");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // HDR Toggle
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isHdrEnabled ? primaryColor.withAlpha(25) : disabledColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.hdr_on,
                      color: isHdrEnabled ? primaryColor : disabledBoldColor,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "HDR Mode",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "High Dynamic Range photography",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: isHdrEnabled,
                    onChanged: (value) {
                      isHdrEnabled = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            if (isHdrEnabled) ...[
              // HDR Mode Selection
              Text(
                "HDR Mode",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spSm,
                children: hdrModeOptions.map((mode) {
                  bool isSelected = hdrMode == mode["value"];
                  return GestureDetector(
                    onTap: () {
                      hdrMode = mode["value"] as String;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            mode["icon"] as IconData,
                            color: isSelected ? primaryColor : disabledBoldColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${mode["label"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? primaryColor : primaryColor,
                                  ),
                                ),
                                Text(
                                  "${mode["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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

              // HDR Settings
              Text(
                "HDR Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // HDR Intensity
                    if (hdrMode == "manual") ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HDR Intensity",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(hdrIntensity * 100).round()}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Slider(
                            value: hdrIntensity,
                            onChanged: (value) {
                              hdrIntensity = value;
                              setState(() {});
                            },
                            divisions: 10,
                          ),
                          Text(
                            "Adjust the strength of HDR processing",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                    
                    // Processing Quality
                    QDropdownField(
                      label: "Processing Quality",
                      items: qualityOptions,
                      value: processingQuality,
                      onChanged: (value, label) {
                        processingQuality = value;
                        setState(() {});
                      },
                    ),
                    
                    // Auto Detect Scenes
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Auto-detect High Contrast",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Automatically enable HDR for suitable scenes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: autoDetectScenes,
                          onChanged: (value) {
                            autoDetectScenes = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    
                    // Show Preview
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Show HDR Preview",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Preview HDR effect in viewfinder",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: showPreview,
                          onChanged: (value) {
                            showPreview = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    
                    // Save Original
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Save Original Photo",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Keep both HDR and original versions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: saveOriginal,
                          onChanged: (value) {
                            saveOriginal = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // HDR Examples
            Text(
              "HDR Examples",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: hdrExamples.map((example) {
                return Container(
                  width: 280,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${example["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${example["original"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Original",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${example["hdr"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "HDR",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "HDR Enhanced",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${example["improvement"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Usage Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(51)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "HDR Photography Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Best for high contrast scenes (backlit subjects, sunsets)\n• Keep camera steady during capture\n• Processing takes longer than regular photos\n• Not ideal for moving subjects",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
