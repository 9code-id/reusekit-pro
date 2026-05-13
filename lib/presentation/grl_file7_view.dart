import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFile7View extends StatefulWidget {
  @override
  State<GrlFile7View> createState() => _GrlFile7ViewState();
}

class _GrlFile7ViewState extends State<GrlFile7View> {
  String searchQuery = "";
  bool isUploading = false;
  double uploadProgress = 0.0;

  List<Map<String, dynamic>> storageStats = [
    {
      "title": "Used Storage",
      "value": "45.2 GB",
      "subtitle": "of 100 GB",
      "color": primaryColor,
      "icon": Icons.storage,
    },
    {
      "title": "Total Files",
      "value": "1,247",
      "subtitle": "files uploaded",
      "color": Colors.blue,
      "icon": Icons.file_copy,
    },
    {
      "title": "Folders",
      "value": "28",
      "subtitle": "organized",
      "color": Colors.orange,
      "icon": Icons.folder,
    },
    {
      "title": "Shared",
      "value": "156",
      "subtitle": "files shared",
      "color": Colors.green,
      "icon": Icons.share,
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "action": "Uploaded",
      "file": "Annual_Report_2024.pdf",
      "user": "John Doe",
      "time": "2 hours ago",
      "icon": Icons.upload,
      "color": Colors.green,
    },
    {
      "action": "Shared",
      "file": "Budget_Spreadsheet.xlsx",
      "user": "Sarah Wilson",
      "time": "4 hours ago",
      "icon": Icons.share,
      "color": Colors.blue,
    },
    {
      "action": "Downloaded",
      "file": "Project_Presentation.pptx",
      "user": "Mike Johnson",
      "time": "6 hours ago",
      "icon": Icons.download,
      "color": Colors.orange,
    },
    {
      "action": "Deleted",
      "file": "temp_file.txt",
      "user": "Jane Smith",
      "time": "1 day ago",
      "icon": Icons.delete,
      "color": Colors.red,
    },
    {
      "action": "Modified",
      "file": "Meeting_Notes.docx",
      "user": "Alex Brown",
      "time": "2 days ago",
      "icon": Icons.edit,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Upload Files",
      "subtitle": "Add new files",
      "icon": Icons.upload_file,
      "color": primaryColor,
    },
    {
      "title": "Create Folder",
      "subtitle": "Organize files",
      "icon": Icons.create_new_folder,
      "color": Colors.orange,
    },
    {
      "title": "Scan Document",
      "subtitle": "Camera to PDF",
      "icon": Icons.document_scanner,
      "color": Colors.blue,
    },
    {
      "title": "Share Link",
      "subtitle": "Generate link",
      "icon": Icons.link,
      "color": Colors.green,
    },
  ];

  List<Map<String, dynamic>> fileTypes = [
    {
      "type": "Documents",
      "count": 245,
      "size": "12.4 GB",
      "icon": Icons.description,
      "color": Colors.blue,
    },
    {
      "type": "Images",
      "count": 892,
      "size": "18.7 GB",
      "icon": Icons.image,
      "color": Colors.green,
    },
    {
      "type": "Videos",
      "count": 34,
      "size": "8.9 GB",
      "icon": Icons.video_file,
      "color": Colors.red,
    },
    {
      "type": "Audio",
      "count": 76,
      "size": "2.1 GB",
      "icon": Icons.audio_file,
      "color": Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Manager Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
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
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    child: Icon(
                      Icons.search,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search files and folders...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: spSm),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: disabledBoldColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Upload Progress (if uploading)
            if (isUploading)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Uploading files... ${(uploadProgress * 100).toInt()}%",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: primaryColor),
                          onPressed: () {
                            isUploading = false;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: uploadProgress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
              ),

            // Storage Stats
            Text(
              "Storage Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            ResponsiveGridView(
              minItemWidth: 200,
              children: storageStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.more_vert,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: stat["color"] as Color,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${stat["subtitle"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            QHorizontalScroll(
              children: quickActions.map((action) {
                return Container(
                  width: 140,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (action["title"] == "Upload Files") {
                        isUploading = true;
                        uploadProgress = 0.0;
                        setState(() {});
                        
                        // Simulate upload progress
                        Future.delayed(Duration(milliseconds: 100), () {
                          _simulateUpload();
                        });
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            action["icon"] as IconData,
                            color: action["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${action["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${action["subtitle"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // File Types Breakdown
            Text(
              "File Types",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              children: fileTypes.map((fileType) {
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
                          color: (fileType["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          fileType["icon"] as IconData,
                          color: fileType["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${fileType["type"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${fileType["count"]} files • ${fileType["size"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Activity
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              children: recentActivity.map((activity) {
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
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (activity["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          activity["icon"] as IconData,
                          color: activity["color"] as Color,
                          size: 20,
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
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${activity["user"]} ",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(text: "${activity["action"].toString().toLowerCase()} "),
                                  TextSpan(
                                    text: "${activity["file"]}",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${activity["time"]}",
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
                );
              }).toList(),
            ),

            // View All Activity Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "View All Activity",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isUploading = true;
          uploadProgress = 0.0;
          setState(() {});
          _simulateUpload();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _simulateUpload() {
    if (uploadProgress < 1.0) {
      Future.delayed(Duration(milliseconds: 200), () {
        uploadProgress += 0.1;
        if (uploadProgress > 1.0) uploadProgress = 1.0;
        setState(() {});
        
        if (uploadProgress < 1.0) {
          _simulateUpload();
        } else {
          Future.delayed(Duration(seconds: 1), () {
            isUploading = false;
            setState(() {});
          });
        }
      });
    }
  }
}
