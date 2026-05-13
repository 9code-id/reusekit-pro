import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDeliveryRequestView extends StatefulWidget {
  const LtaDeliveryRequestView({super.key});

  @override
  State<LtaDeliveryRequestView> createState() => _LtaDeliveryRequestViewState();
}

class _LtaDeliveryRequestViewState extends State<LtaDeliveryRequestView> {
  final formKey = GlobalKey<FormState>();
  
  // Sender Information
  String senderName = "";
  String senderPhone = "";
  String senderEmail = "";
  String senderAddress = "";
  String senderCity = "";
  String senderZipCode = "";
  
  // Recipient Information
  String recipientName = "";
  String recipientPhone = "";
  String recipientEmail = "";
  String recipientAddress = "";
  String recipientCity = "";
  String recipientZipCode = "";
  String recipientBuildingType = "Residential";
  String recipientFloor = "";
  bool recipientHasElevator = false;
  
  // Delivery Preferences
  String deliveryDate = DateTime.now().add(Duration(days: 1)).toString().substring(0, 10);
  String deliveryTime = "10:00";
  String preferredTimeSlot = "Morning (9AM - 12PM)";
  String deliveryInstructions = "";
  bool requiresSignature = false;
  bool leaveAtDoor = false;
  bool callBeforeDelivery = true;
  
  // Package Information
  String packageType = "General";
  String packageDescription = "";
  String packageWeight = "";
  String packageDimensions = "";
  String packageValue = "";
  bool isFragile = false;
  bool requiresRefrigeration = false;
  
  // Service Options
  String priorityLevel = "Standard";
  bool isExpress = false;
  bool requiresInsurance = false;
  String insuranceAmount = "";
  bool trackingRequired = true;
  bool proofOfDelivery = false;
  
  // Special Requirements
  String accessCode = "";
  String parkingInstructions = "";
  String alternateContact = "";
  String alternatePhone = "";
  String specialHandling = "";
  
  List<Map<String, dynamic>> buildingTypes = [
    {"label": "Residential", "value": "Residential"},
    {"label": "Commercial", "value": "Commercial"},
    {"label": "Office Building", "value": "Office Building"},
    {"label": "Apartment Complex", "value": "Apartment Complex"},
    {"label": "Hospital", "value": "Hospital"},
    {"label": "School", "value": "School"},
    {"label": "Other", "value": "Other"},
  ];
  
  List<Map<String, dynamic>> timeSlots = [
    {"label": "Morning (9AM - 12PM)", "value": "Morning (9AM - 12PM)"},
    {"label": "Afternoon (12PM - 5PM)", "value": "Afternoon (12PM - 5PM)"},
    {"label": "Evening (5PM - 8PM)", "value": "Evening (5PM - 8PM)"},
    {"label": "Anytime", "value": "Anytime"},
  ];
  
