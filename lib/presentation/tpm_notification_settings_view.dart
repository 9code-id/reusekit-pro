import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmNotificationSettingsView extends StatefulWidget {
  const TpmNotificationSettingsView({super.key});

  @override
  State<TpmNotificationSettingsView> createState() => _TpmNotificationSettingsViewState();
}

class _TpmNotificationSettingsViewState extends State<TpmNotificationSettingsView> {
  // Global notification settings
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool badgeEnabled = true;
  
  // Project notifications
  bool taskAssignments = true;
  bool taskDeadlines = true;
  bool taskComments = true;
  bool projectUpdates = true;
  bool statusChanges = true;
  
  // Team notifications
  bool teamMessages = true;
  bool meetingReminders = true;
  bool mentionNotifications = true;
  bool teamUpdates = false;
  
  // System notifications
  bool systemMaintenance = true;
  bool securityAlerts = true;
  bool featureUpdates = false;
  bool promotionalEmails = false;
  
  // Timing settings
  String quietHoursStart = "22:00";
  String quietHoursEnd = "08:00";
  bool quietHoursEnabled = true;
  bool weekendNotifications = false;
  
  // Frequency settings
  String digestFrequency = "Daily";
  List<String> digestOptions = ["Instant", "Hourly", "Daily", "Weekly", "Never"];
  
  String reminderTiming = "1 hour";
  List<String> reminderOptions = ["15 minutes", "30 minutes", "1 hour", "2 hours", "1 day"];

  List<Map<String, dynamic>> notificationChannels = [
    {
      "id": 1,
      "name": "Task Management",
      "description": "Notifications about task assignments, updates, and deadlines",
      "icon": Icons.task,
      "color": Colors.blue,
      "enabled": true,
      "priority": "High"
    },
    {
      "id": 2,
      "name": "Team Collaboration",
      "description": "Messages, mentions, and team activity updates",
      "icon": Icons.group,
      "color": Colors.green,
      "enabled": true,
      "priority": "Medium"
    },
    {
      "id": 3,
      "name": "Project Updates",
      "description": "Status changes, milestones, and project notifications",
      "icon": Icons.folder,
      "color": Colors.orange,
      "enabled": true,
      "priority": "Medium"
    },
    {
      "id": 4,
      "name": "Meetings & Events",
      "description": "Calendar events, meeting reminders, and scheduling",
      "icon": Icons.event,
      "color": Colors.purple,
      "enabled": true,
      "priority": "High"
    },
    {
      "id": 5,
      "name": "System Alerts",
      "description": "Security, maintenance, and system notifications",
      "icon": Icons.security,
      "color": Colors.red,
      "enabled": true,
      "priority": "High"
    },
    {
      "id": 6,
      "name": "Client Communications",
      "description": "Client messages, feedback, and support requests",
      "icon": Icons.support_agent,
      "color": Colors.indigo,
      "enabled": false,
      "priority": "Medium"
    }
  ];

