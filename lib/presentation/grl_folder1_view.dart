import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFolder1View extends StatefulWidget {
  @override
  State<GrlFolder1View> createState() => _GrlFolder1ViewState();
}

class _GrlFolder1ViewState extends State<GrlFolder1View> {
  String folderName = "";
  String description = "";
  String selectedColor = "Blue";
  String accessLevel = "Private";
  bool enableSync = true;
  bool enableNotifications = false;
  String selectedTemplate = "General";

  List<Map<String, dynamic>> colorItems = [
    {"label": "Blue", "value": "Blue"},
    {"label": "Green", "value": "Green"},
    {"label": "Red", "value": "Red"},
    {"label": "Orange", "value": "Orange"},
    {"label": "Purple", "value": "Purple"},
    {"label": "Teal", "value": "Teal"},
  ];

  List<Map<String, dynamic>> accessItems = [
    {"label": "Private", "value": "Private"},
    {"label": "Team", "value": "Team"},
    {"label": "Company", "value": "Company"},
    {"label": "Public", "value": "Public"},
  ];

  List<Map<String, dynamic>> templateItems = [
    {"label": "General", "value": "General"},
    {"label": "Project", "value": "Project"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Media", "value": "Media"},
    {"label": "Archive", "value": "Archive"},
  ];

  Map<String, Color> colorMap = {
    "Blue": Colors.blue,
    "Green": Colors.green,
    "Red": Colors.red,
    "Orange": Colors.orange,
    "Purple": Colors.purple,
    "Teal": Colors.teal,
  };

  List<Map<String, dynamic>> folderTemplates = [
    {
      "name": "General",
      "description": "Basic folder for any type of files",
      "icon": Icons.folder,
      "features": ["Basic organization", "Standard permissions"],
    },
    {
      "name": "Project",
      "description": "Folder with project management features",
      "icon": Icons.work,
      "features": ["Task tracking", "Timeline view", "Team collaboration"],
    },
    {
      "name": "Documents",
      "description": "Optimized for document storage and editing",
      "icon": Icons.description,
      "features": ["Version control", "Document templates", "Review workflow"],
    },
    {
      "name": "Media",
      "description": "For photos, videos, and other media files",
      "icon": Icons.perm_media,
      "features": ["Preview gallery", "Metadata indexing", "Auto organization"],
    },
    {
      "name": "Archive",
      "description": "Long-term storage with compression",
      "icon": Icons.archive,
      "features": ["Automatic compression", "Cold storage", "Retention policies"],
    },
  ];

  List<Map<String, dynamic>> recentFolders = [
    {
      "name": "Marketing Assets",
      "files": 45,
      "size": "2.4 GB",
      "color": Colors.blue,
      "lastModified": "2024-06-22",
      "shared": true,
    },
    {
      "name": "Development Docs",
      "files": 128,
      "size": "890 MB",
      "color": Colors.green,
      "lastModified": "2024-06-21",
      "shared": false,
    },
    {
      "name": "Client Projects",
      "files": 67,
      "size": "1.8 GB",
      "color": Colors.orange,
      "lastModified": "2024-06-20",
      "shared": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Folder"),
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
            // Folder Preview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: (colorMap[selectedColor] ?? Colors.blue).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: (colorMap[selectedColor] ?? Colors.blue).withAlpha(50),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.folder,
                    size: 64,
                    color: colorMap[selectedColor] ?? Colors.blue,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    folderName.isEmpty ? "New Folder" : folderName,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: colorMap[selectedColor] ?? Colors.blue,
                    ),
                  ),
                  if (description.isNotEmpty) ...[
                    SizedBox(height: spXs),
                    Text(
                      description,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: (colorMap[selectedColor] ?? Colors.blue).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          accessLevel,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorMap[selectedColor] ?? Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: (colorMap[selectedColor] ?? Colors.blue).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          selectedTemplate,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorMap[selectedColor] ?? Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Basic Information
            Text(
              "Basic Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            QTextField(
              label: "Folder Name",
              value: folderName,
              hint: "Enter folder name",
              onChanged: (value) {
                folderName = value;
                setState(() {});
              },
            ),

            QMemoField(
              label: "Description",
              value: description,
              hint: "Add folder description...",
              onChanged: (value) {
                description = value;
                setState(() {});
              },
            ),

            // Folder Settings
            Text(
              "Folder Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Folder Color",
                    items: colorItems,
                    value: selectedColor,
                    onChanged: (value, label) {
                      selectedColor = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Access Level",
                    items: accessItems,
                    value: accessLevel,
                    onChanged: (value, label) {
                      accessLevel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Folder Template",
              items: templateItems,
              value: selectedTemplate,
              onChanged: (value, label) {
                selectedTemplate = value;
                setState(() {});
              },
            ),

            QSwitch(
              items: [
                {
                  "label": "Enable cloud sync",
                  "value": true,
                  "checked": enableSync,
                }
              ],
              value: [if (enableSync) {"label": "Enable cloud sync", "value": true, "checked": true}],
              onChanged: (values, ids) {
                setState(() {
                  enableSync = values.isNotEmpty;
                });
              },
            ),

            QSwitch(
              items: [
                {
                  "label": "Enable notifications for changes",
                  "value": true,
                  "checked": enableNotifications,
                }
              ],
              value: [if (enableNotifications) {"label": "Enable notifications for changes", "value": true, "checked": true}],
              onChanged: (values, ids) {
                setState(() {
                  enableNotifications = values.isNotEmpty;
                });
              },
            ),

            // Template Features
            if (selectedTemplate != "General") ...[
              Text(
                "Template Features",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          folderTemplates.firstWhere((t) => t["name"] == selectedTemplate)["icon"] as IconData,
                          color: colorMap[selectedColor] ?? Colors.blue,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedTemplate,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                folderTemplates.firstWhere((t) => t["name"] == selectedTemplate)["description"] as String,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Included Features:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(folderTemplates.firstWhere((t) => t["name"] == selectedTemplate)["features"] as List<String>).map((feature) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              feature,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],

            // Recent Folders
            Text(
              "Recent Folders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              children: recentFolders.map((folder) {
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
                          color: (folder["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.folder,
                          color: folder["color"] as Color,
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
                                Expanded(
                                  child: Text(
                                    "${folder["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                if (folder["shared"] as bool)
                                  Icon(
                                    Icons.people,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${folder["files"]} files • ${folder["size"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Modified ${DateTime.parse(folder["lastModified"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
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

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.md,
                    onPressed: () {
                      back();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Create Folder",
                    size: bs.md,
                    onPressed: () {
                      if (folderName.isEmpty) {
                        se("Please enter a folder name");
                        return;
                      }
                      ss("Folder '${folderName}' created successfully!");
                      // back();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
