import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCloud8View extends StatefulWidget {
  @override
  State<GrlCloud8View> createState() => _GrlCloud8ViewState();
}

class _GrlCloud8ViewState extends State<GrlCloud8View> {
  bool loading = false;
  
  List<Map<String, dynamic>> sharedFiles = [
    {
      "id": "1",
      "name": "Project Proposal.pdf",
      "type": "pdf",
      "size": 2.5,
      "sharedWith": [
        {"name": "John Smith", "email": "john@company.com", "role": "viewer"},
        {"name": "Sarah Davis", "email": "sarah@company.com", "role": "editor"},
      ],
      "sharedBy": "You",
      "shareDate": "2024-06-22T10:30:00Z",
      "expiryDate": "2024-07-22T10:30:00Z",
      "public": false,
      "downloads": 12,
      "views": 45,
      "status": "active",
    },
    {
      "id": "2", 
      "name": "Team Photos",
      "type": "folder",
      "size": 125.8,
      "sharedWith": [
        {"name": "Mike Johnson", "email": "mike@company.com", "role": "viewer"},
        {"name": "Lisa Wilson", "email": "lisa@company.com", "role": "viewer"},
        {"name": "Tom Brown", "email": "tom@company.com", "role": "editor"},
      ],
      "sharedBy": "Alex Miller",
      "shareDate": "2024-06-21T14:20:00Z",
      "expiryDate": "2024-12-31T23:59:59Z",
      "public": true,
      "downloads": 89,
      "views": 234,
      "status": "active",
    },
    {
      "id": "3",
      "name": "Budget Report Q2.xlsx",
      "type": "xlsx",
      "size": 1.2,
      "sharedWith": [
        {"name": "Jennifer Taylor", "email": "jen@company.com", "role": "owner"},
      ],
      "sharedBy": "Jennifer Taylor",
      "shareDate": "2024-06-20T09:15:00Z",
      "expiryDate": "2024-07-01T00:00:00Z",
      "public": false,
      "downloads": 5,
      "views": 18,
      "status": "expired",
    },
    {
      "id": "4",
      "name": "Marketing Materials",
      "type": "folder",
      "size": 45.7,
      "sharedWith": [
        {"name": "Public Link", "email": "", "role": "viewer"},
      ],
      "sharedBy": "You",
      "shareDate": "2024-06-19T16:45:00Z",
      "expiryDate": "2024-08-19T16:45:00Z",
      "public": true,
      "downloads": 156,
      "views": 892,
      "status": "active",
    },
    {
      "id": "5",
      "name": "Software License.pdf",
      "type": "pdf",
      "size": 0.8,
      "sharedWith": [
        {"name": "IT Department", "email": "it@company.com", "role": "viewer"},
        {"name": "Legal Team", "email": "legal@company.com", "role": "viewer"},
      ],
      "sharedBy": "Admin",
      "shareDate": "2024-06-18T11:30:00Z",
      "expiryDate": "2024-12-18T11:30:00Z",
      "public": false,
      "downloads": 23,
      "views": 67,
      "status": "active",
    },
  ];

