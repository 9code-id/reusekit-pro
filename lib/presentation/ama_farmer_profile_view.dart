import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaFarmerProfileView extends StatefulWidget {
  const AmaFarmerProfileView({super.key});

  @override
  State<AmaFarmerProfileView> createState() => _AmaFarmerProfileViewState();
}

class _AmaFarmerProfileViewState extends State<AmaFarmerProfileView> {
  bool isEditMode = false;
  String fullName = "John Anderson";
  String email = "john.anderson@email.com";
  String phone = "+1 (555) 123-4567";
  String farmName = "Anderson Organic Farm";
  String farmLocation = "California, USA";
  String farmSize = "250 acres";
  String farmingExperience = "15 years";
  String profileImage = "https://picsum.photos/120/120?random=1&keyword=farmer";
  
  Map<String, dynamic> farmerStats = {
    "total_harvest": 145.5,
    "crops_grown": 8,
    "years_experience": 15,
    "farm_rating": 4.8,
  };

  List<Map<String, dynamic>> farmingCertifications = [
    {
      "name": "USDA Organic Certified",
      "issued_by": "United States Department of Agriculture",
      "issue_date": "2024-01-15",
      "expiry_date": "2026-01-15",
      "status": "Active",
      "icon": Icons.verified,
    },
    {
      "name": "Sustainable Agriculture Certificate",
      "issued_by": "Sustainable Agriculture Initiative",
      "issue_date": "2023-08-20",
      "expiry_date": "2025-08-20",
      "status": "Active",
      "icon": Icons.eco,
    },
    {
      "name": "Food Safety Modernization Act",
      "issued_by": "FDA",
      "issue_date": "2024-03-10",
      "expiry_date": "2025-03-10",
      "status": "Active",
      "icon": Icons.security,
    },
  ];

  List<Map<String, dynamic>> currentCrops = [
    {
      "name": "Organic Tomatoes",
      "variety": "Heirloom",
      "planted_date": "2024-03-15",
      "expected_harvest": "2024-12-15",
      "area": "45 acres",
      "growth_stage": "Flowering",
      "health_status": "Excellent",
      "image": "https://picsum.photos/100/100?random=10&keyword=tomatoes",
    },
    {
      "name": "Sweet Corn",
      "variety": "Golden Bantam",
      "planted_date": "2024-04-01",
      "expected_harvest": "2024-11-30",
      "area": "60 acres",
      "growth_stage": "Mature",
      "health_status": "Good",
      "image": "https://picsum.photos/100/100?random=11&keyword=corn",
    },
    {
      "name": "Bell Peppers",
      "variety": "California Wonder",
      "planted_date": "2024-02-28",
      "expected_harvest": "2024-10-15",
      "area": "30 acres",
      "growth_stage": "Harvesting",
      "health_status": "Excellent",
      "image": "https://picsum.photos/100/100?random=12&keyword=peppers",
    },
    {
      "name": "Organic Lettuce",
      "variety": "Butterhead",
      "planted_date": "2024-05-10",
      "expected_harvest": "2024-08-10",
      "area": "25 acres",
      "growth_stage": "Growing",
      "health_status": "Good",
      "image": "https://picsum.photos/100/100?random=13&keyword=lettuce",
    },
  ];

