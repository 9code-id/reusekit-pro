import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPushNotificationsView extends StatefulWidget {
  const NmaPushNotificationsView({Key? key}) : super(key: key);

  @override
  State<NmaPushNotificationsView> createState() => _NmaPushNotificationsViewState();
}

class _NmaPushNotificationsViewState extends State<NmaPushNotificationsView> {
  bool pushNotificationsEnabled = true;
  bool breakingNewsEnabled = true;
  bool dailyDigestEnabled = true;
  bool personalizedNewsEnabled = true;
  bool weeklyReportEnabled = false;
  bool trendingTopicsEnabled = true;
  bool authorUpdatesEnabled = false;
  bool commentRepliesEnabled = true;
  bool likesEnabled = false;
  bool followersEnabled = true;
  
  String quietHoursStart = "22:00";
  String quietHoursEnd = "07:00";
  bool quietHoursEnabled = true;
  
  String selectedFrequency = "instant";
  List<String> selectedCategories = ["technology", "science", "business"];
  
  List<Map<String, dynamic>> notificationTypes = [
    {
      "title": "Breaking News",
      "description": "Get notified about urgent news and breaking stories",
      "icon": Icons.flash_on,
      "color": Colors.red,
      "enabled": true,
    },
    {
      "title": "Daily Digest",
      "description": "Daily summary of top stories and articles",
      "icon": Icons.today,
      "color": Colors.blue,
      "enabled": true,
    },
    {
      "title": "Personalized News",
      "description": "Articles tailored to your interests and reading history",
      "icon": Icons.person,
      "color": Colors.green,
      "enabled": true,
    },
    {
      "title": "Weekly Report",
      "description": "Weekly overview of most popular content",
      "icon": Icons.calendar_view_week,
      "color": Colors.purple,
      "enabled": false,
    },
    {
      "title": "Trending Topics",
      "description": "Popular topics and discussions in your areas of interest",
      "icon": Icons.trending_up,
      "color": Colors.orange,
      "enabled": true,
    },
    {
      "title": "Author Updates",
      "description": "New articles from your favorite authors",
      "icon": Icons.edit,
      "color": Colors.teal,
      "enabled": false,
    },
  ];

  List<Map<String, dynamic>> socialNotifications = [
    {
      "title": "Comment Replies",
      "description": "Someone replied to your comment",
      "icon": Icons.reply,
      "enabled": true,
    },
    {
      "title": "Likes & Reactions",
      "description": "Your articles or comments received likes",
      "icon": Icons.favorite,
      "enabled": false,
    },
    {
      "title": "New Followers",
      "description": "Someone started following you",
      "icon": Icons.person_add,
      "enabled": true,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "Technology", "value": "technology", "selected": true},
    {"label": "Science", "value": "science", "selected": true},
    {"label": "Business", "value": "business", "selected": true},
    {"label": "Health", "value": "health", "selected": false},
    {"label": "Sports", "value": "sports", "selected": false},
    {"label": "Entertainment", "value": "entertainment", "selected": false},
    {"label": "Politics", "value": "politics", "selected": false},
    {"label": "Environment", "value": "environment", "selected": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Master toggle
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: pushNotificationsEnabled ? primaryColor : disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.notifications,
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
                          "Push Notifications",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          pushNotificationsEnabled 
                              ? "Notifications are enabled"
                              : "Notifications are disabled",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: pushNotificationsEnabled,
                    onChanged: (value) {
                      pushNotificationsEnabled = value;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),

            if (pushNotificationsEnabled) ...[
              // Notification frequency
              Container(
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
                      "Notification Frequency",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "How often do you want to receive notifications?",
                      items: [
                        {"label": "Instant", "value": "instant"},
                        {"label": "Every 15 minutes", "value": "15min"},
                        {"label": "Every hour", "value": "hour"},
                        {"label": "Every 3 hours", "value": "3hour"},
                        {"label": "Twice daily", "value": "twice"},
                        {"label": "Daily", "value": "daily"},
                      ],
                      value: selectedFrequency,
                      onChanged: (value, label) {
                        selectedFrequency = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // News notifications
              Container(
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
                      "News & Content",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...notificationTypes.map((type) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (type["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                type["icon"],
                                color: type["color"],
                                size: 18,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${type["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${type["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: type["enabled"],
                              onChanged: (value) {
                                type["enabled"] = value;
                                setState(() {});
                              },
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Social notifications
              Container(
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
                      "Social Interactions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...socialNotifications.map((notification) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              notification["icon"],
                              color: primaryColor,
                              size: 18,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${notification["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${notification["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: notification["enabled"],
                              onChanged: (value) {
                                notification["enabled"] = value;
                                setState(() {});
                              },
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Categories
              Container(
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
                      "Categories",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Select categories you want to receive notifications for",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: categories.map((category) {
                        bool isSelected = category["selected"];
                        return GestureDetector(
                          onTap: () {
                            category["selected"] = !isSelected;
                            if (isSelected) {
                              selectedCategories.remove(category["value"]);
                            } else {
                              selectedCategories.add(category["value"]);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              "${category["label"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Quiet hours
              Container(
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
                        Icon(
                          Icons.bedtime,
                          color: primaryColor,
                          size: 18,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Quiet Hours",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Switch(
                          value: quietHoursEnabled,
                          onChanged: (value) {
                            quietHoursEnabled = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "No notifications during quiet hours",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (quietHoursEnabled) ...[
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: QTimePicker(
                              label: "Start Time",
                              value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $quietHoursStart:00")),
                              onChanged: (value) {
                                quietHoursStart = value!.format(context);
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QTimePicker(
                              label: "End Time",
                              value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $quietHoursEnd:00")),
                              onChanged: (value) {
                                quietHoursEnd = value!.format(context);
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

              // Notification sound and vibration
              Container(
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
                      "Sound & Vibration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.volume_up, color: disabledBoldColor, size: 16),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Notification Sound",
                            items: [
                              {"label": "Default", "value": "default"},
                              {"label": "Chime", "value": "chime"},
                              {"label": "Bell", "value": "bell"},
                              {"label": "Ping", "value": "ping"},
                              {"label": "Silent", "value": "silent"},
                            ],
                            value: "default",
                            onChanged: (value, label) {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.vibration, color: disabledBoldColor, size: 16),
                        SizedBox(width: spSm),
                        Text(
                          "Vibrate on notification",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Switch(
                          value: true,
                          onChanged: (value) {},
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Test notification button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Send Test Notification",
                  size: bs.md,
                  icon: Icons.send,
                  onPressed: () => _sendTestNotification(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _sendTestNotification() {
    ss("Test notification sent successfully!");
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Notification Help"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Notification Types:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: spXs),
              Text(
                "• Breaking News: Urgent and important news stories\n"
                "• Daily Digest: Summary of top stories sent once daily\n"
                "• Personalized News: Articles based on your interests\n"
                "• Trending Topics: Popular discussions and topics\n"
                "• Author Updates: New content from followed authors",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: spSm),
              Text(
                "Quiet Hours:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: spXs),
              Text(
                "Set times when you don't want to receive notifications. Emergency breaking news may still be delivered.",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
