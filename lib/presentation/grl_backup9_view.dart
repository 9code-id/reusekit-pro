import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBackup9View extends StatefulWidget {
  @override
  State<GrlBackup9View> createState() => _GrlBackup9ViewState();
}

class _GrlBackup9ViewState extends State<GrlBackup9View> {
  String selectedTeamMember = "";
  bool isCreatingTeam = false;
  
  List<Map<String, dynamic>> teamMembers = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "email": "sarah.johnson@company.com",
      "role": "Admin",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "status": "online",
      "lastBackup": DateTime.now().subtract(Duration(hours: 2)),
      "storageUsed": "2.4 GB",
      "devicesCount": 3,
      "backupStatus": "synced",
    },
    {
      "id": 2,
      "name": "Michael Chen",
      "email": "michael.chen@company.com",
      "role": "Editor",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "status": "offline",
      "lastBackup": DateTime.now().subtract(Duration(days: 1)),
      "storageUsed": "1.8 GB",
      "devicesCount": 2,
      "backupStatus": "pending",
    },
    {
      "id": 3,
      "name": "Emily Rodriguez",
      "email": "emily.rodriguez@company.com",
      "role": "Viewer",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "status": "online",
      "lastBackup": DateTime.now().subtract(Duration(hours: 8)),
      "storageUsed": "3.1 GB",
      "devicesCount": 4,
      "backupStatus": "synced",
    },
    {
      "id": 4,
      "name": "David Park",
      "email": "david.park@company.com",
      "role": "Editor",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "status": "online",
      "lastBackup": DateTime.now().subtract(Duration(minutes: 30)),
      "storageUsed": "1.2 GB",
      "devicesCount": 2,
      "backupStatus": "synced",
    },
  ];

  List<Map<String, dynamic>> teamActivities = [
    {
      "user": "Sarah Johnson",
      "action": "Completed full backup",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "details": "2,847 files backed up successfully",
      "type": "backup",
    },
    {
      "user": "Michael Chen",
      "action": "Added new device",
      "timestamp": DateTime.now().subtract(Duration(hours: 6)),
      "details": "MacBook Pro added to backup list",
      "type": "device",
    },
    {
      "user": "Emily Rodriguez",
      "action": "Shared folder access",
      "timestamp": DateTime.now().subtract(Duration(hours: 8)),
      "details": "Granted access to Project Documents folder",
      "type": "sharing",
    },
    {
      "user": "David Park",
      "action": "Restored files",
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
      "details": "Restored 156 files from Dec 18 backup",
      "type": "restore",
    },
    {
      "user": "Sarah Johnson",
      "action": "Updated team settings",
      "timestamp": DateTime.now().subtract(Duration(days: 2)),
      "details": "Changed backup frequency to daily",
      "type": "settings",
    },
  ];

  List<Map<String, dynamic>> sharedFolders = [
    {
      "name": "Project Documents",
      "size": "456 MB",
      "files": 89,
      "sharedWith": 3,
      "lastModified": DateTime.now().subtract(Duration(hours: 4)),
      "owner": "Sarah Johnson",
      "permissions": "Read & Write",
    },
    {
      "name": "Design Assets",
      "size": "1.2 GB",
      "files": 234,
      "sharedWith": 2,
      "lastModified": DateTime.now().subtract(Duration(days: 1)),
      "owner": "Emily Rodriguez",
      "permissions": "Read Only",
    },
    {
      "name": "Marketing Materials",
      "size": "789 MB",
      "files": 156,
      "sharedWith": 4,
      "lastModified": DateTime.now().subtract(Duration(days: 3)),
      "owner": "Michael Chen",
      "permissions": "Read & Write",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Backup"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: _showInviteMemberDialog,
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
          children: [
            // Team Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.group,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Team Storage",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "8.5 GB of 50 GB used",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "17%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  LinearProgressIndicator(
                    value: 0.17,
                    backgroundColor: Colors.white.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${teamMembers.length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Team Members",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${sharedFolders.length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Shared Folders",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_getTotalDevices()}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Devices",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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

            SizedBox(height: spMd),

            // Team Members
            Row(
              children: [
                Text(
                  "Team Members",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Invite Member",
                  size: bs.sm,
                  icon: Icons.person_add,
                  onPressed: _showInviteMemberDialog,
                ),
              ],
            ),
            SizedBox(height: spMd),
            ...teamMembers.map((member) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: selectedTeamMember == member["id"].toString()
                    ? Border.all(color: primaryColor, width: 2)
                    : null,
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("${member["avatar"]}"),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: member["status"] == "online" ? successColor : disabledBoldColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${member["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getRoleColor(member["role"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${member["role"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getRoleColor(member["role"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${member["email"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.storage,
                                size: 14,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${member["storageUsed"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(
                                Icons.devices,
                                size: 14,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${member["devicesCount"]} devices",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getBackupStatusColor(member["backupStatus"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${member["backupStatus"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getBackupStatusColor(member["backupStatus"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(Icons.more_vert, color: disabledBoldColor),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("View Details"),
                          value: "details",
                        ),
                        PopupMenuItem(
                          child: Text("Change Role"),
                          value: "role",
                        ),
                        PopupMenuItem(
                          child: Text("Remove Member"),
                          value: "remove",
                        ),
                      ],
                      onSelected: (value) => _handleMemberAction(value, member),
                    ),
                  ],
                ),
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Shared Folders
            Text(
              "Shared Folders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...sharedFolders.map((folder) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.folder_shared,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${folder["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Owner: ${folder["owner"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.storage,
                              size: 14,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${folder["size"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(
                              Icons.folder,
                              size: 14,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${folder["files"]} files",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Shared with ${folder["sharedWith"]} members",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${folder["permissions"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: primaryColor),
                    onPressed: () => _shareFolder(folder),
                  ),
                ],
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Team Activity
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...teamActivities.map((activity) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getActivityColor(activity["type"]),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getActivityColor(activity["type"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        _getActivityIcon(activity["type"]),
                        color: _getActivityColor(activity["type"]),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${activity["user"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${activity["action"]}",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${activity["details"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${_getRelativeTime(activity["timestamp"] as DateTime)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Create Shared Folder",
                    size: bs.md,
                    icon: Icons.create_new_folder,
                    onPressed: _createSharedFolder,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Team Settings",
                    size: bs.md,
                    icon: Icons.settings,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _getTotalDevices() {
    return teamMembers.fold(0, (sum, member) => sum + (member["devicesCount"] as int));
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Admin':
        return dangerColor;
      case 'Editor':
        return warningColor;
      case 'Viewer':
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getBackupStatusColor(String status) {
    switch (status) {
      case 'synced':
        return successColor;
      case 'pending':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'backup':
        return successColor;
      case 'device':
        return primaryColor;
      case 'sharing':
        return infoColor;
      case 'restore':
        return warningColor;
      case 'settings':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'backup':
        return Icons.backup;
      case 'device':
        return Icons.devices;
      case 'sharing':
        return Icons.share;
      case 'restore':
        return Icons.restore;
      case 'settings':
        return Icons.settings;
      default:
        return Icons.info;
    }
  }

  String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }

  void _showInviteMemberDialog() {
    String email = "";
    String role = "Viewer";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Invite Team Member"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Email Address",
                value: email,
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Role",
                items: [
                  {"label": "Admin", "value": "Admin"},
                  {"label": "Editor", "value": "Editor"},
                  {"label": "Viewer", "value": "Viewer"},
                ],
                value: role,
                onChanged: (value, label) {
                  role = value;
                  setDialogState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _inviteMember(email, role);
            },
            child: Text("Send Invite"),
          ),
        ],
      ),
    );
  }

  void _inviteMember(String email, String role) async {
    if (email.isEmpty) {
      se("Please enter an email address");
      return;
    }
    
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Invitation sent to $email as $role");
  }

  void _handleMemberAction(String action, Map<String, dynamic> member) async {
    switch (action) {
      case 'details':
        // Show member details
        break;
      case 'role':
        // Show role change dialog
        break;
      case 'remove':
        bool isConfirmed = await confirm("Are you sure you want to remove ${member["name"]} from the team?");
        if (isConfirmed) {
          teamMembers.removeWhere((m) => m["id"] == member["id"]);
          setState(() {});
          ss("${member["name"]} removed from team");
        }
        break;
    }
  }

  void _shareFolder(Map<String, dynamic> folder) {
    // Show share folder dialog
    si("Sharing options for ${folder["name"]}");
  }

  void _createSharedFolder() {
    // Show create folder dialog
    si("Create new shared folder");
  }
}
