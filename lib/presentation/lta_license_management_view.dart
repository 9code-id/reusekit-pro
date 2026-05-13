import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaLicenseManagementView extends StatefulWidget {
  const LtaLicenseManagementView({super.key});

  @override
  State<LtaLicenseManagementView> createState() => _LtaLicenseManagementViewState();
}

class _LtaLicenseManagementViewState extends State<LtaLicenseManagementView> {
  int selectedTab = 0;
  String selectedStatus = "All";
  String selectedLicenseType = "All";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> licenses = [
    {
      "id": "LIC-2024-001",
      "driverId": "DRV-001",
      "driverName": "Michael Johnson",
      "driverPhoto": "https://picsum.photos/80/80?random=1&keyword=man",
      "licenseNumber": "DL-123456789",
      "licenseType": "Commercial",
      "category": "Class C",
      "status": "Active",
      "issueDate": "2022-03-15",
      "expiryDate": "2026-03-15",
      "issuingAuthority": "Department of Motor Vehicles",
      "restrictions": "None",
      "endorsements": ["Passenger Transport", "Taxi Service"],
      "points": 0,
      "violations": [],
      "medicalCertificate": {
        "status": "Valid",
        "expiryDate": "2025-06-30",
        "lastExam": "2024-06-30"
      },
      "renewalNotified": false,
      "companyName": "Premium Transport Co.",
      "phoneNumber": "+1 (555) 123-4567",
      "address": "123 Main Street, Downtown",
      "emergencyContact": {
        "name": "Sarah Johnson",
        "phone": "+1 (555) 234-5678",
        "relationship": "Spouse"
      },
    },
    {
      "id": "LIC-2024-002",
      "driverId": "DRV-002",
      "driverName": "Robert Wilson",
      "driverPhoto": "https://picsum.photos/80/80?random=2&keyword=man",
      "licenseNumber": "DL-987654321",
      "licenseType": "Commercial",
      "category": "Class B",
      "status": "Expiring Soon",
      "issueDate": "2020-11-20",
      "expiryDate": "2025-01-20",
      "issuingAuthority": "Department of Motor Vehicles",
      "restrictions": "Corrective Lenses Required",
      "endorsements": ["Heavy Vehicle", "Passenger Transport"],
      "points": 3,
      "violations": [
        {
          "date": "2024-08-15",
          "type": "Speed Violation",
          "points": 3,
          "fine": 150
        }
      ],
      "medicalCertificate": {
        "status": "Valid",
        "expiryDate": "2025-03-15",
        "lastExam": "2024-03-15"
      },
      "renewalNotified": true,
      "companyName": "City Cab Services",
      "phoneNumber": "+1 (555) 234-5678",
      "address": "456 Oak Avenue, Uptown",
      "emergencyContact": {
        "name": "Maria Wilson",
        "phone": "+1 (555) 345-6789",
        "relationship": "Wife"
      },
    },
    {
      "id": "LIC-2024-003",
      "driverId": "DRV-003",
      "driverName": "Jennifer Martinez",
      "driverPhoto": "https://picsum.photos/80/80?random=3&keyword=woman",
      "licenseNumber": "DL-456789123",
      "licenseType": "Commercial",
      "category": "Class C",
      "status": "Active",
      "issueDate": "2023-01-10",
      "expiryDate": "2027-01-10",
      "issuingAuthority": "Department of Motor Vehicles",
      "restrictions": "None",
      "endorsements": ["Passenger Transport", "Delivery Service"],
      "points": 0,
      "violations": [],
      "medicalCertificate": {
        "status": "Valid",
        "expiryDate": "2025-12-31",
        "lastExam": "2024-12-31"
      },
      "renewalNotified": false,
      "companyName": "Express Logistics",
      "phoneNumber": "+1 (555) 345-6789",
      "address": "789 Pine Road, Westside",
      "emergencyContact": {
        "name": "Carlos Martinez",
        "phone": "+1 (555) 456-7890",
        "relationship": "Husband"
      },
    },
    {
      "id": "LIC-2024-004",
      "driverId": "DRV-004",
      "driverName": "Amanda Thompson",
      "driverPhoto": "https://picsum.photos/80/80?random=4&keyword=woman",
      "licenseNumber": "DL-789123456",
      "licenseType": "Standard",
      "category": "Class D",
      "status": "Suspended",
      "issueDate": "2021-06-25",
      "expiryDate": "2025-06-25",
      "issuingAuthority": "Department of Motor Vehicles",
      "restrictions": "None",
      "endorsements": [],
      "points": 12,
      "violations": [
        {
          "date": "2024-10-05",
          "type": "DUI",
          "points": 8,
          "fine": 1000
        },
        {
          "date": "2024-09-20",
          "type": "Reckless Driving",
          "points": 4,
          "fine": 500
        }
      ],
      "medicalCertificate": {
        "status": "Expired",
        "expiryDate": "2024-06-25",
        "lastExam": "2023-06-25"
      },
      "renewalNotified": false,
      "companyName": "Budget Rides",
      "phoneNumber": "+1 (555) 456-7890",
      "address": "321 Elm Street, Eastside",
      "emergencyContact": {
        "name": "Tom Thompson",
        "phone": "+1 (555) 567-8901",
        "relationship": "Father"
      },
    },
    {
      "id": "LIC-2024-005",
      "driverId": "DRV-005",
      "driverName": "Christopher Davis",
      "driverPhoto": "https://picsum.photos/80/80?random=5&keyword=man",
      "licenseNumber": "DL-321654987",
      "licenseType": "Commercial",
      "category": "Class A",
      "status": "Expired",
      "issueDate": "2019-09-12",
      "expiryDate": "2024-09-12",
      "issuingAuthority": "Department of Motor Vehicles",
      "restrictions": "None",
      "endorsements": ["Heavy Vehicle", "Hazmat", "Passenger Transport"],
      "points": 0,
      "violations": [],
      "medicalCertificate": {
        "status": "Expired",
        "expiryDate": "2024-09-12",
        "lastExam": "2023-09-12"
      },
      "renewalNotified": true,
      "companyName": "Elite Transport Services",
      "phoneNumber": "+1 (555) 567-8901",
      "address": "654 Cedar Lane, Northside",
      "emergencyContact": {
        "name": "Linda Davis",
        "phone": "+1 (555) 678-9012",
        "relationship": "Sister"
      },
    },
  ];

