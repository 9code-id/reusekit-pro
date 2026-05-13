import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmInviteMembersView extends StatefulWidget {
  const TpmInviteMembersView({super.key});

  @override
  State<TpmInviteMembersView> createState() => _TpmInviteMembersViewState();
}

class _TpmInviteMembersViewState extends State<TpmInviteMembersView> {
  List<Map<String, dynamic>> inviteList = [];
  String emailInput = "";
  String selectedRole = "Member";
  String inviteMessage = "";
  bool sendWelcomeEmail = true;
  bool allowProjectAccess = true;

  List<Map<String, dynamic>> roleItems = [
    {"label": "Member", "value": "Member"},
    {"label": "Project Manager", "value": "Project Manager"},
    {"label": "Team Lead", "value": "Team Lead"},
    {"label": "Developer", "value": "Developer"},
    {"label": "Designer", "value": "Designer"},
    {"label": "Analyst", "value": "Analyst"},
  ];

  List<Map<String, dynamic>> suggestedUsers = [
    {
      "id": "1",
      "name": "Alex Thompson",
      "email": "alex.thompson@company.com",
      "avatar": "https://picsum.photos/40/40?random=10&keyword=man",
      "department": "Engineering",
      "isInvited": false,
    },
    {
      "id": "2",
      "name": "Maria Garcia",
      "email": "maria.garcia@company.com",
      "avatar": "https://picsum.photos/40/40?random=11&keyword=woman",
      "department": "Design",
      "isInvited": false,
    },
    {
      "id": "3",
      "name": "James Wilson",
      "email": "james.wilson@company.com",
      "avatar": "https://picsum.photos/40/40?random=12&keyword=man",
      "department": "Business",
      "isInvited": false,
    },
    {
      "id": "4",
      "name": "Sophie Chen",
      "email": "sophie.chen@company.com",
      "avatar": "https://picsum.photos/40/40?random=13&keyword=woman",
      "department": "Operations",
      "isInvited": false,
    },
  ];

  void _addEmailToInviteList() {
    if (emailInput.trim().isEmpty) {
      se("Please enter an email address");
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailInput.trim())) {
      se("Please enter a valid email address");
      return;
    }

    bool alreadyExists = inviteList.any((invite) => invite["email"] == emailInput.trim());
    if (alreadyExists) {
      sw("This email is already in the invite list");
      return;
    }