  List<Map<String, dynamic>> packageTypes = [
    {"label": "General", "value": "General"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Clothing", "value": "Clothing"},
    {"label": "Food Items", "value": "Food Items"},
    {"label": "Fragile Items", "value": "Fragile Items"},
    {"label": "Medical Supplies", "value": "Medical Supplies"},
    {"label": "Automotive Parts", "value": "Automotive Parts"},
    {"label": "Other", "value": "Other"},
  ];
  
  List<Map<String, dynamic>> priorityLevels = [
    {"label": "Economy (5-7 days)", "value": "Economy"},
    {"label": "Standard (2-3 days)", "value": "Standard"},
    {"label": "Express (1-2 days)", "value": "Express"},
    {"label": "Same Day", "value": "Same Day"},
    {"label": "Urgent (4 hours)", "value": "Urgent"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Delivery"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Request Delivery Service",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Professional delivery service to your doorstep",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        Icons.delivery_dining,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),

              // Sender Information
              Text(
                "Sender Information",
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
                    QTextField(
                      label: "Sender Name",
                      value: senderName,
                      validator: Validator.required,
                      onChanged: (value) {
                        senderName = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: senderPhone,
                            validator: Validator.required,
                            onChanged: (value) {
                              senderPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Email",
                            value: senderEmail,
                            validator: Validator.email,
                            onChanged: (value) {
                              senderEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QMemoField(
                      label: "Sender Address",
                      value: senderAddress,
                      validator: Validator.required,
                      onChanged: (value) {
                        senderAddress = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "City",
                            value: senderCity,
                            validator: Validator.required,
                            onChanged: (value) {
                              senderCity = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "ZIP Code",
                            value: senderZipCode,
                            validator: Validator.required,
                            onChanged: (value) {
                              senderZipCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Recipient Information
              Text(
                "Delivery Destination",
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
                    QTextField(
                      label: "Recipient Name",
                      value: recipientName,
                      validator: Validator.required,
                      onChanged: (value) {
                        recipientName = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: recipientPhone,
                            validator: Validator.required,
                            onChanged: (value) {
                              recipientPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Email",
                            value: recipientEmail,
                            validator: Validator.email,
                            onChanged: (value) {
                              recipientEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QMemoField(
                      label: "Delivery Address",
                      value: recipientAddress,
                      validator: Validator.required,
                      hint: "Complete address including building name, unit number",
                      onChanged: (value) {
                        recipientAddress = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "City",
                            value: recipientCity,
                            validator: Validator.required,
                            onChanged: (value) {
                              recipientCity = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "ZIP Code",
                            value: recipientZipCode,
                            validator: Validator.required,
                            onChanged: (value) {
                              recipientZipCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Building Type",
                            items: buildingTypes,
                            value: recipientBuildingType,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              recipientBuildingType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Floor Number",
                            value: recipientFloor,
                            hint: "Ground, 2nd, 3rd, etc.",
                            onChanged: (value) {
                              recipientFloor = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Elevator Available",
                          "value": true,
                          "checked": recipientHasElevator,
                        }
                      ],
                      value: [
                        if (recipientHasElevator)
                          {
                            "label": "Elevator Available",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          recipientHasElevator = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Delivery Schedule
              Text(
                "Delivery Schedule",
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
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Delivery Date",
                            value: DateTime.parse(deliveryDate),
                            onChanged: (value) {
                              deliveryDate = value.toString().substring(0, 10);
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTimePicker(
                            label: "Preferred Time",
                            value: deliveryTime.timeOfDay,
                            onChanged: (value) {
                              deliveryTime = value!.kkmm;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Time Slot Preference",
                      items: timeSlots,
                      value: preferredTimeSlot,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        preferredTimeSlot = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Priority Level",
                      items: priorityLevels,
                      value: priorityLevel,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        priorityLevel = value;
                        isExpress = value == "Express" || value == "Same Day" || value == "Urgent";
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Package Information
              Text(
                "Package Information",
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
                    QDropdownField(
                      label: "Package Type",
                      items: packageTypes,
                      value: packageType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        packageType = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Package Description",
                      value: packageDescription,
                      validator: Validator.required,
                      hint: "Detailed description of items",
                      onChanged: (value) {
                        packageDescription = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Weight (kg)",
                            value: packageWeight,
                            validator: Validator.required,
                            onChanged: (value) {
                              packageWeight = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Dimensions (L x W x H cm)",
                            value: packageDimensions,
                            validator: Validator.required,
                            onChanged: (value) {
                              packageDimensions = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QNumberField(
                      label: "Declared Value (\$)",
                      value: packageValue,
                      validator: Validator.required,
                      onChanged: (value) {
                        packageValue = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spMd,
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Fragile Item",
                                "value": true,
                                "checked": isFragile,
                              }
                            ],
                            value: [
                              if (isFragile)
                                {
                                  "label": "Fragile Item",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                isFragile = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Refrigeration Required",
                                "value": true,
                                "checked": requiresRefrigeration,
                              }
                            ],
                            value: [
                              if (requiresRefrigeration)
                                {
                                  "label": "Refrigeration Required",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                requiresRefrigeration = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Delivery Preferences
              Text(
                "Delivery Preferences",
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
                    QMemoField(
                      label: "Delivery Instructions",
                      value: deliveryInstructions,
                      hint: "Special instructions for the delivery driver",
                      onChanged: (value) {
                        deliveryInstructions = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spMd,
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Signature Required",
                                "value": true,
                                "checked": requiresSignature,
                              }
                            ],
                            value: [
                              if (requiresSignature)
                                {
                                  "label": "Signature Required",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                requiresSignature = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Leave at Door",
                                "value": true,
                                "checked": leaveAtDoor,
                              }
                            ],
                            value: [
                              if (leaveAtDoor)
                                {
                                  "label": "Leave at Door",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                leaveAtDoor = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spMd,
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Call Before Delivery",
                                "value": true,
                                "checked": callBeforeDelivery,
                              }
                            ],
                            value: [
                              if (callBeforeDelivery)
                                {
                                  "label": "Call Before Delivery",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                callBeforeDelivery = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Proof of Delivery",
                                "value": true,
                                "checked": proofOfDelivery,
                              }
                            ],
                            value: [
                              if (proofOfDelivery)
                                {
                                  "label": "Proof of Delivery",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                proofOfDelivery = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Additional Services
              Text(
                "Additional Services",
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
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Add Insurance",
                                "value": true,
                                "checked": requiresInsurance,
                              }
                            ],
                            value: [
                              if (requiresInsurance)
                                {
                                  "label": "Add Insurance",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                requiresInsurance = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        if (requiresInsurance)
                          Expanded(
                            child: QNumberField(
                              label: "Insurance Amount (\$)",
                              value: insuranceAmount,
                              validator: Validator.required,
                              onChanged: (value) {
                                insuranceAmount = value;
                                setState(() {});
                              },
                            ),
                          ),
                      ],
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Real-time Tracking",
                          "value": true,
                          "checked": trackingRequired,
                        }
                      ],
                      value: [
                        if (trackingRequired)
                          {
                            "label": "Real-time Tracking",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          trackingRequired = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Special Requirements
              Text(
                "Special Requirements",
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
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Access Code",
                            value: accessCode,
                            hint: "Building or gate access code",
                            onChanged: (value) {
                              accessCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Alternate Contact",
                            value: alternateContact,
                            hint: "Backup contact person",
                            onChanged: (value) {
                              alternateContact = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Alternate Phone",
                            value: alternatePhone,
                            hint: "Backup contact number",
                            onChanged: (value) {
                              alternatePhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Parking Instructions",
                            value: parkingInstructions,
                            hint: "Where driver can park",
                            onChanged: (value) {
                              parkingInstructions = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QMemoField(
                      label: "Special Handling Requirements",
                      value: specialHandling,
                      hint: "Any special care or handling instructions",
                      onChanged: (value) {
                        specialHandling = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Service Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: infoColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Service Summary",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• Delivery will be attempted during your preferred time slot",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "• You will receive tracking information once the delivery is dispatched",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "• Our driver will contact you before delivery if requested",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                    if (isExpress)
                      Text(
                        "• Express service selected - delivery will be prioritized",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Request",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ss("Delivery request saved successfully");
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Submit Request",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ss("Delivery request submitted successfully!");
                          //navigateTo(LtaDeliveryConfirmationView());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
