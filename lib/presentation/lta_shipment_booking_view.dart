import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaShipmentBookingView extends StatefulWidget {
  const LtaShipmentBookingView({super.key});

  @override
  State<LtaShipmentBookingView> createState() => _LtaShipmentBookingViewState();
}

class _LtaShipmentBookingViewState extends State<LtaShipmentBookingView> {
  int currentStep = 0;
  
  // Shipment Details
  String serviceType = "";
  String priority = "";
  DateTime? pickupDate;
  String pickupTime = "";
  DateTime? deliveryDate;
  String deliveryTime = "";
  
  // Addresses
  String senderName = "";
  String senderPhone = "";
  String senderAddress = "";
  String senderCity = "";
  String senderState = "";
  String senderZip = "";
  
  String recipientName = "";
  String recipientPhone = "";
  String recipientAddress = "";
  String recipientCity = "";
  String recipientState = "";
  String recipientZip = "";
  
  // Package Details
  String packageType = "";
  String weight = "";
  String dimensions = "";
  String quantity = "";
  String description = "";
  bool fragile = false;
  bool hazardous = false;
  String specialInstructions = "";
  
  // Additional Services
  bool insurance = false;
  String insuranceValue = "";
  bool signature = false;
  bool tracking = true;
  bool packaging = false;
  
  // Cost
  double baseCost = 0.0;
  double additionalCosts = 0.0;
  double totalCost = 0.0;

  List<Map<String, dynamic>> serviceTypes = [
    {"label": "Standard Delivery", "value": "standard", "price": 15.99},
    {"label": "Express Delivery", "value": "express", "price": 29.99},
    {"label": "Overnight Delivery", "value": "overnight", "price": 45.99},
    {"label": "Same Day Delivery", "value": "same_day", "price": 75.99},
    {"label": "International Shipping", "value": "international", "price": 125.99},
  ];

  List<Map<String, dynamic>> priorityLevels = [
    {"label": "Low", "value": "low"},
    {"label": "Normal", "value": "normal"},
    {"label": "High", "value": "high"},
    {"label": "Urgent", "value": "urgent"},
  ];

  List<Map<String, dynamic>> packageTypes = [
    {"label": "Document", "value": "document"},
    {"label": "Small Package", "value": "small_package"},
    {"label": "Medium Package", "value": "medium_package"},
    {"label": "Large Package", "value": "large_package"},
    {"label": "Oversized", "value": "oversized"},
  ];

  List<String> timeSlots = [
    "8:00 AM - 10:00 AM",
    "10:00 AM - 12:00 PM",
    "12:00 PM - 2:00 PM",
    "2:00 PM - 4:00 PM",
    "4:00 PM - 6:00 PM",
    "6:00 PM - 8:00 PM",
  ];

