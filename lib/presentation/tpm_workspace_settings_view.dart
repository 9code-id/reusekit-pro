import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmWorkspaceSettingsView extends StatefulWidget {
  const TpmWorkspaceSettingsView({super.key});

  @override
  State<TpmWorkspaceSettingsView> createState() => _TpmWorkspaceSettingsViewState();
}

class _TpmWorkspaceSettingsViewState extends State<TpmWorkspaceSettingsView> {
  int currentTab = 0;

  // General Settings
  String workspaceName = "Design Team Workspace";
  String workspaceDescription = "Creative design projects and collaboration space";
  bool publicWorkspace = false;
  bool allowGuestAccess = true;
  String workspaceTimezone = "UTC-5";

  // Notification Settings
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool taskDeadlineReminders = true;
  bool teamMentions = true;
  bool projectUpdates = true;

  // Privacy Settings
  bool requireApprovalForJoining = true;
  bool allowMemberInvites = true;
  bool showMemberList = true;
  bool allowFileSharing = true;

  // Integration Settings
  bool slackIntegration = false;
  bool discordIntegration = false;
  bool githubIntegration = true;
  bool googleDriveIntegration = true;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Workspace Settings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "General", icon: Icon(Icons.settings)),
        Tab(text: "Members", icon: Icon(Icons.people)),
        Tab(text: "Privacy", icon: Icon(Icons.security)),
        Tab(text: "Integrations", icon: Icon(Icons.extension)),
      ],
      tabChildren: [
        _buildGeneralTab(),
        _buildMembersTab(),
        _buildPrivacyTab(),
        _buildIntegrationsTab(),
      ],
    );
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workspace Information
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
                Text(
                  "Workspace Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                QTextField(
                  label: "Workspace Name",
                  value: workspaceName,
                  validator: Validator.required,
                  onChanged: (value) {
                    workspaceName = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                QMemoField(
                  label: "Description",
                  value: workspaceDescription,
                  hint: "Describe the purpose of this workspace",
                  onChanged: (value) {
                    workspaceDescription = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                QDropdownField(
                  label: "Timezone",
                  items: [
                    {"label": "UTC-8 (Pacific)", "value": "UTC-8"},
                    {"label": "UTC-5 (Eastern)", "value": "UTC-5"},
                    {"label": "UTC+0 (GMT)", "value": "UTC+0"},
                    {"label": "UTC+1 (CET)", "value": "UTC+1"},
                    {"label": "UTC+8 (CST)", "value": "UTC+8"},
                  ],
                  value: workspaceTimezone,
                  onChanged: (value, label) {
                    workspaceTimezone = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Workspace Visibility
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
                Text(
                  "Visibility & Access",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildSettingSwitch(
                  "Public Workspace",
                  "Allow anyone to discover this workspace",
                  publicWorkspace,
                  (value) {
                    publicWorkspace = value;
                    setState(() {});
                  },
                ),
                _buildSettingSwitch(
                  "Guest Access",
                  "Allow guests to view projects",
                  allowGuestAccess,
                  (value) {
                    allowGuestAccess = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Notification Settings
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
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildSettingSwitch(
                  "Email Notifications",
                  "Receive workspace updates via email",
                  emailNotifications,
                  (value) {
                    emailNotifications = value;
                    setState(() {});
                  },
                ),
                _buildSettingSwitch(
                  "Push Notifications",
                  "Receive real-time mobile notifications",
                  pushNotifications,
                  (value) {
                    pushNotifications = value;
                    setState(() {});
                  },
                ),
                _buildSettingSwitch(
                  "Task Deadline Reminders",
                  "Get notified about upcoming deadlines",
                  taskDeadlineReminders,
                  (value) {
                    taskDeadlineReminders = value;
                    setState(() {});
                  },
                ),
                _buildSettingSwitch(
                  "Team Mentions",
                  "Get notified when mentioned by team members",
                  teamMentions,
                  (value) {
                    teamMentions = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Save Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Changes",
              size: bs.md,
              onPressed: () {
                ss("Settings saved successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    List<Map<String, dynamic>> members = [
      {
        "name": "John Smith",
        "email": "john@company.com",
        "role": "Admin",
        "avatar": "https://picsum.photos/100/100?random=1",
        "status": "Online",
        "joinDate": "2024-01-15",
      },
      {
        "name": "Sarah Johnson",
        "email": "sarah@company.com",
        "role": "Member",
        "avatar": "https://picsum.photos/100/100?random=2",
        "status": "Away",
        "joinDate": "2024-02-20",
      },
      {
        "name": "Mike Chen",
        "email": "mike@company.com",
        "role": "Member",
        "avatar": "https://picsum.photos/100/100?random=3",
        "status": "Offline",
        "joinDate": "2024-03-10",
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Member Management
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
                    Text(
                      "Team Members (${members.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Invite Members",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                Column(
                  children: members.map((member) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${member["avatar"]}"),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${member["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${member["email"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Joined: ${member["joinDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getRoleColor("${member["role"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${member["role"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getRoleColor("${member["role"]}"),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Roles & Permissions
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
                Text(
                  "Roles & Permissions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildRoleItem("Admin", "Full access to workspace settings and management", primaryColor),
                _buildRoleItem("Member", "Can view and edit projects, create tasks", successColor),
                _buildRoleItem("Viewer", "Read-only access to projects and tasks", infoColor),
                _buildRoleItem("Guest", "Limited access to specific projects only", warningColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Access Control
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
                Text(
                  "Access Control",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildSettingSwitch(
                  "Require Approval for Joining",
                  "New members need admin approval",
                  requireApprovalForJoining,
                  (value) {
                    requireApprovalForJoining = value;
                    setState(() {});
                  },
                ),
                _buildSettingSwitch(
                  "Allow Member Invites",
                  "Members can invite new people",
                  allowMemberInvites,
                  (value) {
                    allowMemberInvites = value;
                    setState(() {});
                  },
                ),
                _buildSettingSwitch(
                  "Show Member List",
                  "Display list of all workspace members",
                  showMemberList,
                  (value) {
                    showMemberList = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Data & File Sharing
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
                Text(
                  "Data & File Sharing",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildSettingSwitch(
                  "Allow File Sharing",
                  "Members can upload and share files",
                  allowFileSharing,
                  (value) {
                    allowFileSharing = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Danger Zone
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Danger Zone",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "These actions cannot be undone. Please proceed with caution.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Archive Workspace",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: QButton(
                          label: "Delete Workspace",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Communication Tools
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
                Text(
                  "Communication Tools",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildIntegrationItem(
                  "Slack",
                  "Connect with your Slack workspace",
                  Icons.chat,
                  slackIntegration,
                  (value) {
                    slackIntegration = value;
                    setState(() {});
                  },
                ),
                _buildIntegrationItem(
                  "Discord",
                  "Integrate with Discord servers",
                  Icons.games,
                  discordIntegration,
                  (value) {
                    discordIntegration = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Development Tools
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
                Text(
                  "Development Tools",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildIntegrationItem(
                  "GitHub",
                  "Link repositories and track commits",
                  Icons.code,
                  githubIntegration,
                  (value) {
                    githubIntegration = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // File Storage
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
                Text(
                  "File Storage",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildIntegrationItem(
                  "Google Drive",
                  "Sync files with Google Drive",
                  Icons.cloud,
                  googleDriveIntegration,
                  (value) {
                    googleDriveIntegration = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSwitch(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
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

  Widget _buildRoleItem(String role, String description, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(Icons.person, color: color, size: 20),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationItem(String name, String description, IconData icon, bool isConnected, Function(bool) onToggle) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isConnected ? successColor.withAlpha(30) : disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: isConnected ? successColor : disabledBoldColor,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isConnected,
            onChanged: onToggle,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case "Admin":
        return primaryColor;
      case "Member":
        return successColor;
      case "Viewer":
        return infoColor;
      case "Guest":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
