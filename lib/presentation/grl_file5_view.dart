import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFile5View extends StatefulWidget {
  @override
  State<GrlFile5View> createState() => _GrlFile5ViewState();
}

class _GrlFile5ViewState extends State<GrlFile5View> {
  String searchQuery = "";
  String selectedFilter = "All Files";
  String sortBy = "Date Modified";
  bool isGridView = false;

  List<Map<String, dynamic>> filterItems = [
    {"label": "All Files", "value": "All Files"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Images", "value": "Images"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Audio", "value": "Audio"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Date Modified", "value": "Date Modified"},
    {"label": "File Name", "value": "File Name"},
    {"label": "File Size", "value": "File Size"},
    {"label": "File Type", "value": "File Type"},
  ];

  List<Map<String, dynamic>> files = [
    {
      "name": "Annual Report 2024.pdf",
      "type": "PDF Document",
      "size": "2.4 MB",
      "modified": "2024-06-20",
      "icon": Icons.picture_as_pdf,
      "color": Colors.red,
    },
    {
      "name": "Project Images.zip",
      "type": "Archive",
      "size": "15.8 MB",
      "modified": "2024-06-19",
      "icon": Icons.archive,
      "color": Colors.orange,
    },
    {
      "name": "Presentation.pptx",
      "type": "PowerPoint",
      "size": "8.2 MB",
      "modified": "2024-06-18",
      "icon": Icons.slideshow,
      "color": Colors.blue,
    },
    {
      "name": "Budget Spreadsheet.xlsx",
      "type": "Excel File",
      "size": "1.5 MB",
      "modified": "2024-06-17",
      "icon": Icons.table_chart,
      "color": Colors.green,
    },
    {
      "name": "Meeting Recording.mp4",
      "type": "Video File",
      "size": "45.3 MB",
      "modified": "2024-06-16",
      "icon": Icons.video_file,
      "color": Colors.purple,
    },
    {
      "name": "Logo Design.png",
      "type": "Image",
      "size": "0.8 MB",
      "modified": "2024-06-15",
      "icon": Icons.image,
      "color": Colors.teal,
    },
  ];

  List<String> selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Explorer"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
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
                                  hintText: "Search files...",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: spSm),
                                ),
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: primaryColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Filter",
                        items: filterItems,
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
                        items: sortItems,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // File List/Grid
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: isGridView ? _buildGridView() : _buildListView(),
            ),
          ),

          // Bottom Action Bar (if files selected)
          if (selectedFiles.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Text(
                    "${selectedFiles.length} files selected",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Share",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Delete",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        final isSelected = selectedFiles.contains(file["name"]);
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
            border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          ),
          child: GestureDetector(
            onTap: () {
              if (isSelected) {
                selectedFiles.remove(file["name"]);
              } else {
                selectedFiles.add(file["name"]);
              }
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.all(spSm),
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
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${file["type"]} • ${file["size"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Modified ${DateTime.parse(file["modified"]).dMMMy}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: files.map((file) {
        final isSelected = selectedFiles.contains(file["name"]);
        
        return Container(
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
            border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          ),
          child: GestureDetector(
            onTap: () {
              if (isSelected) {
                selectedFiles.remove(file["name"]);
              } else {
                selectedFiles.add(file["name"]);
              }
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: (file["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      file["icon"] as IconData,
                      color: file["color"] as Color,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${file["name"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${file["type"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${file["size"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
