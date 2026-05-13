import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaChatSettingsView extends StatefulWidget {
  const SmaChatSettingsView({super.key});

  @override
  State<SmaChatSettingsView> createState() => _SmaChatSettingsViewState();
}

class _SmaChatSettingsViewState extends State<SmaChatSettingsView> {
  bool messageNotifications = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool readReceipts = true;
  bool typingIndicator = true;
  bool onlineStatus = true;
  bool messagePreview = true;
  bool autoDownloadMedia = false;
  bool autoDownloadWifi = true;
  bool chatBackup = true;
  bool encryptMessages = true;
  bool allowStrangers = false;
  
  String chatWallpaper = "default";
  String fontSize = "medium";
  String messageRetention = "1_year";
  String autoDeleteTimer = "never";
  String backupFrequency = "daily";
  String mediaQuality = "standard";

  List<Map<String, dynamic>> wallpaperOptions = [
    {"label": "Default", "value": "default"},
    {"label": "Dark Theme", "value": "dark"},
    {"label": "Nature", "value": "nature"},
    {"label": "Abstract", "value": "abstract"},
    {"label": "Gradient", "value": "gradient"},
    {"label": "Solid Color", "value": "solid"},
  ];

  List<Map<String, dynamic>> fontSizeOptions = [
    {"label": "Small", "value": "small"},
    {"label": "Medium", "value": "medium"},
    {"label": "Large", "value": "large"},
    {"label": "Extra Large", "value": "extra_large"},
  ];

  List<Map<String, dynamic>> retentionOptions = [
    {"label": "30 Days", "value": "30_days"},
    {"label": "3 Months", "value": "3_months"},
    {"label": "6 Months", "value": "6_months"},
    {"label": "1 Year", "value": "1_year"},
    {"label": "Forever", "value": "forever"},
  ];

  List<Map<String, dynamic>> autoDeleteOptions = [
    {"label": "Never", "value": "never"},
    {"label": "24 Hours", "value": "24_hours"},
    {"label": "7 Days", "value": "7_days"},
    {"label": "30 Days", "value": "30_days"},
  ];

