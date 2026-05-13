import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmAppointmentRemindersView extends StatefulWidget {
  const FsmAppointmentRemindersView({super.key});

  @override
  State<FsmAppointmentRemindersView> createState() => _FsmAppointmentRemindersViewState();
}

class _FsmAppointmentRemindersViewState extends State<FsmAppointmentRemindersView> {
  int selectedTab = 0;
  bool autoReminders = true;
  bool confirmationRequired = true;
  bool rescheduleAllowed = true;
  int reminderTiming24h = 24;
  int reminderTiming2h = 2;
  int reminderTiming30m = 30;

  List<Map<String, dynamic>> upcomingReminders = [
    {
      "id": "1",
      "customerName": "Sarah Johnson",
      "appointmentTime": "2024-03-16 09:00",
      "serviceType": "HVAC Maintenance",
      "address": "1234 Oak Street, Downtown",
      "phone": "+1 (555) 123-4567",
      "email": "sarah.johnson@email.com",
      "reminderType": "24-hour",
      "scheduledTime": "2024-03-15 09:00",
      "status": "pending",
      "priority": "High",
      "notes": "Customer prefers morning appointments"
    },
    {
      "id": "2",
      "customerName": "Mike Rodriguez",
      "appointmentTime": "2024-03-16 14:00",
      "serviceType": "Plumbing Repair",
      "address": "5678 Pine Avenue, Riverside",
      "phone": "+1 (555) 987-6543",
      "email": "mike.rodriguez@email.com",
      "reminderType": "2-hour",
      "scheduledTime": "2024-03-16 12:00",
      "status": "sent",
      "priority": "Medium",
      "notes": "Emergency repair - urgent"
    },
    {
      "id": "3",
      "customerName": "Lisa Chen",
      "appointmentTime": "2024-03-16 17:15",
      "serviceType": "Electrical Inspection",
      "address": "9012 Maple Drive, Northside",
      "phone": "+1 (555) 456-7890",
      "email": "lisa.chen@email.com",
      "reminderType": "30-minute",
      "scheduledTime": "2024-03-16 16:45",
      "status": "confirmed",
      "priority": "Low",
      "notes": "Annual safety inspection"
    }
  ];

