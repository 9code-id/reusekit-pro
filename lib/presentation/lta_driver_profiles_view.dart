import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDriverProfilesView extends StatefulWidget {
  const LtaDriverProfilesView({super.key});

  @override
  State<LtaDriverProfilesView> createState() => _LtaDriverProfilesViewState();
}

class _LtaDriverProfilesViewState extends State<LtaDriverProfilesView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedExperience = "All";
  String selectedStatus = "All";

  final List<Map<String, dynamic>> driverProfiles = [
    {
      "id": "DRV001",
      "name": "Ahmad Rahman",
      "profileImage": "https://picsum.photos/120/120?random=1&face",
      "license": "S9876543A",
      "phone": "+65 9123 4567",
      "email": "ahmad.rahman@company.com",
      "status": "Active",
      "experience": "5 years",
      "joinDate": "2019-03-15",
      "rating": 4.8,
      "completedTrips": 1245,
      "totalEarnings": 52500.0,
      "languages": ["English", "Malay", "Tamil"],
      "vehicleType": "Sedan",
      "licenseClass": "3",
      "medicalExpiry": "2025-06-15",
      "backgroundCheck": "Verified",
      "emergencyContact": {
        "name": "Fatimah Rahman",
        "phone": "+65 9876 5432",
        "relationship": "Wife"
      },
      "address": {
        "street": "123 Orchard Road",
        "postal": "238863",
        "city": "Singapore"
      },
      "bankDetails": {
        "accountNumber": "****1234",
        "bankName": "DBS Bank"
      },
      "workHistory": [
        {
          "company": "ComfortDelGro",
          "duration": "2018-2019",
          "position": "Taxi Driver"
        },
        {
          "company": "Grab",
          "duration": "2017-2018", 
          "position": "Private Hire Driver"
        }
      ],
      "certifications": [
        "Defensive Driving Course",
        "First Aid Certification",
        "Customer Service Excellence"
      ],
      "preferences": {
        "workShift": "Morning",
        "preferredAreas": ["CBD", "Orchard", "Marina Bay"],
        "vehiclePreference": "Sedan"
      }
    },
    {
      "id": "DRV002",
      "name": "Siti Aminah",
      "profileImage": "https://picsum.photos/120/120?random=2&face",
      "license": "S8765432B",
      "phone": "+65 9234 5678",
      "email": "siti.aminah@company.com",
      "status": "Active",
      "experience": "7 years",
      "joinDate": "2017-08-22",
      "rating": 4.9,
      "completedTrips": 1856,
      "totalEarnings": 78200.0,
      "languages": ["English", "Malay", "Chinese"],
      "vehicleType": "MPV",
      "licenseClass": "3",
      "medicalExpiry": "2024-12-20",
      "backgroundCheck": "Verified",
      "emergencyContact": {
        "name": "Hassan Ali",
        "phone": "+65 9123 8765",
        "relationship": "Husband"
      },
      "address": {
        "street": "456 Marina Bay Drive",
        "postal": "018956",
        "city": "Singapore"
      },
      "bankDetails": {
        "accountNumber": "****5678",
        "bankName": "OCBC Bank"
      },
      "workHistory": [
        {
          "company": "SMRT Taxis",
          "duration": "2015-2017",
          "position": "Taxi Driver"
        },
        {
          "company": "Premier Taxis",
          "duration": "2013-2015",
          "position": "Private Hire Driver"
        }
      ],
      "certifications": [
        "Advanced Driving Course",
        "CPR Certification",
        "Wheelchair Accessible Vehicle Training"
      ],
      "preferences": {
        "workShift": "Evening",
        "preferredAreas": ["Airport", "Sentosa", "Marina Bay"],
        "vehiclePreference": "MPV"
      }
    },
    {
      "id": "DRV003",
      "name": "Raj Kumar",
      "profileImage": "https://picsum.photos/120/120?random=3&face",
      "license": "S7654321C",
      "phone": "+65 9345 6789",
      "email": "raj.kumar@company.com",
      "status": "Pending Verification",
      "experience": "2 years",
      "joinDate": "2022-11-10",
      "rating": 4.2,
      "completedTrips": 458,
      "totalEarnings": 18200.0,
      "languages": ["English", "Tamil", "Hindi"],
      "vehicleType": "Hatchback",
      "licenseClass": "3",
      "medicalExpiry": "2025-03-18",
      "backgroundCheck": "In Progress",
      "emergencyContact": {
        "name": "Priya Kumar",
        "phone": "+65 9876 1234",
        "relationship": "Sister"
      },
      "address": {
        "street": "789 Raffles Place",
        "postal": "048623",
        "city": "Singapore"
      },
      "bankDetails": {
        "accountNumber": "****9012",
        "bankName": "UOB Bank"
      },
      "workHistory": [
        {
          "company": "Gojek",
          "duration": "2021-2022",
          "position": "Private Hire Driver"
        }
      ],
      "certifications": [
        "Basic Driving Course",
        "Road Safety Workshop"
      ],
      "preferences": {
        "workShift": "Night",
        "preferredAreas": ["Jurong", "Clementi", "Bukit Timah"],
        "vehiclePreference": "Any"
      }
    },
    {
      "id": "DRV004",
      "name": "Chen Wei Ming",
      "profileImage": "https://picsum.photos/120/120?random=4&face",
      "license": "S6543210D",
      "phone": "+65 9456 7890",
      "email": "chen.weiming@company.com",
      "status": "Active",
      "experience": "10 years",
      "joinDate": "2014-05-18",
      "rating": 4.7,
      "completedTrips": 2340,
      "totalEarnings": 95600.0,
      "languages": ["English", "Chinese", "Hokkien"],
      "vehicleType": "Sedan",
      "licenseClass": "3",
      "medicalExpiry": "2024-11-25",
      "backgroundCheck": "Verified",
      "emergencyContact": {
        "name": "Li Mei Chen",
        "phone": "+65 9234 5679",
        "relationship": "Wife"
      },
      "address": {
        "street": "321 Clementi Road",
        "postal": "129809",
        "city": "Singapore"
      },
      "bankDetails": {
        "accountNumber": "****3456",
        "bankName": "Standard Chartered"
      },
      "workHistory": [
        {
          "company": "City Cab",
          "duration": "2010-2014",
          "position": "Taxi Driver"
        },
        {
          "company": "Trans-Cab",
          "duration": "2008-2010",
          "position": "Taxi Driver"
        }
      ],
      "certifications": [
        "Professional Driving Certification",
        "Advanced First Aid",
        "Customer Service Excellence",
        "Vehicle Maintenance Course"
      ],
      "preferences": {
        "workShift": "Morning",
        "preferredAreas": ["CBD", "Tanjong Pagar", "Raffles Place"],
        "vehiclePreference": "Luxury Sedan"
      }
    },
    {
      "id": "DRV005",
      "name": "Maria Santos",
      "profileImage": "https://picsum.photos/120/120?random=5&face",
      "license": "S5432109E",
      "phone": "+65 9567 8901",
      "email": "maria.santos@company.com",
      "status": "Active",
      "experience": "3 years",
      "joinDate": "2021-12-05",
      "rating": 4.6,
      "completedTrips": 892,
      "totalEarnings": 34800.0,
      "languages": ["English", "Filipino", "Spanish"],
      "vehicleType": "Sedan",
      "licenseClass": "3",
      "medicalExpiry": "2025-08-15",
      "backgroundCheck": "Verified",
      "emergencyContact": {
        "name": "Carlos Santos",
        "phone": "+65 9345 6780",
        "relationship": "Husband"
      },
      "address": {
        "street": "654 Jurong East Avenue",
        "postal": "609734",
        "city": "Singapore"
      },
      "bankDetails": {
        "accountNumber": "****7890",
        "bankName": "Maybank"
      },
      "workHistory": [
        {
          "company": "Ryde",
          "duration": "2020-2021",
          "position": "Private Hire Driver"
        }
      ],
      "certifications": [
        "Defensive Driving Course",
        "Basic First Aid",
        "Multi-language Communication"
      ],
      "preferences": {
        "workShift": "Evening",
        "preferredAreas": ["Jurong", "Westgate", "Boon Lay"],
        "vehiclePreference": "Sedan"
      }
    }
  ];

  List<Map<String, dynamic>> get filteredProfiles {
    return driverProfiles.where((profile) {
      final matchesSearch = profile["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          profile["license"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          profile["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesExperience = selectedExperience == "All" || 
          (selectedExperience == "New" && int.parse(profile["experience"].toString().split(" ")[0]) <= 2) ||
          (selectedExperience == "Experienced" && int.parse(profile["experience"].toString().split(" ")[0]) > 2);
      
      final matchesStatus = selectedStatus == "All" || profile["status"] == selectedStatus;
      
      return matchesSearch && matchesExperience && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending Verification":
        return warningColor;
      case "Suspended":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildProfilesTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          color: Colors.white,
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search profiles...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.filter_list,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Experience",
                      items: [
                        {"label": "All Experience", "value": "All"},
                        {"label": "New (≤2 years)", "value": "New"},
                        {"label": "Experienced (>2 years)", "value": "Experienced"},
                      ],
                      value: selectedExperience,
                      onChanged: (value, label) {
                        selectedExperience = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: [
                        {"label": "All Status", "value": "All"},
                        {"label": "Active", "value": "Active"},
                        {"label": "Pending Verification", "value": "Pending Verification"},
                        {"label": "Suspended", "value": "Suspended"},
                      ],
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: filteredProfiles.length,
            itemBuilder: (context, index) {
              final profile = filteredProfiles[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    // Header Section
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor.withAlpha(20), Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: primaryColor, width: 3),
                            ),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage("${profile["profileImage"]}"),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${profile["name"]}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(profile["status"]),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${profile["status"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                Row(
                                  children: [
                                    Icon(Icons.credit_card, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text("${profile["license"]}", style: TextStyle(color: disabledBoldColor)),
                                    SizedBox(width: spMd),
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                    SizedBox(width: spXs),
                                    Text("${profile["rating"]}", style: TextStyle(color: disabledBoldColor, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(Icons.work, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text("${profile["experience"]} experience", style: TextStyle(color: disabledBoldColor)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Stats Section
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: Colors.blue.shade200),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.directions_car, color: Colors.blue, size: 24),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Trips",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${profile["completedTrips"]}",
                                    style: TextStyle(
                                      fontSize: 18,
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
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: Colors.green.shade200),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.attach_money, color: Colors.green, size: 24),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Earnings",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((profile["totalEarnings"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 18,
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
                                color: Colors.purple.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: Colors.purple.shade200),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.language, color: Colors.purple, size: 24),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Languages",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(profile["languages"] as List).length}",
                                    style: TextStyle(
                                      fontSize: 18,
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
                    ),
                    
                    // Contact and Action Section
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radiusLg),
                          bottomRight: Radius.circular(radiusLg),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.phone, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text("${profile["phone"]}", style: TextStyle(color: disabledBoldColor)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.email, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${profile["email"]}", 
                                        style: TextStyle(color: disabledBoldColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Full Profile",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.message,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.phone,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Document Status Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Document Status Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 200,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.verified, color: Colors.green, size: 32),
                          SizedBox(height: spSm),
                          Text(
                            "Verified",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${driverProfiles.where((p) => p["backgroundCheck"] == "Verified").length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.pending, color: Colors.orange, size: 32),
                          SizedBox(height: spSm),
                          Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${driverProfiles.where((p) => p["backgroundCheck"] == "In Progress").length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.warning, color: Colors.red, size: 32),
                          SizedBox(height: spSm),
                          Text(
                            "Expiring Soon",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "2",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Driver Document Details
          ...driverProfiles.map((profile) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${profile["profileImage"]}"),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${profile["name"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${profile["license"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: profile["backgroundCheck"] == "Verified" ? successColor : warningColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${profile["backgroundCheck"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Medical Expiry",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${profile["medicalExpiry"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "License Class",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Class ${profile["licenseClass"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Certifications",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(profile["certifications"] as List).length} certificates",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              label: "View Documents",
                              size: bs.sm,
                              onPressed: () {},
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
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Driver Analytics Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Driver Analytics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 200,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade400, Colors.blue.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.groups, color: Colors.white, size: 32),
                          SizedBox(height: spSm),
                          Text(
                            "Total Drivers",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${driverProfiles.length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green.shade400, Colors.green.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.trending_up, color: Colors.white, size: 32),
                          SizedBox(height: spSm),
                          Text(
                            "Avg Rating",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${(driverProfiles.fold(0.0, (sum, p) => sum + (p["rating"] as double)) / driverProfiles.length).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple.shade400, Colors.purple.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.attach_money, color: Colors.white, size: 32),
                          SizedBox(height: spSm),
                          Text(
                            "Total Revenue",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "\$${((driverProfiles.fold(0.0, (sum, p) => sum + (p["totalEarnings"] as double))).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Experience Distribution
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Experience Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...driverProfiles.map((profile) {
                  final experienceYears = int.parse(profile["experience"].toString().split(" ")[0]);
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${profile["profileImage"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${profile["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: (experienceYears / 10).clamp(0.0, 1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: experienceYears <= 2 ? warningColor : 
                                             experienceYears <= 5 ? infoColor : successColor,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${profile["experience"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Driver Profiles",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Profiles", icon: Icon(Icons.people)),
        Tab(text: "Documents", icon: Icon(Icons.description)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildProfilesTab(),
        _buildDocumentsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }
}