  List<Map<String, dynamic>> backupFrequencyOptions = [
    {"label": "Never", "value": "never"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  List<Map<String, dynamic>> mediaQualityOptions = [
    {"label": "Low", "value": "low"},
    {"label": "Standard", "value": "standard"},
    {"label": "High", "value": "high"},
    {"label": "Original", "value": "original"},
  ];

  void _showBlockedUsers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Blocked Users",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  final blockedUsers = [
                    {"name": "John Doe", "image": "https://picsum.photos/50/50?random=10&keyword=profile"},
                    {"name": "Jane Smith", "image": "https://picsum.photos/50/50?random=11&keyword=profile"},
                    {"name": "Mike Wilson", "image": "https://picsum.photos/50/50?random=12&keyword=profile"},
                  ];
                  final user = blockedUsers[index];
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${user["image"]}"),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Text(
                            "${user["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        QButton(
                          label: "Unblock",
                          size: bs.sm,
                          color: primaryColor,
                          onPressed: () {
                            ss("${user["name"]} has been unblocked");
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _exportChatData() async {
    bool isConfirmed = await confirm("Export all chat data? This may take some time.");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Chat data exported successfully");
    }
  }

  void _clearChatHistory() async {
    bool isConfirmed = await confirm("Clear all chat history? This action cannot be undone.");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Chat history cleared successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () async {
              bool isConfirmed = await confirm("Reset all settings to default?");
              if (isConfirmed) {
                setState(() {
                  messageNotifications = true;
                  soundEnabled = true;
                  vibrationEnabled = true;
                  readReceipts = true;
                  typingIndicator = true;
                  onlineStatus = true;
                  messagePreview = true;
                  autoDownloadMedia = false;
                  autoDownloadWifi = true;
                  chatBackup = true;
                  encryptMessages = true;
                  allowStrangers = false;
                  chatWallpaper = "default";
                  fontSize = "medium";
                  messageRetention = "1_year";
                  autoDeleteTimer = "never";
                  backupFrequency = "daily";
                  mediaQuality = "standard";
                });
                ss("Settings reset to default");
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications Section
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
                      Icon(Icons.notifications, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    items: [
                      {
                        "label": "Message Notifications",
                        "value": "message_notifications",
                        "checked": messageNotifications,
                      }
                    ],
                    value: messageNotifications ? [{"label": "Message Notifications", "value": "message_notifications", "checked": true}] : [],
                    onChanged: (values, ids) {
                      messageNotifications = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Sound",
                        "value": "sound",
                        "checked": soundEnabled,
                      }
                    ],
                    value: soundEnabled ? [{"label": "Sound", "value": "sound", "checked": true}] : [],
                    onChanged: (values, ids) {
                      if (messageNotifications) {
                        soundEnabled = values.isNotEmpty;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Vibration",
                        "value": "vibration",
                        "checked": vibrationEnabled,
                      }
                    ],
                    value: vibrationEnabled ? [{"label": "Vibration", "value": "vibration", "checked": true}] : [],
                    onChanged: (values, ids) {
                      if (messageNotifications) {
                        vibrationEnabled = values.isNotEmpty;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Message Preview",
                        "value": "message_preview",
                        "checked": messagePreview,
                      }
                    ],
                    value: messagePreview ? [{"label": "Message Preview", "value": "message_preview", "checked": true}] : [],
                    onChanged: (values, ids) {
                      if (messageNotifications) {
                        messagePreview = values.isNotEmpty;
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Privacy Section
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
                      Icon(Icons.privacy_tip, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Privacy",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    items: [
                      {
                        "label": "Read Receipts",
                        "value": "read_receipts",
                        "checked": readReceipts,
                      }
                    ],
                    value: readReceipts ? [{"label": "Read Receipts", "value": "read_receipts", "checked": true}] : [],
                    onChanged: (values, ids) {
                      readReceipts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Typing Indicator",
                        "value": "typing_indicator",
                        "checked": typingIndicator,
                      }
                    ],
                    value: typingIndicator ? [{"label": "Typing Indicator", "value": "typing_indicator", "checked": true}] : [],
                    onChanged: (values, ids) {
                      typingIndicator = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Online Status",
                        "value": "online_status",
                        "checked": onlineStatus,
                      }
                    ],
                    value: onlineStatus ? [{"label": "Online Status", "value": "online_status", "checked": true}] : [],
                    onChanged: (values, ids) {
                      onlineStatus = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Allow Messages from Strangers",
                        "value": "allow_strangers",
                        "checked": allowStrangers,
                      }
                    ],
                    value: allowStrangers ? [{"label": "Allow Messages from Strangers", "value": "allow_strangers", "checked": true}] : [],
                    onChanged: (values, ids) {
                      allowStrangers = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Appearance Section
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
                      Icon(Icons.palette, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Appearance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Chat Wallpaper",
                    items: wallpaperOptions,
                    value: chatWallpaper,
                    onChanged: (value, label) {
                      chatWallpaper = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Font Size",
                    items: fontSizeOptions,
                    value: fontSize,
                    onChanged: (value, label) {
                      fontSize = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Storage & Media Section
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
                      Icon(Icons.storage, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Storage & Media",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    items: [
                      {
                        "label": "Auto-download Media",
                        "value": "auto_download_media",
                        "checked": autoDownloadMedia,
                      }
                    ],
                    value: autoDownloadMedia ? [{"label": "Auto-download Media", "value": "auto_download_media", "checked": true}] : [],
                    onChanged: (values, ids) {
                      autoDownloadMedia = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Auto-download on Wi-Fi only",
                        "value": "auto_download_wifi",
                        "checked": autoDownloadWifi,
                      }
                    ],
                    value: autoDownloadWifi ? [{"label": "Auto-download on Wi-Fi only", "value": "auto_download_wifi", "checked": true}] : [],
                    onChanged: (values, ids) {
                      if (autoDownloadMedia) {
                        autoDownloadWifi = values.isNotEmpty;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Media Quality",
                    items: mediaQualityOptions,
                    value: mediaQuality,
                    onChanged: (value, label) {
                      mediaQuality = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Backup & Security Section
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
                      Icon(Icons.security, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Backup & Security",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    items: [
                      {
                        "label": "Chat Backup",
                        "value": "chat_backup",
                        "checked": chatBackup,
                      }
                    ],
                    value: chatBackup ? [{"label": "Chat Backup", "value": "chat_backup", "checked": true}] : [],
                    onChanged: (values, ids) {
                      chatBackup = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Backup Frequency",
                    items: backupFrequencyOptions,
                    value: backupFrequency,
                    onChanged: (value, label) {
                      if (chatBackup) {
                        backupFrequency = value;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    items: [
                      {
                        "label": "End-to-End Encryption",
                        "value": "encrypt_messages",
                        "checked": encryptMessages,
                      }
                    ],
                    value: encryptMessages ? [{"label": "End-to-End Encryption", "value": "encrypt_messages", "checked": true}] : [],
                    onChanged: (values, ids) {
                      encryptMessages = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Data Management Section
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
                      Icon(Icons.data_usage, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Data Management",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Message Retention",
                    items: retentionOptions,
                    value: messageRetention,
                    onChanged: (value, label) {
                      messageRetention = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Auto-delete Timer",
                    items: autoDeleteOptions,
                    value: autoDeleteTimer,
                    onChanged: (value, label) {
                      autoDeleteTimer = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Advanced Actions Section
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
                      Icon(Icons.settings_applications, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Advanced",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Blocked Users",
                          color: disabledBoldColor,
                          onPressed: _showBlockedUsers,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Export Data",
                            color: infoColor,
                            onPressed: _exportChatData,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Clear Chat History",
                      color: dangerColor,
                      onPressed: _clearChatHistory,
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
