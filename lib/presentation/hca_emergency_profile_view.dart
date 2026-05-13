import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaEmergencyProfileView extends StatefulWidget {
  const HcaEmergencyProfileView({super.key});

  @override
  State<HcaEmergencyProfileView> createState() => _HcaEmergencyProfileViewState();
}

class _HcaEmergencyProfileViewState extends State<HcaEmergencyProfileView> {
  String bloodType = "O+";
  String allergies = "Penicillin, Shellfish, Peanuts";
  String currentMedications = "Metformin 500mg, Lisinopril 10mg, Aspirin 81mg";
  String medicalConditions = "Type 2 Diabetes, Hypertension, High Cholesterol";
  String emergencyContact1Name = "Sarah Johnson";
  String emergencyContact1Phone = "(555) 123-4567";
  String emergencyContact1Relationship = "Daughter";
  String emergencyContact2Name = "Michael Johnson";
  String emergencyContact2Phone = "(555) 987-6543";
  String emergencyContact2Relationship = "Son";
  String primaryPhysician = "Dr. Emily Chen";
  String primaryPhysicianPhone = "(555) 456-7890";
  String preferredHospital = "City Medical Center";
  String insuranceProvider = "Blue Cross Blue Shield";
  String insurancePolicyNumber = "BC123456789";
  String pharmacyName = "Westside Pharmacy";
  String pharmacyPhone = "(555) 234-5678";
  String additionalNotes = "Has pacemaker installed in 2022. Diabetic - check blood sugar if unconscious.";
  
  List<Map<String, dynamic>> bloodTypes = [
    {"label": "A+", "value": "A+"},
    {"label": "A-", "value": "A-"},
    {"label": "B+", "value": "B+"},
    {"label": "B-", "value": "B-"},
    {"label": "AB+", "value": "AB+"},
    {"label": "AB-", "value": "AB-"},
    {"label": "O+", "value": "O+"},
    {"label": "O-", "value": "O-"},
    {"label": "Unknown", "value": "unknown"},
  ];
  
  List<Map<String, dynamic>> emergencyActions = [
    {
      "title": "Call 911",
      "description": "For immediate medical emergencies",
      "icon": Icons.local_hospital,
      "color": dangerColor,
      "action": "911"
    },
    {
      "title": "Emergency Contact",
      "description": "Contact primary emergency contact",
      "icon": Icons.contact_phone,
      "color": primaryColor,
      "action": "emergency_contact"
    },
    {
      "title": "Poison Control",
      "description": "Call Poison Control Center",
      "icon": Icons.warning,
      "color": warningColor,
      "action": "poison_control"
    },
    {
      "title": "Primary Doctor",
      "description": "Contact primary physician",
      "icon": Icons.medical_services,
      "color": infoColor,
      "action": "primary_doctor"
    },
  ];
  
