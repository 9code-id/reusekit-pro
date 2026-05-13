import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaRateCalculatorView extends StatefulWidget {
  const DlaRateCalculatorView({super.key});

  @override
  State<DlaRateCalculatorView> createState() => _DlaRateCalculatorViewState();
}

class _DlaRateCalculatorViewState extends State<DlaRateCalculatorView> {
  String fromLocation = "";
  String toLocation = "";
  String serviceType = "standard";
  String vehicleType = "motorcycle";
  String packageType = "regular";
  double weight = 0.0;
  double dimensions_length = 0.0;
  double dimensions_width = 0.0;
  double dimensions_height = 0.0;
  int quantity = 1;
  bool isUrgent = false;
  bool requiresInsurance = false;
  bool requiresSignature = false;
  double insuranceValue = 0.0;
  String selectedDate = DateTime.now().add(Duration(days: 1)).toString().split(' ')[0];
  String selectedTime = "09:00";
  
  Map<String, dynamic>? calculatedRate;
  bool isCalculating = false;

  final List<Map<String, dynamic>> serviceTypes = [
    {"label": "Standard Delivery (3-5 days)", "value": "standard"},
    {"label": "Express Delivery (1-2 days)", "value": "express"},
    {"label": "Same Day Delivery", "value": "same_day"},
    {"label": "Next Day Delivery", "value": "next_day"},
    {"label": "Scheduled Delivery", "value": "scheduled"},
  ];

  final List<Map<String, dynamic>> vehicleTypes = [
    {"label": "Motorcycle", "value": "motorcycle"},
    {"label": "Small Van", "value": "small_van"},
    {"label": "Large Van", "value": "large_van"},
    {"label": "Truck", "value": "truck"},
    {"label": "Refrigerated Vehicle", "value": "refrigerated"},
  ];

