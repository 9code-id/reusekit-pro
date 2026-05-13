import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsShareAppView extends StatefulWidget {
  const BrsShareAppView({super.key});

  @override
  State<BrsShareAppView> createState() => _BrsShareAppViewState();
}

class _BrsShareAppViewState extends State<BrsShareAppView> {
  List<Map<String, dynamic>> shareOptions = [
    {
      "title": "WhatsApp",
      "icon": Icons.chat,
      "color": Colors.green,
      "description": "Share with friends on WhatsApp",
    },
    {
      "title": "Facebook",
      "icon": Icons.facebook,
      "color": Colors.blue,
      "description": "Post on your Facebook timeline",
    },
    {
      "title": "Instagram",
      "icon": Icons.camera_alt,
      "color": Colors.purple,
      "description": "Share story on Instagram",
    },
    {
      "title": "Twitter",
      "icon": Icons.alternate_email,
      "color": Colors.lightBlue,
      "description": "Tweet to your followers",
    },
    {
      "title": "SMS",
      "icon": Icons.sms,
      "color": Colors.orange,
      "description": "Send via text message",
    },
    {
      "title": "Email",
      "icon": Icons.email,
      "color": Colors.red,
      "description": "Share via email",
    },
    {
      "title": "LinkedIn",
      "icon": Icons.business,
      "color": Colors.indigo,
      "description": "Share on LinkedIn",
    },
    {
      "title": "Copy Link",
      "icon": Icons.link,
      "color": primaryColor,
      "description": "Copy app link to clipboard",
    },
  ];

  List<Map<String, dynamic>> shareRewards = [
    {
      "action": "Share App",
      "reward": 5.0,
      "description": "Earn \$5 credit for each share",
      "icon": Icons.share,
      "color": primaryColor,
    },
    {
      "action": "Friend Downloads",
      "reward": 10.0,
      "description": "Get \$10 when friend downloads",
      "icon": Icons.download,
      "color": successColor,
    },
    {
      "action": "Friend Books",
      "reward": 15.0,
      "description": "Earn \$15 when they book first service",
      "icon": Icons.calendar_today,
      "color": warningColor,
    },
  ];

  int totalShares = 8;
  double totalEarned = 120.0;
  int friendsJoined = 5;

  String shareMessage = "Check out BarberPro - the best barbershop booking app! Get professional grooming services at your convenience. Download now and get \$10 off your first booking!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share App"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // View share history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
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
                      Icon(Icons.share, size: 40, color: Colors.white),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Share & Earn",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Spread the word, earn rewards",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Earn up to \$30 per referral",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$totalShares",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Shares",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$friendsJoined",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Friends Joined",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${totalEarned.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Total Earned",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Reward Structure
            Text(
              "How You Earn",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...shareRewards.map((reward) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (reward["color"] as Color).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        reward["icon"] as IconData,
                        color: reward["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${reward["action"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${reward["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "+\$${(reward["reward"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          color: successColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),

            // Share Message Preview
            Text(
              "Share Message",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.message, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Message Preview",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Edit message
                        },
                        child: Icon(Icons.edit, color: primaryColor, size: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    shareMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Share Options
            Text(
              "Choose Platform",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: shareOptions.map((option) {
                return GestureDetector(
                  onTap: () {
                    _shareToplatform(option);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: (option["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            option["icon"] as IconData,
                            color: option["color"] as Color,
                            size: 30,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${option["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${option["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Quick Share Buttons
            Text(
              "Quick Share",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Share to Social",
                    icon: Icons.public,
                    size: bs.md,
                    onPressed: () {
                      // Quick share to social media
                      _showSocialShareDialog();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share to Contacts",
                    icon: Icons.contacts,
                    size: bs.md,
                    onPressed: () {
                      // Share to contacts
                      _showContactsShareDialog();
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Share Tips
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Sharing Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Share on multiple platforms to reach more people\n• Add a personal message about your experience\n• Share during peak hours for better visibility\n• Follow up with friends who might be interested",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // App Rating Prompt
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
                      Icon(Icons.star, color: warningColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Love the app?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Rate us on the app store and help others discover BarberPro",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Rate on App Store",
                          size: bs.sm,
                          onPressed: () {
                            // Open app store rating
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.close,
                        size: bs.sm,
                        onPressed: () {
                          // Dismiss rating prompt
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareToplatform(Map<String, dynamic> option) {
    final title = option["title"] as String;
    
    switch (title) {
      case "Copy Link":
        ss("App link copied to clipboard!");
        break;
      default:
        ss("Shared to $title successfully!");
    }
  }

  void _showSocialShareDialog() {
    // Show dialog with social media options
    ss("Opening social media share options...");
  }

  void _showContactsShareDialog() {
    // Show contacts picker
    ss("Opening contacts to share...");
  }
}
