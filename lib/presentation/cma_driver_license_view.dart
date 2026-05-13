import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaDriverLicenseView extends StatefulWidget {
  const CmaDriverLicenseView({super.key});

  @override
  State<CmaDriverLicenseView> createState() => _CmaDriverLicenseViewState();
}

class _CmaDriverLicenseViewState extends State<CmaDriverLicenseView> {
  String licenseNumber = "D123456789";
  String firstName = "John";
  String lastName = "Smith";
  String middleName = "Michael";
  String dateOfBirth = "1985-03-15";
  String address = "123 Main Street";
  String city = "Springfield";
  String state = "Illinois";
  String zipCode = "62701";
  String licenseClass = "Class C";
  DateTime issueDate = DateTime(2022, 8, 15);
  DateTime expiryDate = DateTime(2026, 8, 15);
  String restrictions = "None";
  String endorsements = "";
  
  List<Map<String, dynamic>> licenseClasses = [
    {"label": "Class A", "value": "Class A"},
    {"label": "Class B", "value": "Class B"},
    {"label": "Class C", "value": "Class C"},
    {"label": "Class M", "value": "Class M"},
    {"label": "CDL A", "value": "CDL A"},
    {"label": "CDL B", "value": "CDL B"},
  ];

  List<Map<String, dynamic>> licenseHistory = [
    {
      "licenseNumber": "D123456789",
      "issueDate": DateTime(2022, 8, 15),
      "expiryDate": DateTime(2026, 8, 15),
      "class": "Class C",
      "status": "Active",
      "state": "Illinois",
    },
    {
      "licenseNumber": "D987654321",
      "issueDate": DateTime(2018, 8, 15),
      "expiryDate": DateTime(2022, 8, 15),
      "class": "Class C",
      "status": "Expired",
      "state": "Illinois",
    },
    {
      "licenseNumber": "D555666777",
      "issueDate": DateTime(2014, 8, 15),
      "expiryDate": DateTime(2018, 8, 15),
      "class": "Class C",
      "status": "Expired",
      "state": "Illinois",
    },
  ];

  List<Map<String, dynamic>> renewalSteps = [
    {
      "step": 1,
      "title": "Check Eligibility",
      "description": "Verify your license is eligible for renewal",
      "completed": true,
    },
    {
      "step": 2,
      "title": "Gather Documents",
      "description": "Collect required identification documents",
      "completed": true,
    },
    {
      "step": 3,
      "title": "Complete Application",
      "description": "Fill out renewal application form",
      "completed": false,
    },
    {
      "step": 4,
      "title": "Vision Test",
      "description": "Pass vision screening test",
      "completed": false,
    },
    {
      "step": 5,
      "title": "Pay Fees",
      "description": "Pay license renewal fees",
      "completed": false,
    },
    {
      "step": 6,
      "title": "Receive License",
      "description": "Get your new license",
      "completed": false,
    },
  ];