  int selectedTab = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetToDefaults,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTab,
              tabs: [
                Tab(text: "General", icon: Icon(Icons.settings)),
                Tab(text: "Channels", icon: Icon(Icons.notifications)),
                Tab(text: "Schedule", icon: Icon(Icons.schedule)),
              ],
              tabChildren: [
                _buildGeneralTab(),
                _buildChannelsTab(),
                _buildScheduleTab(),
              ],
            ),
    );
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Global Settings", Icons.settings),
          _buildGlobalSettings(),
          SizedBox(height: spMd),
          
          _buildSectionHeader("Project Notifications", Icons.folder),
          _buildProjectSettings(),
          SizedBox(height: spMd),
          
          _buildSectionHeader("Team Notifications", Icons.group),
          _buildTeamSettings(),
          SizedBox(height: spMd),
          
          _buildSectionHeader("System Notifications", Icons.security),
          _buildSystemSettings(),
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              size: bs.md,
              onPressed: _saveSettings,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Notification Channels", Icons.notifications),
          SizedBox(height: spSm),
          Text(
            "Configure notification channels and their priorities",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ...notificationChannels.map((channel) => _buildChannelCard(channel)).toList(),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Notification Timing", Icons.schedule),
          _buildTimingSettings(),
          SizedBox(height: spMd),
          
          _buildSectionHeader("Digest & Summary", Icons.email),
          _buildDigestSettings(),
          SizedBox(height: spMd),
          
          _buildSectionHeader("Reminder Settings", Icons.alarm),
          _buildReminderSettings(),
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Schedule Settings",
              size: bs.md,
              onPressed: _saveScheduleSettings,
            ),
          ),
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

  Widget _buildGlobalSettings() {
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
            title: "Enable Notifications",
            subtitle: "Receive all types of notifications",
            value: notificationsEnabled,
            onChanged: (value) {
              notificationsEnabled = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Sound",
            subtitle: "Play notification sounds",
            value: soundEnabled,
            enabled: notificationsEnabled,
            onChanged: (value) {
              soundEnabled = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Vibration",
            subtitle: "Vibrate on notifications",
            value: vibrationEnabled,
            enabled: notificationsEnabled,
            onChanged: (value) {
              vibrationEnabled = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Badge Count",
            subtitle: "Show unread count on app icon",
            value: badgeEnabled,
            enabled: notificationsEnabled,
            onChanged: (value) {
              badgeEnabled = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectSettings() {
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
            value: taskAssignments,
            enabled: notificationsEnabled,
            onChanged: (value) {
              taskAssignments = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Task Deadlines",
            subtitle: "Deadline reminders and alerts",
            value: taskDeadlines,
            enabled: notificationsEnabled,
            onChanged: (value) {
              taskDeadlines = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Task Comments",
            subtitle: "Comments on your tasks",
            value: taskComments,
            enabled: notificationsEnabled,
            onChanged: (value) {
              taskComments = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Project Updates",
            subtitle: "Project status and milestone changes",
            value: projectUpdates,
            enabled: notificationsEnabled,
            onChanged: (value) {
              projectUpdates = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Status Changes",
            subtitle: "Task and project status updates",
            value: statusChanges,
            enabled: notificationsEnabled,
            onChanged: (value) {
              statusChanges = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSettings() {
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
            title: "Team Messages",
            subtitle: "Direct messages from team members",
            value: teamMessages,
            enabled: notificationsEnabled,
            onChanged: (value) {
              teamMessages = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Meeting Reminders",
            subtitle: "Upcoming meetings and events",
            value: meetingReminders,
            enabled: notificationsEnabled,
            onChanged: (value) {
              meetingReminders = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Mentions",
            subtitle: "When someone mentions you",
            value: mentionNotifications,
            enabled: notificationsEnabled,
            onChanged: (value) {
              mentionNotifications = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Team Updates",
            subtitle: "General team activity and updates",
            value: teamUpdates,
            enabled: notificationsEnabled,
            onChanged: (value) {
              teamUpdates = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSystemSettings() {
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
            title: "System Maintenance",
            subtitle: "Scheduled maintenance notifications",
            value: systemMaintenance,
            enabled: notificationsEnabled,
            onChanged: (value) {
              systemMaintenance = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Security Alerts",
            subtitle: "Security and login notifications",
            value: securityAlerts,
            enabled: notificationsEnabled,
            onChanged: (value) {
              securityAlerts = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Feature Updates",
            subtitle: "New features and improvements",
            value: featureUpdates,
            enabled: notificationsEnabled,
            onChanged: (value) {
              featureUpdates = value;
              setState(() {});
            },
          ),
          Divider(),
          _buildSwitchTile(
            title: "Promotional Emails",
            subtitle: "Marketing and promotional content",
            value: promotionalEmails,
            enabled: notificationsEnabled,
            onChanged: (value) {
              promotionalEmails = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChannelCard(Map<String, dynamic> channel) {
    Color priorityColor = channel["priority"] == "High" 
        ? dangerColor 
        : channel["priority"] == "Medium" 
            ? warningColor 
            : successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (channel["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  channel["icon"] as IconData,
                  color: channel["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${channel["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${channel["priority"]}",
                            style: TextStyle(
                              color: priorityColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${channel["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: channel["enabled"] as bool,
                onChanged: (value) => _toggleChannel(channel, value),
                activeColor: successColor,
              ),
            ],
          ),
          if (channel["enabled"] as bool) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Text(
                    "Priority Level:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "",
                      items: [
                        {"label": "Low", "value": "Low"},
                        {"label": "Medium", "value": "Medium"},
                        {"label": "High", "value": "High"},
                      ],
                      value: channel["priority"],
                      onChanged: (value, label) {
                        _updateChannelPriority(channel, value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          _buildSwitchTile(
            title: "Quiet Hours",
            subtitle: "Limit notifications during specified hours",
            value: quietHoursEnabled,
            onChanged: (value) {
              quietHoursEnabled = value;
              setState(() {});
            },
          ),
          if (quietHoursEnabled) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QTimePicker(
                    label: "Start Time",
                    value: quietHoursStart.timeOfDay,
                    onChanged: (value) {
                      quietHoursStart = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTimePicker(
                    label: "End Time",
                    value: quietHoursEnd.timeOfDay,
                    onChanged: (value) {
                      quietHoursEnd = value!.kkmm;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
          Divider(),
          _buildSwitchTile(
            title: "Weekend Notifications",
            subtitle: "Receive notifications on weekends",
            value: weekendNotifications,
            onChanged: (value) {
              weekendNotifications = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDigestSettings() {
    return Container(
      margin: EdgeInsets.only(top: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email Digest Frequency",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Frequency",
            items: digestOptions.map((option) => {"label": option, "value": option}).toList(),
            value: digestFrequency,
            onChanged: (value, label) {
              digestFrequency = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Text(
            "Get a summary of notifications via email",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderSettings() {
    return Container(
      margin: EdgeInsets.only(top: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Default Reminder Time",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Reminder Time",
            items: reminderOptions.map((option) => {"label": option, "value": option}).toList(),
            value: reminderTiming,
            onChanged: (value, label) {
              reminderTiming = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Text(
            "How early to remind you before deadlines",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
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

  void _toggleChannel(Map<String, dynamic> channel, bool value) {
    int index = notificationChannels.indexWhere((c) => c["id"] == channel["id"]);
    if (index != -1) {
      notificationChannels[index]["enabled"] = value;
      setState(() {});
    }
  }

  void _updateChannelPriority(Map<String, dynamic> channel, String priority) {
    int index = notificationChannels.indexWhere((c) => c["id"] == channel["id"]);
    if (index != -1) {
      notificationChannels[index]["priority"] = priority;
      setState(() {});
    }
  }

  void _saveSettings() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});
    
    ss("Notification settings saved successfully");
  }

  void _saveScheduleSettings() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});
    
    ss("Schedule settings saved successfully");
  }

  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Reset all notification settings to default values?");
    if (isConfirmed) {
      // Reset to default values
      notificationsEnabled = true;
      soundEnabled = true;
      vibrationEnabled = true;
      badgeEnabled = true;
      taskAssignments = true;
      taskDeadlines = true;
      taskComments = true;
      projectUpdates = true;
      statusChanges = true;
      teamMessages = true;
      meetingReminders = true;
      mentionNotifications = true;
      teamUpdates = false;
      systemMaintenance = true;
      securityAlerts = true;
      featureUpdates = false;
      promotionalEmails = false;
      quietHoursEnabled = true;
      quietHoursStart = "22:00";
      quietHoursEnd = "08:00";
      weekendNotifications = false;
      digestFrequency = "Daily";
      reminderTiming = "1 hour";

      setState(() {});
      ss("Settings reset to defaults");
    }
  }
}
