import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaProfileView extends StatefulWidget {
  const FdaProfileView({Key? key}) : super(key: key);

  @override
  State<FdaProfileView> createState() => _FdaProfileViewState();
}

class _FdaProfileViewState extends State<FdaProfileView> {
  String name = "Sarah Johnson";
  String email = "sarah.johnson@example.com";
  String phone = "+1 (555) 123-4567";
  String profileImage = "https://picsum.photos/150/150?random=1&keyword=woman";
  String address = "123 Main Street, Apt 4B";
  String city = "New York";
  String zipCode = "10001";
  bool notificationsEnabled = true;
  bool emailPromotions = false;
  bool locationSharing = true;

  Map<String, dynamic> userStats = {
    "totalOrders": 142,
    "favoriteRestaurants": 28,
    "totalSpent": 2847.50,
    "loyaltyPoints": 1250,
    "memberSince": "January 2022",
    "averageRating": 4.8,
  };

  List<Map<String, dynamic>> recentOrders = [
    {
      "id": "12345",
      "restaurant": "Bella Italia",
      "items": "Margherita Pizza, Caesar Salad",
      "total": 28.50,
      "date": "2 days ago",
      "status": "Delivered",
      "image": "https://picsum.photos/80/80?random=2&keyword=pizza",
    },
    {
      "id": "12344",
      "restaurant": "Sushi Master",
      "items": "Salmon Roll, Miso Soup",
      "total": 35.75,
      "date": "1 week ago",
      "status": "Delivered",
      "image": "https://picsum.photos/80/80?random=3&keyword=sushi",
    },
    {
      "id": "12343",
      "restaurant": "Burger Palace",
      "items": "Double Cheeseburger, Fries",
      "total": 16.99,
      "date": "2 weeks ago",
      "status": "Delivered",
      "image": "https://picsum.photos/80/80?random=4&keyword=burger",
    },
  ];

