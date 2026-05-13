import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaCostCalculationView extends StatefulWidget {
  const DlaCostCalculationView({super.key});

  @override
  State<DlaCostCalculationView> createState() => _DlaCostCalculationViewState();
}

class _DlaCostCalculationViewState extends State<DlaCostCalculationView> {
  String serviceType = "standard";
  String deliveryZone = "zone_1";
  String packageType = "regular";
  String vehicleType = "motorcycle";
  double distance = 0.0;
  double weight = 0.0;
  double volume = 0.0;
  bool isExpress = false;
  bool requiresInsurance = false;
  bool requiresSignature = false;
  bool isFragile = false;
  double insuranceValue = 0.0;
  
  final List<Map<String, dynamic>> serviceTypes = [
    {"label": "Standard Delivery", "value": "standard"},
    {"label": "Express Delivery", "value": "express"},
    {"label": "Same Day Delivery", "value": "same_day"},
    {"label": "Next Day Delivery", "value": "next_day"},
    {"label": "Scheduled Delivery", "value": "scheduled"},
  ];

  final List<Map<String, dynamic>> deliveryZones = [
    {"label": "Zone 1 (City Center)", "value": "zone_1"},
    {"label": "Zone 2 (Suburbs)", "value": "zone_2"},
    {"label": "Zone 3 (Extended Area)", "value": "zone_3"},
    {"label": "Zone 4 (Rural)", "value": "zone_4"},
    {"label": "Inter-City", "value": "inter_city"},
  ];

