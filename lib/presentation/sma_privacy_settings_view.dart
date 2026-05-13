import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPrivacySettingsView extends StatefulWidget {
  const SmaPrivacySettingsView({super.key});

  @override
  State<SmaPrivacySettingsView> createState() => _SmaPrivacySettingsViewState();
}

class _SmaPrivacySettingsViewState extends State<SmaPrivacySettingsView> {
  bool isPrivateAccount = false;
  bool allowStorySharing = true;
  bool showOnlineStatus = true;
  bool allowTagging = true;
  bool allowMentions = true;
  bool showReadReceipts = true;
  bool allowScreenshots = true;
  bool allowDataDownload = false;
  bool twoFactorAuth = false;
  bool loginNotifications = true;
  bool allowSearchByEmail = false;
  bool allowSearchByPhone = false;

  List<Map<String, dynamic>> privacyCategories = [
    {
      "title": "Account Privacy",
      "icon": Icons.lock,
      "description": "Control who can see your content and profile",
      "settings": [
        {
          "key": "isPrivateAccount",
          "title": "Private Account",
          "description": "Only approved followers can see your posts",
          "icon": Icons.visibility_off,
          "type": "switch"
        },
        {
          "key": "allowStorySharing",
          "title": "Story Sharing",
          "description": "Allow others to share your stories",
          "icon": Icons.share,
          "type": "switch"
        },
        {
          "key": "showOnlineStatus",
          "title": "Online Status",
          "description": "Show when you're active on the platform",
          "icon": Icons.circle,
          "type": "switch"
        },
      ]
    },
    {
      "title": "Content Privacy",
      "icon": Icons.content_copy,
      "description": "Manage how others interact with your content",
      "settings": [
        {
          "key": "allowTagging",
          "title": "Photo/Video Tagging",
          "description": "Allow others to tag you in posts",
          "icon": Icons.local_offer,
          "type": "switch"
        },
        {
          "key": "allowMentions",
          "title": "Mentions",
          "description": "Allow others to mention you in comments",
          "icon": Icons.alternate_email,
          "type": "switch"
        },
        {
          "key": "allowScreenshots",
          "title": "Screenshot Prevention",
          "description": "Notify when someone screenshots your content",
          "icon": Icons.screenshot,
          "type": "switch"
        },
      ]
    },
    {
      "title": "Message Privacy",
      "icon": Icons.message,
      "description": "Control messaging and communication settings",
      "settings": [
        {
          "key": "showReadReceipts",
          "title": "Read Receipts",
          "description": "Show when you've read messages",
          "icon": Icons.done_all,
          "type": "switch"
        },
      ]
    },
    {
      "title": "Search & Discovery",
      "icon": Icons.search,
      "description": "Control how others can find your profile",
      "settings": [
        {
          "key": "allowSearchByEmail",
          "title": "Search by Email",
          "description": "Allow others to find you using your email",
          "icon": Icons.email,
          "type": "switch"
        },
        {
          "key": "allowSearchByPhone",
          "title": "Search by Phone",
          "description": "Allow others to find you using your phone number",
          "icon": Icons.phone,
          "type": "switch"
        },
      ]
    },
    {
      "title": "Security",
      "icon": Icons.security,
      "description": "Advanced security and authentication settings",
      "settings": [
        {
          "key": "twoFactorAuth",
          "title": "Two-Factor Authentication",
          "description": "Require verification code for login",
          "icon": Icons.verified_user,
          "type": "switch"
        },
        {
          "key": "loginNotifications",
          "title": "Login Notifications",
          "description": "Get notified of new login attempts",
          "icon": Icons.notifications,
          "type": "switch"
        },
        {
          "key": "allowDataDownload",
          "title": "Data Download Requests",
          "description": "Allow requests to download your data",
          "icon": Icons.download,
          "type": "switch"
        },
      ]
    },
  ];

  bool _getSwitchValue(String key) {
    switch (key) {
      case 'isPrivateAccount': return isPrivateAccount;
      case 'allowStorySharing': return allowStorySharing;
      case 'showOnlineStatus': return showOnlineStatus;
      case 'allowTagging': return allowTagging;
      case 'allowMentions': return allowMentions;
      case 'showReadReceipts': return showReadReceipts;
      case 'allowScreenshots': return allowScreenshots;
      case 'allowDataDownload': return allowDataDownload;
      case 'twoFactorAuth': return twoFactorAuth;
      case 'loginNotifications': return loginNotifications;
      case 'allowSearchByEmail': return allowSearchByEmail;
      case 'allowSearchByPhone': return allowSearchByPhone;
      default: return false;
    }
  }

  void _setSwitchValue(String key, bool value) {
    setState(() {
      switch (key) {
        case 'isPrivateAccount':
          isPrivateAccount = value;
          break;
        case 'allowStorySharing':
          allowStorySharing = value;
          break;
        case 'showOnlineStatus':
          showOnlineStatus = value;
          break;
        case 'allowTagging':
          allowTagging = value;
          break;
        case 'allowMentions':
          allowMentions = value;
          break;
        case 'showReadReceipts':
          showReadReceipts = value;
          break;
        case 'allowScreenshots':
          allowScreenshots = value;
          break;
        case 'allowDataDownload':
          allowDataDownload = value;
          break;
        case 'twoFactorAuth':
          twoFactorAuth = value;
          break;
        case 'loginNotifications':
          loginNotifications = value;
          break;
        case 'allowSearchByEmail':
          allowSearchByEmail = value;
          break;
        case 'allowSearchByPhone':
          allowSearchByPhone = value;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Settings"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              ss("Privacy settings saved successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Privacy Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shield,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Privacy Protection",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Control who can see your content, interact with you, and find your profile. These settings help protect your privacy and security on the platform.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Privacy Categories
            ...privacyCategories.map((category) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${category["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${category["description"]}",
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
                    
                    ...(category["settings"] as List).map((setting) {
                      final bool currentValue = _getSwitchValue(setting["key"]);
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: currentValue ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              setting["icon"] as IconData,
                              color: currentValue ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${setting["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${setting["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Switch(
                              value: currentValue,
                              onChanged: (value) {
                                _setSwitchValue(setting["key"], value);
                              },
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),

            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Privacy Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Review Blocked Users",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('BlockedUsersView')
                      },
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Privacy Checkup",
                      size: bs.sm,
                      onPressed: () {
                        ss("Privacy checkup completed");
                      },
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Download Privacy Report",
                      size: bs.sm,
                      onPressed: () {
                        ss("Privacy report download started");
                      },
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
