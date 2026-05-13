import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlUpload4View extends StatefulWidget {
  @override
  State<GrlUpload4View> createState() => _GrlUpload4ViewState();
}

class _GrlUpload4ViewState extends State<GrlUpload4View> {
  String selectedCategory = "documents";
  List<String> uploadedFiles = [];
  String uploadDescription = "";
  bool isPrivate = false;
  bool enableNotifications = true;
  String compressionLevel = "medium";
  int currentStep = 0;

  List<Map<String, dynamic>> categoryItems = [
    {"label": "Documents", "value": "documents"},
    {"label": "Images", "value": "images"},
    {"label": "Videos", "value": "videos"},
    {"label": "Audio", "value": "audio"},
    {"label": "Archive", "value": "archive"},
  ];

  List<Map<String, dynamic>> compressionItems = [
    {"label": "None", "value": "none"},
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
  ];

  List<Map<String, dynamic>> uploadQueue = [
    {
      "name": "presentation.pptx",
      "size": "12.5 MB",
      "progress": 0.85,
      "status": "uploading",
      "type": "document"
    },
    {
      "name": "budget_report.xlsx",
      "size": "2.1 MB",
      "progress": 1.0,
      "status": "completed",
      "type": "document"
    },
    {
      "name": "team_photo.jpg",
      "size": "4.8 MB",
      "progress": 0.45,
      "status": "uploading",
      "type": "image"
    },
    {
      "name": "backup.zip",
      "size": "156.7 MB",
      "progress": 0.0,
      "status": "queued",
      "type": "archive"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-File Upload"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
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
            // Upload Progress Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Upload Center",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "2 of 4 files",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                  Text(
                    "Overall progress: 60% complete",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // File Selection
            Text(
              "Select Files",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            QMultiImagePicker(
              label: "Choose Files",
              value: uploadedFiles,
              maxImages: 10,
              hint: "Select up to 10 files to upload",
              helper: "Supports images, documents, videos, and archives",
              onChanged: (value) {
                uploadedFiles = value;
                setState(() {});
              },
            ),

            // Upload Settings
            Text(
              "Upload Settings",
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
                    label: "Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Compression Level",
                    items: compressionItems,
                    value: compressionLevel,
                    onChanged: (value, label) {
                      compressionLevel = value;
                      setState(() {});
                    },
                  ),

                  QMemoField(
                    label: "Description",
                    value: uploadDescription,
                    hint: "Add description for these files (optional)",
                    onChanged: (value) {
                      uploadDescription = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Private Upload",
                              "value": true,
                              "checked": isPrivate,
                            }
                          ],
                          value: [
                            if (isPrivate)
                              {
                                "label": "Private Upload",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isPrivate = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Upload Notifications",
                              "value": true,
                              "checked": enableNotifications,
                            }
                          ],
                          value: [
                            if (enableNotifications)
                              {
                                "label": "Upload Notifications",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            enableNotifications = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Upload Queue
            Text(
              "Upload Queue",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...uploadQueue.map((file) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: _getStatusColor(file["status"]).withAlpha(50),
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
                          color: _getTypeColor(file["type"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          _getTypeIcon(file["type"]),
                          color: _getTypeColor(file["type"]),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${file["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${file["size"]}",
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
                          color: _getStatusColor(file["status"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${file["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (file["status"] == "uploading") ...[
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Uploading...",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${((file["progress"] as double) * 100).toInt()}%",
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
                          value: file["progress"] as double,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
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
                    label: "Pause All",
                    color: warningColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Start Upload",
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "uploading":
        return primaryColor;
      case "queued":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "document":
        return primaryColor;
      case "image":
        return successColor;
      case "video":
        return dangerColor;
      case "archive":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "document":
        return Icons.description;
      case "image":
        return Icons.image;
      case "video":
        return Icons.videocam;
      case "archive":
        return Icons.archive;
      default:
        return Icons.insert_drive_file;
    }
  }
}
