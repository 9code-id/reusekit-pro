import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmEmailNotificationsView extends StatefulWidget {
  const TpmEmailNotificationsView({super.key});

  @override
  State<TpmEmailNotificationsView> createState() => _TpmEmailNotificationsViewState();
}

class _TpmEmailNotificationsViewState extends State<TpmEmailNotificationsView> {
  // Email notification settings
  bool emailNotificationsEnabled = true;
  String primaryEmail = "john.doe@company.com";
  String backupEmail = "";
  
  // Notification types
  bool taskAssignmentEmails = true;
  bool deadlineReminderEmails = true;
  bool projectUpdateEmails = true;
  bool teamMentionEmails = true;
  bool weeklyDigestEmails = true;
  bool monthlyReportEmails = false;
  bool promotionalEmails = false;
  
  // Timing settings
  String digestFrequency = "Weekly";
  List<String> digestOptions = ["Daily", "Weekly", "Monthly", "Never"];
  
  String reminderTiming = "24 hours";
  List<String> reminderOptions = ["1 hour", "6 hours", "12 hours", "24 hours", "48 hours"];

  List<Map<String, dynamic>> emailTemplates = [
    {
      "id": 1,
      "name": "Task Assignment",
      "subject": "New Task Assigned: {task_name}",
      "description": "Notification when a task is assigned to you",
      "enabled": true,
      "lastModified": "2024-06-19 10:30:00",
      "category": "Tasks"
    },
    {
      "id": 2,
      "name": "Deadline Reminder",
      "subject": "Deadline Alert: {task_name} due {due_date}",
      "description": "Reminder before task deadlines",
      "enabled": true,
      "lastModified": "2024-06-18 14:20:00",
      "category": "Deadlines"
    },
    {
      "id": 3,
      "name": "Project Update",
      "subject": "Project Status Update: {project_name}",
      "description": "Updates on project progress and milestones",
      "enabled": true,
      "lastModified": "2024-06-17 09:15:00",
      "category": "Projects"
    },
    {
      "id": 4,
      "name": "Team Mention",
      "subject": "You were mentioned in {project_name}",
      "description": "When someone mentions you in comments",
      "enabled": true,
      "lastModified": "2024-06-16 11:45:00",
      "category": "Team"
    },
    {
      "id": 5,
      "name": "Weekly Digest",
      "subject": "Weekly Summary - {week_of}",
      "description": "Weekly summary of your activities and tasks",
      "enabled": true,
      "lastModified": "2024-06-15 16:30:00",
      "category": "Digest"
    }
  ];

  List<Map<String, dynamic>> recentEmails = [
    {
      "id": 1,
      "subject": "Task Assignment: Implement user authentication",
      "recipient": "john.doe@company.com",
      "status": "Delivered",
      "sentAt": "2024-06-19 10:30:00",
      "type": "Task Assignment",
      "opened": true
    },
    {
      "id": 2,
      "subject": "Deadline Alert: Database optimization due tomorrow",
      "recipient": "john.doe@company.com",
      "status": "Delivered",
      "sentAt": "2024-06-19 09:15:00",
      "type": "Deadline Reminder",
      "opened": true
    },
    {
      "id": 3,
      "subject": "Weekly Summary - Week of June 17",
      "recipient": "john.doe@company.com",
      "status": "Delivered",
      "sentAt": "2024-06-18 18:00:00",
      "type": "Weekly Digest",
      "opened": false
    },
    {
      "id": 4,
      "subject": "You were mentioned in UI/UX Redesign",
      "recipient": "john.doe@company.com",
      "status": "Failed",
      "sentAt": "2024-06-18 14:20:00",
      "type": "Team Mention",
      "opened": false
    }
  ];

  int selectedTab = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Notifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendTestEmail,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTab,
              tabs: [
                Tab(text: "Settings", icon: Icon(Icons.settings)),
                Tab(text: "Templates", icon: Icon(Icons.email)),
                Tab(text: "History", icon: Icon(Icons.history)),
              ],
              tabChildren: [
                _buildSettingsTab(),
                _buildTemplatesTab(),
                _buildHistoryTab(),
              ],
            ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Email Configuration", Icons.email),
          _buildEmailConfiguration(),
          SizedBox(height: spMd),
          
          _buildSectionHeader("Notification Types", Icons.notifications),
          _buildNotificationTypes(),
          SizedBox(height: spMd),
          