  String selectedFilter = "all";
  List<String> filterOptions = ["all", "active", "expired", "public", "private"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Files"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _createNewShare,
          ),
        ],
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSharingOverview(),
                SizedBox(height: spLg),
                _buildFilterSection(),
                SizedBox(height: spMd),
                _buildSharedFilesList(),
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createNewShare,
        icon: Icon(Icons.share),
        label: Text("Share File"),
        backgroundColor: primaryColor,
      ),
    );
  }

  Widget _buildSharingOverview() {
    int activeShares = sharedFiles.where((f) => f["status"] == "active").length;
    int publicShares = sharedFiles.where((f) => f["public"] as bool).length;
    int totalViews = sharedFiles.fold(0, (sum, f) => sum + (f["views"] as int));
    int totalDownloads = sharedFiles.fold(0, (sum, f) => sum + (f["downloads"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sharing Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  "Active Shares",
                  "$activeShares",
                  Icons.share,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewMetric(
                  "Public Links",
                  "$publicShares",
                  Icons.public,
                  infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  "Total Views",
                  "$totalViews",
                  Icons.visibility,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewMetric(
                  "Downloads",
                  "$totalDownloads",
                  Icons.download,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Row(
      children: [
        Text(
          "Filter:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            height: 40,
            child: QHorizontalScroll(
              children: filterOptions.map((filter) {
                bool isSelected = selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    selectedFilter = filter;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    margin: EdgeInsets.only(right: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: isSelected ? [shadowSm] : [],
                    ),
                    child: Text(
                      filter.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSharedFilesList() {
    List<Map<String, dynamic>> filteredFiles = _getFilteredFiles();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Shared Files (${filteredFiles.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        if (filteredFiles.isEmpty)
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.share,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No shared files found",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredFiles.map((file) => _buildSharedFileItem(file)).toList(),
      ],
    );
  }

  Widget _buildSharedFileItem(Map<String, dynamic> file) {
    Color statusColor = _getStatusColor(file["status"] as String);
    IconData fileIcon = _getFileIcon(file["type"] as String);
    bool isPublic = file["public"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  fileIcon,
                  size: 24,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (isPublic)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            margin: EdgeInsets.only(right: spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "PUBLIC",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${file["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${file["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Shared by ${file["sharedBy"]} • ${((file["size"] as double)).toStringAsFixed(1)} MB",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: disabledBoldColor),
                onSelected: (value) => _handleFileAction(value, file),
                itemBuilder: (context) => [
                  PopupMenuItem(value: "view", child: Text("View Details")),
                  PopupMenuItem(value: "copy", child: Text("Copy Link")),
                  PopupMenuItem(value: "manage", child: Text("Manage Access")),
                  PopupMenuItem(value: "revoke", child: Text("Revoke Access")),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildFileStatistic("Views", "${file["views"]}", Icons.visibility),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildFileStatistic("Downloads", "${file["downloads"]}", Icons.download),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildFileStatistic("Recipients", "${(file["sharedWith"] as List).length}", Icons.people),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shared with:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              ...(file["sharedWith"] as List).take(3).map((recipient) => Padding(
                padding: EdgeInsets.only(bottom: spXs),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getRoleColor(recipient["role"] as String),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${recipient["name"]} (${recipient["role"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )).toList(),
              if ((file["sharedWith"] as List).length > 3)
                Text(
                  "+${(file["sharedWith"] as List).length - 3} more recipients",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Shared ${DateTime.parse("${file["shareDate"]}").dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.event,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Expires ${DateTime.parse("${file["expiryDate"]}").dMMMy}",
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

  Widget _buildFileStatistic(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "expired":
        return dangerColor;
      case "suspended":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case "owner":
        return primaryColor;
      case "editor":
        return warningColor;
      case "viewer":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getFileIcon(String type) {
    switch (type) {
      case "pdf":
        return Icons.picture_as_pdf;
      case "xlsx":
      case "xls":
        return Icons.table_chart;
      case "docx":
      case "doc":
        return Icons.description;
      case "folder":
        return Icons.folder;
      case "image":
        return Icons.image;
      case "video":
        return Icons.video_file;
      default:
        return Icons.insert_drive_file;
    }
  }

  List<Map<String, dynamic>> _getFilteredFiles() {
    if (selectedFilter == "all") {
      return sharedFiles;
    }
    
    return sharedFiles.where((file) {
      switch (selectedFilter) {
        case "active":
          return file["status"] == "active";
        case "expired":
          return file["status"] == "expired";
        case "public":
          return file["public"] as bool;
        case "private":
          return !(file["public"] as bool);
        default:
          return true;
      }
    }).toList();
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...filterOptions.map((filter) => ListTile(
              title: Text(filter.toUpperCase()),
              trailing: selectedFilter == filter ? Icon(Icons.check, color: primaryColor) : null,
              onTap: () {
                selectedFilter = filter;
                setState(() {});
                Navigator.pop(context);
              },
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _createNewShare() {
    si("Feature coming soon - Create new file share");
  }

  void _handleFileAction(String action, Map<String, dynamic> file) {
    switch (action) {
      case "view":
        _viewFileDetails(file);
        break;
      case "copy":
        _copyShareLink(file);
        break;
      case "manage":
        _manageAccess(file);
        break;
      case "revoke":
        _revokeAccess(file);
        break;
    }
  }

  void _viewFileDetails(Map<String, dynamic> file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${file["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Size: ${((file["size"] as double)).toStringAsFixed(1)} MB"),
            Text("Status: ${file["status"]}"),
            Text("Public: ${file["public"] ? "Yes" : "No"}"),
            Text("Views: ${file["views"]}"),
            Text("Downloads: ${file["downloads"]}"),
            Text("Recipients: ${(file["sharedWith"] as List).length}"),
            Text("Shared: ${DateTime.parse("${file["shareDate"]}").dMMMy}"),
            Text("Expires: ${DateTime.parse("${file["expiryDate"]}").dMMMy}"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _copyShareLink(Map<String, dynamic> file) {
    ss("Share link copied to clipboard");
  }

  void _manageAccess(Map<String, dynamic> file) {
    si("Feature coming soon - Manage file access permissions");
  }

  void _revokeAccess(Map<String, dynamic> file) async {
    bool isConfirmed = await confirm("Revoke access to this shared file?");
    if (isConfirmed) {
      file["status"] = "expired";
      setState(() {});
      sw("Access revoked for ${file["name"]}");
    }
  }
}
