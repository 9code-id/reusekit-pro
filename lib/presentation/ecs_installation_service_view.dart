import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsInstallationServiceView extends StatefulWidget {
  const EcsInstallationServiceView({super.key});

  @override
  State<EcsInstallationServiceView> createState() => _EcsInstallationServiceViewState();
}

class _EcsInstallationServiceViewState extends State<EcsInstallationServiceView> {
  String selectedService = "basic";
  DateTime selectedDate = DateTime.now().add(Duration(days: 2));
  String selectedTimeSlot = "9:00 AM - 12:00 PM";
  String contactName = "";
  String contactPhone = "";
  String contactEmail = "";
  String specialRequirements = "";
  bool hasExistingInstallation = false;
  bool needsRemoval = false;
  bool hasAccessIssues = false;
  
  Map<String, dynamic> product = {
    "name": "65\" 4K Smart TV",
    "category": "Electronics",
    "brand": "Samsung",
    "model": "QN65Q80B",
    "image": "https://picsum.photos/400/300?random=1&keyword=tv",
  };

  List<Map<String, dynamic>> installationServices = [
    {
      "id": "basic",
      "name": "Basic Installation",
      "description": "Standard wall mounting and cable connection",
      "duration": "1-2 hours",
      "price": 129.99,
      "included": [
        "Wall mounting (up to 65\")",
        "Basic cable management",
        "Power connection",
        "Initial setup",
      ],
      "icon": Icons.handyman,
    },
    {
      "id": "premium",
      "name": "Premium Installation",
      "description": "Professional installation with advanced setup",
      "duration": "2-3 hours",
      "price": 199.99,
      "included": [
        "Everything in Basic",
        "Advanced cable concealment",
        "Sound system setup",
        "Smart home integration",
        "Calibration & optimization",
      ],
      "icon": Icons.star,
    },
    {
      "id": "white_glove",
      "name": "White Glove Service",
      "description": "Premium service with complete setup",
      "duration": "3-4 hours",
      "price": 299.99,
      "included": [
        "Everything in Premium",
        "Custom mounting solutions",
        "Multi-room setup",
        "Training & demonstration",
        "90-day support",
      ],
      "icon": Icons.workspace_premium,
    },
  ];

  List<String> timeSlots = [
    "9:00 AM - 12:00 PM",
    "12:00 PM - 3:00 PM",
    "3:00 PM - 6:00 PM",
    "6:00 PM - 9:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Installation Service"),
        actions: [
          IconButton(
            onPressed: () {
              // FAQ or help
              ss("Opening installation FAQ");
            },
            icon: Icon(Icons.help_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${product["image"]}",
                      width: 80,
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
                          "${product["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${product["brand"]} ${product["model"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Installation Available",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
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
            SizedBox(height: spMd),

            // Installation Services
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
                    "Choose Installation Service",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...installationServices.map((service) {
                    bool isSelected = selectedService == service["id"];
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedService = service["id"];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  service["icon"],
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                  size: 24,
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${service["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? primaryColor : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${service["description"]}",
                                        style: TextStyle(
                                          fontSize: 12,
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
                                      "\$${(service["price"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? primaryColor : successColor,
                                      ),
                                    ),
                                    Text(
                                      "${service["duration"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Text(
                              "Included:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            ...(service["included"] as List<String>).map((item) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: successColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Schedule Installation
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
                    "Schedule Installation",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QDatePicker(
                    label: "Installation Date",
                    value: selectedDate,
                    onChanged: (value) {
                      setState(() {
                        selectedDate = value;
                      });
                    },
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Time Slot",
                    value: selectedTimeSlot,
                    items: timeSlots.map((slot) => {
                      "label": slot,
                      "value": slot,
                    }).toList(),
                    onChanged: (value, label) {
                      setState(() {
                        selectedTimeSlot = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Contact Information
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
                    "Contact Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Contact Name",
                    value: contactName,
                    hint: "Full name of person to contact",
                    onChanged: (value) {
                      setState(() {
                        contactName = value;
                      });
                    },
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Phone Number",
                    value: contactPhone,
                    hint: "Primary contact number",
                    onChanged: (value) {
                      setState(() {
                        contactPhone = value;
                      });
                    },
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Email Address",
                    value: contactEmail,
                    hint: "For appointment confirmations",
                    onChanged: (value) {
                      setState(() {
                        contactEmail = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Installation Details
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
                    "Installation Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    items: [
                      {
                        "label": "I have an existing installation to replace",
                        "value": "existing",
                        "checked": hasExistingInstallation,
                      }
                    ],
                    value: hasExistingInstallation ? [{"label": "I have an existing installation to replace", "value": "existing", "checked": true}] : [],
                    onChanged: (values, ids) {
                      setState(() {
                        hasExistingInstallation = values.isNotEmpty;
                      });
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "I need old equipment removed",
                        "value": "removal",
                        "checked": needsRemoval,
                      }
                    ],
                    value: needsRemoval ? [{"label": "I need old equipment removed", "value": "removal", "checked": true}] : [],
                    onChanged: (values, ids) {
                      setState(() {
                        needsRemoval = values.isNotEmpty;
                      });
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "There may be access challenges (stairs, narrow hallways, etc.)",
                        "value": "access",
                        "checked": hasAccessIssues,
                      }
                    ],
                    value: hasAccessIssues ? [{"label": "There may be access challenges (stairs, narrow hallways, etc.)", "value": "access", "checked": true}] : [],
                    onChanged: (values, ids) {
                      setState(() {
                        hasAccessIssues = values.isNotEmpty;
                      });
                    },
                  ),
                  SizedBox(height: spMd),
                  QMemoField(
                    label: "Special Requirements",
                    value: specialRequirements,
                    hint: "Any special instructions or requirements for the installation",
                    onChanged: (value) {
                      setState(() {
                        specialRequirements = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Service Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Service Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Text(
                        "Service:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          installationServices.firstWhere((s) => s["id"] == selectedService)["name"],
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Date:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          selectedDate.dMMMy,
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Time:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          selectedTimeSlot,
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Cost:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "\$${(installationServices.firstWhere((s) => s["id"] == selectedService)["price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  if (needsRemoval || hasAccessIssues)
                    Column(
                      children: [
                        SizedBox(height: spSm),
                        Text(
                          "Additional fees may apply for removal services or access challenges. Our technician will provide a quote during the visit.",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Book Installation Button
            QButton(
              label: "Book Installation Service",
              size: bs.md,
              onPressed: () {
                ss("Installation service booked successfully!");
              },
            ),
            SizedBox(height: spSm),

            // Terms and Conditions
            Container(
              padding: EdgeInsets.all(spSm),
              child: Text(
                "By booking this service, you agree to our installation terms and conditions. Cancellation must be made at least 24 hours in advance.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
