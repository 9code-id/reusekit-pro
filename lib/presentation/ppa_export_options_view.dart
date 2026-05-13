import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaExportOptionsView extends StatefulWidget {
  const PpaExportOptionsView({super.key});

  @override
  State<PpaExportOptionsView> createState() => _PpaExportOptionsViewState();
}

class _PpaExportOptionsViewState extends State<PpaExportOptionsView> {
  String selectedFormat = "JPEG";
  String selectedQuality = "High";
  String selectedSize = "Original";
  String selectedDestination = "Gallery";
  bool watermarkEnabled = false;
  bool metadataPreserve = true;
  bool backgroundRemoval = false;
  String colorSpace = "sRGB";
  String compression = "Standard";
  bool batchExport = false;
  
  List<Map<String, dynamic>> exportFormats = [
    {"label": "JPEG", "value": "JPEG", "extension": ".jpg", "description": "Best for photos with many colors"},
    {"label": "PNG", "value": "PNG", "extension": ".png", "description": "Best for images with transparency"},
    {"label": "WEBP", "value": "WEBP", "extension": ".webp", "description": "Modern format with better compression"},
    {"label": "TIFF", "value": "TIFF", "extension": ".tiff", "description": "Uncompressed, highest quality"},
    {"label": "PDF", "value": "PDF", "extension": ".pdf", "description": "Document format for printing"},
    {"label": "RAW", "value": "RAW", "extension": ".raw", "description": "Unprocessed image data"},
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "Low (60%)", "value": "Low", "size": "Smaller file size"},
    {"label": "Medium (80%)", "value": "Medium", "size": "Balanced quality/size"},
    {"label": "High (95%)", "value": "High", "size": "Best quality"},
    {"label": "Maximum (100%)", "value": "Maximum", "size": "Lossless quality"},
  ];

  List<Map<String, dynamic>> sizeOptions = [
    {"label": "Original", "value": "Original", "dimensions": "4000x3000"},
    {"label": "Large", "value": "Large", "dimensions": "2048x1536"},
    {"label": "Medium", "value": "Medium", "dimensions": "1024x768"},
    {"label": "Small", "value": "Small", "dimensions": "640x480"},
    {"label": "Thumbnail", "value": "Thumbnail", "dimensions": "200x150"},
    {"label": "Custom", "value": "Custom", "dimensions": "Set manually"},
  ];

  List<Map<String, dynamic>> destinations = [
    {"label": "Gallery", "value": "Gallery", "icon": Icons.photo_library},
    {"label": "Downloads", "value": "Downloads", "icon": Icons.download},
    {"label": "Cloud Storage", "value": "Cloud", "icon": Icons.cloud_upload},
    {"label": "Share", "value": "Share", "icon": Icons.share},
    {"label": "Email", "value": "Email", "icon": Icons.email},
    {"label": "Social Media", "value": "Social", "icon": Icons.share},
  ];

  List<Map<String, dynamic>> recentExports = [
    {
      "filename": "sunset_beach_edited.jpg",
      "format": "JPEG",
      "size": "2.4 MB",
      "timestamp": "2 minutes ago",
      "destination": "Gallery",
      "status": "completed",
    },
    {
      "filename": "portrait_retouched.png",
      "format": "PNG",
      "size": "8.1 MB",
      "timestamp": "15 minutes ago",
      "destination": "Cloud Storage",
      "status": "completed",
    },
    {
      "filename": "landscape_hdr.tiff",
      "format": "TIFF",
      "size": "45.2 MB",
      "timestamp": "1 hour ago",
      "destination": "Downloads",
      "status": "failed",
    },
    {
      "filename": "family_photo.webp",
      "format": "WEBP",
      "size": "1.8 MB",
      "timestamp": "2 hours ago",
      "destination": "Share",
      "status": "completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Options"),
        actions: [
          QButton(
            icon: Icons.help_outline,
            size: bs.sm,
            onPressed: () => _showExportGuide(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            _buildFormatSection(),
            _buildQualitySection(),
            _buildSizeSection(),
            _buildAdvancedOptions(),
            _buildDestinationSection(),
            _buildExportButton(),
            _buildRecentExports(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.photo, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Export Format",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Choose the file format for your exported image",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spXs,
            children: exportFormats.map((format) {
              bool isSelected = selectedFormat == format["value"];
              return GestureDetector(
                onTap: () {
                  selectedFormat = format["value"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? primaryColor : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? primaryColor : Colors.grey[400]!,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Icon(Icons.check, size: 10, color: Colors.white)
                            : null,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${format["label"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? primaryColor : Colors.black,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${format["extension"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
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
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQualitySection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.high_quality, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Quality Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Adjust compression level and file size",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            spacing: spSm,
            children: qualityOptions.map((quality) {
              bool isSelected = selectedQuality == quality["value"];
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedQuality = quality["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.grey[300]!,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${quality["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${quality["size"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.photo_size_select_large, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Output Size",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Select image dimensions for export",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: sizeOptions.map((size) {
              bool isSelected = selectedSize == size["value"];
              return GestureDetector(
                onTap: () {
                  selectedSize = size["value"];
                  setState(() {});
                  if (size["value"] == "Custom") {
                    _showCustomSizeDialog();
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${size["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? primaryColor : Colors.black,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${size["dimensions"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
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

  Widget _buildAdvancedOptions() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.tune, color: primaryColor, size: 20),
              SizedBox(width: spXs),
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
          _buildSwitchOption(
            "Add Watermark",
            "Include your signature or logo",
            watermarkEnabled,
            (value) {
              watermarkEnabled = value;
              setState(() {});
            },
          ),
          _buildSwitchOption(
            "Preserve Metadata",
            "Keep EXIF data and camera settings",
            metadataPreserve,
            (value) {
              metadataPreserve = value;
              setState(() {});
            },
          ),
          _buildSwitchOption(
            "Remove Background",
            "Auto-remove background for PNG export",
            backgroundRemoval,
            (value) {
              backgroundRemoval = value;
              setState(() {});
            },
          ),
          _buildSwitchOption(
            "Batch Export",
            "Export multiple images with same settings",
            batchExport,
            (value) {
              batchExport = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Color Space",
                  items: [
                    {"label": "sRGB", "value": "sRGB"},
                    {"label": "Adobe RGB", "value": "Adobe RGB"},
                    {"label": "ProPhoto RGB", "value": "ProPhoto RGB"},
                    {"label": "CMYK", "value": "CMYK"},
                  ],
                  value: colorSpace,
                  onChanged: (value, label) {
                    colorSpace = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Compression",
                  items: [
                    {"label": "None", "value": "None"},
                    {"label": "LZW", "value": "LZW"},
                    {"label": "Standard", "value": "Standard"},
                    {"label": "Maximum", "value": "Maximum"},
                  ],
                  value: compression,
                  onChanged: (value, label) {
                    compression = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchOption(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: primaryColor,
        ),
      ],
    );
  }

  Widget _buildDestinationSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.save_alt, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Save Destination",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Choose where to save your exported image",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: destinations.map((dest) {
              bool isSelected = selectedDestination == dest["value"];
              return GestureDetector(
                onTap: () {
                  selectedDestination = dest["value"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey[300]!,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        dest["icon"],
                        size: 24,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${dest["label"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black,
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

  Widget _buildExportButton() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Export Image",
            size: bs.md,
            onPressed: () => _startExport(),
          ),
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Preview",
                size: bs.sm,
                onPressed: () => _showPreview(),
              ),
            ),
            Expanded(
              child: QButton(
                label: "Save Settings",
                size: bs.sm,
                onPressed: () => _saveExportSettings(),
              ),
            ),
          ],
        ),
        Text(
          "Estimated file size: 2.4 MB",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentExports() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.history, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Recent Exports",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _showAllExports(),
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: recentExports.take(3).map((export) {
              Color statusColor = export["status"] == "completed" 
                  ? successColor 
                  : export["status"] == "failed" 
                      ? dangerColor 
                      : warningColor;

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(width: 3, color: statusColor),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.image,
                        size: 20,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${export["filename"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${export["format"]} • ${export["size"]} • ${export["timestamp"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${export["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (export["status"] == "completed")
                          GestureDetector(
                            onTap: () => _shareExport(export),
                            child: Icon(
                              Icons.share,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showExportGuide() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Export Guide"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📷 JPEG: Best for photos, smaller file size"),
            SizedBox(height: spXs),
            Text("🖼️ PNG: Best for graphics with transparency"),
            SizedBox(height: spXs),
            Text("🚀 WEBP: Modern format, best compression"),
            SizedBox(height: spXs),
            Text("📄 TIFF: Uncompressed, highest quality"),
            SizedBox(height: spXs),
            Text("📋 PDF: For documents and printing"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Got it"),
          ),
        ],
      ),
    );
  }

  void _showCustomSizeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Custom Size"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QNumberField(
              label: "Width (px)",
              value: "4000",
              onChanged: (value) {},
            ),
            SizedBox(height: spSm),
            QNumberField(
              label: "Height (px)",
              value: "3000",
              onChanged: (value) {},
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                Text("Maintain aspect ratio"),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }

  void _startExport() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Image exported successfully!");
  }

  void _showPreview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            Text(
              "Export Preview",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 80, color: disabledBoldColor),
                      SizedBox(height: spSm),
                      Text("Preview of exported image"),
                      Text("$selectedFormat • $selectedQuality • $selectedSize"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Close Preview",
              size: bs.md,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _saveExportSettings() {
    ss("Export settings saved as template");
  }

  void _showAllExports() {
    // Navigate to export history view
    si("Opening export history...");
  }

  void _shareExport(Map<String, dynamic> export) {
    si("Sharing ${export["filename"]}...");
  }
}
