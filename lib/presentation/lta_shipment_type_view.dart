import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaShipmentTypeView extends StatefulWidget {
  const LtaShipmentTypeView({super.key});

  @override
  State<LtaShipmentTypeView> createState() => _LtaShipmentTypeViewState();
}

class _LtaShipmentTypeViewState extends State<LtaShipmentTypeView> {
  String selectedShipmentType = "";
  String selectedPriority = "";
  String selectedHandling = "";
  String selectedInsurance = "";
  bool requiresSignature = false;
  bool isFragile = false;
  bool isHazardous = false;
  bool isPerishable = false;
  String specialInstructions = "";

  // Sample data
  List<Map<String, dynamic>> shipmentTypes = [
    {
      "id": "standard",
      "title": "Standard Shipping",
      "description": "Regular delivery in 3-5 business days",
      "icon": Icons.local_shipping,
      "price": 9.99,
      "deliveryTime": "3-5 business days",
      "features": ["Tracking included", "Basic insurance", "Door to door"],
    },
    {
      "id": "express",
      "title": "Express Delivery",
      "description": "Faster delivery in 1-2 business days",
      "icon": Icons.flash_on,
      "price": 19.99,
      "deliveryTime": "1-2 business days",
      "features": ["Priority handling", "Real-time tracking", "Signature required"],
    },
    {
      "id": "overnight",
      "title": "Overnight",
      "description": "Next business day delivery guaranteed",
      "icon": Icons.nightlight,
      "price": 29.99,
      "deliveryTime": "Next business day",
      "features": ["Express handling", "Priority routing", "SMS notifications"],
    },
    {
      "id": "same_day",
      "title": "Same Day",
      "description": "Delivery within the same day",
      "icon": Icons.today,
      "price": 49.99,
      "deliveryTime": "Same day",
      "features": ["Immediate pickup", "Direct delivery", "Live tracking"],
    },
  ];

  List<Map<String, dynamic>> priorityLevels = [
    {
      "label": "Standard",
      "value": "standard",
    },
    {
      "label": "High Priority",
      "value": "high",
    },
    {
      "label": "Urgent",
      "value": "urgent",
    },
    {
      "label": "Critical",
      "value": "critical",
    },
  ];

  List<Map<String, dynamic>> handlingOptions = [
    {
      "label": "Standard Handling",
      "value": "standard",
    },
    {
      "label": "Fragile - Handle with Care",
      "value": "fragile",
    },
    {
      "label": "Hazardous Materials",
      "value": "hazardous",
    },
    {
      "label": "Temperature Controlled",
      "value": "temperature",
    },
  ];

