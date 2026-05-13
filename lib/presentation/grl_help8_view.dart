import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHelp8View extends StatefulWidget {
  @override
  State<GrlHelp8View> createState() => _GrlHelp8ViewState();
}

class _GrlHelp8ViewState extends State<GrlHelp8View> {
  String selectedIssue = "";
  String selectedStep = "";
  bool isLoading = false;

  List<Map<String, dynamic>> commonIssues = [
    {
      "id": "login_issues",
      "title": "Login Issues",
      "description": "Can't sign in to your account",
      "icon": Icons.login,
      "color": dangerColor,
      "steps": [
        {
          "title": "Check Your Credentials",
          "description": "Verify your email and password are correct",
          "action": "verify_credentials"
        },
        {
          "title": "Reset Password",
          "description": "Request a password reset email",
          "action": "reset_password"
        },
        {
          "title": "Clear Browser Cache",
          "description": "Clear your browser's cache and cookies",
          "action": "clear_cache"
        },
        {
          "title": "Check Account Status",
          "description": "Verify your account is active and not suspended",
          "action": "check_status"
        }
      ]
    },
    {
      "id": "upload_problems",
      "title": "Upload Problems",
      "description": "Files not uploading properly",
      "icon": Icons.cloud_upload,
      "color": warningColor,
      "steps": [
        {
          "title": "Check File Size",
          "description": "Ensure file is under 500MB limit",
          "action": "check_size"
        },
        {
          "title": "Verify File Format",
          "description": "Check if file format is supported",
          "action": "check_format"
        },
        {
          "title": "Test Internet Connection",
          "description": "Verify stable internet connection",
          "action": "test_connection"
        },
        {
          "title": "Try Different Browser",
          "description": "Switch to Chrome or Firefox",
          "action": "try_browser"
        }
      ]
    },
    {
      "id": "payment_issues",
      "title": "Payment Issues",
      "description": "Problems with billing or payments",
      "icon": Icons.payment,
      "color": primaryColor,
      "steps": [
        {
          "title": "Check Payment Method",
          "description": "Verify card details and expiry date",
          "action": "check_payment"
        },
        {
          "title": "Verify Billing Address",
          "description": "Ensure billing address matches card",
          "action": "verify_address"
        },
        {
          "title": "Check Account Balance",
          "description": "Ensure sufficient funds available",
          "action": "check_balance"
        },
        {
          "title": "Contact Bank",
          "description": "Check if bank blocked the transaction",
          "action": "contact_bank"
        }
      ]
    },
    {
      "id": "slow_performance",
      "title": "Slow Performance",
      "description": "App or website running slowly",
      "icon": Icons.speed,
      "color": infoColor,
      "steps": [
        {
          "title": "Check Internet Speed",
          "description": "Test your internet connection speed",
          "action": "test_speed"
        },
        {
          "title": "Close Other Apps",
          "description": "Close unnecessary browser tabs/apps",
          "action": "close_apps"
        },
        {
          "title": "Clear Browser Data",
          "description": "Clear cache, cookies, and browsing data",
          "action": "clear_data"
        },
        {
          "title": "Restart Device",
          "description": "Restart your computer or mobile device",
          "action": "restart_device"
        }
      ]
    },
    {
      "id": "account_access",
      "title": "Account Access",
      "description": "Can't access specific features",
      "icon": Icons.lock,
      "color": successColor,
      "steps": [
        {
          "title": "Check Subscription Status",
          "description": "Verify your plan includes this feature",
          "action": "check_subscription"
        },
        {
          "title": "Review Permissions",
          "description": "Check if you have required permissions",
          "action": "check_permissions"
        },
        {
          "title": "Clear App Data",
          "description": "Log out and log back in",
          "action": "clear_app_data"
        },
        {
          "title": "Update Account Info",
          "description": "Ensure profile information is complete",
          "action": "update_profile"
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Troubleshooting Guide"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // navigateTo(HelpCenterView());
            },
          ),
        ],
      ),
      body: selectedIssue.isEmpty ? _buildIssueSelection() : _buildTroubleshootingSteps(),
    );
  }

  Widget _buildIssueSelection() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [infoColor, infoColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.build_circle,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Troubleshooting Guide",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Follow step-by-step solutions for common issues",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.tips_and_updates,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "95% of issues resolved with these guides",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Issue Categories
          Text(
            "Select Your Issue",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...commonIssues.map((issue) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(radiusLg),
                onTap: () {
                  selectedIssue = issue["id"];
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: (issue["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          issue["icon"] as IconData,
                          color: issue["color"] as Color,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${issue["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${issue["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )).toList(),
          
          SizedBox(height: spMd),
          
          // Quick Actions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Still Need Help?",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Live Chat",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo(LiveChatView());
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: primaryColor,
                            width: 1,
                          ),
                        ),
                        child: QButton(
                          label: "Contact Support",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(ContactSupportView());
                          },
                        ),
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

  Widget _buildTroubleshootingSteps() {
    final issue = commonIssues.firstWhere((issue) => issue["id"] == selectedIssue);
    final steps = issue["steps"] as List;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Issue Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: (issue["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: (issue["color"] as Color).withAlpha(50),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: issue["color"] as Color,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    issue["icon"] as IconData,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${issue["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: issue["color"] as Color,
                        ),
                      ),
                      Text(
                        "${issue["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: issue["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIssue = "";
                    selectedStep = "";
                    setState(() {});
                  },
                  child: Icon(
                    Icons.close,
                    color: issue["color"] as Color,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Progress Indicator
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Troubleshooting Steps",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: List.generate(steps.length, (index) {
                    bool isCompleted = selectedStep == steps[index]["action"];
                    return Expanded(
                      child: Container(
                        height: 4,
                        margin: EdgeInsets.only(right: index < steps.length - 1 ? spXs : 0),
                        decoration: BoxDecoration(
                          color: isCompleted ? successColor : Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Steps
          ...steps.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> step = entry.value;
            bool isCompleted = selectedStep == step["action"];
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: isCompleted ? Border.all(
                  color: successColor,
                  width: 2,
                ) : null,
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isCompleted ? successColor : primaryColor.withAlpha(20),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: isCompleted
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${step["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted ? successColor : Colors.black,
                                ),
                              ),
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
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: isCompleted ? "Completed" : "Mark as Done",
                            size: bs.sm,
                            onPressed: isCompleted ? null : () {
                              selectedStep = step["action"];
                              setState(() {});
                              ss("Step completed! Moving to next step.");
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: infoColor,
                              width: 1,
                            ),
                          ),
                          child: QButton(
                            label: "Need Help",
                            size: bs.sm,
                            onPressed: () {
                              _showStepHelp(step);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          
          SizedBox(height: spMd),
          
          // Issue Resolved?
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.help_center,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(height: spMd),
                Text(
                  "Issue Resolved?",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Let us know if these steps helped solve your problem",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: QButton(
                          label: "Yes, It's Fixed!",
                          size: bs.sm,
                          onPressed: () {
                            _markAsResolved();
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: QButton(
                          label: "Still Need Help",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(ContactSupportView());
                          },
                        ),
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

  void _showStepHelp(Map<String, dynamic> step) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${step["title"]} - Help"),
        content: Text("For detailed instructions on this step, please contact our support team or check our knowledge base for more information."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // navigateTo(ContactSupportView());
            },
            child: Text("Contact Support"),
          ),
        ],
      ),
    );
  }

  void _markAsResolved() {
    ss("Great! We're glad we could help you resolve the issue.");
    selectedIssue = "";
    selectedStep = "";
    setState(() {});
  }
}
