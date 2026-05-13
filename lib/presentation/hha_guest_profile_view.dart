import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGuestProfileView extends StatefulWidget {
  const HhaGuestProfileView({super.key});

  @override
  State<HhaGuestProfileView> createState() => _HhaGuestProfileViewState();
}

class _HhaGuestProfileViewState extends State<HhaGuestProfileView> {
  Map<String, dynamic> guestData = {
    "name": "Sarah Johnson",
    "email": "sarah.johnson@email.com",
    "phone": "+1 234 567 8900",
    "member_since": "2023-03-15",
    "loyalty_level": "Gold Member",
    "points": 2450,
    "profile_image": "https://picsum.photos/150/150?random=1&keyword=person",
    "room_number": "A-205",
    "check_in": "2024-12-20",
    "check_out": "2024-12-25",
    "nationality": "United States",
    "id_type": "Passport",
    "id_number": "US123456789",
    "emergency_contact": "John Johnson",
    "emergency_phone": "+1 234 567 8901",
    "preferences": {
      "room_temperature": "22°C",
      "pillow_type": "Soft",
      "newspaper": "The Times",
      "wake_up_call": "07:00",
    },
    "vehicle": {
      "has_vehicle": true,
      "license_number": "ABC-1234",
      "parking_slot": "P-45",
    }
  };

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to edit profile
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              // More options
            },
            icon: Icon(Icons.more_vert),
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
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage("${guestData["profile_image"]}"),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${guestData["name"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${guestData["loyalty_level"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.stars, color: Colors.white, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "${(guestData["points"] as int).toString()} Points",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Current Stay Information
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
                  Row(
                    children: [
                      Icon(Icons.hotel, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Current Stay",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem("Room", "${guestData["room_number"]}"),
                      ),
                      Expanded(
                        child: _buildInfoItem("Check-in", "${(DateTime.parse(guestData["check_in"])).dMMMy}"),
                      ),
                    ],
                  ),
                  _buildInfoItem("Check-out", "${(DateTime.parse(guestData["check_out"])).dMMMy}"),
                ],
              ),
            ),

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
                spacing: spMd,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          "Room Service",
                          Icons.room_service,
                          () {
                            // Navigate to room service
                          },
                        ),
                      ),
                      Expanded(
                        child: _buildActionButton(
                          "Concierge",
                          Icons.room_service,
                          () {
                            // Navigate to concierge
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          "Spa Booking",
                          Icons.spa,
                          () {
                            // Navigate to spa booking
                          },
                        ),
                      ),
                      Expanded(
                        child: _buildActionButton(
                          "Feedback",
                          Icons.feedback,
                          () {
                            // Navigate to feedback
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Personal Information
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
                spacing: spMd,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to edit personal info
                        },
                        child: Icon(
                          Icons.edit,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  _buildInfoItem("Email", "${guestData["email"]}"),
                  _buildInfoItem("Phone", "${guestData["phone"]}"),
                  _buildInfoItem("Nationality", "${guestData["nationality"]}"),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem("ID Type", "${guestData["id_type"]}"),
                      ),
                      Expanded(
                        child: _buildInfoItem("ID Number", "${guestData["id_number"]}"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Emergency Contact
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
                spacing: spMd,
                children: [
                  Text(
                    "Emergency Contact",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildInfoItem("Name", "${guestData["emergency_contact"]}"),
                  _buildInfoItem("Phone", "${guestData["emergency_phone"]}"),
                ],
              ),
            ),

            // Vehicle Information
            if ((guestData["vehicle"] as Map)["has_vehicle"] as bool)
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
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.directions_car, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Vehicle Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoItem("License Number", "${(guestData["vehicle"] as Map)["license_number"]}"),
                        ),
                        Expanded(
                          child: _buildInfoItem("Parking Slot", "${(guestData["vehicle"] as Map)["parking_slot"]}"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Guest Preferences
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
                spacing: spMd,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Preferences",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to edit preferences
                        },
                        child: Icon(
                          Icons.settings,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem("Room Temperature", "${(guestData["preferences"] as Map)["room_temperature"]}"),
                      ),
                      Expanded(
                        child: _buildInfoItem("Pillow Type", "${(guestData["preferences"] as Map)["pillow_type"]}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem("Newspaper", "${(guestData["preferences"] as Map)["newspaper"]}"),
                      ),
                      Expanded(
                        child: _buildInfoItem("Wake-up Call", "${(guestData["preferences"] as Map)["wake_up_call"]}"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Account Actions
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
                spacing: spMd,
                children: [
                  Text(
                    "Account",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildAccountAction("Stay History", Icons.history, () {
                    // Navigate to stay history
                  }),
                  _buildAccountAction("Loyalty Program", Icons.card_membership, () {
                    // Navigate to loyalty program
                  }),
                  _buildAccountAction("Security Settings", Icons.security, () {
                    // Navigate to security settings
                  }),
                  _buildAccountAction("Privacy Settings", Icons.privacy_tip, () {
                    // Navigate to privacy settings
                  }),
                  _buildAccountAction("Help & Support", Icons.help, () {
                    // Navigate to help
                  }),
                  Divider(color: disabledOutlineBorderColor),
                  _buildAccountAction("Sign Out", Icons.logout, () async {
                    bool isConfirmed = await confirm("Are you sure you want to sign out?");
                    if (isConfirmed) {
                      // Sign out logic
                      ss("Signed out successfully");
                    }
                  }, color: dangerColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: primaryColor.withAlpha(40)),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 28),
            SizedBox(height: spSm),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountAction(String title, IconData icon, VoidCallback onPressed, {Color? color}) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? disabledBoldColor,
              size: 20,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: color ?? primaryColor,
                  fontWeight: FontWeight.w500,
                ),
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
    );
  }
}