  List<Map<String, dynamic>> insuranceOptions = [
    {
      "label": "No Insurance",
      "value": "none",
    },
    {
      "label": "Basic Coverage (\$100)",
      "value": "basic",
    },
    {
      "label": "Enhanced Coverage (\$500)",
      "value": "enhanced",
    },
    {
      "label": "Premium Coverage (\$1000)",
      "value": "premium",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipment Type"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_shipping,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Choose Shipment Type",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Select the delivery option that best fits your needs",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Shipment Type Selection
            Text(
              "Delivery Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              spacing: spSm,
              children: shipmentTypes.map((type) {
                bool isSelected = selectedShipmentType == type["id"];
                return GestureDetector(
                  onTap: () {
                    selectedShipmentType = "${type["id"]}";
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? primaryColor.withAlpha(30)
                                    : disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                type["icon"] as IconData,
                                color: isSelected ? primaryColor : disabledBoldColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${type["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? primaryColor : primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${type["description"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: spXs,
                              children: [
                                Text(
                                  "\$${((type["price"] as double)).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${type["deliveryTime"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (isSelected) ...[
                          Divider(color: disabledColor),
                          Text(
                            "Features:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: (type["features"] as List).map((feature) {
                              return Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "$feature",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Priority Level
            QDropdownField(
              label: "Priority Level",
              items: priorityLevels,
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
              },
            ),

            // Special Handling
            QDropdownField(
              label: "Special Handling",
              items: handlingOptions,
              value: selectedHandling,
              onChanged: (value, label) {
                selectedHandling = value;
                setState(() {});
              },
            ),

            // Package Properties
            Text(
              "Package Properties",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Fragile Item",
                        "value": true,
                        "checked": isFragile,
                      }
                    ],
                    value: [if (isFragile) {"label": "Fragile Item", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      isFragile = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Hazardous Material",
                        "value": true,
                        "checked": isHazardous,
                      }
                    ],
                    value: [if (isHazardous) {"label": "Hazardous Material", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      isHazardous = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Perishable Goods",
                        "value": true,
                        "checked": isPerishable,
                      }
                    ],
                    value: [if (isPerishable) {"label": "Perishable Goods", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      isPerishable = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Requires Signature",
                        "value": true,
                        "checked": requiresSignature,
                      }
                    ],
                    value: [if (requiresSignature) {"label": "Requires Signature", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      requiresSignature = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Insurance Coverage
            QDropdownField(
              label: "Insurance Coverage",
              items: insuranceOptions,
              value: selectedInsurance,
              onChanged: (value, label) {
                selectedInsurance = value;
                setState(() {});
              },
            ),

            // Special Instructions
            QMemoField(
              label: "Special Instructions",
              value: specialInstructions,
              hint: "Enter any special delivery instructions...",
              onChanged: (value) {
                specialInstructions = value;
                setState(() {});
              },
            ),

            // Summary Section
            if (selectedShipmentType.isNotEmpty) ...[
              Text(
                "Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Shipment Configuration",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: successColor.withAlpha(100)),
                    _buildSummaryRow("Type", _getSelectedTypeTitle()),
                    if (selectedPriority.isNotEmpty)
                      _buildSummaryRow("Priority", _getPriorityLabel(selectedPriority)),
                    if (selectedHandling.isNotEmpty)
                      _buildSummaryRow("Handling", _getHandlingLabel(selectedHandling)),
                    if (selectedInsurance.isNotEmpty)
                      _buildSummaryRow("Insurance", _getInsuranceLabel(selectedInsurance)),
                    if (isFragile || isHazardous || isPerishable || requiresSignature)
                      _buildSummaryRow("Properties", _getPropertiesText()),
                    Divider(color: successColor.withAlpha(100)),
                    Row(
                      children: [
                        Text(
                          "Estimated Cost:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${_calculateTotalCost().toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset",
                    size: bs.md,
                    onPressed: () {
                      selectedShipmentType = "";
                      selectedPriority = "";
                      selectedHandling = "";
                      selectedInsurance = "";
                      requiresSignature = false;
                      isFragile = false;
                      isHazardous = false;
                      isPerishable = false;
                      specialInstructions = "";
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Continue",
                    size: bs.md,
                    onPressed: selectedShipmentType.isNotEmpty ? () {
                      // Continue to next step
                      ss("Shipment type configured successfully");
                    } : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  String _getSelectedTypeTitle() {
    final selectedType = shipmentTypes.firstWhere(
      (type) => type["id"] == selectedShipmentType,
      orElse: () => {"title": ""},
    );
    return "${selectedType["title"]}";
  }

  String _getPriorityLabel(String value) {
    final priority = priorityLevels.firstWhere(
      (p) => p["value"] == value,
      orElse: () => {"label": ""},
    );
    return "${priority["label"]}";
  }

  String _getHandlingLabel(String value) {
    final handling = handlingOptions.firstWhere(
      (h) => h["value"] == value,
      orElse: () => {"label": ""},
    );
    return "${handling["label"]}";
  }

  String _getInsuranceLabel(String value) {
    final insurance = insuranceOptions.firstWhere(
      (i) => i["value"] == value,
      orElse: () => {"label": ""},
    );
    return "${insurance["label"]}";
  }

  String _getPropertiesText() {
    List<String> properties = [];
    if (isFragile) properties.add("Fragile");
    if (isHazardous) properties.add("Hazardous");
    if (isPerishable) properties.add("Perishable");
    if (requiresSignature) properties.add("Signature Required");
    return properties.join(", ");
  }

  double _calculateTotalCost() {
    double baseCost = 0.0;
    
    if (selectedShipmentType.isNotEmpty) {
      final selectedType = shipmentTypes.firstWhere(
        (type) => type["id"] == selectedShipmentType,
        orElse: () => {"price": 0.0},
      );
      baseCost = (selectedType["price"] as double);
    }

    // Add priority surcharge
    if (selectedPriority == "high") baseCost += 5.0;
    if (selectedPriority == "urgent") baseCost += 10.0;
    if (selectedPriority == "critical") baseCost += 20.0;

    // Add handling surcharge
    if (selectedHandling == "fragile") baseCost += 3.0;
    if (selectedHandling == "hazardous") baseCost += 15.0;
    if (selectedHandling == "temperature") baseCost += 8.0;

    // Add insurance cost
    if (selectedInsurance == "basic") baseCost += 2.0;
    if (selectedInsurance == "enhanced") baseCost += 5.0;
    if (selectedInsurance == "premium") baseCost += 10.0;

    // Add property surcharges
    if (isFragile) baseCost += 2.0;
    if (isHazardous) baseCost += 12.0;
    if (isPerishable) baseCost += 6.0;
    if (requiresSignature) baseCost += 3.0;

    return baseCost;
  }
}