  List<Map<String, dynamic>> requiredDocuments = [
    {
      "document": "Proof of Identity",
      "examples": ["Birth Certificate", "Passport", "Certificate of Naturalization"],
      "required": true,
    },
    {
      "document": "Social Security",
      "examples": ["Social Security Card", "W-2 Form", "Pay Stub"],
      "required": true,
    },
    {
      "document": "Proof of Residency",
      "examples": ["Utility Bill", "Bank Statement", "Lease Agreement"],
      "required": true,
    },
    {
      "document": "Previous License",
      "examples": ["Current Driver's License"],
      "required": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isExpiringSoon = expiryDate.isBefore(DateTime.now().add(Duration(days: 90)));
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver's License"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditLicenseDialog();
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
            // License Status Alert
            if (isExpiringSoon)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 28),
                        SizedBox(width: spSm),
                        Text(
                          "License Expiring Soon",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your driver's license expires on ${expiryDate.dMMMy}. Please renew before expiration.",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start Renewal Process",
                        color: warningColor,
                        onPressed: () {
                          _showRenewalProcessDialog();
                        },
                      ),
                    ),
                  ],
                ),
              ),

            // Digital License Card
            Container(
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
                      Text(
                        "DRIVER LICENSE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Spacer(),
                      Text(
                        state.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "$firstName $middleName $lastName",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "$address",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "$city, $state $zipCode",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
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
                          spacing: spXs,
                          children: [
                            Text(
                              "LICENSE #",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              licenseNumber,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
                              "CLASS",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              licenseClass,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
                              "DOB",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateTime.parse(dateOfBirth).dMMMy,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
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
                              "EXPIRES",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              expiryDate.dMMMy,
                              style: TextStyle(
                                color: isExpiringSoon ? Colors.yellow : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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

            // Quick Actions
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                _buildQuickActionCard(
                  "Renew License",
                  Icons.refresh,
                  primaryColor,
                  () => _showRenewalProcessDialog(),
                ),
                _buildQuickActionCard(
                  "Update Address",
                  Icons.home,
                  infoColor,
                  () => _showUpdateAddressDialog(),
                ),
                _buildQuickActionCard(
                  "Replace Lost",
                  Icons.find_replace,
                  warningColor,
                  () => _showReplacementDialog(),
                ),
                _buildQuickActionCard(
                  "DMV Services",
                  Icons.location_on,
                  successColor,
                  () => si("Finding nearby DMV offices"),
                ),
              ],
            ),

            // License Details
            Text(
              "License Details",
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Issue Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              issueDate.dMMMy,
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
                              expiryDate.dMMMy,
                              style: TextStyle(
                                fontSize: 14,
                                color: isExpiringSoon ? dangerColor : null,
                              ),
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
                              "Restrictions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              restrictions,
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
                              "Endorsements",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              endorsements.isEmpty ? "None" : endorsements,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Required Documents for Renewal
            Text(
              "Required Documents for Renewal",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              spacing: spSm,
              children: requiredDocuments.map((doc) {
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
                      Row(
                        children: [
                          Icon(
                            doc["required"] as bool ? Icons.star : Icons.star_border,
                            color: doc["required"] as bool ? warningColor : disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${doc["document"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (doc["required"] as bool) ...[
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "REQUIRED",
                                style: TextStyle(
                                  color: dangerColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        "Examples: ${(doc["examples"] as List).join(", ")}",
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

            // License History
            Text(
              "License History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              spacing: spSm,
              children: licenseHistory.map((license) {
                Color statusColor = (license["status"] as String) == "Active" 
                    ? successColor 
                    : disabledBoldColor;
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          (license["status"] as String) == "Active" 
                              ? Icons.check_circle 
                              : Icons.history,
                          color: statusColor,
                          size: 20,
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
                                  "${license["licenseNumber"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${license["status"]}",
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${license["class"]} • ${license["state"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Valid: ${(license["issueDate"] as DateTime).dMMMy} - ${(license["expiryDate"] as DateTime).dMMMy}",
                              style: TextStyle(
                                fontSize: 11,
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
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditLicenseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit License Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "License Number",
              value: licenseNumber,
              onChanged: (value) {
                licenseNumber = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "License Class",
              items: licenseClasses,
              value: licenseClass,
              onChanged: (value, label) {
                licenseClass = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Restrictions",
              value: restrictions,
              onChanged: (value) {
                restrictions = value;
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
              ss("License information updated");
            },
            child: Text("Save Changes"),
          ),
        ],
      ),
    );
  }

  void _showRenewalProcessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("License Renewal Process"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: renewalSteps.map((step) {
              bool isCompleted = step["completed"] as bool;
              Color stepColor = isCompleted ? successColor : disabledBoldColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: stepColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: stepColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isCompleted ? Icons.check : Icons.radio_button_unchecked,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${step["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${step["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Starting license renewal application");
            },
            child: Text("Start Renewal"),
          ),
        ],
      ),
    );
  }

  void _showUpdateAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Address"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Street Address",
              value: address,
              onChanged: (value) {
                address = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "City",
              value: city,
              onChanged: (value) {
                city = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "ZIP Code",
              value: zipCode,
              onChanged: (value) {
                zipCode = value;
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
              ss("Address update submitted");
            },
            child: Text("Update Address"),
          ),
        ],
      ),
    );
  }

  void _showReplacementDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Replace Lost License"),
        content: Text(
          "You can request a replacement for your lost or damaged driver's license. "
          "A replacement fee will apply."
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Starting license replacement process");
            },
            child: Text("Request Replacement"),
          ),
        ],
      ),
    );
  }
}
