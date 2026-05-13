import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsProfileView extends StatefulWidget {
  const BrsProfileView({super.key});

  @override
  State<BrsProfileView> createState() => _BrsProfileViewState();
}

class _BrsProfileViewState extends State<BrsProfileView> {
  Map<String, dynamic> userProfile = {
    "name": "John Anderson",
    "email": "john.anderson@email.com",
    "phone": "+1 234 567 8900",
    "avatar": "https://picsum.photos/120/120?random=200&keyword=person",
    "member_since": "2023-01-15",
    "total_bookings": 25,
    "loyalty_points": 450,
    "preferred_barber": "Mike Johnson",
    "favorite_service": "Premium Haircut",
  };

  List<Map<String, dynamic>> profileStats = [
    {
      "title": "Total Visits",
      "value": "25",
      "icon": Icons.content_cut,
      "color": Colors.blue,
    },
    {
      "title": "Loyalty Points",
      "value": "450",
      "icon": Icons.stars,
      "color": Colors.orange,
    },
    {
      "title": "Money Saved",
      "value": "\$125",
      "icon": Icons.savings,
      "color": Colors.green,
    },
    {
      "title": "Reviews Given",
      "value": "18",
      "icon": Icons.rate_review,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> menuItems = [
    {
      "title": "Edit Profile",
      "subtitle": "Update your personal information",
      "icon": Icons.person,
      "action": "edit_profile",
    },
    {
      "title": "Booking History",
      "subtitle": "View all your past appointments",
      "icon": Icons.history,
      "action": "booking_history",
    },
    {
      "title": "Favorite Barbers",
      "subtitle": "Manage your favorite barbers",
      "icon": Icons.favorite,
      "action": "favorite_barbers",
    },
    {
      "title": "Payment Methods",
      "subtitle": "Manage your payment cards",
      "icon": Icons.payment,
      "action": "payment_methods",
    },
    {
      "title": "Notifications",
      "subtitle": "Configure notification preferences",
      "icon": Icons.notifications,
      "action": "notifications",
    },
    {
      "title": "Settings",
      "subtitle": "App settings and preferences",
      "icon": Icons.settings,
      "action": "settings",
    },
    {
      "title": "Help & Support",
      "subtitle": "Get help and contact support",
      "icon": Icons.help,
      "action": "help_support",
    },
    {
      "title": "About",
      "subtitle": "App information and legal",
      "icon": Icons.info,
      "action": "about",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildProfileHeader(),
            _buildMembershipCard(),
            _buildStatsGrid(),
            _buildMenuList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusLg),
            child: Image.network(
              "${userProfile["avatar"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${userProfile["name"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${userProfile["email"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${userProfile["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Member since ${DateTime.parse(userProfile["member_since"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              // Navigate to edit profile
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.card_membership,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Gold Member",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${userProfile["loyalty_points"]} pts",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Next tier: Platinum (550 pts needed)",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
          SizedBox(height: spXs),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              widthFactor: (userProfile["loyalty_points"] as int) / 1000,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(0),
      minItemWidth: 200,
      children: profileStats.map((stat) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  stat["icon"] as IconData,
                  color: stat["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${stat["value"]}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${stat["title"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMenuList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> item = entry.value;
          bool isLast = index == menuItems.length - 1;

          return Container(
            decoration: BoxDecoration(
              border: !isLast ? Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ) : null,
            ),
            child: GestureDetector(
              onTap: () => _handleMenuAction(item["action"]),
              child: Container(
                padding: EdgeInsets.all(spMd),
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
                        spacing: spXs,
                        children: [
                          Text(
                            "${item["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${item["subtitle"]}",
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
          );
        }).toList(),
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case "edit_profile":
        si("Navigate to Edit Profile");
        break;
      case "booking_history":
        si("Navigate to Booking History");
        break;
      case "favorite_barbers":
        si("Navigate to Favorite Barbers");
        break;
      case "payment_methods":
        si("Navigate to Payment Methods");
        break;
      case "notifications":
        si("Navigate to Notifications");
        break;
      case "settings":
        si("Navigate to Settings");
        break;
      case "help_support":
        si("Navigate to Help & Support");
        break;
      case "about":
        si("Navigate to About");
        break;
    }
  }

  void _logout() async {
    bool isConfirmed = await confirm("Are you sure you want to logout?");
    if (!isConfirmed) return;
    
    si("Logged out successfully");
    // Navigate to login screen
  }
}
