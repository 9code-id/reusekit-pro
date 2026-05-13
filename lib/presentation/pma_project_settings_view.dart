import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaProjectSettingsView extends StatefulWidget {
  const PmaProjectSettingsView({super.key});

  @override
  State<PmaProjectSettingsView> createState() => _PmaProjectSettingsViewState();
}

class _PmaProjectSettingsViewState extends State<PmaProjectSettingsView> {
  int currentTab = 0;
  
  // General Settings
  String projectName = "E-commerce Platform";
  String projectDescription = "Development of a modern e-commerce platform with advanced features";
  String projectManager = "Sarah Wilson";
  String startDate = "2024-01-15";
  String endDate = "2024-06-30";
  double budget = 50000.0;
  String priority = "High";
  String status = "In Progress";
  
  // Notification Settings
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool slackNotifications = false;
  bool weeklyReports = true;
  bool milestoneReminders = true;
  bool deadlineAlerts = true;
  bool statusUpdates = false;
  
  // Team Access Settings
  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "John Smith",
      "email": "john.smith@company.com",
      "role": "Backend Developer",
      "permissions": ["Read", "Write", "Comment"],
      "active": true,
    },
    {
      "name": "Alice Johnson",
      "email": "alice.johnson@company.com",
      "role": "Frontend Developer",
      "permissions": ["Read", "Write", "Comment"],
      "active": true,
    },
    {
      "name": "Mike Chen",
      "email": "mike.chen@company.com",
      "role": "UI/UX Designer",
      "permissions": ["Read", "Comment"],
      "active": true,
    },
    {
      "name": "Emily Rodriguez",
      "email": "emily.rodriguez@company.com",
      "role": "QA Engineer",
      "permissions": ["Read", "Write"],
      "active": false,
    },
  ];
  
  // Privacy Settings
  bool projectVisibility = true;
  bool allowGuestAccess = false;
  bool requireApprovalForChanges = true;
  bool enableTimeTracking = true;
  bool allowFileSharing = true;
  
  Widget _buildGeneralSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Project Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Project Name",
            value: projectName,
            onChanged: (value) {
              projectName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Project Description",
            value: projectDescription,
            onChanged: (value) {
              projectDescription = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Project Manager",
            value: projectManager,
            onChanged: (value) {
              projectManager = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Start Date",
                  value: DateTime.parse(startDate),
                  onChanged: (value) {
                    startDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "End Date",
                  value: DateTime.parse(endDate),
                  onChanged: (value) {
                    endDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QNumberField(
            label: "Budget (\$)",
            value: budget.toString(),
            onChanged: (value) {
              budget = double.tryParse(value) ?? 0.0;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "Critical", "value": "Critical"},
                    {"label": "High", "value": "High"},
                    {"label": "Medium", "value": "Medium"},
                    {"label": "Low", "value": "Low"},
                  ],
                  value: priority,
                  onChanged: (value, label) {
                    priority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "Planning", "value": "Planning"},
                    {"label": "In Progress", "value": "In Progress"},
                    {"label": "On Hold", "value": "On Hold"},
                    {"label": "Completed", "value": "Completed"},
                    {"label": "Cancelled", "value": "Cancelled"},
                  ],
                  value: status,
                  onChanged: (value, label) {
                    status = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Changes",
              size: bs.md,
              onPressed: () {
                ss("Project settings updated successfully!");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notification Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildNotificationOption(
            "Email Notifications",
            "Receive notifications via email",
            emailNotifications,
            (value) {
              emailNotifications = value;
              setState(() {});
            },
          ),
          _buildNotificationOption(
            "Push Notifications",
            "Receive push notifications on mobile",
            pushNotifications,
            (value) {
              pushNotifications = value;
              setState(() {});
            },
          ),
          _buildNotificationOption(
            "Slack Notifications",
            "Send updates to Slack channels",
            slackNotifications,
            (value) {
              slackNotifications = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Divider(),
          SizedBox(height: spMd),
          Text(
            "Notification Types",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildNotificationOption(
            "Weekly Reports",
            "Receive weekly progress reports",
            weeklyReports,
            (value) {
              weeklyReports = value;
              setState(() {});
            },
          ),
          _buildNotificationOption(
            "Milestone Reminders",
            "Get notified about upcoming milestones",
            milestoneReminders,
            (value) {
              milestoneReminders = value;
              setState(() {});
            },
          ),
          _buildNotificationOption(
            "Deadline Alerts",
            "Receive alerts for approaching deadlines",
            deadlineAlerts,
            (value) {
              deadlineAlerts = value;
              setState(() {});
            },
          ),
          _buildNotificationOption(
            "Status Updates",
            "Get notified when project status changes",
            statusUpdates,
            (value) {
              statusUpdates = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Notification Settings",
              size: bs.md,
              onPressed: () {
                ss("Notification settings saved!");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationOption(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamAccessSettings() {
    return Container(
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
              Expanded(
                child: Text(
                  "Team Access Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.person_add,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('AddTeamMemberView')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...teamMembers.map((member) => _buildTeamMemberItem(member)),
        ],
      ),
    );
  }

  Widget _buildTeamMemberItem(Map<String, dynamic> member) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (member["active"] as bool) ? primaryColor.withAlpha(5) : disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: (member["active"] as bool) ? disabledOutlineBorderColor : disabledColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: primaryColor,
                child: Text(
                  "${member["name"]}".split(" ").map((n) => n[0]).join(""),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${member["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${member["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${member["role"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: member["active"] as bool,
                onChanged: (value) {
                  member["active"] = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Text(
                "Permissions: ",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ...(member["permissions"] as List).map((permission) => Container(
                margin: EdgeInsets.only(right: spXs),
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$permission",
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
              Spacer(),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //editMemberPermissions
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Privacy & Security",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildPrivacyOption(
            "Project Visibility",
            "Make project visible to all team members",
            projectVisibility,
            (value) {
              projectVisibility = value;
              setState(() {});
            },
          ),
          _buildPrivacyOption(
            "Allow Guest Access",
            "Allow external users to view project",
            allowGuestAccess,
            (value) {
              allowGuestAccess = value;
              setState(() {});
            },
          ),
          _buildPrivacyOption(
            "Require Approval for Changes",
            "Changes must be approved by project manager",
            requireApprovalForChanges,
            (value) {
              requireApprovalForChanges = value;
              setState(() {});
            },
          ),
          _buildPrivacyOption(
            "Enable Time Tracking",
            "Track time spent on tasks and project",
            enableTimeTracking,
            (value) {
              enableTimeTracking = value;
              setState(() {});
            },
          ),
          _buildPrivacyOption(
            "Allow File Sharing",
            "Enable file uploads and sharing",
            allowFileSharing,
            (value) {
              allowFileSharing = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Privacy Settings",
              size: bs.md,
              onPressed: () {
                ss("Privacy settings updated!");
              },
            ),
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Delete Project",
              size: bs.md,
              onPressed: () async {
                bool isConfirmed = await confirm("Are you sure you want to delete this project? This action cannot be undone.");
                if (isConfirmed) {
                  se("Project deletion feature not implemented yet");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyOption(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Project Settings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "General", icon: Icon(Icons.settings)),
        Tab(text: "Notifications", icon: Icon(Icons.notifications)),
        Tab(text: "Team Access", icon: Icon(Icons.group)),
        Tab(text: "Privacy", icon: Icon(Icons.security)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildGeneralSettings(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildNotificationSettings(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTeamAccessSettings(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildPrivacySettings(),
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
