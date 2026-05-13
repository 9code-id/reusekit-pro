import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWelcome7View extends StatefulWidget {
  @override
  State<GrlWelcome7View> createState() => _GrlWelcome7ViewState();
}

class _GrlWelcome7ViewState extends State<GrlWelcome7View> {
  final List<Map<String, dynamic>> achievements = [
    {
      "icon": Icons.account_circle,
      "title": "Profile Created",
      "description": "Your account has been successfully set up",
      "completed": true,
      "color": successColor,
    },
    {
      "icon": Icons.email,
      "title": "Email Verified",
      "description": "Your email address has been confirmed",
      "completed": true,
      "color": infoColor,
    },
    {
      "icon": Icons.security,
      "title": "Security Configured",
      "description": "Your privacy settings have been configured",
      "completed": true,
      "color": primaryColor,
    },
    {
      "icon": Icons.workspace_premium,
      "title": "Plan Selected",
      "description": "You've chosen the perfect plan for your needs",
      "completed": true,
      "color": warningColor,
    },
  ];
  
  final List<Map<String, dynamic>> nextSteps = [
    {
      "icon": Icons.explore,
      "title": "Explore Features",
      "description": "Discover what you can do with our platform",
      "color": primaryColor,
    },
    {
      "icon": Icons.people,
      "title": "Invite Your Team",
      "description": "Collaborate with colleagues and friends",
      "color": successColor,
    },
    {
      "icon": Icons.settings,
      "title": "Customize Settings",
      "description": "Personalize your experience",
      "color": infoColor,
    },
  ];
  
  bool showConfetti = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(20),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                SizedBox(height: spXl),
                
                // Success Animation
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (showConfetti) ...[
                      // Confetti particles
                      ...List.generate(8, (index) {
                        return Positioned(
                          left: 50 + (index * 40).toDouble(),
                          top: 20 + (index % 3 * 30).toDouble(),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: [successColor, warningColor, infoColor, dangerColor][index % 4],
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                        );
                      }),
                    ],
                    
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [successColor, primaryColor],
                        ),
                        borderRadius: BorderRadius.circular(radiusXl),
                        boxShadow: [shadowXl],
                      ),
                      child: Icon(
                        Icons.check_circle,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXl),
                
                // Welcome Message
                Text(
                  "Welcome Aboard!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fsH1,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Text(
                  "🎉 Congratulations! Your account is ready to go.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Text(
                  "You've successfully completed the setup process. Here's what you've accomplished:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
                
                SizedBox(height: sp2xl),
                
                // Achievements
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.emoji_events,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Your Achievements",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Column(
                        children: achievements.map((achievement) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spMd),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: achievement["color"].withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: achievement["color"].withAlpha(100),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: achievement["color"],
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    achievement["icon"],
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
                                        "${achievement["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${achievement["description"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: achievement["color"],
                                  size: 24,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Next Steps
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.rocket_launch,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "What's Next?",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Column(
                        children: nextSteps.map((step) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spMd),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: step["color"].withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                    border: Border.all(
                                      color: step["color"],
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    step["icon"],
                                    color: step["color"],
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${step["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${step["description"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle next step action
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: step["color"],
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: sp2xl),
                
                // Stats Summary
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [successColor.withAlpha(20), successColor.withAlpha(40)],
                          ),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: successColor.withAlpha(100),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "4/4",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Steps Completed",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
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
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(40)],
                          ),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: primaryColor.withAlpha(100),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "100%",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Setup Complete",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: sp2xl),
                
                // Action Buttons
                QButton(
                  label: "Start Using the App",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo('');
                  },
                ),
                
                SizedBox(height: spSm),
                
                GestureDetector(
                  onTap: () {
                    // navigateTo('');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Text(
                      "Take a Quick Tour",
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: spMd),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
