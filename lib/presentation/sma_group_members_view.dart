import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaGroupMembersView extends StatefulWidget {
  const SmaGroupMembersView({super.key});

  @override
  State<SmaGroupMembersView> createState() => _SmaGroupMembersViewState();
}

class _SmaGroupMembersViewState extends State<SmaGroupMembersView> {
  String searchQuery = "";
  String selectedRole = "All";
  String selectedStatus = "All";
  bool showInviteDialog = false;
  String inviteEmail = "";
  
  List<Map<String, dynamic>> members = [
    {
      "id": 1,
      "name": "Alex Chen",
      "email": "alex.chen@email.com",
      "profile_image": "https://picsum.photos/80/80?random=1&keyword=man",
      "role": "admin",
      "status": "active",
      "join_date": "2023-01-15",
      "last_seen": "Online",
      "post_count": 45,
      "contribution_score": 92,
      "is_online": true,
      "location": "San Francisco, CA",
      "bio": "Tech entrepreneur and AI enthusiast",
    },
    {
      "id": 2,
      "name": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "profile_image": "https://picsum.photos/80/80?random=2&keyword=woman",
      "role": "moderator",
      "status": "active",
      "join_date": "2023-02-20",
      "last_seen": "2 hours ago",
      "post_count": 32,
      "contribution_score": 88,
      "is_online": false,
      "location": "New York, NY",
      "bio": "Product manager and design lover",
    },
    {
      "id": 3,
      "name": "Mike Rodriguez",
      "email": "mike.r@email.com",
      "profile_image": "https://picsum.photos/80/80?random=3&keyword=man",
      "role": "moderator",
      "status": "active",
      "join_date": "2023-03-10",
      "last_seen": "1 day ago",
      "post_count": 28,
      "contribution_score": 85,
      "is_online": true,
      "location": "Los Angeles, CA",
      "bio": "Full-stack developer and mentor",
    },
    {
      "id": 4,
      "name": "Emma Davis",
      "email": "emma.d@email.com",
      "profile_image": "https://picsum.photos/80/80?random=4&keyword=woman",
      "role": "member",
      "status": "active",
      "join_date": "2023-06-12",
      "last_seen": "Online",
      "post_count": 15,
      "contribution_score": 67,
      "is_online": true,
      "location": "Seattle, WA",
      "bio": "UX designer passionate about accessibility",
    },
    {
      "id": 5,
      "name": "James Wilson",
      "email": "james.w@email.com",
      "profile_image": "https://picsum.photos/80/80?random=5&keyword=man",
      "role": "member",
      "status": "inactive",
      "join_date": "2023-08-05",
      "last_seen": "2 weeks ago",
      "post_count": 22,
      "contribution_score": 45,
      "is_online": false,
      "location": "Austin, TX",
      "bio": "Data scientist and machine learning researcher",
    },
    {
      "id": 6,
      "name": "Lisa Wang",
      "email": "lisa.w@email.com",
      "profile_image": "https://picsum.photos/80/80?random=6&keyword=woman",
      "role": "member",
      "status": "pending",
      "join_date": "2024-01-10",
      "last_seen": "Never",
      "post_count": 0,
      "contribution_score": 0,
      "is_online": false,
      "location": "Boston, MA",
      "bio": "Marketing specialist interested in tech trends",
    },
  ];

  List<String> roleOptions = ["All", "Admin", "Moderator", "Member"];
  List<String> statusOptions = ["All", "Active", "Inactive", "Pending"];
  
