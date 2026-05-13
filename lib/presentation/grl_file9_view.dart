import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFile9View extends StatefulWidget {
  @override
  State<GrlFile9View> createState() => _GrlFile9ViewState();
}

class _GrlFile9ViewState extends State<GrlFile9View> {
  String shareLink = "https://files.myapp.com/share/abc123xyz789";
  String selectedPermission = "View Only";
  bool linkExpires = true;
  DateTime expiryDate = DateTime.now().add(Duration(days: 7));
  bool requirePassword = false;
  String sharePassword = "";
  bool allowDownload = true;
  bool allowComments = false;
  String emailMessage = "";

  List<Map<String, dynamic>> permissionItems = [
    {"label": "View Only", "value": "View Only"},
    {"label": "Comment", "value": "Comment"},
    {"label": "Edit", "value": "Edit"},
    {"label": "Full Access", "value": "Full Access"},
  ];

  List<Map<String, dynamic>> sharedFiles = [
    {
      "name": "Annual_Report_2024.pdf",
      "type": "PDF Document",
      "size": "2.4 MB",
      "sharedWith": 12,
      "views": 45,
      "downloads": 8,
      "shareDate": "2024-06-20",
      "icon": Icons.picture_as_pdf,
      "color": Colors.red,
    },
    {
      "name": "Budget_Spreadsheet.xlsx",
      "type": "Excel File",
      "size": "1.5 MB",
      "sharedWith": 8,
      "views": 23,
      "downloads": 5,
      "shareDate": "2024-06-18",
      "icon": Icons.table_chart,
      "color": Colors.green,
    },
    {
      "name": "Project_Presentation.pptx",
      "type": "PowerPoint",
      "size": "8.2 MB",
      "sharedWith": 15,
      "views": 67,
      "downloads": 12,
      "shareDate": "2024-06-15",
      "icon": Icons.slideshow,
      "color": Colors.blue,
    },
  ];

  List<Map<String, dynamic>> recentShares = [
    {
      "user": "John Doe",
      "email": "john.doe@company.com",
      "file": "Annual_Report_2024.pdf",
      "permission": "View Only",
      "date": "2024-06-22",
      "avatar": "JD",
    },
    {
      "user": "Sarah Wilson",
      "email": "sarah.wilson@company.com",
      "file": "Budget_Spreadsheet.xlsx",
      "permission": "Edit",
      "date": "2024-06-21",
      "avatar": "SW",
    },
    {
      "user": "Mike Johnson",
      "email": "mike.johnson@company.com",
      "file": "Project_Presentation.pptx",
      "permission": "Comment",
      "date": "2024-06-20",
      "avatar": "MJ",
    },
  ];

  List<String> emailList = [];
  String currentEmail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Files"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
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
            // Share Link Section
            Text(
              "Share Link",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Text(
                            shareLink,
                            style: TextStyle(
                              fontFamily: "monospace",
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Copy",
                        icon: Icons.copy,
                        size: bs.sm,
                        onPressed: () {
                          ss("Link copied to clipboard!");
                        },
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Permission",
                          items: permissionItems,
                          value: selectedPermission,
                          onChanged: (value, label) {
                            selectedPermission = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Generate New",
                          size: bs.sm,
                          onPressed: () {
                            shareLink = "https://files.myapp.com/share/${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";
                            setState(() {});
                            ss("New share link generated!");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Link Settings
            Text(
              "Link Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            QSwitch(
              items: [
                {
                  "label": "Link expires",
                  "value": true,
                  "checked": linkExpires,
                }
              ],
              value: [if (linkExpires) {"label": "Link expires", "value": true, "checked": true}],
              onChanged: (values, ids) {
                setState(() {
                  linkExpires = values.isNotEmpty;
                });
              },
            ),

            if (linkExpires)
              QDatePicker(
                label: "Expiry Date",
                value: expiryDate,
                onChanged: (value) {
                  expiryDate = value;
                  setState(() {});
                },
              ),

            QSwitch(
              items: [
                {
                  "label": "Require password",
                  "value": true,
                  "checked": requirePassword,
                }
              ],
              value: [if (requirePassword) {"label": "Require password", "value": true, "checked": true}],
              onChanged: (values, ids) {
                setState(() {
                  requirePassword = values.isNotEmpty;
                });
              },
            ),

            if (requirePassword)
              QTextField(
                label: "Share Password",
                value: sharePassword,
                hint: "Enter password for shared link",
                obscureText: true,
                onChanged: (value) {
                  sharePassword = value;
                  setState(() {});
                },
              ),

            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Allow download",
                        "value": true,
                        "checked": allowDownload,
                      }
                    ],
                    value: [if (allowDownload) {"label": "Allow download", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      setState(() {
                        allowDownload = values.isNotEmpty;
                      });
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Allow comments",
                        "value": true,
                        "checked": allowComments,
                      }
                    ],
                    value: [if (allowComments) {"label": "Allow comments", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      setState(() {
                        allowComments = values.isNotEmpty;
                      });
                    },
                  ),
                ),
              ],
            ),

            // Share via Email
            Text(
              "Share via Email",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Email Address",
                    value: currentEmail,
                    hint: "Enter email address",
                    onChanged: (value) {
                      currentEmail = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Add",
                  size: bs.sm,
                  onPressed: () {
                    if (currentEmail.isNotEmpty && currentEmail.contains('@')) {
                      emailList.add(currentEmail);
                      currentEmail = "";
                      setState(() {});
                    }
                  },
                ),
              ],
            ),

            if (emailList.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: emailList.map((email) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {
                              emailList.remove(email);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

            QMemoField(
              label: "Message (Optional)",
              value: emailMessage,
              hint: "Add a message to your email...",
              onChanged: (value) {
                emailMessage = value;
                setState(() {});
              },
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: "Send Email Invitations",
                size: bs.md,
                onPressed: emailList.isEmpty ? null : () {
                  ss("Email invitations sent to ${emailList.length} recipients!");
                  emailList.clear();
                  emailMessage = "";
                  setState(() {});
                },
              ),
            ),

            // Shared Files Statistics
            Text(
              "Shared Files",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              children: sharedFiles.map((file) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: (file["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          file["icon"] as IconData,
                          color: file["color"] as Color,
                          size: 24,
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
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${file["type"]} • ${file["size"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.people, size: 14, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text("${file["sharedWith"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                SizedBox(width: spSm),
                                Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text("${file["views"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                SizedBox(width: spSm),
                                Icon(Icons.download, size: 14, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text("${file["downloads"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: disabledBoldColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Shares
            Text(
              "Recent Shares",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              children: recentShares.map((share) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 20,
                        child: Text(
                          "${share["avatar"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${share["user"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${share["file"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${share["permission"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${DateTime.parse(share["date"]).dMMMy}",
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
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: disabledBoldColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // View All Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "View All Shares",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