  List<Map<String, dynamic>> medicalAlerts = [
    {
      "title": "Pacemaker",
      "description": "Installed in 2022 - Inform medical personnel",
      "icon": Icons.favorite,
      "color": dangerColor,
      "priority": "critical"
    },
    {
      "title": "Diabetes",
      "description": "Check blood sugar if unconscious",
      "icon": Icons.water_drop,
      "color": warningColor,
      "priority": "high"
    },
    {
      "title": "Drug Allergies",
      "description": "Penicillin, Shellfish, Peanuts",
      "icon": Icons.block,
      "color": dangerColor,
      "priority": "critical"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareEmergencyProfile();
            },
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              _printEmergencyCard();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmergencyActions(),
            _buildMedicalAlerts(),
            _buildBasicInformation(),
            _buildMedicalInformation(),
            _buildEmergencyContacts(),
            _buildMedicalProviders(),
            _buildInsuranceInformation(),
            _buildAdditionalNotes(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showEmergencyDialog();
        },
        backgroundColor: dangerColor,
        icon: Icon(Icons.emergency, color: Colors.white),
        label: Text(
          "EMERGENCY",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [dangerColor, dangerColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.emergency,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Emergency Actions",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: emergencyActions.map((action) => _buildEmergencyActionCard(action)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyActionCard(Map<String, dynamic> action) {
    return GestureDetector(
      onTap: () => _handleEmergencyAction(action["action"]),
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(50),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(
              action["icon"],
              color: Colors.white,
              size: 32,
            ),
            SizedBox(height: spXs),
            Text(
              "${action["title"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "${action["description"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(200),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalAlerts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning,
                color: dangerColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Critical Medical Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          ...medicalAlerts.map((alert) => _buildMedicalAlertItem(alert)),
        ],
      ),
    );
  }

  Widget _buildMedicalAlertItem(Map<String, dynamic> alert) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: (alert["color"] as Color).withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (alert["color"] as Color).withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: alert["color"] as Color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              alert["icon"],
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${alert["title"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: alert["color"] as Color,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: alert["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${alert["priority"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${alert["description"]}",
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
  }

  Widget _buildBasicInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Blood Type",
            items: bloodTypes,
            value: bloodType,
            onChanged: (value, label) {
              bloodType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Medical Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Allergies",
            value: allergies,
            onChanged: (value) {
              allergies = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Current Medications",
            value: currentMedications,
            onChanged: (value) {
              currentMedications = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Medical Conditions",
            value: medicalConditions,
            onChanged: (value) {
              medicalConditions = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContacts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.contact_phone,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Emergency Contacts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Primary Contact",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          QTextField(
            label: "Name",
            value: emergencyContact1Name,
            onChanged: (value) {
              emergencyContact1Name = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: emergencyContact1Phone,
                  onChanged: (value) {
                    emergencyContact1Phone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Relationship",
                  value: emergencyContact1Relationship,
                  onChanged: (value) {
                    emergencyContact1Relationship = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Secondary Contact",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          QTextField(
            label: "Name",
            value: emergencyContact2Name,
            onChanged: (value) {
              emergencyContact2Name = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: emergencyContact2Phone,
                  onChanged: (value) {
                    emergencyContact2Phone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Relationship",
                  value: emergencyContact2Relationship,
                  onChanged: (value) {
                    emergencyContact2Relationship = value;
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

  Widget _buildMedicalProviders() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_hospital,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Medical Providers",
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
                child: QTextField(
                  label: "Primary Physician",
                  value: primaryPhysician,
                  onChanged: (value) {
                    primaryPhysician = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: primaryPhysicianPhone,
                  onChanged: (value) {
                    primaryPhysicianPhone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Preferred Hospital",
            value: preferredHospital,
            onChanged: (value) {
              preferredHospital = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Pharmacy Name",
                  value: pharmacyName,
                  onChanged: (value) {
                    pharmacyName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Pharmacy Phone",
                  value: pharmacyPhone,
                  onChanged: (value) {
                    pharmacyPhone = value;
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

  Widget _buildInsuranceInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.card_membership,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Insurance Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Insurance Provider",
            value: insuranceProvider,
            onChanged: (value) {
              insuranceProvider = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Policy Number",
            value: insurancePolicyNumber,
            onChanged: (value) {
              insurancePolicyNumber = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalNotes() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.note,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Additional Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Special Instructions for Emergency Personnel",
            value: additionalNotes,
            onChanged: (value) {
              additionalNotes = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Emergency Profile",
              size: bs.md,
              onPressed: () {
                ss("Emergency profile saved successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleEmergencyAction(String action) {
    switch (action) {
      case "911":
        _call911();
        break;
      case "emergency_contact":
        _callEmergencyContact();
        break;
      case "poison_control":
        _callPoisonControl();
        break;
      case "primary_doctor":
        _callPrimaryDoctor();
        break;
    }
  }

  void _call911() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emergency, color: dangerColor),
            SizedBox(width: spSm),
            Text("Calling 911"),
          ],
        ),
        content: Text("This would initiate a call to emergency services (911)."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Call Now",
            color: dangerColor,
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Emergency services contacted");
            },
          ),
        ],
      ),
    );
  }

  void _callEmergencyContact() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Emergency Contacts"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QButton(
              label: "Call $emergencyContact1Name ($emergencyContact1Relationship)",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                ss("Calling $emergencyContact1Name");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Call $emergencyContact2Name ($emergencyContact2Relationship)",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                ss("Calling $emergencyContact2Name");
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _callPoisonControl() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Poison Control"),
        content: Text("Call Poison Control Center at 1-800-222-1222"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Call Now",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Calling Poison Control");
            },
          ),
        ],
      ),
    );
  }

  void _callPrimaryDoctor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Primary Doctor"),
        content: Text("Call $primaryPhysician at $primaryPhysicianPhone"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Call Now",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Calling $primaryPhysician");
            },
          ),
        ],
      ),
    );
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emergency, color: dangerColor),
            SizedBox(width: spSm),
            Text("EMERGENCY", style: TextStyle(color: dangerColor)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Choose emergency action:",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            QButton(
              label: "Call 911",
              color: dangerColor,
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                _call911();
              },
            ),
            QButton(
              label: "Call Emergency Contact",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                _callEmergencyContact();
              },
            ),
            QButton(
              label: "Show Medical Info",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                _showQuickMedicalInfo();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showQuickMedicalInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quick Medical Info"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Blood Type: $bloodType", style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: spXs),
            Text("Allergies: $allergies"),
            SizedBox(height: spXs),
            Text("Conditions: $medicalConditions"),
            SizedBox(height: spXs),
            Text("Current Medications: $currentMedications"),
            SizedBox(height: spXs),
            Text("Emergency Contact: $emergencyContact1Name ($emergencyContact1Phone)"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _shareEmergencyProfile() {
    ss("Emergency profile shared successfully");
  }

  void _printEmergencyCard() {
    ss("Emergency card sent to printer");
  }
}
