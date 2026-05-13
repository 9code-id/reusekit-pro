import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaDriverProfileView extends StatefulWidget {
  const CmaDriverProfileView({super.key});

  @override
  State<CmaDriverProfileView> createState() => _CmaDriverProfileViewState();
}

class _CmaDriverProfileViewState extends State<CmaDriverProfileView> {
  String fullName = "John Michael Smith";
  String email = "john.smith@email.com";
  String phone = "+1 (555) 123-4567";
  String address = "123 Main Street, Springfield, IL 62701";
  String emergencyContact = "Sarah Smith - (555) 987-6543";
  String profileImage = "";
  
  Map<String, dynamic> driverInfo = {
    "licenseNumber": "D123456789",
    "licenseClass": "Class C",
    "licenseExpiry": DateTime(2026, 8, 15),
    "licenseState": "Illinois",
    "yearsExperience": 12,
    "totalMiles": 125000,
    "safetyRating": 4.8,
    "violations": 1,
    "accidents": 0,
  };

  List<Map<String, dynamic>> vehicles = [
    {
      "year": 2022,
      "make": "Honda",
      "model": "Civic",
      "vin": "1HGBH41JXMN109186",
      "license": "ABC123",
      "color": "Blue",
      "mileage": 15000,
      "primaryDriver": true,
    },
    {
      "year": 2019,
      "make": "Toyota",
      "model": "Camry",
      "vin": "4T1BE46K19U123456",
      "license": "XYZ789",
      "color": "Silver",
      "mileage": 48000,
      "primaryDriver": false,
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Safe Driver",
      "description": "12 months without violations",
      "icon": Icons.shield,
      "color": Colors.green,
      "earned": DateTime.now().subtract(Duration(days: 30)),
    },
    {
      "title": "Eco Driver",
      "description": "Excellent fuel efficiency",
      "icon": Icons.eco,
      "color": Colors.green,
      "earned": DateTime.now().subtract(Duration(days: 45)),
    },
    {
      "title": "Experienced",
      "description": "10+ years of driving",
      "icon": Icons.star,
      "color": Colors.amber,
      "earned": DateTime.now().subtract(Duration(days: 730)),
    },
    {
      "title": "High Mileage",
      "description": "100,000+ miles driven",
      "icon": Icons.directions_car,
      "color": Colors.blue,
      "earned": DateTime.now().subtract(Duration(days: 365)),
    },
  ];

  List<Map<String, dynamic>> drivingStats = [
    {
      "period": "This Month",
      "miles": 1250,
      "trips": 34,
      "avgSpeed": 32,
      "fuelEfficiency": 28.5,
      "safetyScore": 95,
    },
    {
      "period": "Last Month",
      "miles": 1150,
      "trips": 28,
      "avgSpeed": 30,
      "fuelEfficiency": 29.2,
      "safetyScore": 92,
    },
    {
      "period": "3 Months Ago",
      "miles": 980,
      "trips": 25,
      "avgSpeed": 28,
      "fuelEfficiency": 27.8,
      "safetyScore": 88,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditProfileDialog();
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
            // Profile Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: profileImage.isEmpty
                        ? Icon(
                            Icons.person,
                            size: 40,
                            color: primaryColor,
                          )
                        : ClipOval(
                            child: Image.network(
                              profileImage,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          fullName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          phone,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 16,
                                  color: index < (driverInfo["safetyRating"] as double).floor()
                                      ? Colors.amber
                                      : disabledColor,
                                );
                              }),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${driverInfo["safetyRating"]} Safety Rating",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Driver Statistics
            Text(
              "Driver Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                _buildStatCard(
                  "Years Experience",
                  "${driverInfo["yearsExperience"]}",
                  Icons.timer,
                  primaryColor,
                ),
                _buildStatCard(
                  "Total Miles",
                  "${((driverInfo["totalMiles"] as int) / 1000).toStringAsFixed(0)}K",
                  Icons.straighten,
                  infoColor,
                ),
                _buildStatCard(
                  "Violations",
                  "${driverInfo["violations"]}",
                  Icons.warning,
                  driverInfo["violations"] == 0 ? successColor : warningColor,
                ),
                _buildStatCard(
                  "Accidents",
                  "${driverInfo["accidents"]}",
                  Icons.car_crash,
                  driverInfo["accidents"] == 0 ? successColor : dangerColor,
                ),
              ],
            ),

            // License Information
            Text(
              "License Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.credit_card, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Driver's License",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "License Number",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${driverInfo["licenseNumber"]}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Class",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${driverInfo["licenseClass"]}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "State",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${driverInfo["licenseState"]}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Expiry Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(driverInfo["licenseExpiry"] as DateTime).dMMMy}",
                              style: TextStyle(
                                fontSize: 14,
                                color: (driverInfo["licenseExpiry"] as DateTime).isBefore(DateTime.now().add(Duration(days: 90)))
                                    ? dangerColor
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if ((driverInfo["licenseExpiry"] as DateTime).isBefore(DateTime.now().add(Duration(days: 90))))
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning, color: warningColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "License expires soon. Please renew.",
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Registered Vehicles
            Text(
              "Registered Vehicles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              spacing: spSm,
              children: vehicles.map((vehicle) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: (vehicle["primaryDriver"] as bool)
                        ? Border.all(color: primaryColor.withAlpha(50), width: 2)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.directions_car,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${vehicle["year"]} ${vehicle["make"]} ${vehicle["model"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (vehicle["primaryDriver"] as bool) ...[
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "PRIMARY",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              "License: ${vehicle["license"]} • ${vehicle["color"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "VIN: ${vehicle["vin"]} • ${((vehicle["mileage"] as int) / 1000).toStringAsFixed(0)}K miles",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Driving Performance
            Text(
              "Recent Driving Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              spacing: spSm,
              children: drivingStats.map((stat) {
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
                      Text(
                        "${stat["period"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 80,
                        children: [
                          _buildPerformanceMetric("Miles", "${stat["miles"]}", Icons.straighten),
                          _buildPerformanceMetric("Trips", "${stat["trips"]}", Icons.trip_origin),
                          _buildPerformanceMetric("Avg Speed", "${stat["avgSpeed"]} mph", Icons.speed),
                          _buildPerformanceMetric("MPG", "${stat["fuelEfficiency"]}", Icons.local_gas_station),
                          _buildPerformanceMetric("Safety", "${stat["safetyScore"]}%", Icons.shield),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Achievements
            Text(
              "Achievements",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: achievements.map((achievement) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: (achievement["color"] as Color).withAlpha(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (achievement["color"] as Color).withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          achievement["icon"] as IconData,
                          color: achievement["color"] as Color,
                          size: 24,
                        ),
                      ),
                      Text(
                        "${achievement["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${achievement["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Earned: ${(achievement["earned"] as DateTime).dMMMy}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: primaryColor),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Full Name",
              value: fullName,
              onChanged: (value) {
                fullName = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Email",
              value: email,
              onChanged: (value) {
                email = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Phone",
              value: phone,
              onChanged: (value) {
                phone = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Profile updated successfully");
            },
            child: Text("Save Changes"),
          ),
        ],
      ),
    );
  }
}
