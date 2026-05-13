import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmProjectSettingsView extends StatefulWidget {
  const TpmProjectSettingsView({super.key});

  @override
  State<TpmProjectSettingsView> createState() => _TpmProjectSettingsViewState();
}

class _TpmProjectSettingsViewState extends State<TpmProjectSettingsView> {
  final formKey = GlobalKey<FormState>();
  
  // Project Basic Info
  String projectName = "E-Commerce Platform";
  String projectDescription = "A comprehensive e-commerce platform with modern features and scalable architecture";
  String projectCategory = "web_development";
  String projectStatus = "active";
  DateTime startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime endDate = DateTime.now().add(Duration(days: 60));
  
  // Project Access & Permissions
  bool isPublic = false;
  bool allowGuestAccess = false;
  bool enableNotifications = true;
  bool enableEmailUpdates = true;
  bool enableTaskReminders = true;
  bool allowFileSharing = true;
  bool requireApproval = false;
  
  // Team Management
  List<Map<String, dynamic>> teamMembers = [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/40/40?random=1",
      "permissions": ["read", "write", "delete", "admin"],
      "joinedAt": DateTime.now().subtract(Duration(days: 30)),
      "isActive": true,
    },
    {
      "id": 2,
      "name": "Jane Smith",
      "email": "jane@example.com",
      "role": "UI/UX Designer",
      "avatar": "https://picsum.photos/40/40?random=2",
      "permissions": ["read", "write"],
      "joinedAt": DateTime.now().subtract(Duration(days: 25)),
      "isActive": true,
    },
    {
      "id": 3,
      "name": "Mike Johnson",
      "email": "mike@example.com",
      "role": "Backend Developer",
      "avatar": "https://picsum.photos/40/40?random=3",
      "permissions": ["read", "write", "delete"],
      "joinedAt": DateTime.now().subtract(Duration(days: 20)),
      "isActive": true,
    },
    {
      "id": 4,
      "name": "Sarah Wilson",
      "email": "sarah@example.com",
      "role": "QA Engineer",
      "avatar": "https://picsum.photos/40/40?random=4",
      "permissions": ["read", "write"],
      "joinedAt": DateTime.now().subtract(Duration(days: 15)),
      "isActive": false,
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Web Development", "value": "web_development"},
    {"label": "Mobile Development", "value": "mobile_development"},
    {"label": "Desktop Application", "value": "desktop_application"},
    {"label": "Data Analysis", "value": "data_analysis"},
    {"label": "Marketing Campaign", "value": "marketing_campaign"},
    {"label": "Research Project", "value": "research_project"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "active"},
    {"label": "On Hold", "value": "on_hold"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> roleOptions = [
    {"label": "Project Manager", "value": "project_manager"},
    {"label": "Team Lead", "value": "team_lead"},
    {"label": "Developer", "value": "developer"},
    {"label": "Designer", "value": "designer"},
    {"label": "QA Engineer", "value": "qa_engineer"},
    {"label": "Viewer", "value": "viewer"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Settings"),
        actions: [
          QButton(
            label: "Save Changes",
            size: bs.sm,
            onPressed: () => _saveSettings(),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spLg,
            children: [
              _buildProjectInfoSection(),
              _buildProjectDatesSection(),
              _buildAccessPermissionsSection(),
              _buildNotificationSettingsSection(),
              _buildTeamManagementSection(),
              _buildDangerZoneSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Project Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Project Name",
            value: projectName,
            validator: Validator.required,
            onChanged: (value) {
              projectName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Project Description",
            value: projectDescription,
            hint: "Describe your project goals and objectives",
            validator: Validator.required,
            onChanged: (value) {
              projectDescription = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: projectCategory,
                  onChanged: (value, label) {
                    projectCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: projectStatus,
                  onChanged: (value, label) {
                    projectStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectDatesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Project Timeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Start Date",
                  value: startDate,
                  onChanged: (value) {
                    startDate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDatePicker(
                  label: "End Date",
                  value: endDate,
                  onChanged: (value) {
                    endDate = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Duration: ${endDate.difference(startDate).inDays} days",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessPermissionsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Access & Permissions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Public Project",
                "value": true,
                "checked": isPublic,
              }
            ],
            value: [if (isPublic) {"label": "Public Project", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                isPublic = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Allow Guest Access",
                "value": true,
                "checked": allowGuestAccess,
              }
            ],
            value: [if (allowGuestAccess) {"label": "Allow Guest Access", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                allowGuestAccess = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Enable File Sharing",
                "value": true,
                "checked": allowFileSharing,
              }
            ],
            value: [if (allowFileSharing) {"label": "Enable File Sharing", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                allowFileSharing = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Require Task Approval",
                "value": true,
                "checked": requireApproval,
              }
            ],
            value: [if (requireApproval) {"label": "Require Task Approval", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                requireApproval = values.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettingsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Notification Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Notifications",
                "value": true,
                "checked": enableNotifications,
              }
            ],
            value: [if (enableNotifications) {"label": "Enable Notifications", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                enableNotifications = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Email Updates",
                "value": true,
                "checked": enableEmailUpdates,
              }
            ],
            value: [if (enableEmailUpdates) {"label": "Email Updates", "value": true, "checked": true}],
            onChanged: (values, ids) {
              if (enableNotifications) {
                setState(() {
                  enableEmailUpdates = values.isNotEmpty;
                });
              }
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Task Reminders",
                "value": true,
                "checked": enableTaskReminders,
              }
            ],
            value: [if (enableTaskReminders) {"label": "Task Reminders", "value": true, "checked": true}],
            onChanged: (values, ids) {
              if (enableNotifications) {
                setState(() {
                  enableTaskReminders = values.isNotEmpty;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamManagementSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
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
                icon: Icons.person_add,
                size: bs.sm,
                onPressed: () => _showInviteMemberDialog(),
              ),
            ],
          ),
          ...teamMembers.map((member) => _buildTeamMemberItem(member)).toList(),
        ],
      ),
    );
  }

  Widget _buildTeamMemberItem(Map<String, dynamic> member) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("${member["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${member["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    if (!(member["isActive"] as bool)) ...[
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "INACTIVE",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
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
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${member["role"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(color: disabledColor),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Joined ${(member["joinedAt"] as DateTime).dMMMy}",
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
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () => _showEditMemberDialog(member),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.delete,
            size: bs.sm,
            color: dangerColor,
            onPressed: () => _removeMember(member),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZoneSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: dangerColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Danger Zone",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          Text(
            "These actions are irreversible. Please proceed with caution.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Archive Project",
                  icon: Icons.archive,
                  size: bs.sm,
                  color: warningColor,
                  onPressed: () => _archiveProject(),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: "Delete Project",
                  icon: Icons.delete_forever,
                  size: bs.sm,
                  color: dangerColor,
                  onPressed: () => _deleteProject(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveSettings() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Project settings saved successfully");
    }
  }

  void _showInviteMemberDialog() {
    // Implementation for invite member dialog
  }

  void _showEditMemberDialog(Map<String, dynamic> member) {
    // Implementation for edit member dialog
  }

  void _removeMember(Map<String, dynamic> member) async {
    bool isConfirmed = await confirm("Are you sure you want to remove ${member["name"]} from this project?");
    if (isConfirmed) {
      setState(() {
        teamMembers.remove(member);
      });
      ss("${member["name"]} has been removed from the project");
    }
  }

  void _archiveProject() async {
    bool isConfirmed = await confirm("Are you sure you want to archive this project? It will be moved to archived projects.");
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Project has been archived successfully");
    }
  }

  void _deleteProject() async {
    bool isConfirmed = await confirm("Are you sure you want to permanently delete this project? This action cannot be undone.");
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      se("Project deletion is not implemented in this demo");
    }
  }
}