  List<Map<String, dynamic>> harvestHistory = [
    {
      "crop": "Organic Tomatoes",
      "harvest_date": "2023-12-10",
      "quantity": "18.5 tons",
      "quality_grade": "Grade A",
      "revenue": 42500.0,
      "buyer": "Whole Foods Market",
    },
    {
      "crop": "Sweet Corn",
      "harvest_date": "2023-11-25",
      "quantity": "32.0 tons",
      "quality_grade": "Grade A",
      "revenue": 28000.0,
      "buyer": "Local Farmers Market",
    },
    {
      "crop": "Bell Peppers",
      "harvest_date": "2023-10-15",
      "quantity": "12.8 tons",
      "quality_grade": "Premium",
      "revenue": 35600.0,
      "buyer": "Organic Grocery Chain",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farmer Profile"),
        actions: [
          IconButton(
            icon: Icon(isEditMode ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditMode) {
                // Save changes
                ss("Profile updated successfully");
              }
              isEditMode = !isEditMode;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(profileImage),
                      ),
                      if (isEditMode)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                              onPressed: () {
                                si("Camera functionality would open here");
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  isEditMode
                      ? Column(
                          children: [
                            QTextField(
                              label: "Full Name",
                              value: fullName,
                              onChanged: (value) {
                                fullName = value;
                                setState(() {});
                              },
                            ),
                            SizedBox(height: spSm),
                            QTextField(
                              label: "Email",
                              value: email,
                              onChanged: (value) {
                                email = value;
                                setState(() {});
                              },
                            ),
                            SizedBox(height: spSm),
                            QTextField(
                              label: "Phone Number",
                              value: phone,
                              onChanged: (value) {
                                phone = value;
                                setState(() {});
                              },
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              fullName,
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              phone,
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Farm Information
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
                    "Farm Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  isEditMode
                      ? Column(
                          children: [
                            QTextField(
                              label: "Farm Name",
                              value: farmName,
                              onChanged: (value) {
                                farmName = value;
                                setState(() {});
                              },
                            ),
                            SizedBox(height: spSm),
                            QTextField(
                              label: "Farm Location",
                              value: farmLocation,
                              onChanged: (value) {
                                farmLocation = value;
                                setState(() {});
                              },
                            ),
                            SizedBox(height: spSm),
                            QTextField(
                              label: "Farm Size",
                              value: farmSize,
                              onChanged: (value) {
                                farmSize = value;
                                setState(() {});
                              },
                            ),
                            SizedBox(height: spSm),
                            QTextField(
                              label: "Farming Experience",
                              value: farmingExperience,
                              onChanged: (value) {
                                farmingExperience = value;
                                setState(() {});
                              },
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _buildInfoRow(Icons.agriculture, "Farm Name", farmName),
                            SizedBox(height: spSm),
                            _buildInfoRow(Icons.location_on, "Location", farmLocation),
                            SizedBox(height: spSm),
                            _buildInfoRow(Icons.landscape, "Farm Size", farmSize),
                            SizedBox(height: spSm),
                            _buildInfoRow(Icons.timeline, "Experience", farmingExperience),
                          ],
                        ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Farmer Statistics
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
                    "Farming Statistics",
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
                        child: _buildStatCard(
                          "${(farmerStats["total_harvest"] as double).toStringAsFixed(1)} tons",
                          "Total Harvest",
                          Icons.agriculture,
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "${farmerStats["crops_grown"]}",
                          "Crops Grown",
                          Icons.eco,
                          infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "${farmerStats["years_experience"]} years",
                          "Experience",
                          Icons.timeline,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "${farmerStats["farm_rating"]}⭐",
                          "Farm Rating",
                          Icons.star,
                          primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Certifications
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
                    "Farming Certifications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...List.generate(farmingCertifications.length, (index) {
                    final cert = farmingCertifications[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              cert["icon"] as IconData,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${cert["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${cert["issued_by"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Valid until ${DateTime.parse(cert["expiry_date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${cert["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Current Crops
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Current Crops",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Add Crop",
                        size: bs.sm,
                        icon: Icons.add,
                        onPressed: () {
                          si("Add new crop functionality");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ...List.generate(currentCrops.length, (index) {
                    final crop = currentCrops[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                        boxShadow: [shadowXs],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${crop["image"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${crop["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${crop["variety"]} • ${crop["area"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getStageColor(crop["growth_stage"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${crop["growth_stage"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: _getStageColor(crop["growth_stage"]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getHealthColor(crop["health_status"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${crop["health_status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: _getHealthColor(crop["health_status"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              si("Crop details menu");
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Harvest History
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
                    "Recent Harvest History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...List.generate(harvestHistory.length, (index) {
                    final harvest = harvestHistory[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${harvest["crop"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${DateTime.parse(harvest["harvest_date"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Quantity: ${harvest["quantity"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Grade: ${harvest["quality_grade"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Buyer: ${harvest["buyer"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Revenue",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((harvest["revenue"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(width: spSm),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getStageColor(String stage) {
    switch (stage.toLowerCase()) {
      case 'planting':
        return infoColor;
      case 'growing':
        return warningColor;
      case 'flowering':
        return primaryColor;
      case 'mature':
        return successColor;
      case 'harvesting':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getHealthColor(String health) {
    switch (health.toLowerCase()) {
      case 'excellent':
        return successColor;
      case 'good':
        return warningColor;
      case 'fair':
        return infoColor;
      case 'poor':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
