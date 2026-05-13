import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFolder9View extends StatefulWidget {
  @override
  State<GrlFolder9View> createState() => _GrlFolder9ViewState();
}

class _GrlFolder9ViewState extends State<GrlFolder9View> {
  String searchQuery = "";
  String selectedPermission = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> permissions = [
    {
      "id": 1,
      "userName": "John Smith",
      "userEmail": "john.smith@company.com",
      "userAvatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "permission": "Editor",
      "grantedDate": "2024-01-10",
      "lastAccess": "2 hours ago",
      "status": "Active",
      "resourceType": "Folder",
      "resourceName": "Project Files",
      "resourcePath": "/Documents/Projects/",
      "isInherited": false,
      "canRevoke": true,
    },
    {
      "id": 2,
      "userName": "Sarah Wilson",
      "userEmail": "sarah.wilson@company.com",
      "userAvatar": "https://picsum.photos/40/40?random=2&keyword=person",
      "permission": "Viewer",
      "grantedDate": "2024-01-08",
      "lastAccess": "1 day ago",
      "status": "Active",
      "resourceType": "File",
      "resourceName": "Budget_Report.xlsx",
      "resourcePath": "/Documents/Finance/",
      "isInherited": false,
      "canRevoke": true,
    },
    {
      "id": 3,
      "userName": "Development Team",
      "userEmail": "dev-team@company.com",
      "userAvatar": "https://picsum.photos/40/40?random=3&keyword=team",
      "permission": "Editor",
      "grantedDate": "2024-01-05",
      "lastAccess": "5 minutes ago",
      "status": "Active",
      "resourceType": "Folder",
      "resourceName": "Source Code",
      "resourcePath": "/Development/",
      "isInherited": true,
      "canRevoke": false,
    },
    {
      "id": 4,
      "userName": "Mike Johnson",
      "userEmail": "mike.johnson@company.com",
      "userAvatar": "https://picsum.photos/40/40?random=4&keyword=person",
      "permission": "Commenter",
      "grantedDate": "2024-01-12",
      "lastAccess": "Never",
      "status": "Pending",
      "resourceType": "File",
      "resourceName": "Presentation.pptx",
      "resourcePath": "/Documents/Presentations/",
      "isInherited": false,
      "canRevoke": true,
    },
    {
      "id": 5,
      "userName": "Lisa Garcia",
      "userEmail": "lisa.garcia@company.com",
      "userAvatar": "https://picsum.photos/40/40?random=5&keyword=person",
      "permission": "Viewer",
      "grantedDate": "2024-01-01",
      "lastAccess": "2 weeks ago",
      "status": "Expired",
      "resourceType": "Folder",
      "resourceName": "Marketing Assets",
      "resourcePath": "/Marketing/",
      "isInherited": false,
      "canRevoke": true,
    },
  ];

  List<Map<String, dynamic>> permissionOptions = [
    {"label": "All", "value": "All"},
    {"label": "Editor", "value": "Editor"},
    {"label": "Viewer", "value": "Viewer"},
    {"label": "Commenter", "value": "Commenter"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Expired", "value": "Expired"},
  ];

  Color getPermissionColor(String permission) {
    switch (permission) {
      case 'Editor':
        return successColor;
      case 'Viewer':
        return primaryColor;
      case 'Commenter':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return successColor;
      case 'Pending':
        return warningColor;
      case 'Expired':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> get filteredPermissions {
    return permissions.where((permission) {
      bool matchesSearch = permission["userName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          permission["resourceName"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesPermission = selectedPermission == "All" || permission["permission"] == selectedPermission;
      bool matchesStatus = selectedStatus == "All" || permission["status"] == selectedStatus;
      return matchesSearch && matchesPermission && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Access Control"),
        actions: [
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
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
                    label: "Search users or resources",
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

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Permission Level",
                    items: permissionOptions,
                    value: selectedPermission,
                    onChanged: (value, label) {
                      selectedPermission = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Permission Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.security, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Permission Overview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${permissions.where((p) => p["status"] == "Active").length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Active Users",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${permissions.where((p) => p["status"] == "Pending").length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${permissions.where((p) => p["status"] == "Expired").length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Expired",
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
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Grant Access",
                          icon: Icons.person_add,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Bulk Actions",
                          icon: Icons.checklist,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Permissions List
            Text(
              "Access Permissions (${filteredPermissions.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredPermissions.map((permission) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: permission["status"] == "Expired" 
                      ? Border.all(color: dangerColor.withAlpha(50), width: 1)
                      : permission["status"] == "Pending"
                          ? Border.all(color: warningColor.withAlpha(50), width: 1)
                          : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    // User Info Header
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: disabledColor.withAlpha(50)),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              "${permission["userAvatar"]}",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: primaryColor,
                                  child: Icon(Icons.person, color: Colors.white, size: 24),
                                );
                              },
                            ),
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
                                      "${permission["userName"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: getStatusColor("${permission["status"]}").withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${permission["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: getStatusColor("${permission["status"]}"),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${permission["userEmail"]}",
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

                    // Resource Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                permission["resourceType"] == "Folder" ? Icons.folder : Icons.insert_drive_file,
                                color: primaryColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${permission["resourceName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: getPermissionColor("${permission["permission"]}").withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${permission["permission"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: getPermissionColor("${permission["permission"]}"),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.folder_outlined, color: disabledBoldColor, size: 14),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${permission["resourcePath"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Permission Details
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Granted: ${permission["grantedDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Last Access: ${permission["lastAccess"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (permission["isInherited"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.link, color: infoColor, size: 12),
                                SizedBox(width: spXs),
                                Text(
                                  "Inherited",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        if (permission["status"] == "Pending") ...[
                          Expanded(
                            child: QButton(
                              label: "Approve",
                              icon: Icons.check,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Decline",
                              icon: Icons.close,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ] else if (permission["status"] == "Expired") ...[
                          Expanded(
                            child: QButton(
                              label: "Renew Access",
                              icon: Icons.refresh,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Remove",
                              icon: Icons.delete,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ] else ...[
                          Expanded(
                            child: QButton(
                              label: "Modify",
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (permission["canRevoke"] == true)
                            Expanded(
                              child: QButton(
                                label: "Revoke",
                                icon: Icons.remove_circle,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                        ],
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Empty State
            if (filteredPermissions.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.security, color: disabledColor, size: 64),
                    SizedBox(height: spMd),
                    Text(
                      "No Permissions Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No access permissions match your current filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
