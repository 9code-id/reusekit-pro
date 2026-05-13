import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWelcome6View extends StatefulWidget {
  @override
  State<GrlWelcome6View> createState() => _GrlWelcome6ViewState();
}

class _GrlWelcome6ViewState extends State<GrlWelcome6View> {
  bool enableNotifications = true;
  bool enableLocationServices = false;
  bool enableDataSync = true;
  bool enableAnalytics = false;
  bool acceptTerms = false;
  bool acceptPrivacy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permissions & Privacy"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, primaryColor],
                ),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.privacy_tip,
                size: 40,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Privacy & Permissions",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Configure your privacy settings and permissions to enhance your experience while keeping your data safe.",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Permissions Section
            Container(
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
                        Icons.settings,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "App Permissions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  _buildPermissionItem(
                    Icons.notifications,
                    "Push Notifications",
                    "Receive important updates and reminders",
                    enableNotifications,
                    successColor,
                    (value) {
                      enableNotifications = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildPermissionItem(
                    Icons.location_on,
                    "Location Services",
                    "Enable location-based features and recommendations",
                    enableLocationServices,
                    warningColor,
                    (value) {
                      enableLocationServices = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildPermissionItem(
                    Icons.sync,
                    "Data Synchronization",
                    "Sync your data across all devices",
                    enableDataSync,
                    infoColor,
                    (value) {
                      enableDataSync = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildPermissionItem(
                    Icons.analytics,
                    "Usage Analytics",
                    "Help us improve the app with anonymous usage data",
                    enableAnalytics,
                    dangerColor,
                    (value) {
                      enableAnalytics = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Privacy Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(100),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Your Privacy Matters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPrivacyPoint("We never sell your personal data"),
                      _buildPrivacyPoint("All data is encrypted in transit and at rest"),
                      _buildPrivacyPoint("You can export or delete your data anytime"),
                      _buildPrivacyPoint("We only collect data necessary for app functionality"),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Terms and Privacy
            Container(
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
                        Icons.gavel,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Legal Agreements",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Terms of Service
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          acceptTerms = !acceptTerms;
                          setState(() {});
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: acceptTerms ? primaryColor : Colors.transparent,
                            border: Border.all(
                              color: acceptTerms ? primaryColor : disabledOutlineBorderColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: acceptTerms
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Open terms of service
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                  children: [
                                    TextSpan(text: "I agree to the "),
                                    TextSpan(
                                      text: "Terms of Service",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "By using our service, you agree to our terms and conditions.",
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
                  
                  SizedBox(height: spMd),
                  
                  // Privacy Policy
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          acceptPrivacy = !acceptPrivacy;
                          setState(() {});
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: acceptPrivacy ? primaryColor : Colors.transparent,
                            border: Border.all(
                              color: acceptPrivacy ? primaryColor : disabledOutlineBorderColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: acceptPrivacy
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Open privacy policy
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                  children: [
                                    TextSpan(text: "I have read and accept the "),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Learn how we collect, use, and protect your data.",
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
                ],
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Continue Button
            QButton(
              label: "Complete Setup",
              size: bs.md,
              onPressed: (acceptTerms && acceptPrivacy) ? () {
                // navigateTo('');
              } : null,
            ),
            
            SizedBox(height: spSm),
            
            if (!acceptTerms || !acceptPrivacy)
              Container(
                width: double.infinity,
                child: Text(
                  "Please accept both Terms of Service and Privacy Policy to continue.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                  ),
                ),
              ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPermissionItem(
    IconData icon,
    String title,
    String description,
    bool value,
    Color color,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                color: value ? primaryColor : disabledColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: AnimatedAlign(
                duration: Duration(milliseconds: 200),
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 26,
                  height: 26,
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrivacyPoint(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: infoColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
