import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsProfileView extends StatefulWidget {
  const EcsProfileView({super.key});

  @override
  State<EcsProfileView> createState() => _EcsProfileViewState();
}

class _EcsProfileViewState extends State<EcsProfileView> {
  String name = "John Doe";
  String email = "john.doe@email.com";
  String phone = "+1 234 567 8900";
  String profileImage = "";
  int totalOrders = 24;
  int loyaltyPoints = 1250;

  List<Map<String, dynamic>> profileStats = [
    {
      "icon": Icons.shopping_bag,
      "label": "Total Orders",
      "value": "24",
      "color": Colors.blue,
    },
    {
      "icon": Icons.star,
      "label": "Loyalty Points",
      "value": "1,250",
      "color": Colors.orange,
    },
    {
      "icon": Icons.favorite,
      "label": "Wishlist Items",
      "value": "18",
      "color": Colors.red,
    },
    {
      "icon": Icons.receipt,
      "label": "Total Savings",
      "value": "\$284",
      "color": Colors.green,
    },
  ];

  List<Map<String, dynamic>> profileMenus = [
    {
      "icon": Icons.edit,
      "title": "Edit Profile",
      "subtitle": "Update your personal information",
    },
    {
      "icon": Icons.location_on,
      "title": "Address Book",
      "subtitle": "Manage delivery addresses",
    },
    {
      "icon": Icons.payment,
      "title": "Payment Methods",
      "subtitle": "Cards and payment options",
    },
    {
      "icon": Icons.shopping_cart,
      "title": "Order History",
      "subtitle": "View past orders and track",
    },
    {
      "icon": Icons.card_giftcard,
      "title": "Gift Cards",
      "subtitle": "Manage your gift cards",
    },
    {
      "icon": Icons.notifications,
      "title": "Notifications",
      "subtitle": "Customize your preferences",
    },
    {
      "icon": Icons.security,
      "title": "Security",
      "subtitle": "Password and privacy settings",
    },
    {
      "icon": Icons.help,
      "title": "Help & Support",
      "subtitle": "Get help with your account",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              //navigateTo('settings')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Profile Header Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Profile Picture and Basic Info
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              name,
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
                                Text(
                                  email,
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
                                  Icons.phone,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  phone,
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
                    ],
                  ),
                  SizedBox(height: spMd),
                  // Membership Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Premium Member",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Profile Statistics
            Text(
              "Account Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          stat["icon"] as IconData,
                          size: 24,
                          color: stat["color"] as Color,
                        ),
                      ),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["label"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Profile Menu Options
            Text(
              "Account Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: profileMenus.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> menu = entry.value;
                  bool isLast = index == profileMenus.length - 1;

                  return Container(
                    decoration: BoxDecoration(
                      border: !isLast
                          ? Border(
                              bottom: BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              ),
                            )
                          : null,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        //navigateTo('${menu["title"]}')
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                menu["icon"] as IconData,
                                size: 20,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${menu["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${menu["subtitle"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: disabledBoldColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Logout Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Sign Out",
                size: bs.md,
                onPressed: () async {
                  bool isConfirmed = await confirm("Are you sure you want to sign out?");
                  if (isConfirmed) {
                    //navigateTo('login')
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
