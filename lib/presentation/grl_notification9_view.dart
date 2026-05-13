import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNotification9View extends StatefulWidget {
  @override
  State<GrlNotification9View> createState() => _GrlNotification9ViewState();
}

class _GrlNotification9ViewState extends State<GrlNotification9View> {
  bool enableNotifications = true;
  bool enablePushNotifications = true;
  bool enableEmailNotifications = false;
  bool enableSmsNotifications = false;
  bool enableSoundNotifications = true;
  bool enableVibrationNotifications = true;
  
  String selectedNotificationTone = "Default";
  List<String> notificationTones = [
    "Default",
    "Chime",
    "Bell",
    "Ding",
    "Whistle",
  ];
  
  List<Map<String, dynamic>> notificationCategories = [
    {
      "title": "Messages",
      "description": "Personal messages and chats",
      "enabled": true,
      "icon": Icons.message,
      "color": Colors.blue,
    },
    {
      "title": "Orders",
      "description": "Order updates and delivery notifications",
      "enabled": true,
      "icon": Icons.shopping_bag,
      "color": Colors.green,
    },
    {
      "title": "Promotions",
      "description": "Deals, offers, and promotional content",
      "enabled": false,
      "icon": Icons.local_offer,
      "color": Colors.orange,
    },
    {
      "title": "Security",
      "description": "Account security and login alerts",
      "enabled": true,
      "icon": Icons.security,
      "color": Colors.red,
    },
    {
      "title": "Updates",
      "description": "App updates and new features",
      "enabled": true,
      "icon": Icons.system_update,
      "color": Colors.purple,
    },
    {
      "title": "Social",
      "description": "Comments, likes, and social interactions",
      "enabled": false,
      "icon": Icons.people,
      "color": Colors.pink,
    },
  ];

  List<Map<String, dynamic>> recentNotifications = [
    {
      "id": 1,
      "title": "Order Delivered",
      "message": "Your order #12345 has been delivered successfully",
      "time": "2 min ago",
      "type": "order",
      "isRead": false,
    },
    {
      "id": 2,
      "title": "New Message",
      "message": "You have received a new message from Sarah",
      "time": "10 min ago",
      "type": "message",
      "isRead": false,
    },
    {
      "id": 3,
      "title": "Security Alert",
      "message": "New device login detected",
      "time": "1 hour ago",
      "type": "security",
      "isRead": true,
    },
  ];

  void _toggleNotificationCategory(int index) {
    setState(() {
      notificationCategories[index]["enabled"] = !notificationCategories[index]["enabled"];
    });
    
    final category = notificationCategories[index];
    final isEnabled = category["enabled"] as bool;
    ss("${category["title"]} notifications ${isEnabled ? 'enabled' : 'disabled'}");
  }