  final List<Map<String, dynamic>> packageTypes = [
    {"label": "Regular Package", "value": "regular"},
    {"label": "Fragile Items", "value": "fragile"},
    {"label": "Documents", "value": "documents"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Food & Beverages", "value": "food"},
    {"label": "Hazardous Materials", "value": "hazardous"},
  ];

  final List<String> popularRoutes = [
    "Jakarta → Surabaya",
    "Jakarta → Bandung", 
    "Surabaya → Malang",
    "Bandung → Bogor",
    "Jakarta → Tangerang",
    "Surabaya → Sidoarjo",
  ];

  double get volume => dimensions_length * dimensions_width * dimensions_height / 1000000; // Convert to cubic meters

  Widget _buildLocationInput() {
    return Container(
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
              Icon(Icons.location_on, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Delivery Locations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "From Location",
            value: fromLocation,
            hint: "Enter pickup address or city",
            onChanged: (value) {
              fromLocation = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "To Location",
            value: toLocation,
            hint: "Enter delivery address or city",
            onChanged: (value) {
              toLocation = value;
              setState(() {});
            },
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Popular Routes",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Container(
            height: 40,
            child: QHorizontalScroll(
              children: popularRoutes.map((route) => Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    List<String> locations = route.split(' → ');
                    fromLocation = locations[0];
                    toLocation = locations[1];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Text(
                      route,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceOptions() {
    return Container(
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
          Text(
            "Service Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Service Type",
            items: serviceTypes,
            value: serviceType,
            onChanged: (value, label) {
              serviceType = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Vehicle Type",
                  items: vehicleTypes,
                  value: vehicleType,
                  onChanged: (value, label) {
                    vehicleType = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Package Type",
                  items: packageTypes,
                  value: packageType,
                  onChanged: (value, label) {
                    packageType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (serviceType == "scheduled")
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "Delivery Date",
                    value: DateTime.parse(selectedDate),
                    onChanged: (value) {
                      selectedDate = value.toString().split(' ')[0];
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QTimePicker(
                    label: "Delivery Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $selectedTime:00")),
                    onChanged: (value) {
                      selectedTime = value!.kkmm;
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

  Widget _buildPackageDetails() {
    return Container(
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
          Text(
            "Package Details",
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
                child: QNumberField(
                  label: "Weight (kg)",
                  value: weight.toString(),
                  onChanged: (value) {
                    weight = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Quantity",
                  value: quantity.toString(),
                  onChanged: (value) {
                    quantity = int.tryParse(value) ?? 1;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Text(
            "Dimensions (cm)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Length",
                  value: dimensions_length.toString(),
                  onChanged: (value) {
                    dimensions_length = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Width", 
                  value: dimensions_width.toString(),
                  onChanged: (value) {
                    dimensions_width = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Height",
                  value: dimensions_height.toString(),
                  onChanged: (value) {
                    dimensions_height = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (volume > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.calculate, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Calculated Volume: ${volume.toStringAsFixed(3)} m³",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalServices() {
    return Container(
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
          Text(
            "Additional Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Urgent Delivery (+50%)",
                "value": "urgent",
                "checked": isUrgent,
              }
            ],
            value: [if (isUrgent) {"label": "Urgent Delivery (+50%)", "value": "urgent", "checked": true}],
            onChanged: (values, ids) {
              isUrgent = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Signature Required (+\$2.50)",
                "value": "signature",
                "checked": requiresSignature,
              }
            ],
            value: [if (requiresSignature) {"label": "Signature Required (+\$2.50)", "value": "signature", "checked": true}],
            onChanged: (values, ids) {
              requiresSignature = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Insurance Coverage",
                "value": "insurance",
                "checked": requiresInsurance,
              }
            ],
            value: [if (requiresInsurance) {"label": "Insurance Coverage", "value": "insurance", "checked": true}],
            onChanged: (values, ids) {
              requiresInsurance = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (requiresInsurance)
            QNumberField(
              label: "Insurance Value (\$)",
              value: insuranceValue.toString(),
              hint: "Declared value of items",
              onChanged: (value) {
                insuranceValue = double.tryParse(value) ?? 0.0;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget _buildRateResults() {
    if (calculatedRate == null) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: successColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: successColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Calculated Rate",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Route:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "$fromLocation → $toLocation",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Distance:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${calculatedRate!["distance"]} km",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Estimated Time:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${calculatedRate!["estimated_time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: disabledOutlineBorderColor,
                ),
                Row(
                  children: [
                    Text(
                      "Base Cost:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(calculatedRate!["base_cost"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                if ((calculatedRate!["additional_fees"] as double) > 0)
                  Row(
                    children: [
                      Text(
                        "Additional Fees:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(calculatedRate!["additional_fees"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Text(
                      "Tax (10%):",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(calculatedRate!["tax"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 2,
                  color: successColor,
                ),
                Row(
                  children: [
                    Text(
                      "Total Rate:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(calculatedRate!["total_cost"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Save Quote",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    ss("Quote saved successfully");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Book Now",
                  size: bs.md,
                  onPressed: () {
                    ss("Proceeding to booking...");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _calculateRate() {
    if (fromLocation.isEmpty || toLocation.isEmpty) {
      se("Please enter both locations");
      return;
    }
    
    if (weight <= 0) {
      se("Please enter package weight");
      return;
    }

    isCalculating = true;
    setState(() {});

    // Simulate API call delay
    Future.delayed(Duration(seconds: 2), () {
      // Mock calculation
      double distance = 25.5 + (fromLocation.length + toLocation.length) * 0.5;
      double baseCost = _calculateBaseCost();
      double additionalFees = _calculateAdditionalFees();
      double tax = (baseCost + additionalFees) * 0.10;
      double totalCost = baseCost + additionalFees + tax;
      
      calculatedRate = {
        "distance": distance.toStringAsFixed(1),
        "estimated_time": _getEstimatedTime(),
        "base_cost": baseCost,
        "additional_fees": additionalFees,
        "tax": tax,
        "total_cost": totalCost,
      };
      
      isCalculating = false;
      setState(() {});
      ss("Rate calculated successfully!");
    });
  }

  double _calculateBaseCost() {
    Map<String, double> serviceRates = {
      "standard": 8.50,
      "express": 12.00,
      "same_day": 25.00,
      "next_day": 15.00,
      "scheduled": 10.00,
    };
    
    Map<String, double> vehicleMultipliers = {
      "motorcycle": 1.0,
      "small_van": 1.3,
      "large_van": 1.8,
      "truck": 2.5,
      "refrigerated": 3.0,
    };
    
    double baseRate = serviceRates[serviceType] ?? 8.50;
    double vehicleMultiplier = vehicleMultipliers[vehicleType] ?? 1.0;
    double weightCost = weight > 5.0 ? (weight - 5.0) * 2.00 : 0.0;
    double volumeCost = volume > 0.1 ? (volume - 0.1) * 15.00 : 0.0;
    
    double total = (baseRate * vehicleMultiplier) + weightCost + volumeCost;
    
    if (isUrgent) {
      total *= 1.5;
    }
    
    return total * quantity;
  }

  double _calculateAdditionalFees() {
    double fees = 0.0;
    
    if (requiresSignature) {
      fees += 2.50;
    }
    
    if (requiresInsurance && insuranceValue > 0) {
      fees += (insuranceValue * 0.01).clamp(5.0, 50.0);
    }
    
    if (packageType == "fragile") {
      fees += 5.00;
    } else if (packageType == "electronics") {
      fees += 3.00;
    } else if (packageType == "hazardous") {
      fees += 15.00;
    }
    
    return fees;
  }

  String _getEstimatedTime() {
    switch (serviceType) {
      case "same_day":
        return "Same Day";
      case "next_day":
        return "Next Day";
      case "express":
        return "1-2 Days";
      case "scheduled":
        return "Scheduled Date";
      default:
        return "3-5 Days";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Calculator"),
        actions: [
          QButton(
            icon: Icons.history,
            size: bs.sm,
            onPressed: () {
              si("View calculation history");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildLocationInput(),
            _buildServiceOptions(),
            _buildPackageDetails(),
            _buildAdditionalServices(),
            Container(
              width: double.infinity,
              child: QButton(
                label: isCalculating ? "Calculating..." : "Calculate Rate",
                size: bs.md,
                onPressed: isCalculating ? null : _calculateRate,
              ),
            ),
            _buildRateResults(),
          ],
        ),
      ),
    );
  }
}
