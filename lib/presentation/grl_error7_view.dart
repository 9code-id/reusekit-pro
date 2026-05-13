import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlError7View extends StatefulWidget {
  @override
  State<GrlError7View> createState() => _GrlError7ViewState();
}

class _GrlError7ViewState extends State<GrlError7View> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              dangerColor.withAlpha(5),
              Colors.white,
              dangerColor.withAlpha(5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              
              // Crash Icon
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusXl),
                  boxShadow: [shadowXl],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sentiment_very_dissatisfied,
                      size: 72,
                      color: dangerColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "CRASH",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Crash Title
              Text(
                "App Crashed",
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Crash Message
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 32,
                      color: dangerColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Oops! Something went terribly wrong",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "The app encountered an unexpected error and needs to restart. We're sorry for the inconvenience.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Error Details Toggle
              GestureDetector(
                onTap: () {
                  showDetails = !showDetails;
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: showDetails ? primaryColor : disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          showDetails ? "Hide Error Details" : "Show Error Details",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Icon(
                        showDetails ? Icons.expand_less : Icons.expand_more,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Error Details
              if (showDetails)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Technical Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      _buildErrorDetail("Error Type", "NullPointerException"),
                      _buildErrorDetail("Module", "UserAuthentication"),
                      _buildErrorDetail("Function", "validateUserSession()"),
                      _buildErrorDetail("Line", "247"),
                      _buildErrorDetail("Timestamp", "${DateTime.now().toString().substring(0, 19)}"),
                      _buildErrorDetail("Build", "v2.1.3 (build 148)"),
                      
                      SizedBox(height: spMd),
                      
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Stack Trace:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "at UserAuth.validateSession(UserAuth.java:247)\nat LoginManager.checkAuth(LoginManager.java:89)\nat MainActivity.onCreate(MainActivity.java:156)",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              
              SizedBox(height: spMd),
              
              // Action Buttons
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Restart App",
                      size: bs.md,
                      onPressed: () {
                        ss("App is restarting...");
                        // Simulate restart
                      },
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Send Crash Report",
                      size: bs.md,
                      onPressed: () {
                        ss("Crash report sent successfully");
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              // Recovery Options
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: infoColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.healing,
                          size: 20,
                          color: infoColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Recovery Options",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    _buildRecoveryOption(
                      "Clear App Cache",
                      "Remove temporary files that might be causing issues",
                      Icons.cleaning_services,
                      () {
                        ss("App cache cleared");
                      },
                    ),
                    
                    _buildRecoveryOption(
                      "Reset to Safe Mode",
                      "Start with minimal features to isolate the problem",
                      Icons.security,
                      () {
                        si("Safe mode activated");
                      },
                    ),
                    
                    _buildRecoveryOption(
                      "Check for Updates",
                      "Install the latest version with bug fixes",
                      Icons.system_update,
                      () {
                        si("Checking for updates...");
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Support Information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: successColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.support_agent,
                          size: 20,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "We're Here to Help",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Our technical team has been automatically notified about this crash. If the problem persists, please contact support with the error details above.",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // navigateTo(ContactSupportView());
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Contact Support",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // navigateTo(FAQView());
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: successColor,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.help,
                                    size: 16,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "View FAQ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
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
        ),
      ),
    );
  }

  Widget _buildErrorDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryOption(String title, String description, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: infoColor.withAlpha(30),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: infoColor,
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
                      color: infoColor,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: infoColor,
            ),
          ],
        ),
      ),
    );
  }
}
