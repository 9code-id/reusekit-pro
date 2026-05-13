import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStorage3View extends StatefulWidget {
  @override
  State<GrlStorage3View> createState() => _GrlStorage3ViewState();
}

class _GrlStorage3ViewState extends State<GrlStorage3View> {
  String selectedView = "List";
  String sortBy = "Name";
  bool showHidden = false;
  String currentPath = "/";
  
  final List<String> pathHistory = ["/"];
  
  final List<Map<String, dynamic>> folders = [
    {
      "name": "Documents",
      "type": "folder",
      "size": "2.4 GB",
      "items": 156,
      "modified": "Today",
      "permissions": "Read/Write",
      "shared": false,
    },
    {
      "name": "Downloads",
      "type": "folder",
      "size": "1.8 GB",
      "items": 89,
      "modified": "Yesterday",
      "permissions": "Read/Write",
      "shared": false,
    },
    {
      "name": "Pictures",
      "type": "folder",
      "size": "8.7 GB",
      "items": 1240,
      "modified": "2 days ago",
      "permissions": "Read Only",
      "shared": true,
    },
    {
      "name": "Music",
      "type": "folder",
      "size": "3.2 GB",
      "items": 298,
      "modified": "1 week ago",
      "permissions": "Read/Write",
      "shared": false,
    },
  ];

  final List<Map<String, dynamic>> files = [
    {
      "name": "Project_Proposal.pdf",
      "type": "pdf",
      "size": "2.4 MB",
      "modified": "2 hours ago",
      "permissions": "Read/Write",
      "shared": true,
      "thumbnail": "https://picsum.photos/100/100?random=1&keyword=document",
    },
    {
      "name": "Budget_Analysis.xlsx",
      "type": "spreadsheet", 
      "size": "890 KB",
      "modified": "5 hours ago",
      "permissions": "Read/Write",
      "shared": false,
      "thumbnail": "https://picsum.photos/100/100?random=2&keyword=spreadsheet",
    },
    {
      "name": "Team_Photo.jpg",
      "type": "image",
      "size": "1.2 MB",
      "modified": "1 day ago",
      "permissions": "Read Only",
      "shared": true,
      "thumbnail": "https://picsum.photos/100/100?random=3&keyword=photo",
    },
    {
      "name": "Presentation.pptx",
      "type": "presentation",
      "size": "15.7 MB",
      "modified": "3 days ago",
      "permissions": "Read/Write",
      "shared": false,
      "thumbnail": "https://picsum.photos/100/100?random=4&keyword=presentation",
    },
  ];

