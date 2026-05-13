import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlUpload6View extends StatefulWidget {
  @override
  State<GrlUpload6View> createState() => _GrlUpload6ViewState();
}

class _GrlUpload6ViewState extends State<GrlUpload6View> {
  String selectedFormat = "pdf";
  String selectedQuality = "high";
  String selectedSize = "original";
  bool enableWatermark = false;
  bool removeMetadata = true;
  String watermarkText = "";
  String outputName = "";
  List<String> selectedFiles = [];

  List<Map<String, dynamic>> formatItems = [
    {"label": "PDF", "value": "pdf"},
    {"label": "JPG", "value": "jpg"},
    {"label": "PNG", "value": "png"},
    {"label": "WEBP", "value": "webp"},
    {"label": "TIFF", "value": "tiff"},
  ];

  List<Map<String, dynamic>> qualityItems = [
    {"label": "Low (Fast)", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Lossless", "value": "lossless"},
  ];

  List<Map<String, dynamic>> sizeItems = [
    {"label": "Original", "value": "original"},
    {"label": "50%", "value": "50"},
    {"label": "75%", "value": "75"},
    {"label": "Custom", "value": "custom"},
  ];

  List<Map<String, dynamic>> conversionQueue = [
    {
      "name": "document.docx",
      "originalSize": "2.4 MB",
      "newSize": "1.8 MB",
      "progress": 0.75,
      "status": "converting",
      "format": "PDF",
      "eta": "2 min"
    },
    {
      "name": "image.png",
      "originalSize": "15.2 MB",
      "newSize": "3.1 MB",
      "progress": 1.0,
      "status": "completed",
      "format": "JPG",
      "eta": "0 min"
    },
    {
      "name": "presentation.pptx",
      "originalSize": "45.7 MB",
      "newSize": "12.3 MB",
      "progress": 0.35,
      "status": "converting",
      "format": "PDF",
      "eta": "8 min"
    },
    {
      "name": "video.mp4",
      "originalSize": "150.0 MB",
      "newSize": "45.2 MB",
      "progress": 0.0,
      "status": "queued",
      "format": "WEBM",
      "eta": "15 min"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Converter"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Conversion Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    successColor,
                    successColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.transform,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "File Conversion Center",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "1,247",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Files Converted",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "2.4 GB",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Space Saved",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "4",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "In Queue",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // File Selection
            Text(
              "Select Files to Convert",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            QMultiImagePicker(
              label: "Choose Files",
              value: selectedFiles,
              maxImages: 20,
              hint: "Select files for conversion",
              helper: "Supports documents, images, videos, and audio files",
              onChanged: (value) {
                selectedFiles = value;
                setState(() {});
              },
            ),

            // Conversion Settings
            Text(
              "Conversion Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QDropdownField(
                    label: "Output Format",
                    items: formatItems,
                    value: selectedFormat,
                    onChanged: (value, label) {
                      selectedFormat = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Quality",
                          items: qualityItems,
                          value: selectedQuality,
                          onChanged: (value, label) {
                            selectedQuality = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Size",
                          items: sizeItems,
                          value: selectedSize,
                          onChanged: (value, label) {
                            selectedSize = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QTextField(
                    label: "Output Name (Optional)",
                    value: outputName,
                    hint: "Leave empty for auto-generated names",
                    onChanged: (value) {
                      outputName = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Add Watermark",
                              "value": true,
                              "checked": enableWatermark,
                            }
                          ],
                          value: [
                            if (enableWatermark)
                              {
                                "label": "Add Watermark",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            enableWatermark = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  if (enableWatermark) ...[
                    QTextField(
                      label: "Watermark Text",
                      value: watermarkText,
                      hint: "Enter watermark text",
                      onChanged: (value) {
                        watermarkText = value;
                        setState(() {});
                      },
                    ),
                  ],

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Remove Metadata",
                              "value": true,
                              "checked": removeMetadata,
                            }
                          ],
                          value: [
                            if (removeMetadata)
                              {
                                "label": "Remove Metadata",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            removeMetadata = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Conversion Queue
            Text(
              "Conversion Queue",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...conversionQueue.map((item) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: _getConversionStatusColor(item["status"]).withAlpha(50),
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          _getFileTypeIcon(item["name"]),
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${item["originalSize"]} → ${item["newSize"]} (${item["format"]})",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getConversionStatusColor(item["status"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${item["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (item["status"] == "converting") ...[
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Converting... ETA: ${item["eta"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${((item["progress"] as double) * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: item["progress"] as double,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ],
                    ),
                  ] else if (item["status"] == "completed") ...[
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Conversion completed successfully",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                        ),
                        QButton(
                          label: "Download",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            )),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear Queue",
                    color: dangerColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Start Conversion",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getConversionStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "converting":
        return primaryColor;
      case "queued":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getFileTypeIcon(String filename) {
    String extension = filename.toLowerCase().split('.').last;
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'docx':
      case 'doc':
        return Icons.description;
      case 'pptx':
      case 'ppt':
        return Icons.slideshow;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'mp4':
      case 'avi':
        return Icons.video_file;
      default:
        return Icons.insert_drive_file;
    }
  }
}
