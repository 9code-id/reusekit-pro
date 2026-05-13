import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExport3View extends StatefulWidget {
  @override
  State<GrlExport3View> createState() => _GrlExport3ViewState();
}

class _GrlExport3ViewState extends State<GrlExport3View> {
  String selectedFormat = "PDF";
  String selectedQuality = "High";
  String selectedDestination = "Local Storage";
  bool includeMetadata = true;
  bool compressFiles = false;
  bool passwordProtected = false;
  String password = "";
  
  final List<Map<String, dynamic>> exportItems = [
    {
      "name": "Annual Report 2024",
      "type": "Document",
      "size": "2.4 MB",
      "pages": 45,
      "selected": true,
      "thumbnail": "https://picsum.photos/100/100?random=1&keyword=report",
    },
    {
      "name": "Financial Charts",
      "type": "Spreadsheet",
      "size": "890 KB",
      "sheets": 12,
      "selected": true,
      "thumbnail": "https://picsum.photos/100/100?random=2&keyword=chart",
    },
    {
      "name": "Product Presentation",
      "type": "Slides",
      "size": "15.7 MB",
      "slides": 28,
      "selected": false,
      "thumbnail": "https://picsum.photos/100/100?random=3&keyword=presentation",
    },
    {
      "name": "Team Photos",
      "type": "Images",
      "size": "125 MB",
      "images": 89,
      "selected": true,
      "thumbnail": "https://picsum.photos/100/100?random=4&keyword=photos",
    },
    {
      "name": "Project Videos",
      "type": "Videos",
      "size": "1.2 GB",
      "videos": 15,
      "selected": false,
      "thumbnail": "https://picsum.photos/100/100?random=5&keyword=videos",
    },
  ];

  final List<String> formats = ["PDF", "DOCX", "XLSX", "PPTX", "ZIP", "PNG", "JPEG"];
  final List<String> qualities = ["Low", "Medium", "High", "Ultra"];
  final List<String> destinations = ["Local Storage", "Google Drive", "OneDrive", "Dropbox"];

  List<Map<String, dynamic>> get selectedItems {
    return exportItems.where((item) => item["selected"] as bool).toList();
  }

  double get totalSize {
    double total = 0;
    for (var item in selectedItems) {
      String sizeStr = item["size"] as String;
      if (sizeStr.contains("GB")) {
        total += (double.tryParse(sizeStr.replaceAll(" GB", "")) ?? 0) * 1024;
      } else if (sizeStr.contains("MB")) {
        total += (double.tryParse(sizeStr.replaceAll(" MB", "")) ?? 0);
      } else if (sizeStr.contains("KB")) {
        total += (double.tryParse(sizeStr.replaceAll(" KB", "")) ?? 0) / 1024;
      }
    }
    return total;
  }

  void _toggleItemSelection(int index) {
    exportItems[index]["selected"] = !(exportItems[index]["selected"] as bool);
    setState(() {});
  }

