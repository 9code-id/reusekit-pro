import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFile2View extends StatefulWidget {
  @override
  State<GrlFile2View> createState() => _GrlFile2ViewState();
}

class _GrlFile2ViewState extends State<GrlFile2View> {
  String selectedUser = "all";
  String permissionLevel = "read";
  String shareMethod = "link";
  bool passwordProtected = false;
  bool hasExpiration = false;
  String password = "";
  DateTime? expirationDate;
  bool allowDownload = true;
  bool allowComment = false;
  bool notifyOnAccess = true;

  List<Map<String, dynamic>> userItems = [
    {"label": "All Users", "value": "all"},
    {"label": "Team Members", "value": "team"},
    {"label": "External Users", "value": "external"},
    {"label": "Specific Users", "value": "specific"},
  ];

  List<Map<String, dynamic>> permissionItems = [
    {"label": "View Only", "value": "read"},
    {"label": "Comment", "value": "comment"},
    {"label": "Edit", "value": "edit"},
    {"label": "Full Access", "value": "full"},
  ];

  List<Map<String, dynamic>> shareMethodItems = [
    {"label": "Shareable Link", "value": "link"},
    {"label": "Email Invitation", "value": "email"},
    {"label": "QR Code", "value": "qr"},
    {"label": "Embed Code", "value": "embed"},
  ];

  List<Map<String, dynamic>> sharedFiles = [
    {
      "name": "Project Proposal.pdf",
      "size": "2.4 MB",
      "sharedWith": "Marketing Team",
      "permission": "Edit",
      "accessCount": 24,
      "lastAccessed": "2 hours ago",
      "status": "active",
      "expires": "Never"
    },
    {
      "name": "Budget Report.xlsx",
      "size": "1.8 MB",
      "sharedWith": "Finance Department",
      "permission": "View Only",
      "accessCount": 12,
      "lastAccessed": "5 hours ago",
      "status": "active",
      "expires": "7 days"
    },
    {
      "name": "Design Mockups.zip",
      "size": "45.2 MB",
      "sharedWith": "john.doe@company.com",
      "permission": "Comment",
      "accessCount": 8,
      "lastAccessed": "1 day ago",
      "status": "expired",
      "expires": "Expired"
    },
    {
      "name": "Meeting Recording.mp4",
      "size": "125.7 MB",
      "sharedWith": "All Company",
      "permission": "View Only",
      "accessCount": 156,
      "lastAccessed": "3 hours ago",
      "status": "active",
      "expires": "30 days"
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "user": "Sarah Johnson",
      "action": "Downloaded",
      "file": "Project Proposal.pdf",
      "timestamp": "5 minutes ago",
      "avatar": "SJ"
    },
    {
      "user": "Mike Chen",
      "action": "Commented on",
      "file": "Design Mockups.zip",
      "timestamp": "15 minutes ago",
      "avatar": "MC"
    },
    {
      "user": "Emily Davis",
      "action": "Viewed",
      "file": "Budget Report.xlsx",
      "timestamp": "1 hour ago",
      "avatar": "ED"
    },
    {
      "user": "Alex Wilson",
      "action": "Shared",
      "file": "Meeting Recording.mp4",
      "timestamp": "2 hours ago",
      "avatar": "AW"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Sharing"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
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
            // Sharing Overview
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
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "File Sharing Center",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "24 ACTIVE",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "247",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Shares",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              "Total Views",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "85",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Downloads",
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

            // Share Settings
            Text(
              "Share New File",
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
                    label: "Share Method",
                    items: shareMethodItems,
                    value: shareMethod,
                    onChanged: (value, label) {
                      shareMethod = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Share With",
                          items: userItems,
                          value: selectedUser,
                          onChanged: (value, label) {
                            selectedUser = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Permission Level",
                          items: permissionItems,
                          value: permissionLevel,
                          onChanged: (value, label) {
                            permissionLevel = value;
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
                              "label": "Password Protection",
                              "value": true,
                              "checked": passwordProtected,
                            }
                          ],
                          value: [
                            if (passwordProtected)
                              {
                                "label": "Password Protection",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            passwordProtected = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  if (passwordProtected) ...[
                    QTextField(
                      label: "Share Password",
                      value: password,
                      hint: "Enter password for shared file",
                      onChanged: (value) {
                        password = value;
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
                              "label": "Set Expiration Date",
                              "value": true,
                              "checked": hasExpiration,
                            }
                          ],
                          value: [
                            if (hasExpiration)
                              {
                                "label": "Set Expiration Date",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            hasExpiration = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  if (hasExpiration) ...[
                    QDatePicker(
                      label: "Expiration Date",
                      value: expirationDate ?? DateTime.now().add(Duration(days: 7)),
                      onChanged: (value) {
                        expirationDate = value;
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
                              "label": "Allow Download",
                              "value": true,
                              "checked": allowDownload,
                            }
                          ],
                          value: [
                            if (allowDownload)
                              {
                                "label": "Allow Download",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            allowDownload = values.isNotEmpty;
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
                              "label": "Allow Comments",
                              "value": true,
                              "checked": allowComment,
                            }
                          ],
                          value: [
                            if (allowComment)
                              {
                                "label": "Allow Comments",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            allowComment = values.isNotEmpty;
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
                              "label": "Notify on Access",
                              "value": true,
                              "checked": notifyOnAccess,
                            }
                          ],
                          value: [
                            if (notifyOnAccess)
                              {
                                "label": "Notify on Access",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            notifyOnAccess = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Create Share Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Share Link",
                size: bs.md,
                onPressed: () {},
              ),
            ),

            // Shared Files
            Text(
              "Currently Shared Files",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...sharedFiles.map((file) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: _getShareStatusColor(file["status"]).withAlpha(50),
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
                          color: _getShareStatusColor(file["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.share,
                          color: _getShareStatusColor(file["status"]),
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
                              "${file["size"]} • Shared with ${file["sharedWith"]}",
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
                          color: _getShareStatusColor(file["status"]),
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
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Permission: ${file["permission"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "Expires: ${file["expires"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${file["accessCount"]} views",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "Last accessed: ${file["lastAccessed"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Copy Link",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Settings",
                          color: secondaryColor,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Revoke",
                          color: dangerColor,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),

            // Recent Activity
            Text(
              "Recent Activity",
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
                children: recentActivity.map((activity) => Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: primaryColor,
                      child: Text(
                        "${activity["avatar"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "${activity["user"]} ",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                TextSpan(text: "${activity["action"]} "),
                                TextSpan(
                                  text: "${activity["file"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${activity["timestamp"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getShareStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "expired":
        return dangerColor;
      case "revoked":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
