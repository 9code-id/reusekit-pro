import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaBloodTypeView extends StatefulWidget {
  const HcaBloodTypeView({super.key});

  @override
  State<HcaBloodTypeView> createState() => _HcaBloodTypeViewState();
}

class _HcaBloodTypeViewState extends State<HcaBloodTypeView> {
  String bloodType = "A+";
  String rhFactor = "Positive";
  bool isVerified = true;
  String lastUpdated = "2024-01-15";
  String verificationMethod = "Laboratory Test";
  
  List<Map<String, dynamic>> bloodTypes = [
    {"label": "A+", "value": "A+"},
    {"label": "A-", "value": "A-"},
    {"label": "B+", "value": "B+"},
    {"label": "B-", "value": "B-"},
    {"label": "AB+", "value": "AB+"},
    {"label": "AB-", "value": "AB-"},
    {"label": "O+", "value": "O+"},
    {"label": "O-", "value": "O-"},
  ];

  List<Map<String, dynamic>> verificationMethods = [
    {"label": "Laboratory Test", "value": "Laboratory Test"},
    {"label": "Blood Donation", "value": "Blood Donation"},
    {"label": "Medical Record", "value": "Medical Record"},
    {"label": "Hospital Record", "value": "Hospital Record"},
  ];

  List<Map<String, dynamic>> compatibilityInfo = [
    {
      "type": "Can Donate To",
      "bloodTypes": ["A+", "AB+"],
      "description": "Your blood can help people with A+ and AB+ blood types",
      "icon": Icons.favorite,
      "color": Colors.red,
    },
    {
      "type": "Can Receive From",
      "bloodTypes": ["A+", "A-", "O+", "O-"],
      "description": "You can receive blood from A+, A-, O+, and O- donors",
      "icon": Icons.input,
      "color": Colors.blue,
    },
  ];

  List<Map<String, dynamic>> medicalNotes = [
    {
      "date": "2024-01-15",
      "note": "Blood type verified through comprehensive blood panel",
      "doctor": "Dr. Sarah Chen",
      "facility": "City Medical Center"
    },
    {
      "date": "2023-08-20",
      "note": "Initial blood typing during annual physical",
      "doctor": "Dr. Michael Rodriguez",
      "facility": "Primary Care Clinic"
    },
  ];

  void _updateBloodType() {
    ss("Blood type information updated successfully");
  }

  void _verifyBloodType() {
    ss("Blood type verification request submitted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Type Information"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Edit blood type
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Blood Type Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: isVerified ? successColor : warningColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: isVerified ? successColor : warningColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            bloodType,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Blood Type",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  isVerified ? Icons.verified : Icons.warning,
                                  size: 16,
                                  color: isVerified ? successColor : warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  isVerified ? "Verified" : "Unverified",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isVerified ? successColor : warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rh Factor",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              rhFactor,
                              style: TextStyle(
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
                          children: [
                            Text(
                              "Last Updated",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              lastUpdated,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
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
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Update",
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: _updateBloodType,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Verify",
                    icon: Icons.verified_user,
                    size: bs.sm,
                    onPressed: _verifyBloodType,
                  ),
                ),
              ],
            ),

            // Compatibility Information
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
                children: [
                  Text(
                    "Blood Compatibility",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...compatibilityInfo.map((info) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (info["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: info["color"] as Color,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              info["icon"] as IconData,
                              size: 20,
                              color: info["color"] as Color,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${info["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: info["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Wrap(
                          spacing: spXs,
                          children: (info["bloodTypes"] as List).map((type) => Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: info["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$type",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )).toList(),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${info["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),

            // Edit Blood Type Information
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
                children: [
                  Text(
                    "Update Blood Type",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Blood Type",
                    items: bloodTypes,
                    value: bloodType,
                    onChanged: (value, label) {
                      bloodType = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Verification Method",
                    items: verificationMethods,
                    value: verificationMethod,
                    onChanged: (value, label) {
                      verificationMethod = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Medical Notes
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
                children: [
                  Text(
                    "Medical Notes",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...medicalNotes.map((note) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: infoColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.note_alt,
                              size: 16,
                              color: infoColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${note["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${note["note"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${note["doctor"]} • ${note["facility"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