  List<Map<String, dynamic>> favoriteRestaurants = [
    {
      "name": "Bella Italia",
      "cuisine": "Italian",
      "rating": 4.8,
      "deliveryTime": "25-35 min",
      "image": "https://picsum.photos/120/80?random=5&keyword=italian",
    },
    {
      "name": "Sushi Master",
      "cuisine": "Japanese",
      "rating": 4.9,
      "deliveryTime": "30-40 min",
      "image": "https://picsum.photos/120/80?random=6&keyword=japanese",
    },
    {
      "name": "Taco Fiesta",
      "cuisine": "Mexican",
      "rating": 4.6,
      "deliveryTime": "20-30 min",
      "image": "https://picsum.photos/120/80?random=7&keyword=mexican",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Food Explorer",
      "description": "Tried 50+ different restaurants",
      "icon": Icons.explore,
      "earned": true,
      "progress": 100,
    },
    {
      "title": "Loyal Customer",
      "description": "100+ orders completed",
      "icon": Icons.star,
      "earned": true,
      "progress": 100,
    },
    {
      "title": "Review Master",
      "description": "Left 25+ helpful reviews",
      "icon": Icons.rate_review,
      "earned": false,
      "progress": 72,
    },
    {
      "title": "Early Bird",
      "description": "10 breakfast orders",
      "icon": Icons.wb_sunny,
      "earned": false,
      "progress": 40,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editProfile(),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _openSettings(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: spMd),
            _buildStatsSection(),
            SizedBox(height: spMd),
            _buildQuickActions(),
            SizedBox(height: spMd),
            _buildRecentOrders(),
            SizedBox(height: spMd),
            _buildFavoriteRestaurants(),
            SizedBox(height: spMd),
            _buildAchievements(),
            SizedBox(height: spMd),
            _buildAccountSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, primaryColor.withAlpha(200)],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profileImage),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: successColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            name,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            email,
            style: TextStyle(
              color: Colors.white.withAlpha(230),
              fontSize: 14,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spMd,
              vertical: spSm,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.diamond,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Text(
                  "${userStats["loyaltyPoints"]} Points",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Stats",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Total Orders",
                "${userStats["totalOrders"]}",
                Icons.shopping_bag,
                successColor,
              ),
              _buildStatCard(
                "Favorite Places",
                "${userStats["favoriteRestaurants"]}",
                Icons.favorite,
                dangerColor,
              ),
              _buildStatCard(
                "Total Spent",
                "\$${((userStats["totalSpent"] as double)).toStringAsFixed(0)}",
                Icons.attach_money,
                primaryColor,
              ),
              _buildStatCard(
                "Avg Rating",
                "${userStats["averageRating"]}⭐",
                Icons.star,
                warningColor,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Text(
                  "Member since ${userStats["memberSince"]}",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildActionCard(
                "Order History",
                Icons.history,
                primaryColor,
                () => _viewOrderHistory(),
              ),
              _buildActionCard(
                "Addresses",
                Icons.location_on,
                successColor,
                () => _manageAddresses(),
              ),
              _buildActionCard(
                "Payment Methods",
                Icons.payment,
                infoColor,
                () => _managePayments(),
              ),
              _buildActionCard(
                "Help & Support",
                Icons.help,
                warningColor,
                () => _getHelp(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrders() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Recent Orders",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _viewOrderHistory(),
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...recentOrders.map((order) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      image: DecorationImage(
                        image: NetworkImage("${order["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${order["restaurant"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${order["items"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "\$${((order["total"] as double)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${order["status"]}",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "${order["date"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: spSm),
                      GestureDetector(
                        onTap: () => _reorderItems(order),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Reorder",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFavoriteRestaurants() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Favorite Restaurants",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _viewAllFavorites(),
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: favoriteRestaurants.map((restaurant) {
              return Container(
                width: 180,
                margin: EdgeInsets.only(right: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                        image: DecorationImage(
                          image: NetworkImage("${restaurant["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${restaurant["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${restaurant["cuisine"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: warningColor,
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${restaurant["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.access_time,
                                color: disabledBoldColor,
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${restaurant["deliveryTime"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 10,
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...achievements.map((achievement) {
            bool isEarned = achievement["earned"] as bool;
            int progress = achievement["progress"] as int;
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isEarned ? warningColor.withAlpha(20) : Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isEarned ? warningColor.withAlpha(50) : disabledOutlineBorderColor,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isEarned ? warningColor : disabledBoldColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      achievement["icon"],
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${achievement["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isEarned ? warningColor : primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${achievement["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        if (!isEarned) ...[
                          SizedBox(height: spSm),
                          LinearProgressIndicator(
                            value: progress / 100,
                            backgroundColor: disabledOutlineBorderColor,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "$progress% complete",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (isEarned)
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 24,
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
          _buildSettingItem(
            "Notifications",
            Icons.notifications,
            notificationsEnabled,
            (value) {
              notificationsEnabled = value;
              setState(() {});
            },
          ),
          _buildSettingItem(
            "Email Promotions",
            Icons.email,
            emailPromotions,
            (value) {
              emailPromotions = value;
              setState(() {});
            },
          ),
          _buildSettingItem(
            "Location Sharing",
            Icons.location_on,
            locationSharing,
            (value) {
              locationSharing = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Logout",
              icon: Icons.logout,
              size: bs.md,
              onPressed: () => _logout(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  void _editProfile() {
    ss("Edit profile tapped");
    // Navigate to edit profile
  }

  void _openSettings() {
    ss("Settings opened");
    // Navigate to settings
  }

  void _viewOrderHistory() {
    ss("Viewing order history");
    // Navigate to order history
  }

  void _manageAddresses() {
    ss("Managing addresses");
    // Navigate to address management
  }

  void _managePayments() {
    ss("Managing payment methods");
    // Navigate to payment methods
  }

  void _getHelp() {
    ss("Getting help");
    // Navigate to help center
  }

  void _reorderItems(Map<String, dynamic> order) {
    ss("Reordering items from ${order["restaurant"]}");
    // Add items to cart
  }

  void _viewAllFavorites() {
    ss("Viewing all favorite restaurants");
    // Navigate to favorites
  }

  void _logout() async {
    bool isConfirmed = await confirm("Are you sure you want to logout?");
    if (isConfirmed) {
      ss("Logged out successfully");
      // Perform logout
    }
  }
}