  final List<Map<String, dynamic>> packageTypes = [
    {"label": "Regular Package", "value": "regular"},
    {"label": "Fragile Items", "value": "fragile"},
    {"label": "Documents", "value": "documents"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Food & Beverages", "value": "food"},
  ];

  final List<Map<String, dynamic>> vehicleTypes = [
    {"label": "Motorcycle", "value": "motorcycle"},
    {"label": "Small Van", "value": "small_van"},
    {"label": "Large Van", "value": "large_van"},
    {"label": "Truck", "value": "truck"},
    {"label": "Refrigerated Truck", "value": "refrigerated"},
  ];

  Map<String, double> basePrices = {
    "standard": 5.00,
    "express": 8.50,
    "same_day": 15.00,
    "next_day": 10.00,
    "scheduled": 7.50,
  };

  Map<String, double> zoneMultipliers = {
    "zone_1": 1.0,
    "zone_2": 1.2,
    "zone_3": 1.5,
    "zone_4": 2.0,
    "inter_city": 3.0,
  };

  Map<String, double> vehicleMultipliers = {
    "motorcycle": 1.0,
    "small_van": 1.3,
    "large_van": 1.8,
    "truck": 2.5,
    "refrigerated": 3.0,
  };

  double get basePrice => basePrices[serviceType] ?? 5.00;
  double get zoneMultiplier => zoneMultipliers[deliveryZone] ?? 1.0;
  double get vehicleMultiplier => vehicleMultipliers[vehicleType] ?? 1.0;
  
  double get distanceCost => distance * 0.50;
  double get weightCost => weight > 5.0 ? (weight - 5.0) * 2.00 : 0.0;
  double get volumeCost => volume > 0.1 ? (volume - 0.1) * 10.00 : 0.0;
  double get packageTypeCost => packageType == "fragile" ? 5.00 : packageType == "electronics" ? 3.00 : 0.0;
  double get signatureCost => requiresSignature ? 2.50 : 0.0;
  double get insuranceCost => requiresInsurance ? (insuranceValue * 0.01).clamp(5.0, 50.0) : 0.0;
  
  double get subtotal => (basePrice * zoneMultiplier * vehicleMultiplier) + distanceCost + weightCost + volumeCost + packageTypeCost + signatureCost + insuranceCost;
  double get tax => subtotal * 0.10;
  double get totalCost => subtotal + tax;

  Widget _buildServiceSelection() {
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
            "Service Configuration",
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
                child: QDropdownField(
                  label: "Service Type",
                  items: serviceTypes,
                  value: serviceType,
                  onChanged: (value, label) {
                    serviceType = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Delivery Zone",
                  items: deliveryZones,
                  value: deliveryZone,
                  onChanged: (value, label) {
                    deliveryZone = value;
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
                  label: "Package Type",
                  items: packageTypes,
                  value: packageType,
                  onChanged: (value, label) {
                    packageType = value;
                    setState(() {});
                  },
                ),
              ),
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
                  label: "Distance (km)",
                  value: distance.toString(),
                  onChanged: (value) {
                    distance = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
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
            ],
          ),
          QNumberField(
            label: "Volume (m³)",
            value: volume.toString(),
            onChanged: (value) {
              volume = double.tryParse(value) ?? 0.0;
              setState(() {});
            },
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
              hint: "Value of items to be insured",
              onChanged: (value) {
                insuranceValue = double.tryParse(value) ?? 0.0;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown() {
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
            "Cost Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                _buildCostItem("Base Price", basePrice),
                _buildCostItem("Zone Multiplier (${(zoneMultiplier * 100).toInt()}%)", basePrice * (zoneMultiplier - 1)),
                _buildCostItem("Vehicle Multiplier (${(vehicleMultiplier * 100).toInt()}%)", basePrice * zoneMultiplier * (vehicleMultiplier - 1)),
                if (distanceCost > 0) _buildCostItem("Distance Cost (${distance.toStringAsFixed(1)}km)", distanceCost),
                if (weightCost > 0) _buildCostItem("Weight Cost (${weight.toStringAsFixed(1)}kg)", weightCost),
                if (volumeCost > 0) _buildCostItem("Volume Cost (${volume.toStringAsFixed(2)}m³)", volumeCost),
                if (packageTypeCost > 0) _buildCostItem("Package Type Cost", packageTypeCost),
                if (signatureCost > 0) _buildCostItem("Signature Service", signatureCost),
                if (insuranceCost > 0) _buildCostItem("Insurance (\$${insuranceValue.toStringAsFixed(0)})", insuranceCost),
                Container(
                  height: 1,
                  color: disabledOutlineBorderColor,
                ),
                _buildCostItem("Subtotal", subtotal, isSubtotal: true),
                _buildCostItem("Tax (10%)", tax),
                Container(
                  height: 1,
                  color: disabledOutlineBorderColor,
                ),
                _buildCostItem("Total Cost", totalCost, isTotal: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostItem(String label, double amount, {bool isSubtotal = false, bool isTotal = false}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal || isSubtotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? primaryColor : disabledBoldColor,
          ),
        ),
        Spacer(),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal || isSubtotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? primaryColor : primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickEstimates() {
    List<Map<String, dynamic>> quickEstimates = [
      {"label": "Motorcycle - Zone 1", "service": "standard", "zone": "zone_1", "vehicle": "motorcycle", "distance": 5.0},
      {"label": "Van - Zone 2", "service": "express", "zone": "zone_2", "vehicle": "small_van", "distance": 10.0},
      {"label": "Truck - Inter-City", "service": "next_day", "zone": "inter_city", "vehicle": "truck", "distance": 50.0},
    ];

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
            "Quick Estimates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...quickEstimates.map((estimate) {
            double estimateTotal = _calculateQuickEstimate(estimate);
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${estimate["label"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${estimate["distance"]}km - ${_getServiceLabel(estimate["service"])}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${estimateTotal.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  double _calculateQuickEstimate(Map<String, dynamic> estimate) {
    double basePrice = basePrices[estimate["service"]] ?? 5.00;
    double zoneMultiplier = zoneMultipliers[estimate["zone"]] ?? 1.0;
    double vehicleMultiplier = vehicleMultipliers[estimate["vehicle"]] ?? 1.0;
    double distanceCost = (estimate["distance"] as double) * 0.50;
    double subtotal = (basePrice * zoneMultiplier * vehicleMultiplier) + distanceCost;
    return subtotal * 1.10; // Including 10% tax
  }

  String _getServiceLabel(String service) {
    switch (service) {
      case "standard":
        return "Standard";
      case "express":
        return "Express";
      case "same_day":
        return "Same Day";
      case "next_day":
        return "Next Day";
      case "scheduled":
        return "Scheduled";
      default:
        return service;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Calculator"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () {
              ss("Cost calculation saved");
            },
          ),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              si("Share cost estimate");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildServiceSelection(),
            _buildPackageDetails(),
            _buildAdditionalServices(),
            _buildCostBreakdown(),
            _buildQuickEstimates(),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset Calculator",
                    color: disabledBoldColor,
                    size: bs.md,
                    onPressed: () {
                      serviceType = "standard";
                      deliveryZone = "zone_1";
                      packageType = "regular";
                      vehicleType = "motorcycle";
                      distance = 0.0;
                      weight = 0.0;
                      volume = 0.0;
                      requiresSignature = false;
                      requiresInsurance = false;
                      insuranceValue = 0.0;
                      setState(() {});
                      si("Calculator reset");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Create Quote",
                    size: bs.md,
                    onPressed: () {
                      ss("Quote created for \$${totalCost.toStringAsFixed(2)}");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