  List<Map<String, dynamic>> renewalReminders = [
    {
      "driverName": "Robert Wilson",
      "licenseNumber": "DL-987654321",
      "expiryDate": "2025-01-20",
      "daysUntilExpiry": 32,
      "category": "Class B",
    },
    {
      "driverName": "Amanda Thompson",
      "licenseNumber": "DL-789123456",
      "expiryDate": "2025-06-25",
      "daysUntilExpiry": 189,
      "category": "Class D",
    },
  ];

  List<String> statusOptions = ["All", "Active", "Expiring Soon", "Expired", "Suspended"];
  List<String> licenseTypeOptions = ["All", "Commercial", "Standard"];
  List<String> categoryOptions = ["All", "Class A", "Class B", "Class C", "Class D"];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "License Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Licenses", icon: Icon(Icons.card_membership)),
        Tab(text: "Renewals", icon: Icon(Icons.refresh)),
        Tab(text: "Violations", icon: Icon(Icons.warning)),
      ],
      tabChildren: [
        // Licenses Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Status Summary Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [successColor.withAlpha(25), successColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.verified_user,
                                color: successColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${licenses.where((license) => license["status"] == "Active").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Active Licenses",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Valid & Current",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [warningColor.withAlpha(25), warningColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: warningColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${licenses.where((license) => license["status"] == "Expiring Soon").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Expiring Soon",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Renewal Required",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [dangerColor.withAlpha(25), dangerColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.error,
                                color: dangerColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${licenses.where((license) => license["status"] == "Expired" || license["status"] == "Suspended").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Invalid Licenses",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Action Required",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor.withAlpha(25), primaryColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: primaryColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${licenses.length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Total Drivers",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "In System",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Filters
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions.map((status) => {
                        "label": status,
                        "value": status,
                      }).toList(),
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "License Type",
                      items: licenseTypeOptions.map((type) => {
                        "label": type,
                        "value": type,
                      }).toList(),
                      value: selectedLicenseType,
                      onChanged: (value, label) {
                        selectedLicenseType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QDropdownField(
                label: "Category",
                items: categoryOptions.map((category) => {
                  "label": category,
                  "value": category,
                }).toList(),
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),

              // Licenses List
              Column(
                children: licenses
                    .where((license) {
                      if (selectedStatus != "All" && license["status"] != selectedStatus) return false;
                      if (selectedLicenseType != "All" && license["licenseType"] != selectedLicenseType) return false;
                      if (selectedCategory != "All" && license["category"] != selectedCategory) return false;
                      return true;
                    })
                    .map((license) {
                  Color statusColor = license["status"] == "Active" ? successColor :
                                     license["status"] == "Expiring Soon" ? warningColor :
                                     license["status"] == "Suspended" ? dangerColor :
                                     license["status"] == "Expired" ? dangerColor : infoColor;

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: statusColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.network(
                                "${license["driverPhoto"]}",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${license["driverName"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${license["licenseNumber"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${license["licenseType"]} • ${license["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${license["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // License Details
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Valid until ${license["expiryDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.location_city,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${license["issuingAuthority"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Company & Contact Info
                        Row(
                          children: [
                            Icon(
                              Icons.business,
                              color: primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${license["companyName"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.phone,
                              color: primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${license["phoneNumber"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        // Points & Violations
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.toll,
                                    color: license["points"] > 0 ? dangerColor : successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${license["points"]} points",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: license["points"] > 0 ? dangerColor : successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.medical_services,
                                    color: license["medicalCertificate"]["status"] == "Valid" ? successColor : dangerColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Medical: ${license["medicalCertificate"]["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: license["medicalCertificate"]["status"] == "Valid" ? successColor : dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Endorsements
                        if ((license["endorsements"] as List).isNotEmpty)
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Endorsements:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (license["endorsements"] as List).map((endorsement) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(50),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "$endorsement",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),

                        // Restrictions
                        if (license["restrictions"] != "None")
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Restriction: ${license["restrictions"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        Row(
                          children: [
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            if (license["status"] == "Expiring Soon" || license["status"] == "Expired")
                              QButton(
                                label: "Renew License",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            if (license["medicalCertificate"]["status"] == "Expired")
                              SizedBox(width: spSm),
                            if (license["medicalCertificate"]["status"] == "Expired")
                              QButton(
                                label: "Medical Update",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Renewals Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Renewal Reminders",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                children: renewalReminders.map((reminder) {
                  Color urgencyColor = reminder["daysUntilExpiry"] <= 30 ? dangerColor :
                                      reminder["daysUntilExpiry"] <= 60 ? warningColor : infoColor;

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: urgencyColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              reminder["daysUntilExpiry"] <= 30 ? Icons.error : Icons.schedule,
                              color: urgencyColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${reminder["driverName"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${reminder["licenseNumber"]} • ${reminder["category"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: urgencyColor.withAlpha(25),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${reminder["daysUntilExpiry"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: urgencyColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: urgencyColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: urgencyColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Expires on ${reminder["expiryDate"]} (${reminder["daysUntilExpiry"]} days remaining)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: urgencyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            QButton(
                              label: "Send Reminder",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Schedule Renewal",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              if (renewalReminders.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 48,
                          color: successColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "All Licenses Current",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "No immediate renewals required",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Send All Reminders",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),

        // Violations Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Violations Statistics
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [dangerColor.withAlpha(25), dangerColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: dangerColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${licenses.fold(0, (sum, license) => sum + (license["violations"] as List).length)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Total Violations",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "All Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [warningColor.withAlpha(25), warningColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.toll,
                                color: warningColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${licenses.fold(0, (sum, license) => sum + (license["points"] as int))}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Total Points",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Active",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Text(
                "Drivers with Violations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                children: licenses
                    .where((license) => (license["violations"] as List).isNotEmpty)
                    .map((license) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: dangerColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.network(
                                "${license["driverPhoto"]}",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${license["driverName"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${license["licenseNumber"]} • ${license["points"]} points",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (license["status"] == "Suspended")
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "SUSPENDED",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        Column(
                          children: (license["violations"] as List).map((violation) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${violation["type"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: dangerColor,
                                          ),
                                        ),
                                        Text(
                                          "${violation["date"]} • ${violation["points"]} points",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "\$${violation["fine"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                        Row(
                          children: [
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Contact Driver",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              if (licenses.where((license) => (license["violations"] as List).isNotEmpty).isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.sentiment_very_satisfied,
                          size: 48,
                          color: successColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Clean Driving Records",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "No violations on record for any driver",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