  List<Map<String, dynamic>> get allItems {
    List<Map<String, dynamic>> items = [...folders, ...files];
    
    // Apply sorting
    switch (sortBy) {
      case "Name":
        items.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
        break;
      case "Size":
        items.sort((a, b) => _getSizeInBytes(a["size"] as String).compareTo(_getSizeInBytes(b["size"] as String)));
        break;
      case "Type":
        items.sort((a, b) => (a["type"] as String).compareTo(b["type"] as String));
        break;
      case "Modified":
        // Keep current order for simplicity
        break;
    }
    
    return items;
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

  void _navigateToFolder(String folderName) {
    currentPath += "$folderName/";
    pathHistory.add(currentPath);
    setState(() {});
  }

  void _navigateBack() {
    if (pathHistory.length > 1) {
      pathHistory.removeLast();
      currentPath = pathHistory.last;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Header with Path
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + spSm,
              left: spMd,
              right: spMd,
              bottom: spSm,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Top Row
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => back(),
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "File Manager",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        selectedView = selectedView == "List" ? "Grid" : "List";
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          selectedView == "List" ? Icons.grid_view : Icons.list,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.search,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Path Breadcrumb
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      // Back Button
                      if (pathHistory.length > 1)
                        GestureDetector(
                          onTap: _navigateBack,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      
                      SizedBox(width: spSm),
                      
                      // Path
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _buildPathBreadcrumb(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Toolbar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(
                bottom: BorderSide(color: disabledOutlineBorderColor),
              ),
            ),
            child: Row(
              children: [
                // Sort Dropdown
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: ["Name", "Size", "Type", "Modified"].map((sort) => {
                      "label": sort,
                      "value": sort,
                    }).toList(),
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
                
                SizedBox(width: spMd),
                
                // Hidden Files Toggle
                GestureDetector(
                  onTap: () {
                    showHidden = !showHidden;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: showHidden ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: showHidden ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          showHidden ? Icons.visibility : Icons.visibility_off,
                          color: showHidden ? Colors.white : disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Hidden",
                          style: TextStyle(
                            color: showHidden ? Colors.white : disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Items Count
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${allItems.length} items",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.create_new_folder,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "New Folder",
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

          // Content
          Expanded(
            child: selectedView == "List" ? _buildListView() : _buildGridView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.upload_file,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _buildPathBreadcrumb() {
    List<Widget> breadcrumbs = [];
    List<String> pathParts = currentPath.split('/').where((part) => part.isNotEmpty).toList();
    
    // Home
    breadcrumbs.add(
      GestureDetector(
        onTap: () {
          currentPath = "/";
          pathHistory.clear();
          pathHistory.add("/");
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          child: Row(
            children: [
              Icon(
                Icons.home,
                color: primaryColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Home",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Path parts
    for (int i = 0; i < pathParts.length; i++) {
      breadcrumbs.add(
        Icon(
          Icons.chevron_right,
          color: disabledBoldColor,
          size: 16,
        ),
      );
      
      breadcrumbs.add(
        GestureDetector(
          onTap: () {
            String newPath = "/" + pathParts.take(i + 1).join("/") + "/";
            currentPath = newPath;
            // Update history
            pathHistory.clear();
            pathHistory.add("/");
            for (int j = 0; j <= i; j++) {
              pathHistory.add("/" + pathParts.take(j + 1).join("/") + "/");
            }
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            child: Text(
              pathParts[i],
              style: TextStyle(
                color: i == pathParts.length - 1 ? primaryColor : disabledBoldColor,
                fontSize: 14,
                fontWeight: i == pathParts.length - 1 ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    }

    return breadcrumbs;
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: allItems.length,
      itemBuilder: (context, index) {
        final item = allItems[index];
        bool isFolder = item["type"] == "folder";

        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Row(
            children: [
              // Icon/Thumbnail
              Container(
                width: 50,
                height: 50,
                child: isFolder
                    ? Container(
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.folder,
                          color: primaryColor,
                          size: 28,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${item["thumbnail"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              SizedBox(width: spMd),

              // Info
              Expanded(
                child: GestureDetector(
                  onTap: isFolder ? () => _navigateToFolder(item["name"] as String) : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${item["name"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (item["shared"] as bool)
                            Container(
                              margin: EdgeInsets.only(left: spSm),
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: successColor,
                                    size: 10,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Shared",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
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
                      Text(
                        "${item["permissions"]}",
                        style: TextStyle(
                          color: _getPermissionColor(item["permissions"] as String),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Actions
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
        );
      },
    );
  }

  Widget _buildGridView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: ResponsiveGridView(
        minItemWidth: 200,
        children: allItems.map((item) {
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
                // Thumbnail/Icon
                GestureDetector(
                  onTap: isFolder ? () => _navigateToFolder(item["name"] as String) : null,
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    child: isFolder
                        ? Container(
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.folder,
                              color: primaryColor,
                              size: 48,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${item["thumbnail"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
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
                SizedBox(height: spSm),

                // Permissions & Actions
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${item["permissions"]}",
                        style: TextStyle(
                          color: _getPermissionColor(item["permissions"] as String),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (item["shared"] as bool)
                      Icon(
                        Icons.share,
                        color: successColor,
                        size: 14,
                      ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 16,
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

  Color _getPermissionColor(String permission) {
    switch (permission) {
      case "Read/Write":
        return successColor;
      case "Read Only":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