    Map<String, dynamic> newInvite = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "email": emailInput.trim(),
      "role": selectedRole,
      "status": "pending",
      "invitedAt": DateTime.now(),
    };

    inviteList.add(newInvite);
    emailInput = "";
    setState(() {});
    ss("Email added to invite list");
  }

  void _removeFromInviteList(String id) {
    inviteList.removeWhere((invite) => invite["id"] == id);
    setState(() {});
  }

  void _addSuggestedUser(Map<String, dynamic> user) {
    Map<String, dynamic> newInvite = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "email": user["email"],
      "name": user["name"],
      "avatar": user["avatar"],
      "role": selectedRole,
      "status": "pending",
      "invitedAt": DateTime.now(),
    };

    inviteList.add(newInvite);
    
    // Mark as invited in suggestions
    int index = suggestedUsers.indexWhere((u) => u["id"] == user["id"]);
    if (index != -1) {
      suggestedUsers[index]["isInvited"] = true;
    }
    
    setState(() {});
    ss("${user["name"]} added to invite list");
  }

  void _sendInvitations() async {
    if (inviteList.isEmpty) {
      se("Please add at least one person to invite");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    // Simulate sending invitations
    for (var invite in inviteList) {
      invite["status"] = "sent";
      invite["sentAt"] = DateTime.now();
    }

    setState(() {});
    ss("Invitations sent successfully to ${inviteList.length} ${inviteList.length == 1 ? 'person' : 'people'}");
    
    await Future.delayed(Duration(seconds: 1));
    back();
  }

  String _getRoleIcon(String role) {
    switch (role) {
      case "Project Manager":
        return "👨‍💼";
      case "Team Lead":
        return "🎯";
      case "Developer":
        return "👨‍💻";
      case "Designer":
        return "🎨";
      case "Analyst":
        return "📊";
      default:
        return "👤";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Members"),
        actions: [
          QButton(
            label: "Send Invites",
            size: bs.sm,
            onPressed: inviteList.isNotEmpty ? _sendInvitations : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Invite Form Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_add, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Invite New Members",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: QTextField(
                          label: "Email Address",
                          value: emailInput,
                          hint: "Enter email address",
                          onChanged: (value) {
                            emailInput = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Role",
                          items: roleItems,
                          value: selectedRole,
                          onChanged: (value, label) {
                            selectedRole = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Add to Invite List",
                      size: bs.sm,
                      onPressed: _addEmailToInviteList,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Suggested Users Section
            if (suggestedUsers.any((user) => !user["isInvited"]))
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people_alt, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Suggested Team Members",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    ...suggestedUsers.where((user) => !user["isInvited"]).map((user) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledColor),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage("${user["avatar"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${user["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${user["email"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${user["department"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.add,
                              size: bs.sm,
                              onPressed: () => _addSuggestedUser(user),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

            if (suggestedUsers.any((user) => !user["isInvited"]))
              SizedBox(height: spMd),

            // Invite List Section
            if (inviteList.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mail, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Pending Invitations (${inviteList.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    ...inviteList.map((invite) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(50)),
                        ),
                        child: Row(
                          children: [
                            if (invite["avatar"] != null)
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage("${invite["avatar"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            else
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "${invite["email"]}".substring(0, 1).toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (invite["name"] != null)
                                    Text(
                                      "${invite["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  Text(
                                    "${invite["email"]}",
                                    style: TextStyle(
                                      fontSize: invite["name"] != null ? 12 : 14,
                                      color: invite["name"] != null ? disabledBoldColor : primaryColor,
                                      fontWeight: invite["name"] != null ? FontWeight.normal : FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        _getRoleIcon("${invite["role"]}"),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${invite["role"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${invite["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.close,
                              size: bs.sm,
                              onPressed: () => _removeFromInviteList("${invite["id"]}"),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

            if (inviteList.isNotEmpty)
              SizedBox(height: spMd),

            // Invitation Settings Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.settings, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Invitation Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QMemoField(
                    label: "Welcome Message (Optional)",
                    value: inviteMessage,
                    hint: "Add a personal message to the invitation...",
                    onChanged: (value) {
                      inviteMessage = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Send welcome email with workspace info",
                        "value": true,
                        "checked": sendWelcomeEmail,
                      }
                    ],
                    value: [if (sendWelcomeEmail) {"label": "Send welcome email with workspace info", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      if (values.isNotEmpty) {
                        sendWelcomeEmail = values.isNotEmpty;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spXs),
                  QSwitch(
                    items: [
                      {
                        "label": "Allow access to existing projects",
                        "value": true,
                        "checked": allowProjectAccess,
                      }
                    ],
                    value: [if (allowProjectAccess) {"label": "Allow access to existing projects", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      if (values.isNotEmpty) {
                        allowProjectAccess = values.isNotEmpty;
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Summary Section
            if (inviteList.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Invitation Summary",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "• ${inviteList.length} ${inviteList.length == 1 ? 'person' : 'people'} will be invited to the workspace",
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "• Invited members will have ${selectedRole.toLowerCase()} permissions",
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryColor,
                      ),
                    ),
                    if (sendWelcomeEmail)
                      Text(
                        "• Welcome email will be sent with workspace information",
                        style: TextStyle(
                          fontSize: 13,
                          color: primaryColor,
                        ),
                      ),
                    if (allowProjectAccess)
                      Text(
                        "• New members will have access to existing projects",
                        style: TextStyle(
                          fontSize: 13,
                          color: primaryColor,
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
