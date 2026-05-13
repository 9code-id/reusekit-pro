import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaAccountSettingsView extends StatefulWidget {
  const SmaAccountSettingsView({super.key});

  @override
  State<SmaAccountSettingsView> createState() => _SmaAccountSettingsViewState();
}

class _SmaAccountSettingsViewState extends State<SmaAccountSettingsView> {
  String currentEmail = "john.doe@example.com";
  String currentPhone = "+1 (555) 123-4567";
  String accountType = "Personal";
  String memberSince = "January 2022";
  bool emailVerified = true;
  bool phoneVerified = true;
  bool accountActive = true;
  bool dataBackupEnabled = true;
  String storageUsed = "2.3 GB";
  String storageLimit = "5 GB";

  List<Map<String, dynamic>> accountSettings = [
    {
      "category": "Account Information",
      "icon": Icons.person,
      "items": [
        {
          "title": "Email Address",
          "value": "john.doe@example.com",
          "verified": true,
          "action": "Change Email",
          "icon": Icons.email,
        },
        {
          "title": "Phone Number",
          "value": "+1 (555) 123-4567",
          "verified": true,
          "action": "Change Phone",
          "icon": Icons.phone,
        },
        {
          "title": "Account Type",
          "value": "Personal Account",
          "verified": false,
          "action": "Upgrade to Business",
          "icon": Icons.business,
        },
      ]
    },
    {
      "category": "Subscription & Billing",
      "icon": Icons.payment,
      "items": [
        {
          "title": "Current Plan",
          "value": "Premium Plan",
          "verified": false,
          "action": "Manage Plan",
          "icon": Icons.star,
        },
        {
          "title": "Billing Method",
          "value": "**** **** **** 1234",
          "verified": false,
          "action": "Update Payment",
          "icon": Icons.credit_card,
        },
        {
          "title": "Next Billing",
          "value": "July 16, 2024",
          "verified": false,
          "action": "View Invoice",
          "icon": Icons.receipt,
        },
      ]
    },
    {
      "category": "Data & Storage",
      "icon": Icons.storage,
      "items": [
        {
          "title": "Storage Used",
          "value": "2.3 GB of 5 GB",
          "verified": false,
          "action": "Manage Storage",
          "icon": Icons.folder,
        },
        {
          "title": "Data Backup",
          "value": "Last backup: Today",
          "verified": true,
          "action": "Backup Now",
          "icon": Icons.backup,
        },
        {
          "title": "Data Export",
          "value": "Download your data anytime",
          "verified": false,
          "action": "Request Export",
          "icon": Icons.download,
        },
      ]
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Change Password",
      "description": "Update your account password",
      "icon": Icons.lock,
      "color": primaryColor,
      "action": "change_password"
    },
    {
      "title": "Verify Identity",
      "description": "Complete identity verification",
      "icon": Icons.verified_user,
      "color": successColor,
      "action": "verify_identity"
    },
    {
      "title": "Download Data",
      "description": "Export all your account data",
      "icon": Icons.file_download,
      "color": infoColor,
      "action": "download_data"
    },
    {
      "title": "Deactivate Account",
      "description": "Temporarily disable your account",
      "icon": Icons.pause_circle,
      "color": warningColor,
      "action": "deactivate_account"
    },
    {
      "title": "Delete Account",
      "description": "Permanently delete your account",
      "icon": Icons.delete_forever,
      "color": dangerColor,
      "action": "delete_account"
    },
  ];

  void _handleQuickAction(String action) async {
    switch (action) {
      case 'change_password':
        //navigateTo('ChangePasswordView')
        break;
      case 'verify_identity':
        ss("Identity verification process started");
        break;
      case 'download_data':
        ss("Data download request submitted");
        break;
      case 'deactivate_account':
        bool isConfirmed = await confirm("Are you sure you want to deactivate your account?");
        if (isConfirmed) {
          ss("Account deactivation process started");
        }
        break;
      case 'delete_account':
        bool isConfirmed = await confirm("Are you sure you want to permanently delete your account? This action cannot be undone.");
        if (isConfirmed) {
          se("Account deletion requires additional verification");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Account Status Overview
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
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "John Doe",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                if (emailVerified && phoneVerified)
                                  Icon(
                                    Icons.verified,
                                    color: successColor,
                                    size: 20,
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: accountActive ? successColor : warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    accountActive ? "ACTIVE" : "INACTIVE",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Member since $memberSince",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Storage Used",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "$storageUsed / $storageLimit",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                            color: Colors.white.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Account Type",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                accountType,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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

            // Account Settings Categories
            ...accountSettings.map((category) {
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
                    
                    ...(category["items"] as List).map((item) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                item["icon"] as IconData,
                                color: primaryColor,
                                size: 18,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${item["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (item["verified"] as bool) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          color: successColor,
                                          size: 16,
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "${item["value"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "${item["action"]}",
                              size: bs.sm,
                              onPressed: () {
                                ss("${item["action"]} action clicked");
                              },
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...quickActions.map((action) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: (action["color"] as Color).withAlpha(30),
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(radiusSm),
                          onTap: () => _handleQuickAction(action["action"]),
                          child: Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: (action["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    action["icon"] as IconData,
                                    color: action["color"] as Color,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${action["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${action["description"]}",
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
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Help & Support
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
                    "Help & Support",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Contact Support",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('ContactSupportView')
                      },
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Account Recovery",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('AccountRecoveryView')
                      },
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Terms & Privacy",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('TermsPrivacyView')
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
