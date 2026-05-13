import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaHospitalDirectoryView extends StatefulWidget {
  const HcaHospitalDirectoryView({super.key});

  @override
  State<HcaHospitalDirectoryView> createState() => _HcaHospitalDirectoryViewState();
}

class _HcaHospitalDirectoryViewState extends State<HcaHospitalDirectoryView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedCity = "";
  int selectedTab = 0;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": ""},
    {"label": "General Hospital", "value": "general"},
    {"label": "Specialty Center", "value": "specialty"},
    {"label": "Emergency Care", "value": "emergency"},
    {"label": "Pediatric Hospital", "value": "pediatric"},
    {"label": "Mental Health", "value": "mental"},
    {"label": "Rehabilitation", "value": "rehab"},
  ];

  List<Map<String, dynamic>> cities = [
    {"label": "All Cities", "value": ""},
    {"label": "New York", "value": "newyork"},
    {"label": "Los Angeles", "value": "losangeles"},
    {"label": "Chicago", "value": "chicago"},
    {"label": "Houston", "value": "houston"},
    {"label": "Miami", "value": "miami"},
  ];

  List<Map<String, dynamic>> hospitals = [
    {
      "id": "1",
      "name": "Metropolitan General Hospital",
      "category": "General Hospital",
      "city": "New York",
      "address": "123 Medical Center Drive, New York, NY 10001",
      "phone": "+1 (555) 123-4567",
      "email": "info@metropolitan.com",
      "website": "www.metropolitangeneral.com",
      "rating": 4.8,
      "reviews": 2456,
      "beds": 850,
      "founded": 1925,
      "image": "https://picsum.photos/400/250?random=1&keyword=hospital",
      "logo": "https://picsum.photos/80/80?random=101&keyword=medical",
      "isEmergency": true,
      "isTrauma": true,
      "accreditation": ["Joint Commission", "MAGNET", "AHRQ"],
      "specialties": [
        "Cardiology", "Neurology", "Oncology", "Orthopedics", 
        "Emergency Medicine", "Surgery", "Pediatrics", "Radiology"
      ],
      "services": [
        "24/7 Emergency Care", "Cardiac Surgery", "Cancer Treatment",
        "Maternity Care", "ICU", "Surgical Services", "Diagnostic Imaging"
      ],
      "insurance": ["Medicare", "Medicaid", "Blue Cross", "Aetna", "Cigna", "UnitedHealth"],
      "keyStats": {
        "patients": 125000,
        "staff": 3500,
        "surgeries": 15000,
        "births": 2800
      }
    },
    {
      "id": "2",
      "name": "Heart & Vascular Institute",
      "category": "Specialty Center",
      "city": "Los Angeles",
      "address": "456 Cardiac Avenue, Los Angeles, CA 90210",
      "phone": "+1 (555) 234-5678",
      "email": "contact@heartvascular.com",
      "website": "www.heartvascular.com",
      "rating": 4.9,
      "reviews": 1890,
      "beds": 300,
      "founded": 1985,
      "image": "https://picsum.photos/400/250?random=2&keyword=cardiac",
      "logo": "https://picsum.photos/80/80?random=102&keyword=heart",
      "isEmergency": true,
      "isTrauma": false,
      "accreditation": ["Joint Commission", "American Heart Association"],
      "specialties": ["Cardiology", "Cardiac Surgery", "Vascular Surgery", "Interventional Cardiology"],
      "services": [
        "Heart Transplant", "Cardiac Catheterization", "Pacemaker Implantation",
        "Vascular Surgery", "Heart Failure Treatment", "Cardiac Rehabilitation"
      ],
      "insurance": ["Medicare", "Blue Cross", "Aetna", "Kaiser", "Humana"],
      "keyStats": {
        "patients": 45000,
        "staff": 1200,
        "surgeries": 5000,
        "procedures": 12000
      }
    },
    {
      "id": "3",
      "name": "Children's Medical Center",
      "category": "Pediatric Hospital",
      "city": "Chicago",
      "address": "789 Kids Way, Chicago, IL 60601",
      "phone": "+1 (555) 345-6789",
      "email": "info@childrensmedical.com",
      "website": "www.childrensmedical.com",
      "rating": 4.7,
      "reviews": 3200,
      "beds": 450,
      "founded": 1960,
      "image": "https://picsum.photos/400/250?random=3&keyword=pediatric",
      "logo": "https://picsum.photos/80/80?random=103&keyword=children",
      "isEmergency": true,
      "isTrauma": true,
      "accreditation": ["Joint Commission", "MAGNET", "AANMC"],
      "specialties": [
        "Pediatric Surgery", "Neonatology", "Pediatric Cardiology",
        "Child Psychology", "Pediatric Oncology", "Orthopedics"
      ],
      "services": [
        "NICU", "Pediatric Emergency", "Child Life Services",
        "Pediatric Surgery", "Family Support", "Specialized Therapy"
      ],
      "insurance": ["Medicare", "Medicaid", "Blue Cross", "Aetna", "UnitedHealth"],
      "keyStats": {
        "patients": 85000,
        "staff": 2100,
        "surgeries": 8000,
        "births": 4200
      }
    },
    {
      "id": "4",
      "name": "Emergency Trauma Center",
      "category": "Emergency Care",
      "city": "Houston",
      "address": "321 Emergency Blvd, Houston, TX 77001",
      "phone": "+1 (555) 456-7890",
      "email": "emergency@traumacenter.com",
      "website": "www.emergencytrauma.com",
      "rating": 4.6,
      "reviews": 1567,
      "beds": 200,
      "founded": 1995,
      "image": "https://picsum.photos/400/250?random=4&keyword=emergency",
      "logo": "https://picsum.photos/80/80?random=104&keyword=ambulance",
      "isEmergency": true,
      "isTrauma": true,
      "accreditation": ["Joint Commission", "ACS Trauma Center"],
      "specialties": [
        "Emergency Medicine", "Trauma Surgery", "Critical Care",
        "Toxicology", "Emergency Psychiatry"
      ],
      "services": [
        "Level 1 Trauma", "24/7 Emergency", "Flight Services",
        "Poison Control", "Crisis Intervention", "Emergency Surgery"
      ],
      "insurance": ["Medicare", "Medicaid", "All Major Insurance"],
      "keyStats": {
        "patients": 95000,
        "staff": 800,
        "emergencies": 75000,
        "traumas": 3500
      }
    },
    {
      "id": "5",
      "name": "Wellness Mental Health Institute",
      "category": "Mental Health",
      "city": "Miami",
      "address": "654 Wellness Drive, Miami, FL 33101",
      "phone": "+1 (555) 567-8901",
      "email": "info@wellnessmental.com",
      "website": "www.wellnessmental.com",
      "rating": 4.5,
      "reviews": 890,
      "beds": 150,
      "founded": 2005,
      "image": "https://picsum.photos/400/250?random=5&keyword=wellness",
      "logo": "https://picsum.photos/80/80?random=105&keyword=mental",
      "isEmergency": false,
      "isTrauma": false,
      "accreditation": ["Joint Commission", "CARF", "NAMI"],
      "specialties": [
        "Psychiatry", "Psychology", "Addiction Treatment",
        "Family Therapy", "Adolescent Care", "Crisis Counseling"
      ],
      "services": [
        "Inpatient Treatment", "Outpatient Programs", "Group Therapy",
        "Crisis Intervention", "Addiction Recovery", "Family Support"
      ],
      "insurance": ["Medicare", "Medicaid", "Blue Cross", "Aetna", "UnitedHealth"],
      "keyStats": {
        "patients": 12000,
        "staff": 450,
        "programs": 25,
        "sessions": 35000
      }
    }
  ];

  List<Map<String, dynamic>> get filteredHospitals {
    return hospitals.where((hospital) {
      bool matchesSearch = searchQuery.isEmpty || 
          hospital["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          hospital["category"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (hospital["specialties"] as List).any((specialty) => 
              specialty.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory.isEmpty || 
          hospital["category"].toString().toLowerCase().contains(selectedCategory.toLowerCase());
      
      bool matchesCity = selectedCity.isEmpty || 
          hospital["city"].toString().toLowerCase().contains(selectedCity.toLowerCase());
      
      return matchesSearch && matchesCategory && matchesCity;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital Directory"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              ss("Opening hospital map view");
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          _buildTabSection(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Icon(
                    Icons.search,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search hospitals, specialties...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: disabledColor,
                        fontSize: 14,
                      ),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "City",
                  items: cities,
                  value: selectedCity,
                  onChanged: (value, label) {
                    selectedCity = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildTab("All Hospitals", 0),
          _buildTab("Emergency Only", 1),
          _buildTab("Favorites", 2),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    List<Map<String, dynamic>> displayHospitals = filteredHospitals;
    
    if (selectedTab == 1) {
      displayHospitals = filteredHospitals.where((h) => h["isEmergency"]).toList();
    } else if (selectedTab == 2) {
      displayHospitals = []; // Favorites would be stored locally
    }

    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(spMd),
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_hospital,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Found ${displayHospitals.length} hospitals",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ...displayHospitals.map((hospital) => _buildHospitalCard(hospital)).toList(),
        ],
      ),
    );
  }

  Widget _buildHospitalCard(Map<String, dynamic> hospital) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
              image: DecorationImage(
                image: NetworkImage("${hospital["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${hospital["category"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (hospital["isEmergency"])
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.emergency,
                            color: Colors.white,
                            size: 10,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "24/7",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${hospital["logo"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${hospital["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${hospital["city"]} • ${hospital["beds"]} beds",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${hospital["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${hospital["address"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (hospital["specialties"] as List).take(4).map((specialty) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${specialty}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if ((hospital["accreditation"] as List).isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: successColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Accredited",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " • ${(hospital["accreditation"] as List).length} certifications",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          _showHospitalDetails(hospital);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () {
                        ss("Calling ${hospital["name"]}");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.directions,
                      size: bs.sm,
                      onPressed: () {
                        ss("Getting directions to ${hospital["name"]}");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.favorite_border,
                      size: bs.sm,
                      onPressed: () {
                        ss("Added to favorites");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Filter Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hospital Features",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              CheckboxListTile(
                title: Text(
                  "Emergency Services",
                  style: TextStyle(fontSize: 14),
                ),
                value: true,
                onChanged: (value) {},
                dense: true,
              ),
              CheckboxListTile(
                title: Text(
                  "Trauma Center",
                  style: TextStyle(fontSize: 14),
                ),
                value: false,
                onChanged: (value) {},
                dense: true,
              ),
              CheckboxListTile(
                title: Text(
                  "Teaching Hospital",
                  style: TextStyle(fontSize: 14),
                ),
                value: false,
                onChanged: (value) {},
                dense: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: disabledBoldColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ss("Filters applied");
              },
              child: Text(
                "Apply",
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showHospitalDetails(Map<String, dynamic> hospital) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${hospital["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          image: DecorationImage(
                            image: NetworkImage("${hospital["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${hospital["logo"]}"),
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
                                  "${hospital["category"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Founded in ${hospital["founded"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: warningColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${hospital["rating"]} (${hospital["reviews"]} reviews)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spLg),
                      Text(
                        "Key Statistics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 150,
                        children: [
                          _buildStatCard("Beds", "${hospital["beds"]}", Icons.bed, primaryColor),
                          _buildStatCard("Annual Patients", "${((hospital["keyStats"]["patients"] as int) / 1000).toInt()}K", Icons.people, successColor),
                          _buildStatCard("Staff", "${((hospital["keyStats"]["staff"] as int) / 1000).toStringAsFixed(1)}K", Icons.medical_services, infoColor),
                          _buildStatCard("Surgeries/Year", "${((hospital["keyStats"]["surgeries"] as int) / 1000).toInt()}K", Icons.healing, warningColor),
                        ],
                      ),
                      SizedBox(height: spLg),
                      Text(
                        "Medical Specialties",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spSm,
                        runSpacing: spSm,
                        children: (hospital["specialties"] as List).map((specialty) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: primaryColor.withAlpha(40)),
                            ),
                            child: Text(
                              "${specialty}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spLg),
                      Text(
                        "Services",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...((hospital["services"] as List).map((service) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${service}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()),
                      SizedBox(height: spLg),
                      Text(
                        "Insurance Accepted",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (hospital["insurance"] as List).map((insurance) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: infoColor.withAlpha(40)),
                            ),
                            child: Text(
                              "${insurance}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spLg),
                      Text(
                        "Accreditations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...((hospital["accreditation"] as List).map((accred) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.verified,
                                color: warningColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${accred}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()),
                      SizedBox(height: spLg),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${hospital["address"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${hospital["phone"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.web,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${hospital["website"]}",
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(40)),
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
