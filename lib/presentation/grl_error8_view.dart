import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlError8View extends StatefulWidget {
  @override
  State<GrlError8View> createState() => _GrlError8ViewState();
}

class _GrlError8ViewState extends State<GrlError8View> {
  bool isCheckingUpdates = false;
  String currentVersion = "2.1.0";
  String latestVersion = "2.3.5";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Version Incompatible"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: spLg),
            
            // Version Icon
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius4xl),
                boxShadow: [shadowLg],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.system_update_alt,
                    size: 56,
                    color: warningColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "UPDATE",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Update Title
            Text(
              "Update Required",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: warningColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Update Message
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: warningColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your app version is outdated and no longer supported. Please update to continue using the app.",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        size: 16,
                        color: warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Some features may not work properly",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Version Comparison
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
                  Row(
                    children: [
                      Icon(
                        Icons.compare_arrows,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Version Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: dangerColor.withAlpha(30),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.phone_android,
                                size: 24,
                                color: dangerColor,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Current Version",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "v$currentVersion",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(width: spMd),
                      
                      Icon(
                        Icons.arrow_forward,
                        color: warningColor,
                        size: 24,
                      ),
                      
                      SizedBox(width: spMd),
                      
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: successColor.withAlpha(30),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.smartphone,
                                size: 24,
                                color: successColor,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Latest Version",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "v$latestVersion",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
            
            SizedBox(height: spMd),
            
            // What's New
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
                  Row(
                    children: [
                      Icon(
                        Icons.new_releases,
                        size: 20,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "What's New in v$latestVersion",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildChangeItem("🚀", "Performance improvements", "50% faster loading times"),
                  _buildChangeItem("🔒", "Enhanced security", "Advanced encryption and data protection"),
                  _buildChangeItem("🎨", "New UI design", "Modern interface with better accessibility"),
                  _buildChangeItem("🐛", "Bug fixes", "Resolved 25+ reported issues"),
                  _buildChangeItem("⚡", "New features", "Dark mode, offline sync, and more"),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Update Actions
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isCheckingUpdates ? "Checking Updates..." : "Update Now",
                    size: bs.md,
                    onPressed: isCheckingUpdates ? () {} : () async {
                      isCheckingUpdates = true;
                      setState(() {});
                      
                      // Simulate update check
                      await Future.delayed(Duration(seconds: 3));
                      
                      isCheckingUpdates = false;
                      setState(() {});
                      
                      ss("Redirecting to app store...");
                    },
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Remind Me Later",
                    size: bs.md,
                    onPressed: () {
                      // back();
                      si("You'll be reminded in 24 hours");
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Critical Update Warning
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: dangerColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.priority_high,
                        size: 20,
                        color: dangerColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Important Notice",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "⚠️ Your current version contains security vulnerabilities\n📅 Support ends on ${DateTime.now().add(Duration(days: 30)).day}/${DateTime.now().add(Duration(days: 30)).month}/${DateTime.now().add(Duration(days: 30)).year}\n🔒 Critical security patches included in latest version",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Update Instructions
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
                        Icons.info_outline,
                        size: 20,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "How to Update",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildInstructionStep("1", "Tap 'Update Now' button above"),
                  _buildInstructionStep("2", "You'll be redirected to app store"),
                  _buildInstructionStep("3", "Tap 'Update' in the app store"),
                  _buildInstructionStep("4", "Wait for download to complete"),
                  _buildInstructionStep("5", "Open the updated app"),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Support Contact
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.help_outline,
                    size: 16,
                    color: primaryColor,
                  ),
                  SizedBox(width: spXs),
                  GestureDetector(
                    onTap: () {
                      // navigateTo(UpdateHelpView());
                    },
                    child: Text(
                      "Need help updating? Contact Support",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
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

  Widget _buildChangeItem(String emoji, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: 20),
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
                    color: primaryColor,
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
        ],
      ),
    );
  }

  Widget _buildInstructionStep(String step, String instruction) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: infoColor,
              borderRadius: BorderRadius.circular(radius4xl),
            ),
            child: Center(
              child: Text(
                step,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              instruction,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