          _buildSectionHeader("Timing & Frequency", Icons.schedule),
          _buildTimingSettings(),
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Email Settings",
              size: bs.md,
              onPressed: _saveEmailSettings,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Email Templates", Icons.email),
          SizedBox(height: spSm),
          Text(
            "Customize email templates for different notification types",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ...emailTemplates.map((template) => _buildTemplateCard(template)).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Email History", Icons.history),
          SizedBox(height: spSm),
          _buildEmailStats(),
          SizedBox(height: spMd),
          Text(
            "Recent Emails",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...recentEmails.map((email) => _buildEmailHistoryCard(email)).toList(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: spXs),
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailConfiguration() {
    return Container(
      margin: EdgeInsets.only(top: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            title: "Enable Email Notifications",
            subtitle: "Receive notifications via email",
            value: emailNotificationsEnabled,
            onChanged: (value) {
              emailNotificationsEnabled = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Primary Email",
            value: primaryEmail,
            onChanged: (value) {
              primaryEmail = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Backup Email (Optional)",
            value: backupEmail,
            hint: "Secondary email for important notifications",
            onChanged: (value) {
              backupEmail = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTypes() {
    return Container(
      margin: EdgeInsets.only(top: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            title: "Task Assignments",
            subtitle: "When you're assigned to a task",
            value: taskAssignmentEmails,
            enabled: emailNotificationsEnabled,
            onChanged: (value) {
              taskAssignmentEmails = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Deadline Reminders",
            subtitle: "Reminders before task deadlines",
            value: deadlineReminderEmails,
            enabled: emailNotificationsEnabled,
            onChanged: (value) {
              deadlineReminderEmails = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Project Updates",
            subtitle: "Project status and milestone changes",
            value: projectUpdateEmails,
            enabled: emailNotificationsEnabled,
            onChanged: (value) {
              projectUpdateEmails = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Team Mentions",
            subtitle: "When someone mentions you",
            value: teamMentionEmails,
            enabled: emailNotificationsEnabled,
            onChanged: (value) {
              teamMentionEmails = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Weekly Digest",
            subtitle: "Weekly summary of activities",
            value: weeklyDigestEmails,
            enabled: emailNotificationsEnabled,
            onChanged: (value) {
              weeklyDigestEmails = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Monthly Reports",
            subtitle: "Monthly performance reports",
            value: monthlyReportEmails,
            enabled: emailNotificationsEnabled,
            onChanged: (value) {
              monthlyReportEmails = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Promotional Emails",
            subtitle: "Product updates and announcements",
            value: promotionalEmails,
            enabled: emailNotificationsEnabled,
            onChanged: (value) {
              promotionalEmails = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimingSettings() {
    return Container(
      margin: EdgeInsets.only(top: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          QDropdownField(
            label: "Digest Frequency",
            items: digestOptions.map((option) => {"label": option, "value": option}).toList(),
            value: digestFrequency,
            onChanged: (value, label) {
              digestFrequency = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Reminder Timing",
            items: reminderOptions.map((option) => {"label": option, "value": option}).toList(),
            value: reminderTiming,
            onChanged: (value, label) {
              reminderTiming = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: template["enabled"] as bool,
                onChanged: (value) => _toggleTemplate(template, value),
                activeColor: successColor,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Subject Line:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${template["subject"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${template["category"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Modified ${DateTime.parse(template["lastModified"]).dMMMy}",
                style: TextStyle(
                  color: disabledColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Template",
                  size: bs.sm,
                  onPressed: () => _editTemplate(template),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Preview",
                size: bs.sm,
                onPressed: () => _previewTemplate(template),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmailStats() {
    int deliveredCount = recentEmails.where((e) => e["status"] == "Delivered").length;
    int openedCount = recentEmails.where((e) => e["opened"] == true).length;
    int failedCount = recentEmails.where((e) => e["status"] == "Failed").length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Delivered",
            value: "$deliveredCount",
            icon: Icons.check_circle,
            color: successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Opened",
            value: "$openedCount",
            icon: Icons.mark_email_read,
            color: infoColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Failed",
            value: "$failedCount",
            icon: Icons.error,
            color: dangerColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailHistoryCard(Map<String, dynamic> email) {
    Color statusColor = email["status"] == "Delivered" 
        ? successColor 
        : email["status"] == "Failed" 
            ? dangerColor 
            : warningColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${email["subject"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "To: ${email["recipient"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${email["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${email["type"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (email["opened"] == true) ...[
                SizedBox(width: spSm),
                Icon(Icons.mark_email_read, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Opened",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              Spacer(),
              Text(
                "${DateTime.parse(email["sentAt"]).dMMMy}",
                style: TextStyle(
                  color: disabledColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool enabled = true,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: enabled ? primaryColor : disabledColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: enabled ? disabledBoldColor : disabledColor,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: enabled ? value : false,
          onChanged: enabled ? onChanged : null,
          activeColor: successColor,
        ),
      ],
    );
  }

  void _toggleTemplate(Map<String, dynamic> template, bool value) {
    int index = emailTemplates.indexWhere((t) => t["id"] == template["id"]);
    if (index != -1) {
      emailTemplates[index]["enabled"] = value;
      setState(() {});
    }
  }

  void _editTemplate(Map<String, dynamic> template) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit Template: ${template["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: Column(
                children: [
                  QTextField(
                    label: "Subject Line",
                    value: template["subject"],
                    onChanged: (value) {},
                  ),
                  SizedBox(height: spSm),
                  QMemoField(
                    label: "Email Content",
                    value: "Default email template content goes here...",
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Changes",
                    size: bs.md,
                    onPressed: () {
                      back();
                      ss("Template saved successfully");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Cancel",
                  size: bs.md,
                  onPressed: () => back(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _previewTemplate(Map<String, dynamic> template) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Preview: ${template["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Subject: ${template["subject"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Dear John Doe,\n\nThis is a preview of the ${template["name"]} email template. The actual content will be populated with real data when the notification is sent.\n\nThank you,\nProject Management Team",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Close Preview",
                size: bs.md,
                onPressed: () => back(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveEmailSettings() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});
    
    ss("Email settings saved successfully");
  }

  void _sendTestEmail() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});
    
    ss("Test email sent to $primaryEmail");
  }
}
