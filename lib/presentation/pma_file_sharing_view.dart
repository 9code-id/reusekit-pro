import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaFileSharingView extends StatefulWidget {
  const PmaFileSharingView({super.key});

  @override
  State<PmaFileSharingView> createState() => _PmaFileSharingViewState();
}

class _PmaFileSharingViewState extends State<PmaFileSharingView> {
  String searchQuery = "";
  String selectedFilter = "all";
  String selectedSort = "recent";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Files", "value": "all"},
    {"label": "Documents", "value": "documents"},
    {"label": "Images", "value": "images"},
    {"label": "Videos", "value": "videos"},
    {"label": "Shared by Me", "value": "shared_by_me"},
    {"label": "Shared with Me", "value": "shared_with_me"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Recent", "value": "recent"},
    {"label": "Name A-Z", "value": "name_asc"},
    {"label": "Name Z-A", "value": "name_desc"},
    {"label": "Size (Large)", "value": "size_desc"},
    {"label": "Size (Small)", "value": "size_asc"},
  ];

  List<Map<String, dynamic>> files = [
    {
      "id": "1",
      "name": "Project Requirements.pdf",
      "type": "document",
      "size": 2.5,
      "shared_by": "Sarah Johnson",
      "shared_with": ["John Doe", "Mike Wilson", "3 others"],
      "uploaded_at": "2024-01-15T10:30:00Z",
      "downloads": 12,
      "comments": 3,
      "version": "v2.1",
      "is_favorite": true,
      "permissions": ["view", "download", "comment"],
      "icon": Icons.picture_as_pdf,
      "color": 0xFFE53E3E,
    },
    {
      "id": "2",
      "name": "UI Design Mockups.fig",
      "type": "design",
      "size": 15.2,
      "shared_by": "Alex Chen",
      "shared_with": ["Design Team", "5 members"],
      "uploaded_at": "2024-01-14T14:22:00Z",
      "downloads": 8,
      "comments": 7,
      "version": "v1.5",
      "is_favorite": false,
      "permissions": ["view", "download", "edit", "comment"],
      "icon": Icons.brush,
      "color": 0xFF9F7AEA,
    },
    {
      "id": "3",
      "name": "Team Photo.jpg",
      "type": "image",
      "size": 4.7,
      "shared_by": "Emma Davis",
      "shared_with": ["All Team Members"],
      "uploaded_at": "2024-01-13T16:45:00Z",
      "downloads": 25,
      "comments": 12,
      "version": "v1.0",
      "is_favorite": true,
      "permissions": ["view", "download"],
      "icon": Icons.image,
      "color": 0xFF38A169,
    },
    {
      "id": "4",
      "name": "Sprint Planning.xlsx",
      "type": "spreadsheet",
      "size": 1.8,
      "shared_by": "David Lee",
      "shared_with": ["Project Managers", "Scrum Masters"],
      "uploaded_at": "2024-01-12T09:15:00Z",
      "downloads": 6,
      "comments": 2,
      "version": "v3.0",
      "is_favorite": false,
      "permissions": ["view", "download", "edit"],
      "icon": Icons.table_chart,
      "color": 0xFF319795,
    },
    {
      "id": "5",
      "name": "Demo Video.mp4",
      "type": "video",
      "size": 125.3,
      "shared_by": "Lisa Wang",
      "shared_with": ["Stakeholders", "Client Team"],
      "uploaded_at": "2024-01-11T11:30:00Z",
      "downloads": 18,
      "comments": 5,
      "version": "v1.2",
      "is_favorite": true,
      "permissions": ["view", "download", "comment"],
      "icon": Icons.play_circle,
      "color": 0xFFD69E2E,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Sharing"),
        actions: [
          IconButton(
            onPressed: () {
              // Add file action
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              // Upload file action
            },
            icon: Icon(Icons.cloud_upload),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildStorageInfo(),
            _buildQuickActions(),
            _buildFilesList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Quick upload action
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search files...",
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
              onPressed: () {
                // Perform search
              },
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Filter",
                items: filterOptions,
                value: selectedFilter,
                onChanged: (value, label) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Sort by",
                items: sortOptions,
                value: selectedSort,
                onChanged: (value, label) {
                  selectedSort = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStorageInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.cloud_outlined,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Storage Usage",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "148.7 GB of 500 GB used",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "29.7%",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: LinearProgressIndicator(
              value: 0.297,
              backgroundColor: disabledColor,
              valueColor: AlwaysStoppedAnimation<Color>(successColor),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            "Upload File",
            Icons.cloud_upload,
            primaryColor,
            () {
              // Upload action
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildActionCard(
            "Create Folder",
            Icons.create_new_folder,
            warningColor,
            () {
              // Create folder action
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildActionCard(
            "Share Link",
            Icons.link,
            infoColor,
            () {
              // Share link action
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: color.withAlpha(76),
            width: 1,
          ),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Recent Files",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // View all files
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        ...files.map((file) => _buildFileItem(file)),
      ],
    );
  }

  Widget _buildFileItem(Map<String, dynamic> file) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(file["color"] as int).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  file["icon"] as IconData,
                  color: Color(file["color"] as int),
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
                            "${file["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (file["is_favorite"] as bool)
                          Icon(
                            Icons.star,
                            color: warningColor,
                            size: 16,
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "${((file["size"] as double)).toStringAsFixed(1)} MB",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "•",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${file["version"]}",
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
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.download, size: 18),
                        SizedBox(width: spXs),
                        Text("Download"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.share, size: 18),
                        SizedBox(width: spXs),
                        Text("Share"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.star_border, size: 18),
                        SizedBox(width: spXs),
                        Text("Add to Favorites"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 18, color: dangerColor),
                        SizedBox(width: spXs),
                        Text("Delete", style: TextStyle(color: dangerColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 1, color: disabledColor),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Shared by ${file["shared_by"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.download,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${file["downloads"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.comment,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${file["comments"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