  List<Map<String, dynamic>> get filteredMembers {
    var filtered = members;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((member) =>
        (member["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (member["email"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (member["bio"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    if (selectedRole != "All") {
      filtered = filtered.where((member) =>
        (member["role"] as String).toLowerCase() == selectedRole.toLowerCase()
      ).toList();
    }
    
    if (selectedStatus != "All") {
      filtered = filtered.where((member) =>
        (member["status"] as String).toLowerCase() == selectedStatus.toLowerCase()
      ).toList();
    }
    
    // Sort by role priority, then by contribution score
    filtered.sort((a, b) {
      final roleOrder = {"admin": 0, "moderator": 1, "member": 2};
      final aRoleOrder = roleOrder[a["role"]] ?? 3;
      final bRoleOrder = roleOrder[b["role"]] ?? 3;
      
      if (aRoleOrder != bRoleOrder) {
        return aRoleOrder.compareTo(bRoleOrder);
      }
      
      return (b["contribution_score"] as int).compareTo(a["contribution_score"] as int);
    });
    
    return filtered;
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case "admin":
        return dangerColor;
      case "moderator":
        return warningColor;
      case "member":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return disabledColor;
      case "pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _changeRole(int memberId, String newRole) {
    setState(() {
      final memberIndex = members.indexWhere((member) => member["id"] == memberId);
      if (memberIndex != -1) {
        members[memberIndex]["role"] = newRole;
      }
    });
    ss("Member role updated successfully");
  }

  void _removeMember(int memberId) async {
    final confirmed = await confirm("Are you sure you want to remove this member from the group?");
    if (confirmed) {
      setState(() {
        members.removeWhere((member) => member["id"] == memberId);
      });
      ss("Member removed from group");
    }
  }

  void _approveMember(int memberId) {
    setState(() {
      final memberIndex = members.indexWhere((member) => member["id"] == memberId);
      if (memberIndex != -1) {
        members[memberIndex]["status"] = "active";
        members[memberIndex]["last_seen"] = "Just now";
      }
    });
    ss("Member approved and added to group");
  }

  void _inviteMember() {
    if (inviteEmail.isNotEmpty) {
      // Add new pending member
      final newMember = {
        "id": members.length + 1,
        "name": "Invited User",
        "email": inviteEmail,
        "profile_image": "https://picsum.photos/80/80?random=${members.length + 1}&keyword=person",
        "role": "member",
        "status": "pending",
        "join_date": DateTime.now().toString().substring(0, 10),
        "last_seen": "Never",
        "post_count": 0,
        "contribution_score": 0,
        "is_online": false,
        "location": "Unknown",
        "bio": "New member invitation sent",
      };
      
      setState(() {
        members.add(newMember);
        inviteEmail = "";
        showInviteDialog = false;
      });
      
      ss("Invitation sent successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Members"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              showInviteDialog = true;
              setState(() {});
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'export':
                  // Export member list
                  break;
                case 'bulk_action':
                  // Bulk actions
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: spXs),
                    Text("Export List"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'bulk_action',
                child: Row(
                  children: [
                    Icon(Icons.checklist),
                    SizedBox(width: spXs),
                    Text("Bulk Actions"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search members",
                  value: searchQuery,
                  hint: "Search by name, email, or bio",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Role",
                        items: roleOptions.map((role) => {
                          "label": role,
                          "value": role,
                        }).toList(),
                        value: selectedRole,
                        onChanged: (value, label) {
                          selectedRole = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusOptions.map((status) => {
                          "label": status,
                          "value": status,
                        }).toList(),
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Stats Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredMembers.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Members",
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${members.where((m) => m["is_online"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Online Now",
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${members.where((m) => m["status"] == "pending").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Members List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredMembers.length,
              itemBuilder: (context, index) {
                final member = filteredMembers[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      // Member Header
                      Row(
                        children: [
                          // Profile Image with Status
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage("${member["profile_image"]}"),
                              ),
                              if (member["is_online"] as bool)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          
                          // Member Info
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
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getRoleColor(member["role"] as String).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${member["role"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getRoleColor(member["role"] as String),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${member["email"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${member["bio"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          
                          // Status Badge
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(member["status"] as String).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${member["status"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: _getStatusColor(member["status"] as String),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Member Stats
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Joined ${member["join_date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.article,
                            size: 14,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${member["post_count"]} posts",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Score: ${member["contribution_score"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Action Buttons
                      Row(
                        children: [
                          if (member["status"] == "pending") ...[
                            Expanded(
                              child: QButton(
                                label: "Approve",
                                icon: Icons.check,
                                color: successColor,
                                size: bs.sm,
                                onPressed: () => _approveMember(member["id"] as int),
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Reject",
                              icon: Icons.close,
                              color: dangerColor,
                              size: bs.sm,
                              onPressed: () => _removeMember(member["id"] as int),
                            ),
                          ] else ...[
                            Expanded(
                              child: QButton(
                                label: "View Profile",
                                icon: Icons.person,
                                size: bs.sm,
                                onPressed: () {
                                  // View profile
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Message",
                              icon: Icons.message,
                              color: successColor,
                              size: bs.sm,
                              onPressed: () {
                                // Send message
                              },
                            ),
                            SizedBox(width: spXs),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                final memberId = member["id"] as int;
                                switch (value) {
                                  case 'promote_admin':
                                    _changeRole(memberId, 'admin');
                                    break;
                                  case 'promote_moderator':
                                    _changeRole(memberId, 'moderator');
                                    break;
                                  case 'demote_member':
                                    _changeRole(memberId, 'member');
                                    break;
                                  case 'remove':
                                    _removeMember(memberId);
                                    break;
                                }
                              },
                              icon: Icon(Icons.more_vert, color: disabledBoldColor),
                              itemBuilder: (context) => [
                                if (member["role"] != "admin")
                                  PopupMenuItem(
                                    value: 'promote_admin',
                                    child: Row(
                                      children: [
                                        Icon(Icons.admin_panel_settings, color: dangerColor),
                                        SizedBox(width: spXs),
                                        Text("Make Admin"),
                                      ],
                                    ),
                                  ),
                                if (member["role"] == "member")
                                  PopupMenuItem(
                                    value: 'promote_moderator',
                                    child: Row(
                                      children: [
                                        Icon(Icons.shield, color: warningColor),
                                        SizedBox(width: spXs),
                                        Text("Make Moderator"),
                                      ],
                                    ),
                                  ),
                                if (member["role"] != "member")
                                  PopupMenuItem(
                                    value: 'demote_member',
                                    child: Row(
                                      children: [
                                        Icon(Icons.person, color: primaryColor),
                                        SizedBox(width: spXs),
                                        Text("Make Member"),
                                      ],
                                    ),
                                  ),
                                PopupMenuItem(
                                  value: 'remove',
                                  child: Row(
                                    children: [
                                      Icon(Icons.remove_circle, color: dangerColor),
                                      SizedBox(width: spXs),
                                      Text("Remove Member"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      
      // Invite Dialog
      floatingActionButton: showInviteDialog
          ? null
          : FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                showInviteDialog = true;
                setState(() {});
              },
              child: Icon(Icons.person_add, color: Colors.white),
            ),
      
      // Invite Modal
      bottomSheet: showInviteDialog
          ? Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                boxShadow: [shadowLg],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Invite New Member",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showInviteDialog = false;
                          setState(() {});
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Email Address",
                    value: inviteEmail,
                    hint: "Enter email address to invite",
                    onChanged: (value) {
                      inviteEmail = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          color: secondaryColor,
                          size: bs.md,
                          onPressed: () {
                            showInviteDialog = false;
                            inviteEmail = "";
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Send Invite",
                          icon: Icons.send,
                          size: bs.md,
                          onPressed: _inviteMember,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // For safe area
                ],
              ),
            )
          : null,
    );
  }
}
