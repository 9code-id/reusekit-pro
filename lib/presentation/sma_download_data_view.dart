import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaDownloadDataView extends StatefulWidget {
  const SmaDownloadDataView({super.key});

  @override
  State<SmaDownloadDataView> createState() => _SmaDownloadDataViewState();
}

class _SmaDownloadDataViewState extends State<SmaDownloadDataView> {
  List<String> selectedDataTypes = [];
  String emailAddress = "";
  bool includeMedia = true;
  bool includeComments = true;
  bool includePrivateMessages = false;
  String selectedFormat = "JSON";
  String selectedDateRange = "All Time";

  List<Map<String, dynamic>> dataTypes = [
    {
      "id": "profile",
      "title": "Profile Information",
      "description": "Your basic profile data, bio, and settings",
      "icon": Icons.person,
      "size": "2.5 MB",
      "required": true,
    },
    {
      "id": "posts",
      "title": "Posts & Content",
      "description": "All your posts, captions, and shared content",
      "icon": Icons.article,
      "size": "45.2 MB",
      "required": false,
    },
    {
      "id": "connections",
      "title": "Connections & Followers",
      "description": "Your friends, followers, and following lists",
      "icon": Icons.people,
      "size": "8.7 MB",
      "required": false,
    },
    {
      "id": "activity",
      "title": "Activity History",
      "description": "Likes, comments, shares, and interaction history",
      "icon": Icons.history,
      "size": "15.3 MB",
      "required": false,
    },
    {
      "id": "messages",
      "title": "Messages & Conversations",
      "description": "Your message history and conversations",
      "icon": Icons.message,
      "size": "32.1 MB",
      "required": false,
    },
    {
      "id": "media",
      "title": "Photos & Videos",
      "description": "All uploaded images and video files",
      "icon": Icons.photo_library,
      "size": "234.8 MB",
      "required": false,
    },
  ];

  List<String> formats = ["JSON", "CSV", "XML"];
  List<String> dateRanges = ["All Time", "Last Year", "Last 6 Months", "Last 3 Months", "Last Month"];

  List<Map<String, dynamic>> downloadHistory = [
    {
      "date": "2024-11-15",
      "status": "Completed",
      "format": "JSON",
      "size": "156.2 MB",
      "types": ["Profile", "Posts", "Connections"],
    },
    {
      "date": "2024-10-22",
      "status": "Completed",
      "format": "CSV",
      "size": "89.5 MB",
      "types": ["Activity", "Messages"],
    },
    {
      "date": "2024-09-08",
      "status": "Expired",
      "format": "JSON",
      "size": "201.3 MB",
      "types": ["All Data"],
    },
  ];

  void _toggleDataType(String typeId) {
    Map<String, dynamic> dataType = dataTypes.firstWhere((type) => type["id"] == typeId);
    
    if (dataType["required"] == true) return;
    
    if (selectedDataTypes.contains(typeId)) {
      selectedDataTypes.remove(typeId);
    } else {
      selectedDataTypes.add(typeId);
    }
    setState(() {});
  }

  double _calculateTotalSize() {
    double total = 0;
    for (var type in dataTypes) {
      if (type["required"] == true || selectedDataTypes.contains(type["id"])) {
        String sizeStr = type["size"];
        double size = double.parse(sizeStr.split(" ")[0]);
        total += size;
      }
    }
    if (includeMedia) total += 50.5; // Additional media processing
    if (includeComments) total += 12.3; // Comments from others
    return total;
  }

  void _requestDownload() async {
    if (emailAddress.isEmpty) {
      se("Please enter your email address");
      return;
    }

    if (selectedDataTypes.isEmpty) {
      se("Please select at least one data type");
      return;
    }

    bool isConfirmed = await confirm("Request data download? You'll receive an email when your data is ready (usually within 24-48 hours).");
    if (isConfirmed) {
      ss("Data download request submitted successfully. You'll receive an email notification when ready.");
    }
  }

  @override
  void initState() {
    super.initState();
    // Pre-select profile (required)
    selectedDataTypes.add("profile");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Your Data"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Introduction
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.download, color: infoColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Download Your Data",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Get a copy of your data to keep for your records or transfer to another service. Your download will be available for 7 days after processing.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Email Address
            QTextField(
              label: "Email Address",
              value: emailAddress,
              hint: "We'll send download link to this email",
              validator: Validator.email,
              onChanged: (value) {
                emailAddress = value;
                setState(() {});
              },
            ),

            // Data Types Selection
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Select Data Types",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...dataTypes.map((type) {
                    bool isSelected = selectedDataTypes.contains(type["id"]);
                    bool isRequired = type["required"] == true;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: isRequired ? null : () => _toggleDataType(type["id"]),
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: (isSelected || isRequired) ? primaryColor : Colors.transparent,
                                    border: Border.all(
                                      color: (isSelected || isRequired) ? primaryColor : disabledColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: (isSelected || isRequired)
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                ),
                                SizedBox(width: spMd),
                                Icon(
                                  type["icon"],
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${type["title"]}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (isRequired) ...[
                                            SizedBox(width: spSm),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                              decoration: BoxDecoration(
                                                color: warningColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "Required",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: warningColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "${type["description"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${type["size"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Additional Options
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Additional Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    // Include Media
                    QSwitch(
                      items: [
                        {
                          "label": "Include high-resolution media files",
                          "value": true,
                          "checked": includeMedia,
                        }
                      ],
                      value: [if (includeMedia) {"label": "Include high-resolution media files", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        includeMedia = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    // Include Comments
                    QSwitch(
                      items: [
                        {
                          "label": "Include comments from others on your posts",
                          "value": true,
                          "checked": includeComments,
                        }
                      ],
                      value: [if (includeComments) {"label": "Include comments from others on your posts", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        includeComments = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    // Include Private Messages
                    QSwitch(
                      items: [
                        {
                          "label": "Include private/deleted messages",
                          "value": true,
                          "checked": includePrivateMessages,
                        }
                      ],
                      value: [if (includePrivateMessages) {"label": "Include private/deleted messages", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        includePrivateMessages = values.isNotEmpty;
                        setState(() {});
                      },
                    ),

                    // Format Selection
                    QDropdownField(
                      label: "Download Format",
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

                    // Date Range Selection
                    QDropdownField(
                      label: "Date Range",
                      items: dateRanges.map((range) => {
                        "label": range,
                        "value": range,
                      }).toList(),
                      value: selectedDateRange,
                      onChanged: (value, label) {
                        selectedDateRange = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Estimated Size
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(40)),
              ),
              child: Row(
                children: [
                  Icon(Icons.storage, color: successColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "Estimated download size: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${_calculateTotalSize().toStringAsFixed(1)} MB",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),

            // Download Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Request Data Download",
                icon: Icons.download,
                size: bs.md,
                onPressed: _requestDownload,
              ),
            ),

            // Download History
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Download History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...downloadHistory.map((download) {
                    Color statusColor = download["status"] == "Completed" 
                        ? successColor 
                        : download["status"] == "Expired" 
                            ? dangerColor 
                            : warningColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      DateTime.parse(download["date"]).dMMMy,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: statusColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${download["status"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: statusColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${download["format"]} • ${download["size"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  (download["types"] as List).join(", "),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (download["status"] == "Completed")
                            QButton(
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {
                                ss("Download started");
                              },
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