  List<Map<String, dynamic>> bookingSteps = [
    {
      "title": "Service & Schedule",
      "description": "Choose service type and delivery schedule",
      "icon": Icons.local_shipping,
    },
    {
      "title": "Addresses",
      "description": "Sender and recipient information",
      "icon": Icons.location_on,
    },
    {
      "title": "Package Details",
      "description": "Package specifications and description",
      "icon": Icons.inventory,
    },
    {
      "title": "Additional Services",
      "description": "Insurance, tracking, and special services",
      "icon": Icons.add_circle,
    },
    {
      "title": "Review & Payment",
      "description": "Review details and complete booking",
      "icon": Icons.payment,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Shipment"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              ss("Shipment details saved as draft");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Step ${currentStep + 1} of ${bookingSteps.length}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(((currentStep + 1) / bookingSteps.length) * 100).toStringAsFixed(0)}% Complete",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (currentStep + 1) / bookingSteps.length,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        bookingSteps[currentStep]["icon"] as IconData,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${bookingSteps[currentStep]["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${bookingSteps[currentStep]["description"]}",
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
              ],
            ),
          ),
          
          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildCurrentStep(),
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              spacing: spSm,
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                Expanded(
                  flex: currentStep == 0 ? 1 : 1,
                  child: QButton(
                    label: currentStep == bookingSteps.length - 1 ? "Book Shipment" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep == bookingSteps.length - 1) {
                        _completeBooking();
                      } else {
                        if (_validateCurrentStep()) {
                          currentStep++;
                          setState(() {});
                          if (currentStep == bookingSteps.length - 1) {
                            _calculateTotalCost();
                          }
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildServiceScheduleStep();
      case 1:
        return _buildAddressesStep();
      case 2:
        return _buildPackageDetailsStep();
      case 3:
        return _buildAdditionalServicesStep();
      case 4:
        return _buildReviewPaymentStep();
      default:
        return Container();
    }
  }

  Widget _buildServiceScheduleStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Service & Schedule",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QDropdownField(
          label: "Service Type",
          items: serviceTypes.map((service) => {
            "label": "${service["label"]} - \$${((service["price"] as double).toDouble()).currency}",
            "value": "${service["value"]}",
          }).toList(),
          value: serviceType,
          onChanged: (value, label) {
            serviceType = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Priority Level",
          items: priorityLevels,
          value: priority,
          onChanged: (value, label) {
            priority = value;
            setState(() {});
          },
        ),
        
        Text(
          "Pickup Schedule",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDatePicker(
                label: "Pickup Date",
                value: pickupDate ?? DateTime.now(),
                onChanged: (value) {
                  pickupDate = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QDropdownField(
                label: "Pickup Time",
                items: timeSlots.map((slot) => {
                  "label": slot,
                  "value": slot,
                }).toList(),
                value: pickupTime,
                onChanged: (value, label) {
                  pickupTime = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        Text(
          "Delivery Schedule",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDatePicker(
                label: "Delivery Date",
                value: deliveryDate ?? DateTime.now().add(Duration(days: 1)),
                onChanged: (value) {
                  deliveryDate = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QDropdownField(
                label: "Delivery Time",
                items: timeSlots.map((slot) => {
                  "label": slot,
                  "value": slot,
                }).toList(),
                value: deliveryTime,
                onChanged: (value, label) {
                  deliveryTime = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressesStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Sender Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QTextField(
                label: "Sender Name",
                value: senderName,
                validator: Validator.required,
                onChanged: (value) {
                  senderName = value;
                  setState(() {});
                },
              ),
            ),
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
          ],
        ),
        
        QTextField(
          label: "Street Address",
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
              flex: 2,
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
                label: "State",
                value: senderState,
                validator: Validator.required,
                onChanged: (value) {
                  senderState = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QTextField(
                label: "ZIP Code",
                value: senderZip,
                validator: Validator.required,
                onChanged: (value) {
                  senderZip = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spMd),
        
        Text(
          "Recipient Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QTextField(
                label: "Recipient Name",
                value: recipientName,
                validator: Validator.required,
                onChanged: (value) {
                  recipientName = value;
                  setState(() {});
                },
              ),
            ),
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
          ],
        ),
        
        QTextField(
          label: "Street Address",
          value: recipientAddress,
          validator: Validator.required,
          onChanged: (value) {
            recipientAddress = value;
            setState(() {});
          },
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              flex: 2,
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
                label: "State",
                value: recipientState,
                validator: Validator.required,
                onChanged: (value) {
                  recipientState = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QTextField(
                label: "ZIP Code",
                value: recipientZip,
                validator: Validator.required,
                onChanged: (value) {
                  recipientZip = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPackageDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Package Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QDropdownField(
          label: "Package Type",
          items: packageTypes,
          value: packageType,
          onChanged: (value, label) {
            packageType = value;
            setState(() {});
          },
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QNumberField(
                label: "Weight (lbs)",
                value: weight,
                onChanged: (value) {
                  weight = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QTextField(
                label: "Dimensions (L×W×H)",
                value: dimensions,
                hint: "e.g., 12×8×6 inches",
                onChanged: (value) {
                  dimensions = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QNumberField(
                label: "Quantity",
                value: quantity,
                onChanged: (value) {
                  quantity = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        QMemoField(
          label: "Package Description",
          value: description,
          hint: "Describe the contents of your package",
          onChanged: (value) {
            description = value;
            setState(() {});
          },
        ),
        
        Text(
          "Special Handling",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Column(
          spacing: spSm,
          children: [
            QSwitch(
              items: [
                {
                  "label": "Fragile - Handle with care",
                  "value": "fragile",
                  "checked": fragile,
                }
              ],
              value: fragile ? [{"label": "Fragile - Handle with care", "value": "fragile", "checked": true}] : [],
              onChanged: (values, ids) {
                fragile = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            QSwitch(
              items: [
                {
                  "label": "Hazardous materials",
                  "value": "hazardous",
                  "checked": hazardous,
                }
              ],
              value: hazardous ? [{"label": "Hazardous materials", "value": "hazardous", "checked": true}] : [],
              onChanged: (values, ids) {
                hazardous = values.isNotEmpty;
                setState(() {});
              },
            ),
          ],
        ),
        
        QMemoField(
          label: "Special Instructions",
          value: specialInstructions,
          hint: "Any special handling or delivery instructions",
          onChanged: (value) {
            specialInstructions = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildAdditionalServicesStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Additional Services",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Column(
          spacing: spSm,
          children: [
            QSwitch(
              items: [
                {
                  "label": "Package Insurance (+\$5.99)",
                  "value": "insurance",
                  "checked": insurance,
                }
              ],
              value: insurance ? [{"label": "Package Insurance (+\$5.99)", "value": "insurance", "checked": true}] : [],
              onChanged: (values, ids) {
                insurance = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            if (insurance)
              QNumberField(
                label: "Insurance Value (\$)",
                value: insuranceValue,
                hint: "Enter package value for insurance",
                onChanged: (value) {
                  insuranceValue = value;
                  setState(() {});
                },
              ),
            
            QSwitch(
              items: [
                {
                  "label": "Signature Required (+\$3.99)",
                  "value": "signature",
                  "checked": signature,
                }
              ],
              value: signature ? [{"label": "Signature Required (+\$3.99)", "value": "signature", "checked": true}] : [],
              onChanged: (values, ids) {
                signature = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            QSwitch(
              items: [
                {
                  "label": "Real-time Tracking (Included)",
                  "value": "tracking",
                  "checked": tracking,
                }
              ],
              value: tracking ? [{"label": "Real-time Tracking (Included)", "value": "tracking", "checked": true}] : [],
              onChanged: (values, ids) {
                tracking = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            QSwitch(
              items: [
                {
                  "label": "Professional Packaging (+\$12.99)",
                  "value": "packaging",
                  "checked": packaging,
                }
              ],
              value: packaging ? [{"label": "Professional Packaging (+\$12.99)", "value": "packaging", "checked": true}] : [],
              onChanged: (values, ids) {
                packaging = values.isNotEmpty;
                setState(() {});
              },
            ),
          ],
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(color: infoColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Additional services help protect your package and provide better delivery experience. You can add or remove these services as needed.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewPaymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Review & Payment",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        // Shipment Summary
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Shipment Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              _buildSummaryRow("Service Type", _getServiceLabel()),
              _buildSummaryRow("Priority", priority),
              _buildSummaryRow("Pickup", "${pickupDate?.toString().split(' ')[0]} $pickupTime"),
              _buildSummaryRow("Delivery", "${deliveryDate?.toString().split(' ')[0]} $deliveryTime"),
              _buildSummaryRow("From", "$senderCity, $senderState"),
              _buildSummaryRow("To", "$recipientCity, $recipientState"),
              _buildSummaryRow("Package", "$packageType - $weight lbs"),
            ],
          ),
        ),
        
        // Cost Breakdown
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Cost Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              _buildCostRow("Base Shipping", baseCost),
              if (insurance) _buildCostRow("Insurance", 5.99),
              if (signature) _buildCostRow("Signature Required", 3.99),
              if (packaging) _buildCostRow("Professional Packaging", 12.99),
              
              Divider(),
              
              Row(
                children: [
                  Text(
                    "Total Cost",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "\$${totalCost.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Payment Method
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(color: successColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.credit_card,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Payment will be processed using your default payment method. You'll receive confirmation and tracking details via email.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCostRow(String label, double amount) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Spacer(),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  String _getServiceLabel() {
    var service = serviceTypes.firstWhere(
      (s) => s["value"] == serviceType,
      orElse: () => {"label": "Unknown Service"},
    );
    return service["label"] as String;
  }

  void _calculateTotalCost() {
    // Get base cost from selected service
    var service = serviceTypes.firstWhere(
      (s) => s["value"] == serviceType,
      orElse: () => {"price": 0.0},
    );
    baseCost = (service["price"] as double);
    
    // Calculate additional costs
    additionalCosts = 0.0;
    if (insurance) additionalCosts += 5.99;
    if (signature) additionalCosts += 3.99;
    if (packaging) additionalCosts += 12.99;
    
    totalCost = baseCost + additionalCosts;
    
    setState(() {});
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        if (serviceType.isEmpty || priority.isEmpty || pickupTime.isEmpty || deliveryTime.isEmpty) {
          se("Please complete service and schedule details");
          return false;
        }
        break;
      case 1:
        if (senderName.isEmpty || senderAddress.isEmpty || recipientName.isEmpty || recipientAddress.isEmpty) {
          se("Please complete address information");
          return false;
        }
        break;
      case 2:
        if (packageType.isEmpty || weight.isEmpty || description.isEmpty) {
          se("Please complete package details");
          return false;
        }
        break;
      case 3:
        if (insurance && insuranceValue.isEmpty) {
          se("Please enter insurance value");
          return false;
        }
        break;
    }
    return true;
  }

  void _completeBooking() {
    if (!_validateCurrentStep()) return;
    
    ss("Shipment booked successfully! Tracking number: LTA${DateTime.now().millisecondsSinceEpoch}");
    // Navigate to confirmation or tracking screen
  }
}