  void _testNotification() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Test Notification"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications,
              size: 48,
              color: primaryColor,
            ),
            SizedBox(height: spMd),
            Text(
              "This is how your notifications will look!",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Settings"),
        actions: [
          IconButton(
            onPressed: _testNotification,
            icon: Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main notification toggle
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enable Notifications",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Receive important updates and alerts",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: enableNotifications,
                    onChanged: (value) {
                      setState(() {
                        enableNotifications = value;
                      });
                      ss("Notifications ${value ? 'enabled' : 'disabled'}");
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            // Notification methods
            if (enableNotifications) ...[
              Text(
                "Notification Methods",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    // Push notifications
                    ListTile(
                      leading: Icon(Icons.phone_android, color: primaryColor),
                      title: Text("Push Notifications"),
                      subtitle: Text("Show notifications on your device"),
                      trailing: Switch(
                        value: enablePushNotifications,
                        onChanged: (value) {
                          setState(() {
                            enablePushNotifications = value;
                          });
                        },
                        activeColor: primaryColor,
                      ),
                    ),
                    Divider(height: 1),
                    
                    // Email notifications
                    ListTile(
                      leading: Icon(Icons.email, color: primaryColor),
                      title: Text("Email Notifications"),
                      subtitle: Text("Receive notifications via email"),
                      trailing: Switch(
                        value: enableEmailNotifications,
                        onChanged: (value) {
                          setState(() {
                            enableEmailNotifications = value;
                          });
                        },
                        activeColor: primaryColor,
                      ),
                    ),
                    Divider(height: 1),
                    
                    // SMS notifications
                    ListTile(
                      leading: Icon(Icons.sms, color: primaryColor),
                      title: Text("SMS Notifications"),
                      subtitle: Text("Receive notifications via text message"),
                      trailing: Switch(
                        value: enableSmsNotifications,
                        onChanged: (value) {
                          setState(() {
                            enableSmsNotifications = value;
                          });
                        },
                        activeColor: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spLg),
              
              // Sound and vibration
              Text(
                "Sound & Vibration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    // Sound notifications
                    ListTile(
                      leading: Icon(Icons.volume_up, color: primaryColor),
                      title: Text("Sound"),
                      subtitle: Text("Play sound for notifications"),
                      trailing: Switch(
                        value: enableSoundNotifications,
                        onChanged: (value) {
                          setState(() {
                            enableSoundNotifications = value;
                          });
                        },
                        activeColor: primaryColor,
                      ),
                    ),
                    Divider(height: 1),
                    
                    // Vibration
                    ListTile(
                      leading: Icon(Icons.vibration, color: primaryColor),
                      title: Text("Vibration"),
                      subtitle: Text("Vibrate device for notifications"),
                      trailing: Switch(
                        value: enableVibrationNotifications,
                        onChanged: (value) {
                          setState(() {
                            enableVibrationNotifications = value;
                          });
                        },
                        activeColor: primaryColor,
                      ),
                    ),
                    Divider(height: 1),
                    
                    // Notification tone
                    ListTile(
                      leading: Icon(Icons.music_note, color: primaryColor),
                      title: Text("Notification Tone"),
                      subtitle: Text(selectedNotificationTone),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: EdgeInsets.all(spMd),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Select Notification Tone",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spMd),
                                ...notificationTones.map((tone) {
                                  return ListTile(
                                    leading: Icon(
                                      selectedNotificationTone == tone 
                                          ? Icons.radio_button_checked 
                                          : Icons.radio_button_unchecked,
                                      color: primaryColor,
                                    ),
                                    title: Text(tone),
                                    onTap: () {
                                      setState(() {
                                        selectedNotificationTone = tone;
                                      });
                                      back();
                                      ss("Notification tone changed to $tone");
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: spLg),
              
              // Notification categories
              Text(
                "Notification Categories",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: notificationCategories.map((category) {
                    final index = notificationCategories.indexOf(category);
                    final isEnabled = category["enabled"] as bool;
                    final color = category["color"] as Color;
                    
                    return Column(
                      children: [
                        ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: color.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              category["icon"] as IconData,
                              color: color,
                              size: 20,
                            ),
                          ),
                          title: Text("${category["title"]}"),
                          subtitle: Text("${category["description"]}"),
                          trailing: Switch(
                            value: isEnabled,
                            onChanged: (value) => _toggleNotificationCategory(index),
                            activeColor: color,
                          ),
                        ),
                        if (index < notificationCategories.length - 1)
                          Divider(height: 1),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: spLg),
              
              // Recent notifications preview
              Text(
                "Recent Notifications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: recentNotifications.map((notification) {
                    final index = recentNotifications.indexOf(notification);
                    final isRead = notification["isRead"] as bool;
                    
                    return Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isRead ? disabledColor.withAlpha(20) : primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.notifications,
                              color: isRead ? disabledColor : primaryColor,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            "${notification["title"]}",
                            style: TextStyle(
                              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${notification["message"]}"),
                              SizedBox(height: spXs),
                              Text(
                                "${notification["time"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          trailing: !isRead 
                              ? Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                        ),
                        if (index < recentNotifications.length - 1)
                          Divider(height: 1),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