  List<Map<String, dynamic>> reminderHistory = [
    {
      "id": "1",
      "customerName": "Robert Smith",
      "appointmentTime": "2024-03-15 10:00",
      "serviceType": "HVAC Installation",
      "reminderSent": "2024-03-14 10:00",
      "method": "SMS + Email",
      "response": "Confirmed",
      "responseTime": "2024-03-14 10:15",
      "actualAppointment": "2024-03-15 10:00",
      "status": "completed",
      "satisfaction": 5
    },
    {
      "id": "2",
      "customerName": "Emma Davis",
      "appointmentTime": "2024-03-15 15:30",
      "serviceType": "Plumbing Maintenance",
      "reminderSent": "2024-03-15 13:30",
      "method": "Phone Call",
      "response": "Rescheduled",
      "responseTime": "2024-03-15 13:45",
      "actualAppointment": "2024-03-16 15:30",
      "status": "rescheduled",
      "satisfaction": 4
    },
    {
      "id": "3",
      "customerName": "David Wilson",
      "appointmentTime": "2024-03-14 11:15",
      "serviceType": "Electrical Repair",
      "reminderSent": "2024-03-14 10:45",
      "method": "SMS",
      "response": "No Response",
      "responseTime": "",
      "actualAppointment": "2024-03-14 11:15",
      "status": "no-show",
      "satisfaction": 0
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Appointment Reminders",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Upcoming", icon: Icon(Icons.upcoming)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildUpcomingTab(),
        _buildSettingsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildUpcomingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Status Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: autoReminders ? successColor.withAlpha(20) : warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: autoReminders ? successColor : warningColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: autoReminders ? successColor : warningColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    autoReminders ? Icons.schedule_send : Icons.schedule,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        autoReminders ? "Auto Reminders Active" : "Manual Mode",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        autoReminders 
                          ? "Reminders are sent automatically" 
                          : "Manual approval required",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: autoReminders ? "Disable" : "Enable",
                  size: bs.sm,
                  onPressed: () {
                    autoReminders = !autoReminders;
                    setState(() {});
                    ss(autoReminders ? "Auto reminders enabled" : "Auto reminders disabled");
                  },
                ),
              ],
            ),
          ),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatCard("Today's Reminders", "8", Icons.schedule_send, primaryColor),
              _buildStatCard("Pending", "${upcomingReminders.where((r) => r["status"] == "pending").length}", Icons.pending, warningColor),
              _buildStatCard("Confirmed", "${upcomingReminders.where((r) => r["status"] == "confirmed").length}", Icons.check_circle, successColor),
              _buildStatCard("Response Rate", "87%", Icons.trending_up, infoColor),
            ],
          ),

          // Upcoming Reminders List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.upcoming, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Scheduled Reminders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Send All",
                      icon: Icons.send,
                      size: bs.sm,
                      onPressed: () {
                        ss("All pending reminders sent");
                      },
                    ),
                  ],
                ),
                ...upcomingReminders.map((reminder) => _buildReminderCard(reminder)),
              ],
            ),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
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
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Schedule Reminder",
                        icon: Icons.add_alarm,
                        size: bs.sm,
                        onPressed: () {
                          ss("New reminder scheduled");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Bulk Update",
                        icon: Icons.update,
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening bulk update");
                        },
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

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // General Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "General Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSwitchItem("Auto Reminders", "Automatically send appointment reminders", autoReminders, (value) {
                  autoReminders = value;
                  setState(() {});
                }),
                _buildSwitchItem("Confirmation Required", "Require customer confirmation", confirmationRequired, (value) {
                  confirmationRequired = value;
                  setState(() {});
                }),
                _buildSwitchItem("Allow Rescheduling", "Enable customers to reschedule via reminder", rescheduleAllowed, (value) {
                  rescheduleAllowed = value;
                  setState(() {});
                }),
              ],
            ),
          ),

          // Timing Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Reminder Timing",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSliderSetting("24-Hour Reminder", "Initial reminder sent 24 hours before", reminderTiming24h.toDouble(), 12, 48, "hours", (value) {
                  reminderTiming24h = value.round();
                  setState(() {});
                }),
                _buildSliderSetting("2-Hour Reminder", "Follow-up reminder before appointment", reminderTiming2h.toDouble(), 1, 6, "hours", (value) {
                  reminderTiming2h = value.round();
                  setState(() {});
                }),
                _buildSliderSetting("30-Minute Reminder", "Final reminder before arrival", reminderTiming30m.toDouble(), 15, 60, "minutes", (value) {
                  reminderTiming30m = value.round();
                  setState(() {});
                }),
              ],
            ),
          ),

          // Message Templates
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Message Templates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Edit Templates",
                      size: bs.sm,
                      onPressed: () {
                        ss("Opening template editor");
                      },
                    ),
                  ],
                ),
                _buildTemplatePreview("24-Hour Reminder", "Hi [Customer], this is a reminder that you have an appointment scheduled for [Date] at [Time] for [Service]. Please confirm your availability."),
                _buildTemplatePreview("2-Hour Reminder", "Hi [Customer], your appointment for [Service] is in 2 hours at [Time]. Our technician will arrive shortly. Please ensure access to the service area."),
                _buildTemplatePreview("30-Minute Reminder", "Hi [Customer], our technician will arrive in approximately 30 minutes for your [Service] appointment. Please be available at [Address]."),
              ],
            ),
          ),

          // Notification Methods
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Notification Methods",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildMethodCard("SMS Text", "Primary reminder method", Icons.message, true, "Instant delivery, high open rate"),
                _buildMethodCard("Email", "Secondary confirmation method", Icons.email, true, "Detailed information, attachments"),
                _buildMethodCard("Phone Call", "For non-responders", Icons.phone, false, "Personal touch, immediate response"),
                _buildMethodCard("Push Notification", "Mobile app users", Icons.notifications, true, "Real-time alerts"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Statistics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "This Week's Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 140,
                  children: [
                    _buildSummaryCard("Sent", "42", Icons.send, primaryColor),
                    _buildSummaryCard("Confirmed", "36", Icons.check_circle, successColor),
                    _buildSummaryCard("Rescheduled", "4", Icons.schedule, warningColor),
                    _buildSummaryCard("No Shows", "2", Icons.cancel, dangerColor),
                  ],
                ),
              ],
            ),
          ),

          // Filter Options
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Filter History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Today",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering today's reminders");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "This Week",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering this week");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "This Month",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering this month");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Custom",
                        size: bs.sm,
                        onPressed: () {
                          ss("Custom date range");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Reminder History List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.history, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Recent Reminders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Export",
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        ss("Exporting reminder history");
                      },
                    ),
                  ],
                ),
                ...reminderHistory.map((history) => _buildHistoryCard(history)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 32),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
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
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard(Map<String, dynamic> reminder) {
    Color statusColor = _getStatusColor(reminder["status"] as String);
    Color priorityColor = _getPriorityColor(reminder["priority"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getStatusIcon(reminder["status"] as String),
                  color: Colors.white,
                  size: 16,
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
                            "${reminder["customerName"]}",
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
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${reminder["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: priorityColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${reminder["serviceType"]}",
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
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Appointment: ${DateTime.parse(reminder["appointmentTime"] as String).dMMMy} at ${TimeOfDay.fromDateTime(DateTime.parse(reminder["appointmentTime"] as String)).format(context)}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.notification_important, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Reminder: ${reminder["reminderType"]} - ${DateTime.parse(reminder["scheduledTime"] as String).dMMMy} at ${TimeOfDay.fromDateTime(DateTime.parse(reminder["scheduledTime"] as String)).format(context)}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (reminder["status"] == "pending")
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Send Now",
                    icon: Icons.send,
                    size: bs.sm,
                    onPressed: () {
                      reminder["status"] = "sent";
                      setState(() {});
                      ss("Reminder sent to ${reminder["customerName"]}");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Reschedule",
                    icon: Icons.schedule,
                    size: bs.sm,
                    onPressed: () {
                      ss("Rescheduling reminder");
                    },
                  ),
                ),
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    ss("Calling ${reminder["customerName"]}");
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
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
                Text(
                  subtitle,
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

  Widget _buildSliderSetting(String title, String subtitle, double value, double min, double max, String unit, Function(double) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
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
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${value.round()} $unit",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).round(),
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatePreview(String title, String content) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
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
            content,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodCard(String title, String subtitle, IconData icon, bool enabled, String description) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: enabled ? successColor.withAlpha(10) : disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: enabled ? successColor.withAlpha(30) : disabledColor.withAlpha(30),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: enabled ? successColor : disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: enabled ? primaryColor : disabledBoldColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            onChanged: (value) {
              ss(enabled ? "Method disabled" : "Method enabled");
            },
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
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
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> history) {
    Color statusColor = _getHistoryStatusColor(history["status"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getHistoryStatusIcon(history["status"] as String),
                  color: Colors.white,
                  size: 14,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${history["customerName"]} - ${history["serviceType"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              if ((history["satisfaction"] as int) > 0)
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < (history["satisfaction"] as int) ? Icons.star : Icons.star_border,
                      color: warningColor,
                      size: 12,
                    );
                  }),
                ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "Sent: ${history["reminderSent"]} | Method: ${history["method"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.reply, color: disabledBoldColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "Response: ${history["response"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if ((history["responseTime"] as String).isNotEmpty) ...[
                Text(
                  " at ${history["responseTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return warningColor;
      case 'sent': return infoColor;
      case 'confirmed': return successColor;
      case 'failed': return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return Icons.schedule;
      case 'sent': return Icons.send;
      case 'confirmed': return Icons.check_circle;
      case 'failed': return Icons.error;
      default: return Icons.info;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high': return dangerColor;
      case 'medium': return warningColor;
      case 'low': return successColor;
      default: return disabledBoldColor;
    }
  }

  Color _getHistoryStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed': return successColor;
      case 'rescheduled': return warningColor;
      case 'no-show': return dangerColor;
      case 'cancelled': return disabledBoldColor;
      default: return primaryColor;
    }
  }

  IconData _getHistoryStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed': return Icons.check_circle;
      case 'rescheduled': return Icons.schedule;
      case 'no-show': return Icons.cancel;
      case 'cancelled': return Icons.close;
      default: return Icons.info;
    }
  }
}
