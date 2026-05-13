import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsEmergencyContactView extends StatefulWidget {
  const BrsEmergencyContactView({super.key});

  @override
  State<BrsEmergencyContactView> createState() => _BrsEmergencyContactViewState();
}

class _BrsEmergencyContactViewState extends State<BrsEmergencyContactView> {
  final formKey = GlobalKey<FormState>();
  
  String emergencyContactName = "";
  String emergencyContactPhone = "";
  String emergencyContactRelation = "";
  String emergencyContactEmail = "";
  String medicalConditions = "";
  String allergies = "";
  String currentMedications = "";
  String bloodType = "";
  String additionalNotes = "";
  
  List<Map<String, dynamic>> relationItems = [
    {"label": "Spouse", "value": "spouse"},
    {"label": "Parent", "value": "parent"},
    {"label": "Child", "value": "child"},
    {"label": "Sibling", "value": "sibling"},
    {"label": "Friend", "value": "friend"},
    {"label": "Colleague", "value": "colleague"},
    {"label": "Other", "value": "other"},
  ];
  
  List<Map<String, dynamic>> bloodTypeItems = [
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
  
  List<Map<String, dynamic>> emergencyServices = [
    {
      "name": "Emergency Medical Services",
      "phone": "911",
      "description": "Medical emergencies, accidents",
      "icon": Icons.medical_services,
      "color": Colors.red,
    },
    {
      "name": "Police Department",
      "phone": "911",
      "description": "Security, criminal activities",
      "icon": Icons.local_police,
      "color": Colors.blue,
    },
    {
      "name": "Fire Department",
      "phone": "911", 
      "description": "Fire emergencies, rescue operations",
      "icon": Icons.local_fire_department,
      "color": Colors.orange,
    },
    {
      "name": "Poison Control Center",
      "phone": "1-800-222-1222",
      "description": "Poisoning emergencies",
      "icon": Icons.warning,
      "color": Colors.purple,
    },
    {
      "name": "Mental Health Crisis Line",
      "phone": "988",
      "description": "Mental health emergencies",
      "icon": Icons.psychology,
      "color": Colors.teal,
    },
  ];
  
  List<Map<String, dynamic>> nearbyHospitals = [
    {
      "name": "Central General Hospital",
      "address": "123 Main Street, Downtown",
      "phone": "(555) 123-4567",
      "distance": "1.2 km",
      "rating": 4.8,
      "emergency": true,
    },
    {
      "name": "St. Mary's Medical Center",
      "address": "456 Oak Avenue, Midtown",
      "phone": "(555) 234-5678",
      "distance": "2.1 km",
      "rating": 4.6,
      "emergency": true,
    },
    {
      "name": "Metro Emergency Clinic",
      "address": "789 Pine Street, Eastside",
      "phone": "(555) 345-6789",
      "distance": "3.5 km",
      "rating": 4.2,
      "emergency": false,
    },
  ];
  
  void _saveEmergencyContact() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Emergency contact information saved successfully");
    }
  }
  
  void _callEmergencyService(String phone) async {
    bool isConfirmed = await confirm("Are you sure you want to call $phone?");
    if (isConfirmed) {
      // Simulate making a call
      ss("Calling $phone...");
    }
  }
  
  void _callHospital(String phone, String name) async {
    bool isConfirmed = await confirm("Call $name at $phone?");
    if (isConfirmed) {
      ss("Calling $name...");
    }
  }
  
  void _getDirections(String hospitalName) {
    ss("Opening directions to $hospitalName...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Contact"),
        actions: [
          IconButton(
            onPressed: () {
              ss("Emergency protocols downloaded");
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Emergency Alert Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.emergency, color: dangerColor, size: 24),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Emergency Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Keep this information updated for emergency situations",
                          style: TextStyle(
                            color: dangerColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Emergency Services Quick Access
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.phone_in_talk, color: dangerColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Emergency Services",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: emergencyServices.map((service) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (service["color"] as Color).withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                service["icon"] as IconData,
                                color: service["color"] as Color,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${service["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "${service["description"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "${service["phone"]}",
                              size: bs.sm,
                              onPressed: () => _callEmergencyService("${service["phone"]}"),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Personal Emergency Contact Form
            Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(Icons.person, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Emergency Contact Person",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Full Name",
                      value: emergencyContactName,
                      validator: Validator.required,
                      onChanged: (value) {
                        emergencyContactName = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: emergencyContactPhone,
                            validator: Validator.required,
                            onChanged: (value) {
                              emergencyContactPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Relationship",
                            items: relationItems,
                            value: emergencyContactRelation,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              emergencyContactRelation = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Email Address",
                      value: emergencyContactEmail,
                      hint: "Optional",
                      onChanged: (value) {
                        emergencyContactEmail = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            // Medical Information Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.medical_information, color: primaryColor, size: 20),
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
                  QDropdownField(
                    label: "Blood Type",
                    items: bloodTypeItems,
                    value: bloodType,
                    onChanged: (value, label) {
                      bloodType = value;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Medical Conditions",
                    value: medicalConditions,
                    hint: "List any chronic conditions, disabilities, or medical history...",
                    onChanged: (value) {
                      medicalConditions = value;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Allergies",
                    value: allergies,
                    hint: "Food allergies, drug allergies, environmental allergies...",
                    onChanged: (value) {
                      allergies = value;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Current Medications",
                    value: currentMedications,
                    hint: "List all medications you are currently taking...",
                    onChanged: (value) {
                      currentMedications = value;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Additional Notes",
                    value: additionalNotes,
                    hint: "Any other important medical information...",
                    onChanged: (value) {
                      additionalNotes = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Save Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Emergency Information",
                icon: Icons.save,
                onPressed: _saveEmergencyContact,
              ),
            ),
            
            // Nearby Hospitals Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.local_hospital, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Nearby Hospitals",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: nearbyHospitals.map((hospital) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: (hospital["emergency"] as bool) ? dangerColor : warningColor,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${hospital["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                if (hospital["emergency"] as bool)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "24/7 ER",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              "${hospital["address"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: disabledBoldColor, size: 12),
                                SizedBox(width: spXs),
                                Text(
                                  "${hospital["distance"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.star, color: warningColor, size: 12),
                                SizedBox(width: spXs),
                                Text(
                                  "${hospital["rating"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    QButton(
                                      icon: Icons.phone,
                                      size: bs.sm,
                                      onPressed: () => _callHospital("${hospital["phone"]}", "${hospital["name"]}"),
                                    ),
                                    SizedBox(width: spXs),
                                    QButton(
                                      icon: Icons.directions,
                                      size: bs.sm,
                                      onPressed: () => _getDirections("${hospital["name"]}"),
                                    ),
                                  ],
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
          ],
        ),
      ),
    );
  }
}