  void _exportFiles() async {
    if (selectedItems.isEmpty) {
      se("Please select at least one item to export");
      return;
    }

    showLoading();
    
    // Simulate export process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    ss("Files exported successfully to $selectedDestination");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Files"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.help_outline,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Export Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(10)],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.upload,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Export Summary",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
                              "${selectedItems.length}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Items Selected",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${totalSize.toStringAsFixed(1)} MB",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Total Size",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              selectedFormat,
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Format",
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 12,
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

            SizedBox(height: spXl),

            // Items to Export
            Text(
              "Select Items to Export",
              style: TextStyle(
                color: primaryColor,
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),

            ...exportItems.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;
              bool isSelected = item["selected"] as bool;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowXs],
                  border: isSelected 
                      ? Border.all(color: primaryColor, width: 1)
                      : Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    // Checkbox
                    GestureDetector(
                      onTap: () => _toggleItemSelection(index),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(width: spMd),

                    // Thumbnail
                    Container(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${item["thumbnail"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),

                    // Item Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getTypeColor(item["type"] as String).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["type"]}",
                                  style: TextStyle(
                                    color: _getTypeColor(item["type"] as String),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${item["size"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          if (item["pages"] != null)
                            Text(
                              "${item["pages"]} pages",
                              style: TextStyle(
                                color: disabledColor,
                                fontSize: 11,
                              ),
                            )
                          else if (item["sheets"] != null)
                            Text(
                              "${item["sheets"]} sheets",
                              style: TextStyle(
                                color: disabledColor,
                                fontSize: 11,
                              ),
                            )
                          else if (item["slides"] != null)
                            Text(
                              "${item["slides"]} slides",
                              style: TextStyle(
                                color: disabledColor,
                                fontSize: 11,
                              ),
                            )
                          else if (item["images"] != null)
                            Text(
                              "${item["images"]} images",
                              style: TextStyle(
                                color: disabledColor,
                                fontSize: 11,
                              ),
                            )
                          else if (item["videos"] != null)
                            Text(
                              "${item["videos"]} videos",
                              style: TextStyle(
                                color: disabledColor,
                                fontSize: 11,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spXl),

            // Export Settings
            Text(
              "Export Settings",
              style: TextStyle(
                color: primaryColor,
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),

            // Format Selection
            QDropdownField(
              label: "Export Format",
              items: formats.map((format) => {
                "label": format,
                "value": format,
              }).toList(),
              value: selectedFormat,
              onChanged: (value, label) {
                selectedFormat = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Quality Selection
            QDropdownField(
              label: "Quality",
              items: qualities.map((quality) => {
                "label": quality,
                "value": quality,
              }).toList(),
              value: selectedQuality,
              onChanged: (value, label) {
                selectedQuality = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Destination Selection
            QDropdownField(
              label: "Save to",
              items: destinations.map((dest) => {
                "label": dest,
                "value": dest,
              }).toList(),
              value: selectedDestination,
              onChanged: (value, label) {
                selectedDestination = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Advanced Options
            Text(
              "Advanced Options",
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: spMd),

            // Include Metadata
            QSwitch(
              items: [
                {
                  "label": "Include metadata and properties",
                  "value": true,
                  "checked": includeMetadata,
                }
              ],
              value: [if (includeMetadata) {"label": "Include metadata and properties", "value": true, "checked": true}],
              onChanged: (values, ids) {
                includeMetadata = values.isNotEmpty;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            // Compress Files
            QSwitch(
              items: [
                {
                  "label": "Compress files for smaller size",
                  "value": true,
                  "checked": compressFiles,
                }
              ],
              value: [if (compressFiles) {"label": "Compress files for smaller size", "value": true, "checked": true}],
              onChanged: (values, ids) {
                compressFiles = values.isNotEmpty;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            // Password Protection
            QSwitch(
              items: [
                {
                  "label": "Password protect exported files",
                  "value": true,
                  "checked": passwordProtected,
                }
              ],
              value: [if (passwordProtected) {"label": "Password protect exported files", "value": true, "checked": true}],
              onChanged: (values, ids) {
                passwordProtected = values.isNotEmpty;
                setState(() {});
              },
            ),

            if (passwordProtected) ...[
              SizedBox(height: spMd),
              QTextField(
                label: "Password",
                value: password,
                hint: "Enter password for protection",
                obscureText: true,
                onChanged: (value) {
                  password = value;
                  setState(() {});
                },
              ),
            ],

            SizedBox(height: spXl),

            // Export Progress Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Export Information",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Large files may take several minutes to export. You'll receive a notification when complete.",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spXl),

            // Export Button
            Container(
              width: double.infinity,
              child: QButton(
                label: selectedItems.isEmpty 
                    ? "Select items to export"
                    : "Export ${selectedItems.length} item${selectedItems.length > 1 ? 's' : ''}",
                size: bs.md,
                onPressed: selectedItems.isEmpty ? null : _exportFiles,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Document":
        return Colors.blue;
      case "Spreadsheet":
        return Colors.green;
      case "Slides":
        return Colors.orange;
      case "Images":
        return Colors.purple;
      case "Videos":
        return Colors.red;
      default:
        return primaryColor;
    }
  }
}
