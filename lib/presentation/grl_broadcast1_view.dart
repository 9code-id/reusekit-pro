import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBroadcast1View extends StatefulWidget {
  @override
  State<GrlBroadcast1View> createState() => _GrlBroadcast1ViewState();
}

class _GrlBroadcast1ViewState extends State<GrlBroadcast1View> {
  String broadcastTitle = "";
  String broadcastMessage = "";
  String selectedAudience = "All Followers";
  String selectedPriority = "Normal";
  bool scheduleForLater = false;
  String selectedDate = DateTime.now().toString();
  String selectedTime = "12:00";
  bool pushNotification = true;
  bool emailNotification = false;
  bool smsNotification = false;
  List<String> selectedChannels = ["In-App"];

  List<Map<String, dynamic>> audienceOptions = [
    {"label": "All Followers", "value": "All Followers"},
    {"label": "Active Subscribers", "value": "Active Subscribers"},
    {"label": "Premium Members", "value": "Premium Members"},
    {"label": "Recent Viewers", "value": "Recent Viewers"},
    {"label": "Custom Segment", "value": "Custom Segment"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Normal", "value": "Normal"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];

  List<Map<String, dynamic>> channelOptions = [
    {"label": "In-App Notification", "value": "In-App"},
    {"label": "Push Notification", "value": "Push"},
    {"label": "Email", "value": "Email"},
    {"label": "SMS", "value": "SMS"},
  ];

  List<Map<String, dynamic>> audienceStats = [
    {
      "title": "Total Followers",
      "value": "125.4K",
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Active Subscribers",
      "value": "45.2K",
      "icon": Icons.notifications_active,
      "color": successColor,
    },
    {
      "title": "Premium Members",
      "value": "12.8K",
      "icon": Icons.star,
      "color": warningColor,
    },
    {
      "title": "Recent Viewers",
      "value": "89.6K",
      "icon": Icons.visibility,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> recentBroadcasts = [
    {
      "title": "New Feature Update Available",
      "audience": "All Followers",
      "sent": "2 hours ago",
      "opened": 78.5,
      "clicked": 12.3,
      "status": "Sent",
    },
    {
      "title": "Live Stream Starting Soon",
      "audience": "Active Subscribers",
      "sent": "1 day ago",
      "opened": 85.2,
      "clicked": 24.7,
      "status": "Sent",
    },
    {
      "title": "Premium Content Released",
      "audience": "Premium Members",
      "sent": "3 days ago",
      "opened": 92.1,
      "clicked": 35.8,
      "status": "Sent",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Broadcast"),
        actions: [
          GestureDetector(
            onTap: () => _saveDraft(),
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.save, size: 24),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Audience Statistics
            Text(
              "Audience Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: audienceStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          stat["icon"] as IconData,
                          color: stat["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${stat["value"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: stat["color"] as Color,
                              ),
                            ),
                            Text(
                              "${stat["title"]}",
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
                );
              }).toList(),
            ),
            SizedBox(height: spMd),

            // Broadcast Content
            Text(
              "Broadcast Content",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QTextField(
              label: "Broadcast Title",
              value: broadcastTitle,
              hint: "Enter a compelling title for your broadcast",
              onChanged: (value) {
                broadcastTitle = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            QMemoField(
              label: "Message",
              value: broadcastMessage,
              hint: "Write your broadcast message here...",
              onChanged: (value) {
                broadcastMessage = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Audience and Priority Settings
            Text(
              "Delivery Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Target Audience",
                    items: audienceOptions,
                    value: selectedAudience,
                    onChanged: (value, label) {
                      selectedAudience = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: priorityOptions,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Notification Channels
            Text(
              "Notification Channels",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildChannelOption(
                    title: "Push Notification",
                    subtitle: "Send to mobile devices",
                    value: pushNotification,
                    onChanged: (value) {
                      pushNotification = value;
                      setState(() {});
                    },
                  ),
                  Divider(),
                  _buildChannelOption(
                    title: "Email Notification",
                    subtitle: "Send to registered email addresses",
                    value: emailNotification,
                    onChanged: (value) {
                      emailNotification = value;
                      setState(() {});
                    },
                  ),
                  Divider(),
                  _buildChannelOption(
                    title: "SMS Notification",
                    subtitle: "Send to phone numbers (Premium)",
                    value: smsNotification,
                    onChanged: (value) {
                      smsNotification = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Scheduling
            Text(
              "Scheduling",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Schedule for Later",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Send broadcast at a specific time",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: scheduleForLater,
                        onChanged: (value) {
                          scheduleForLater = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  if (scheduleForLater) ...[
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Date",
                            value: DateTime.parse(selectedDate),
                            onChanged: (value) {
                              selectedDate = value.toString();
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Time",
                            value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $selectedTime:00")),
                            onChanged: (value) {
                              selectedTime = value!.format(context);
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Preview Section
            Text(
              "Preview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              broadcastTitle.isNotEmpty ? broadcastTitle : "Broadcast Title",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Channel Name",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "now",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    broadcastMessage.isNotEmpty ? broadcastMessage : "Your broadcast message will appear here...",
                    style: TextStyle(
                      fontSize: 13,
                      color: broadcastMessage.isNotEmpty ? Colors.black : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Recent Broadcasts
            Text(
              "Recent Broadcasts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: recentBroadcasts.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> broadcast = entry.value;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index < recentBroadcasts.length - 1 
                          ? Border(bottom: BorderSide(color: disabledOutlineBorderColor))
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${broadcast["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${broadcast["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${broadcast["audience"]} • ${broadcast["sent"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Opened",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(broadcast["opened"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
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
                                    "Clicked",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(broadcast["clicked"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Preview & Test",
                    size: bs.md,
                    onPressed: () {
                      _previewBroadcast();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: scheduleForLater ? "Schedule Broadcast" : "Send Now",
                    color: scheduleForLater ? warningColor : successColor,
                    size: bs.md,
                    onPressed: () {
                      _sendBroadcast();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelOption({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
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
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spXs),
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
        ),
      ],
    );
  }

  void _saveDraft() {
    if (broadcastTitle.isEmpty) {
      se("Please enter a broadcast title");
      return;
    }
    
    ss("Broadcast saved as draft");
  }

  void _previewBroadcast() {
    if (broadcastTitle.isEmpty || broadcastMessage.isEmpty) {
      se("Please complete title and message first");
      return;
    }
    
    si("Opening broadcast preview...");
  }

  void _sendBroadcast() {
    if (broadcastTitle.isEmpty || broadcastMessage.isEmpty) {
      se("Please complete all required fields");
      return;
    }
    
    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      if (scheduleForLater) {
        ss("Broadcast scheduled successfully!");
      } else {
        ss("Broadcast sent to $selectedAudience!");
      }
      back();
    });
  }
}
