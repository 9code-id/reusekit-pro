import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSecurity2View extends StatefulWidget {
  @override
  State<GrlSecurity2View> createState() => _GrlSecurity2ViewState();
}

class _GrlSecurity2ViewState extends State<GrlSecurity2View> {
  bool twoFactorEnabled = true;
  bool biometricEnabled = false;
  bool loginNotifications = true;
  bool suspiciousActivity = true;
  bool deviceTracking = false;

  List<Map<String, dynamic>> trustedDevices = [
    {
      "name": "iPhone 13 Pro",
      "location": "New York, NY",
      "lastAccess": "2 hours ago",
      "icon": Icons.phone_iphone,
      "status": "Active"
    },
    {
      "name": "MacBook Pro",
      "location": "New York, NY", 
      "lastAccess": "1 day ago",
      "icon": Icons.laptop_mac,
      "status": "Active"
    },
    {
      "name": "iPad Air",
      "location": "Boston, MA",
      "lastAccess": "3 days ago",
      "icon": Icons.tablet_mac,
      "status": "Inactive"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account Security",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.verified_user,
                          size: 20,
                          color: successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Two-Factor Authentication",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Add an extra layer of security",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: twoFactorEnabled,
                        onChanged: (value) {
                          twoFactorEnabled = value;
                          setState(() {});
                        },
                        activeColor: successColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.fingerprint,
                          size: 20,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Biometric Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Use fingerprint or face ID",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: biometricEnabled,
                        onChanged: (value) {
                          biometricEnabled = value;
                          setState(() {});
                        },
                        activeColor: successColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Security Notifications",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.login,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login Notifications",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Get notified of new logins",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: loginNotifications,
                        onChanged: (value) {
                          loginNotifications = value;
                          setState(() {});
                        },
                        activeColor: successColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Suspicious Activity",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Alert me of unusual activity",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: suspiciousActivity,
                        onChanged: (value) {
                          suspiciousActivity = value;
                          setState(() {});
                        },
                        activeColor: successColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trusted Devices",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Manage All",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Column(
              children: trustedDevices.map((device) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          device["icon"],
                          size: 20,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${device["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${device["location"]} • ${device["lastAccess"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: device["status"] == "Active"
                              ? successColor.withAlpha(20)
                              : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${device["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: device["status"] == "Active"
                                ? successColor
                                : disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
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
    );
  }
}
