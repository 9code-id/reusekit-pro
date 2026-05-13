import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStorage1View extends StatefulWidget {
  @override
  State<GrlStorage1View> createState() => _GrlStorage1ViewState();
}

class _GrlStorage1ViewState extends State<GrlStorage1View> {
  String selectedFilter = "All Files";
  String selectedSort = "Date Modified";
  bool isGridView = false;
  
  final List<Map<String, dynamic>> storageData = [
    {
      "name": "Documents",
      "type": "folder",
      "size": "2.4 GB",
      "items": 156,
      "modified": "2 hours ago",
      "icon": Icons.folder,
      "color": Colors.blue,
    },
    {
      "name": "Photos",
      "type": "folder", 
      "size": "8.7 GB",
      "items": 1240,
      "modified": "1 day ago",
      "icon": Icons.photo_library,
      "color": Colors.green,
    },
    {
      "name": "Music",
      "type": "folder",
      "size": "3.2 GB", 
      "items": 298,
      "modified": "3 days ago",
      "icon": Icons.library_music,
      "color": Colors.purple,
    },
    {
      "name": "Videos",
      "type": "folder",
      "size": "12.5 GB",
      "items": 47,
      "modified": "1 week ago",
      "icon": Icons.video_library,
      "color": Colors.red,
    },
    {
      "name": "Project_Report.pdf",
      "type": "pdf",
      "size": "2.4 MB",
      "modified": "30 minutes ago",
      "icon": Icons.picture_as_pdf,
      "color": Colors.red,
    },
    {
      "name": "Presentation.pptx",
      "type": "presentation",
      "size": "15.7 MB",
      "modified": "2 hours ago",
      "icon": Icons.slideshow,
      "color": Colors.orange,
    },
    {
      "name": "Budget_2024.xlsx",
      "type": "spreadsheet",
      "size": "890 KB",
      "modified": "1 day ago",
      "icon": Icons.table_chart,
      "color": Colors.green,
    },
    {
      "name": "Profile_Image.jpg",
      "type": "image",
      "size": "1.2 MB",
      "modified": "3 hours ago",
      "icon": Icons.image,
      "color": Colors.blue,
    },
  ];

  final List<String> filters = ["All Files", "Folders", "Documents", "Images", "Videos", "Audio"];
  final List<String> sortOptions = ["Name", "Date Modified", "Size", "Type"];

  List<Map<String, dynamic>> get filteredData {
    var filtered = storageData.where((item) {
      switch (selectedFilter) {
        case "Folders":
          return item["type"] == "folder";
        case "Documents":
          return ["pdf", "presentation", "spreadsheet", "document"].contains(item["type"]);
        case "Images":
          return item["type"] == "image";
        case "Videos":
          return item["type"] == "video";
        case "Audio":
          return item["type"] == "audio";
        default:
          return true;
      }
    }).toList();

    // Sort data
    switch (selectedSort) {
      case "Name":
        filtered.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
        break;
      case "Size":
        filtered.sort((a, b) => _getSizeInBytes(a["size"] as String).compareTo(_getSizeInBytes(b["size"] as String)));
        break;
      case "Type":
        filtered.sort((a, b) => (a["type"] as String).compareTo(b["type"] as String));
        break;
      default: // Date Modified
        break;
    }

    return filtered;
  }

  int _getSizeInBytes(String size) {
    if (size.contains("GB")) {
      return ((double.tryParse(size.replaceAll(" GB", "")) ?? 0) * 1024 * 1024 * 1024).round();
    } else if (size.contains("MB")) {
      return ((double.tryParse(size.replaceAll(" MB", "")) ?? 0) * 1024 * 1024).round();
    } else if (size.contains("KB")) {
      return ((double.tryParse(size.replaceAll(" KB", "")) ?? 0) * 1024).round();
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage"),
        actions: [
          GestureDetector(
            onTap: () {
              isGridView = !isGridView;
              setState(() {});
            },
            child: Icon(
              isGridView ? Icons.list : Icons.grid_view,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.search,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_vert,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          // Storage Summary
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(10)],
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(40)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.storage,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Storage Usage",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "27.8 GB / 64 GB",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Progress Bar
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.43, // 27.8/64
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, successColor],
                        ),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spMd),
                
                // Storage Breakdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStorageCategory("Photos", "8.7 GB", Colors.green),
                    _buildStorageCategory("Videos", "12.5 GB", Colors.red),
                    _buildStorageCategory("Music", "3.2 GB", Colors.purple),
                    _buildStorageCategory("Docs", "2.4 GB", Colors.blue),
                    _buildStorageCategory("Other", "1.0 GB", Colors.orange),
                  ],
                ),
              ],
            ),
          ),

          // Filter and Sort Options
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                // Filter Dropdown
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: filters.map((filter) => {
                      "label": filter,
                      "value": filter,
                    }).toList(),
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                
                // Sort Dropdown
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions.map((sort) => {
                      "label": sort,
                      "value": sort,
                    }).toList(),
                    value: selectedSort,
                    onChanged: (value, label) {
                      selectedSort = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // File List Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Text(
                  "${filteredData.length} items",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.select_all,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Select All",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spSm),

          // File List
          Expanded(
            child: isGridView ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStorageCategory(String name, String size, Color color) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          name,
          style: TextStyle(
            color: primaryColor,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          size,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final item = filteredData[index];
        bool isFolder = item["type"] == "folder";

        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowXs],
          ),
          child: Row(
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (item["color"] as Color).withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: item["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),

              // File Info
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          isFolder ? "${item["items"]} items" : "${item["size"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: disabledBoldColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${item["modified"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions
              Row(
                children: [
                  if (!isFolder) ...[
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.download,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                  ],
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.share,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.more_vert,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: ResponsiveGridView(
        minItemWidth: 200,
        children: filteredData.map((item) {
          bool isFolder = item["type"] == "folder";
          
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: (item["color"] as Color).withAlpha(40),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    item["icon"] as IconData,
                    color: item["color"] as Color,
                    size: 32,
                  ),
                ),
                SizedBox(height: spMd),

                // Name
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),

                // Size/Items
                Text(
                  isFolder ? "${item["items"]} items" : "${item["size"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: spXs),

                // Modified
                Text(
                  "${item["modified"]}",
                  style: TextStyle(
                    color: disabledColor,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: spMd),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!isFolder)
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.download,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.share,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
