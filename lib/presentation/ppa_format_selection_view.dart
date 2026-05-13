import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaFormatSelectionView extends StatefulWidget {
  const PpaFormatSelectionView({super.key});

  @override
  State<PpaFormatSelectionView> createState() => _PpaFormatSelectionViewState();
}

class _PpaFormatSelectionViewState extends State<PpaFormatSelectionView> {
  String selectedFormat = "JPG";
  String selectedSize = "Full Size";
  bool enableMetadata = true;
  bool enableThumbnail = true;
  String orientation = "Original";

  List<Map<String, dynamic>> formatData = [
    {
      "name": "JPG",
      "description": "Standard format for photos",
      "size": "Small",
      "quality": "Good",
      "compatibility": "Universal",
      "icon": Icons.image,
      "color": Colors.blue,
      "features": ["Fast processing", "Small file size", "Universal support"],
    },
    {
      "name": "PNG",
      "description": "Lossless format with transparency",
      "size": "Large",
      "quality": "Excellent",
      "compatibility": "High",
      "icon": Icons.photo,
      "color": Colors.green,
      "features": ["Transparency support", "Lossless quality", "No compression artifacts"],
    },
    {
      "name": "TIFF",
      "description": "Professional format for archiving",
      "size": "Very Large",
      "quality": "Excellent",
      "compatibility": "Medium",
      "icon": Icons.archive,
      "color": Colors.orange,
      "features": ["Uncompressed quality", "Professional grade", "Metadata rich"],
    },
    {
      "name": "WEBP",
      "description": "Modern web-optimized format",
      "size": "Small",
      "quality": "Very Good",
      "compatibility": "Modern",
      "icon": Icons.web,
      "color": Colors.purple,
      "features": ["Web optimized", "Small size", "Good quality"],
    },
    {
      "name": "HEIF",
      "description": "High efficiency image format",
      "size": "Very Small",
      "quality": "Excellent",
      "compatibility": "Limited",
      "icon": Icons.compress,
      "color": Colors.red,
      "features": ["Ultra compression", "High quality", "Modern format"],
    },
    {
      "name": "RAW",
      "description": "Unprocessed image data",
      "size": "Huge",
      "quality": "Perfect",
      "compatibility": "Professional",
      "icon": Icons.camera_alt,
      "color": Colors.teal,
      "features": ["No processing loss", "Maximum editing flexibility", "Professional workflow"],
    },
  ];

  List<Map<String, dynamic>> sizeOptions = [
    {"label": "Full Size", "value": "Full Size"},
    {"label": "Large (1920x1080)", "value": "Large"},
    {"label": "Medium (1280x720)", "value": "Medium"},
    {"label": "Small (640x480)", "value": "Small"},
    {"label": "Thumbnail (320x240)", "value": "Thumbnail"},
  ];

  List<Map<String, dynamic>> orientationOptions = [
    {"label": "Original", "value": "Original"},
    {"label": "Landscape", "value": "Landscape"},
    {"label": "Portrait", "value": "Portrait"},
    {"label": "Square", "value": "Square"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Format Selection"),
        actions: [
          QButton(
            icon: Icons.info,
            size: bs.sm,
            onPressed: () {
              si("Choose the best format for your needs. JPG for general use, PNG for transparency, RAW for professional editing.");
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
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.format_list_bulleted,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Select your preferred image format and settings",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              spacing: spSm,
              children: formatData.map((format) {
                bool isSelected = selectedFormat == format["name"];
                return GestureDetector(
                  onTap: () {
                    selectedFormat = format["name"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [shadowMd] : [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (format["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                format["icon"],
                                color: format["color"],
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${format["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (isSelected) ...[
                                        SizedBox(width: spSm),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "SELECTED",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "${format["description"]}",
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
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormatAttribute("Size", "${format["size"]}", Icons.storage),
                            ),
                            Expanded(
                              child: _buildFormatAttribute("Quality", "${format["quality"]}", Icons.high_quality),
                            ),
                            Expanded(
                              child: _buildFormatAttribute("Support", "${format["compatibility"]}", Icons.devices),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (format["features"] as List<String>).map((feature) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: (format["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(
                                  color: (format["color"] as Color).withAlpha(50),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: format["color"],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
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
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Output Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Output Size",
                    items: sizeOptions,
                    value: selectedSize,
                    onChanged: (value, label) {
                      selectedSize = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Orientation",
                    items: orientationOptions,
                    value: orientation,
                    onChanged: (value, label) {
                      orientation = value;
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
                        Icons.tune,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Additional Options",
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
                        "label": "Include Metadata",
                        "value": true,
                        "checked": enableMetadata,
                      }
                    ],
                    value: [
                      if (enableMetadata)
                        {
                          "label": "Include Metadata",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableMetadata = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Generate Thumbnail",
                        "value": true,
                        "checked": enableThumbnail,
                      }
                    ],
                    value: [
                      if (enableThumbnail)
                        {
                          "label": "Generate Thumbnail",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableThumbnail = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Format Settings",
                onPressed: () {
                  ss("Format settings applied: $selectedFormat");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatAttribute(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
