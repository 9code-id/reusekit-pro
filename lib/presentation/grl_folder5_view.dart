import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFolder5View extends StatefulWidget {
  @override
  State<GrlFolder5View> createState() => _GrlFolder5ViewState();
}

class _GrlFolder5ViewState extends State<GrlFolder5View> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool showDetails = false;

  List<Map<String, dynamic>> recentFiles = [
    {
      "id": 1,
      "name": "quarterly_report.pdf",
      "type": "PDF",
      "size": "2.4 MB",
      "lastAccessed": "5 minutes ago",
      "path": "/Documents/Reports/",
      "thumbnail": "https://picsum.photos/80/80?random=1&keyword=document",
      "isStarred": true,
    },
    {
      "id": 2,
      "name": "team_meeting_notes.docx",
      "type": "DOCX",
      "size": "156 KB",
      "lastAccessed": "1 hour ago",
      "path": "/Documents/Meetings/",
      "thumbnail": "https://picsum.photos/80/80?random=2&keyword=notes",
      "isStarred": false,
    },
    {
      "id": 3,
      "name": "project_timeline.xlsx",
      "type": "XLSX",
      "size": "890 KB",
      "lastAccessed": "3 hours ago",
      "path": "/Documents/Projects/",
      "thumbnail": "https://picsum.photos/80/80?random=3&keyword=spreadsheet",
      "isStarred": true,
    },
    {
      "id": 4,
      "name": "vacation_photos.zip",
      "type": "ZIP",
      "size": "45.2 MB",
      "lastAccessed": "1 day ago",
      "path": "/Downloads/",
      "thumbnail": "https://picsum.photos/80/80?random=4&keyword=photos",
      "isStarred": false,
    },
    {
      "id": 5,
      "name": "presentation_template.pptx",
      "type": "PPTX",
      "size": "3.1 MB",
      "lastAccessed": "2 days ago",
      "path": "/Documents/Templates/",
      "thumbnail": "https://picsum.photos/80/80?random=5&keyword=presentation",
      "isStarred": true,
    },
  ];

  List<Map<String, dynamic>> starredFiles = [
    {
      "id": 1,
      "name": "Important_Contract.pdf",
      "type": "PDF",
      "size": "1.2 MB",
      "lastModified": "1 week ago",
      "path": "/Documents/Legal/",
    },
    {
      "id": 2,
      "name": "Budget_2024.xlsx",
      "type": "XLSX",
      "size": "567 KB",
      "lastModified": "3 days ago",
      "path": "/Documents/Finance/",
    },
    {
      "id": 3,
      "name": "Client_Presentation.pptx",
      "type": "PPTX",
      "size": "8.9 MB",
      "lastModified": "5 days ago",
      "path": "/Documents/Presentations/",
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Images", "value": "Images"},
    {"label": "Spreadsheets", "value": "Spreadsheets"},
    {"label": "Presentations", "value": "Presentations"},
  ];

  Color getFileTypeColor(String type) {
    switch (type.toUpperCase()) {
      case 'PDF':
        return dangerColor;
      case 'DOCX':
        case 'DOC':
        return primaryColor;
      case 'XLSX':
      case 'XLS':
        return successColor;
      case 'PPTX':
      case 'PPT':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData getFileTypeIcon(String type) {
    switch (type.toUpperCase()) {
      case 'PDF':
        return Icons.picture_as_pdf;
      case 'DOCX':
      case 'DOC':
        return Icons.description;
      case 'XLSX':
      case 'XLS':
        return Icons.table_chart;
      case 'PPTX':
      case 'PPT':
        return Icons.slideshow;
      case 'ZIP':
        return Icons.archive;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Files"),
        actions: [
          IconButton(
            icon: Icon(showDetails ? Icons.view_list : Icons.view_module),
            onPressed: () {
              showDetails = !showDetails;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
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
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search recent files",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Dropdown
            QDropdownField(
              label: "Filter by type",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Icon(Icons.access_time, color: primaryColor, size: 20),
                        Text(
                          "24",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Files Today",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Icon(Icons.star, color: successColor, size: 20),
                        Text(
                          "${starredFiles.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Starred",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Recent Files Section
            Text(
              "Recently Accessed",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...recentFiles.map((file) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    // File Thumbnail/Icon
                    if (showDetails)
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${file["thumbnail"]}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: getFileTypeColor("${file["type"]}").withAlpha(30),
                                child: Icon(
                                  getFileTypeIcon("${file["type"]}"),
                                  color: getFileTypeColor("${file["type"]}"),
                                  size: 24,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    else
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: getFileTypeColor("${file["type"]}").withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          getFileTypeIcon("${file["type"]}"),
                          color: getFileTypeColor("${file["type"]}"),
                          size: 20,
                        ),
                      ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${file["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              if (file["isStarred"] == true)
                                Icon(Icons.star, color: warningColor, size: 16),
                            ],
                          ),
                          if (showDetails) ...[
                            Text(
                              "${file["path"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${file["type"]} • ${file["size"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${file["lastAccessed"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ] else
                            Row(
                              children: [
                                Text(
                                  "${file["type"]} • ${file["size"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${file["lastAccessed"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            }).toList(),

            // Starred Files Section
            Text(
              "Starred Files",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...starredFiles.map((file) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: getFileTypeColor("${file["type"]}").withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        getFileTypeIcon("${file["type"]}"),
                        color: getFileTypeColor("${file["type"]}"),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${file["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Icon(Icons.star, color: warningColor, size: 16),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${file["type"]} • ${file["size"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${file["lastModified"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            }).toList(),

            // Clear Recent Files Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Clear Recent Files",
                icon: Icons.clear_all,
                size: bs.sm,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
