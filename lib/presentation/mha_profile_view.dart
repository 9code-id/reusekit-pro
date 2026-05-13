import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaProfileView extends StatefulWidget {
  const MhaProfileView({super.key});

  @override
  State<MhaProfileView> createState() => _MhaProfileViewState();
}

class _MhaProfileViewState extends State<MhaProfileView> {
  String userName = "John Doe";
  String userEmail = "john.doe@example.com";
  String userPhone = "+1 234 567 8900";
  String userImage = "https://picsum.photos/200/200?random=1&keyword=person";
  String userAge = "32 years";
  String userGender = "Male";
  String bloodType = "O+";
  String emergencyContact = "+1 234 567 8901";

  final List<Map<String, dynamic>> menuSections = [
    {
      "title": "Health Information",
      "items": [
        {
          "title": "Medical History",
          "icon": Icons.history,
          "color": primaryColor,
        },
        {
          "title": "Vital Signs",
          "icon": Icons.favorite,
          "color": dangerColor,
        },
        {
          "title": "Allergies",
          "icon": Icons.warning,
          "color": warningColor,
        },
        {
          "title": "Medications",
          "icon": Icons.medication,
          "color": infoColor,
        },
      ],
    },
    {
      "title": "Healthcare",
      "items": [
        {
          "title": "Insurance",
          "icon": Icons.security,
          "color": successColor,
        },
        {
          "title": "Emergency Contacts",
          "icon": Icons.emergency,
          "color": dangerColor,
        },
        {
          "title": "Family Health",
          "icon": Icons.family_restroom,
          "color": primaryColor,
        },
      ],
    },
    {
      "title": "Settings",
      "items": [
        {
          "title": "Notifications",
          "icon": Icons.notifications,
          "color": warningColor,
        },
        {
          "title": "Privacy",
          "icon": Icons.privacy_tip,
          "color": infoColor,
        },
        {
          "title": "Security",
          "icon": Icons.lock,
          "color": primaryColor,
        },
        {
          "title": "Help & Support",
          "icon": Icons.help,
          "color": successColor,
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> healthStats = [
    {
      "title": "Appointments",
      "value": "24",
      "subtitle": "This year",
      "color": primaryColor,
    },
    {
      "title": "Lab Tests",
      "value": "8",
      "subtitle": "Completed",
      "color": successColor,
    },
    {
      "title": "Prescriptions",
      "value": "12",
      "subtitle": "Active",
      "color": infoColor,
    },
  ];

  void _logout() async {
    bool isConfirmed = await confirm("Are you sure you want to logout?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Logged out successfully");
      // navigateTo(MhaLoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: QButton(
              icon: Icons.edit,
              size: bs.sm,
              onPressed: () {
                // navigateTo(MhaEditProfileView());
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        userImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    userEmail,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: healthStats.map((stat) {
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          decoration: BoxDecoration(
                            color: (stat["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${stat["value"]}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: stat["color"] as Color,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${stat["title"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: stat["color"] as Color,
                                ),
                              ),
                              Text(
                                "${stat["subtitle"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
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
                  Text(
                    "Personal Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem("Phone", userPhone, Icons.phone),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: _buildInfoItem("Age", userAge, Icons.cake),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem("Gender", userGender, Icons.person),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: _buildInfoItem("Blood Type", bloodType, Icons.bloodtype),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildInfoItem("Emergency Contact", emergencyContact, Icons.emergency),
                ],
              ),
            ),
            SizedBox(height: spLg),
            ...menuSections.map((section) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${section["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ...(section["items"] as List).map((item) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(radiusSm),
                            onTap: () {
                              si("Opening ${item["title"]}");
                            },
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: (item["color"] as Color).withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      item["icon"] as IconData,
                                      size: 20,
                                      color: item["color"] as Color,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Text(
                                      "${item["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: spMd),
              child: QButton(
                label: "Logout",
                size: bs.md,
                onPressed: _logout,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Version 1.0.0",
              style: TextStyle(
                fontSize: 12,
                color: disabledColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: primaryColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
