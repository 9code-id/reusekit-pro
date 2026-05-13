import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProfile1View extends StatefulWidget {
  @override
  State<GrlProfile1View> createState() => _GrlProfile1ViewState();
}

class _GrlProfile1ViewState extends State<GrlProfile1View> {
  Map<String, dynamic> user = {
    "name": "Sarah Johnson",
    "email": "sarah.johnson@email.com",
    "phone": "+1 (555) 123-4567",
    "avatar": "https://picsum.photos/120/120?random=1&keyword=woman",
    "location": "New York, USA",
    "joinDate": "March 2023",
    "bio": "Digital marketing specialist passionate about creating meaningful connections and helping businesses grow through innovative strategies.",
    "followers": 2847,
    "following": 1293,
    "posts": 156,
    "verified": true,
  };

  List<Map<String, dynamic>> quickActions = [
    {"icon": Icons.edit, "label": "Edit Profile", "color": Colors.blue},
    {"icon": Icons.settings, "label": "Settings", "color": Colors.grey},
    {"icon": Icons.share, "label": "Share", "color": Colors.green},
    {"icon": Icons.help, "label": "Help", "color": Colors.orange},
  ];

  List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.person, "label": "Personal Information", "subtitle": "Manage your account details"},
    {"icon": Icons.security, "label": "Privacy & Security", "subtitle": "Control your privacy settings"},
    {"icon": Icons.notifications, "label": "Notifications", "subtitle": "Customize your notifications"},
    {"icon": Icons.payment, "label": "Payment Methods", "subtitle": "Manage payment options"},
    {"icon": Icons.history, "label": "Activity History", "subtitle": "View your recent activities"},
    {"icon": Icons.language, "label": "Language & Region", "subtitle": "Change language preferences"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Profile Header Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowLg],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  // Avatar and Basic Info
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [shadowMd],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            "${user["avatar"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${user["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                if (user["verified"] == true) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.verified,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${user["email"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white.withAlpha(200),
                                  size: 14,
                                ),
                                SizedBox(width: spXxs),
                                Text(
                                  "${user["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(200),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem("Posts", "${user["posts"]}"),
                      ),
                      Expanded(
                        child: _buildStatItem("Followers", "${(user["followers"] as int) / 1000}K"),
                      ),
                      Expanded(
                        child: _buildStatItem("Following", "${(user["following"] as int) / 1000}K"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bio Section
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
                    "About",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${user["bio"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Member since ${user["joinDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: quickActions.map((action) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: (action["color"] as Color).withAlpha(30),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  action["icon"] as IconData,
                                  color: action["color"] as Color,
                                  size: 24,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${action["label"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
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

            // Menu Items
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
                    "Account Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: menuItems.map((item) {
                      int index = menuItems.indexOf(item);
                      return Container(
                        margin: EdgeInsets.only(
                          bottom: index < menuItems.length - 1 ? spSm : 0,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  item["icon"] as IconData,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item["label"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXxs),
                                    Text(
                                      "${item["subtitle"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: disabledColor,
                                size: 16,
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

            // Logout Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Sign Out",
                color: dangerColor,
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }
}
