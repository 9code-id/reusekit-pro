import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlContact3View extends StatefulWidget {
  @override
  State<GrlContact3View> createState() => _GrlContact3ViewState();
}

class _GrlContact3ViewState extends State<GrlContact3View> {
  String searchQuery = '';
  String selectedGroup = 'all';
  
  List<Map<String, dynamic>> contactGroups = [
    {
      "id": 1,
      "name": "Family",
      "color": successColor,
      "icon": Icons.family_restroom,
      "count": 8,
      "description": "Close family members",
    },
    {
      "id": 2,
      "name": "Work Team",
      "color": primaryColor,
      "icon": Icons.work,
      "count": 12,
      "description": "Colleagues and work contacts",
    },
    {
      "id": 3,
      "name": "Best Friends",
      "color": warningColor,
      "icon": Icons.people,
      "count": 6,
      "description": "Closest friends",
    },
    {
      "id": 4,
      "name": "University",
      "color": infoColor,
      "icon": Icons.school,
      "count": 15,
      "description": "College friends and classmates",
    },
    {
      "id": 5,
      "name": "Neighbors",
      "color": secondaryColor,
      "icon": Icons.home,
      "count": 4,
      "description": "People from the neighborhood",
    },
  ];
  
  List<Map<String, dynamic>> groupContacts = [
    {
      "id": 1,
      "name": "Emma Wilson",
      "avatar": "https://picsum.photos/100/100?random=21&keyword=woman",
      "phone": "+1 (555) 123-4567",
      "relationship": "Sister",
      "group": "Family",
      "status": "online",
      "lastSeen": DateTime.now().subtract(Duration(minutes: 5)),
    },
    {
      "id": 2,
      "name": "Robert Johnson",
      "avatar": "https://picsum.photos/100/100?random=22&keyword=man",
      "phone": "+1 (555) 987-6543",
      "relationship": "Father",
      "group": "Family",
      "status": "offline",
      "lastSeen": DateTime.now().subtract(Duration(hours: 2)),
    },
    {
      "id": 3,
      "name": "Lisa Chen",
      "avatar": "https://picsum.photos/100/100?random=23&keyword=woman",
      "phone": "+1 (555) 456-7890",
      "relationship": "Team Lead",
      "group": "Work Team",
      "status": "busy",
      "lastSeen": DateTime.now().subtract(Duration(minutes: 30)),
    },
    {
      "id": 4,
      "name": "Michael Brown",
      "avatar": "https://picsum.photos/100/100?random=24&keyword=man",
      "phone": "+1 (555) 321-0987",
      "relationship": "Developer",
      "group": "Work Team",
      "status": "online",
      "lastSeen": DateTime.now().subtract(Duration(minutes: 10)),
    },
    {
      "id": 5,
      "name": "Jessica Davis",
      "avatar": "https://picsum.photos/100/100?random=25&keyword=woman",
      "phone": "+1 (555) 654-3210",
      "relationship": "Best Friend",
      "group": "Best Friends",
      "status": "online",
      "lastSeen": DateTime.now().subtract(Duration(minutes: 1)),
    },
    {
      "id": 6,
      "name": "Tom Anderson",
      "avatar": "https://picsum.photos/100/100?random=26&keyword=man",
      "phone": "+1 (555) 789-0123",
      "relationship": "Classmate",
      "group": "University",
      "status": "away",
      "lastSeen": DateTime.now().subtract(Duration(hours: 1)),
    },
  ];

