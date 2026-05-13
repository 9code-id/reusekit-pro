import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaProfileSettingsView extends StatefulWidget {
  const SmaProfileSettingsView({super.key});

  @override
  State<SmaProfileSettingsView> createState() => _SmaProfileSettingsViewState();
}

class _SmaProfileSettingsViewState extends State<SmaProfileSettingsView> {
  bool isPrivateAccount = false;
  bool showActivityStatus = true;
  bool allowStorySharing = true;
  bool showContactInfo = false;
  bool allowTagging = true;
  bool allowMentions = true;
  bool showFollowersCount = true;
  bool showFollowingCount = true;
  bool allowComments = true;
  bool allowDirectMessages = true;
  bool syncContacts = false;
  bool locationTracking = false;

  List<Map<String, dynamic>> settings = [
    {
      "category": "Account Privacy",
      "icon": Icons.lock,
      "settings": [
        {
          "title": "Private Account",
          "description": "Only followers can see your posts",
          "key": "isPrivateAccount",
          "type": "switch"
        },
        {
          "title": "Show Activity Status",
          "description": "Let followers see when you're active",
          "key": "showActivityStatus",
          "type": "switch"
        },
        {
          "title": "Allow Story Sharing",
          "description": "Let others share your stories",
          "key": "allowStorySharing",
          "type": "switch"
        },
      ]
    },
    {
      "category": "Profile Visibility",
      "icon": Icons.visibility,
      "settings": [
        {
          "title": "Show Contact Info",
          "description": "Display email and phone in profile",
          "key": "showContactInfo",
          "type": "switch"
        },
        {
          "title": "Show Followers Count",
          "description": "Display number of followers",
          "key": "showFollowersCount",
          "type": "switch"
        },
        {
          "title": "Show Following Count",
          "description": "Display number of following",
          "key": "showFollowingCount",
          "type": "switch"
        },
      ]
    },
    {
      "category": "Interactions",
      "icon": Icons.chat,
      "settings": [
        {
          "title": "Allow Tagging",
          "description": "Let others tag you in posts",
          "key": "allowTagging",
          "type": "switch"
        },
        {
          "title": "Allow Mentions",
          "description": "Let others mention you in comments",
          "key": "allowMentions",
          "type": "switch"
        },
        {
          "title": "Allow Comments",
          "description": "Let others comment on your posts",
          "key": "allowComments",
          "type": "switch"
        },
        {
          "title": "Allow Direct Messages",
          "description": "Let others send you direct messages",
          "key": "allowDirectMessages",
          "type": "switch"
        },
      ]
    },
    {
      "category": "Data & Sync",
      "icon": Icons.sync,
      "settings": [
        {
          "title": "Sync Contacts",
          "description": "Find friends from your contacts",
          "key": "syncContacts",
          "type": "switch"
        },
        {
          "title": "Location Tracking",
          "description": "Allow location-based features",
          "key": "locationTracking",
          "type": "switch"
        },
      ]
    },
  ];

  bool _getSwitchValue(String key) {
    switch (key) {
      case 'isPrivateAccount': return isPrivateAccount;
      case 'showActivityStatus': return showActivityStatus;
      case 'allowStorySharing': return allowStorySharing;
      case 'showContactInfo': return showContactInfo;
      case 'allowTagging': return allowTagging;
      case 'allowMentions': return allowMentions;
      case 'showFollowersCount': return showFollowersCount;
      case 'showFollowingCount': return showFollowingCount;
      case 'allowComments': return allowComments;
      case 'allowDirectMessages': return allowDirectMessages;
      case 'syncContacts': return syncContacts;
      case 'locationTracking': return locationTracking;
      default: return false;
    }
  }

  void _setSwitchValue(String key, bool value) {
    setState(() {
      switch (key) {
        case 'isPrivateAccount':
          isPrivateAccount = value;
          break;
        case 'showActivityStatus':
          showActivityStatus = value;
          break;
        case 'allowStorySharing':
          allowStorySharing = value;
          break;
        case 'showContactInfo':
          showContactInfo = value;
          break;
        case 'allowTagging':
          allowTagging = value;
          break;
        case 'allowMentions':
          allowMentions = value;
          break;
        case 'showFollowersCount':
          showFollowersCount = value;
          break;
        case 'showFollowingCount':
          showFollowingCount = value;
          break;
        case 'allowComments':
          allowComments = value;
          break;
        case 'allowDirectMessages':
          allowDirectMessages = value;
          break;
        case 'syncContacts':
          syncContacts = value;
          break;
        case 'locationTracking':
          locationTracking = value;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.analytics,
                                color: infoColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Insights",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Settings Categories
            ...settings.map((category) {
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
                        Icon(
                          category["icon"] as IconData,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${category["category"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                        ),
                        child: Row(
                          children: [
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
                                  SizedBox(height: spXs),
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

            // Advanced Settings
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
                    "Advanced Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Backup Profile Data",
                      size: bs.sm,
                      onPressed: () {
                        ss("Profile backup started");
                      },
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Download Profile Data",
                      size: bs.sm,
                      onPressed: () {
                        ss("Download request submitted");
                      },
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Reset All Settings",
                      size: bs.sm,
                      onPressed: () async {
                        bool isConfirmed = await confirm("Are you sure you want to reset all profile settings to default?");
                        if (isConfirmed) {
                          // Reset all settings
                          setState(() {
                            isPrivateAccount = false;
                            showActivityStatus = true;
                            allowStorySharing = true;
                            showContactInfo = false;
                            allowTagging = true;
                            allowMentions = true;
                            showFollowersCount = true;
                            showFollowingCount = true;
                            allowComments = true;
                            allowDirectMessages = true;
                            syncContacts = false;
                            locationTracking = false;
                          });
                          ss("All settings have been reset to default");
                        }
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