  List<Map<String, dynamic>> get filteredGroups {
    if (searchQuery.isEmpty) return contactGroups;
    return contactGroups.where((group) =>
      (group["name"] as String).toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  List<Map<String, dynamic>> get currentGroupContacts {
    if (selectedGroup == 'all') return groupContacts;
    return groupContacts.where((contact) => contact["group"] == selectedGroup).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Groups"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              _showCreateGroupDialog();
            },
          ),
        ],
      ),
      body: selectedGroup == 'all' ? _buildGroupsView() : _buildGroupContactsView(),
    );
  }

  Widget _buildGroupsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Header
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
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.groups,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact Groups",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Organize your contacts efficiently",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${contactGroups.length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Groups",
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
                        children: [
                          Text(
                            "${groupContacts.length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Contacts",
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
                        children: [
                          Text(
                            "${groupContacts.where((c) => c["status"] == "online").length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Online",
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
          
          // Groups Grid
          Text(
            "Your Groups",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ResponsiveGridView(
            minItemWidth: 200,
            children: filteredGroups.map((group) {
              return GestureDetector(
                onTap: () {
                  selectedGroup = group["name"];
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      // Group Header
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: (group["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: group["color"] as Color,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                group["icon"] as IconData,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${group["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Group Info
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          children: [
                            Text(
                              "${group["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spMd),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 18,
                                  color: group["color"] as Color,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${group["count"]} members",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: group["color"] as Color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "View Group",
                                size: bs.sm,
                                onPressed: () {
                                  selectedGroup = group["name"];
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _showCreateGroupDialog();
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Create Group",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Handle manage groups
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.settings,
                          color: infoColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Manage Groups",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupContactsView() {
    final group = contactGroups.firstWhere((g) => g["name"] == selectedGroup);
    
    return Column(
      children: [
        // Group Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: (group["color"] as Color).withAlpha(20),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      selectedGroup = 'all';
                      setState(() {});
                    },
                  ),
                  SizedBox(width: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: group["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      group["icon"] as IconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${group["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${currentGroupContacts.length} members",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      _showGroupOptions(group);
                    },
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${currentGroupContacts.where((c) => c["status"] == "online").length}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Online",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${currentGroupContacts.where((c) => c["status"] == "away").length}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Away",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${currentGroupContacts.where((c) => c["status"] == "offline").length}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: disabledColor,
                            ),
                          ),
                          Text(
                            "Offline",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Contacts List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: currentGroupContacts.length,
            itemBuilder: (context, index) {
              final contact = currentGroupContacts[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(contact["status"]),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      // Avatar with status
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage("${contact["avatar"]}"),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: _getStatusColor(contact["status"]),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spMd),
                      
                      // Contact Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${contact["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${contact["relationship"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: group["color"] as Color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${contact["phone"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  _getStatusIcon(contact["status"]),
                                  size: 14,
                                  color: _getStatusColor(contact["status"]),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${contact["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getStatusColor(contact["status"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (contact["status"] != "online") ...[
                                  Text(
                                    " • ${_formatLastSeen(contact["lastSeen"] as DateTime)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Action Buttons
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: successColor,
                            ),
                            onPressed: () {
                              // Make call
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.message,
                              color: infoColor,
                            ),
                            onPressed: () {
                              // Send message
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Search Groups"),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Enter group name...",
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                searchQuery = '';
                setState(() {});
                back();
              },
              child: Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                back();
              },
              child: Text("Search"),
            ),
          ],
        );
      },
    );
  }

  void _showCreateGroupDialog() {
    String groupName = '';
    String groupDescription = '';
    Color selectedColor = primaryColor;
    IconData selectedIcon = Icons.people;
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Create New Group"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Group Name",
                        hintText: "Enter group name",
                      ),
                      onChanged: (value) {
                        groupName = value;
                      },
                    ),
                    SizedBox(height: spMd),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Description",
                        hintText: "Enter group description",
                      ),
                      onChanged: (value) {
                        groupDescription = value;
                      },
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Choose Color",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spSm,
                      children: [
                        primaryColor,
                        successColor,
                        warningColor,
                        dangerColor,
                        infoColor,
                        secondaryColor,
                      ].map((color) {
                        return GestureDetector(
                          onTap: () {
                            selectedColor = color;
                            setDialogState(() {});
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: selectedColor == color
                                  ? Border.all(color: Colors.black, width: 2)
                                  : null,
                            ),
                            child: selectedColor == color
                                ? Icon(Icons.check, color: Colors.white)
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Choose Icon",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spSm,
                      children: [
                        Icons.people,
                        Icons.family_restroom,
                        Icons.work,
                        Icons.school,
                        Icons.home,
                        Icons.sports,
                      ].map((icon) {
                        return GestureDetector(
                          onTap: () {
                            selectedIcon = icon;
                            setDialogState(() {});
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: selectedIcon == icon
                                  ? selectedColor
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              icon,
                              color: selectedIcon == icon
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    back();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (groupName.isNotEmpty) {
                      // Add new group
                      contactGroups.add({
                        "id": contactGroups.length + 1,
                        "name": groupName,
                        "color": selectedColor,
                        "icon": selectedIcon,
                        "count": 0,
                        "description": groupDescription.isEmpty
                            ? "New contact group"
                            : groupDescription,
                      });
                      setState(() {});
                      back();
                      ss("Group created successfully!");
                    }
                  },
                  child: Text("Create"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showGroupOptions(Map<String, dynamic> group) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Group"),
                onTap: () {
                  back();
                  // Handle edit group
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add),
                title: Text("Add Members"),
                onTap: () {
                  back();
                  // Handle add members
                },
              ),
              ListTile(
                leading: Icon(Icons.group_remove),
                title: Text("Remove Members"),
                onTap: () {
                  back();
                  // Handle remove members
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share Group"),
                onTap: () {
                  back();
                  // Handle share group
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete Group"),
                onTap: () {
                  back();
                  // Handle delete group
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'online':
        return successColor;
      case 'busy':
        return dangerColor;
      case 'away':
        return warningColor;
      case 'offline':
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'online':
        return Icons.circle;
      case 'busy':
        return Icons.do_not_disturb;
      case 'away':
        return Icons.schedule;
      case 'offline':
        return Icons.circle_outlined;
      default:
        return Icons.circle_outlined;
    }
  }

  String _formatLastSeen(DateTime lastSeen) {
    final now = DateTime.now();
    final difference = now.difference(lastSeen);
    
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return lastSeen.dMMMy;
    }
  }
}
