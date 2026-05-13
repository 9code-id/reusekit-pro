import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaFuelSurchargeView extends StatefulWidget {
  const LtaFuelSurchargeView({super.key});

  @override
  State<LtaFuelSurchargeView> createState() => _LtaFuelSurchargeViewState();
}

class _LtaFuelSurchargeViewState extends State<LtaFuelSurchargeView> {
  bool loading = true;
  String selectedFuelType = "Diesel";
  String selectedRegion = "National";
  
  List<Map<String, dynamic>> fuelTypeOptions = [
    {"label": "Diesel", "value": "Diesel"},
    {"label": "Gasoline", "value": "Gasoline"},
    {"label": "Natural Gas", "value": "Natural Gas"},
    {"label": "Electric", "value": "Electric"},
  ];

  List<Map<String, dynamic>> regionOptions = [
    {"label": "National", "value": "National"},
    {"label": "North Region", "value": "North"},
    {"label": "South Region", "value": "South"},
    {"label": "East Region", "value": "East"},
    {"label": "West Region", "value": "West"},
    {"label": "Central Region", "value": "Central"},
  ];

  Map<String, dynamic> currentFuelPrices = {
    "diesel": {
      "current_price": 3.85,
      "last_week": 3.82,
      "change": 0.03,
      "change_percent": 0.79,
      "last_updated": "2024-01-15T08:30:00Z"
    },
    "gasoline": {
      "current_price": 3.65,
      "last_week": 3.68,
      "change": -0.03,
      "change_percent": -0.82,
      "last_updated": "2024-01-15T08:30:00Z"
    },
    "natural_gas": {
      "current_price": 2.95,
      "last_week": 2.93,
      "change": 0.02,
      "change_percent": 0.68,
      "last_updated": "2024-01-15T08:30:00Z"
    }
  };

  List<Map<String, dynamic>> surchargeRules = [
    {
      "id": "rule_001",
      "fuel_type": "Diesel",
      "base_price": 3.50,
      "current_price": 3.85,
      "threshold": 3.60,
      "surcharge_rate": 0.15,
      "current_surcharge": 3.75,
      "applicable_services": ["Standard", "Express", "Same Day"],
      "effective_date": "2024-01-01",
      "status": "Active"
    },
    {
      "id": "rule_002",
      "fuel_type": "Gasoline",
      "base_price": 3.40,
      "current_price": 3.65,
      "threshold": 3.55,
      "surcharge_rate": 0.12,
      "current_surcharge": 1.20,
      "applicable_services": ["Light Vehicle", "Courier"],
      "effective_date": "2024-01-01",
      "status": "Active"
    },
    {
      "id": "rule_003",
      "fuel_type": "Natural Gas",
      "base_price": 2.80,
      "current_price": 2.95,
      "threshold": 2.90,
      "surcharge_rate": 0.10,
      "current_surcharge": 0.50,
      "applicable_services": ["Eco Fleet"],
      "effective_date": "2024-01-01",
      "status": "Active"
    }
  ];

  List<Map<String, dynamic>> priceHistory = [
    {"date": "2024-01-15", "price": 3.85, "surcharge": 3.75},
    {"date": "2024-01-14", "price": 3.83, "surcharge": 3.45},
    {"date": "2024-01-13", "price": 3.82, "surcharge": 3.20},
    {"date": "2024-01-12", "price": 3.80, "surcharge": 3.00},
    {"date": "2024-01-11", "price": 3.78, "surcharge": 2.80},
    {"date": "2024-01-10", "price": 3.76, "surcharge": 2.60},
    {"date": "2024-01-09", "price": 3.75, "surcharge": 2.50}
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    setState(() {});
  }

  void _showEditSurchargeDialog(Map<String, dynamic> rule) {
    String fuelType = "${rule["fuel_type"]}";
    double basePrice = (rule["base_price"] as num).toDouble();
    double threshold = (rule["threshold"] as num).toDouble();
    double surchargeRate = (rule["surcharge_rate"] as num).toDouble();
    String effectiveDate = "${rule["effective_date"]}";
    String status = "${rule["status"]}";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Fuel Surcharge Rule"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Fuel Type",
                value: fuelType,
                onChanged: (value) => fuelType = value,
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Base Price (\$)",
                value: basePrice.toString(),
                onChanged: (value) => basePrice = double.tryParse(value) ?? 0.0,
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Threshold Price (\$)",
                value: threshold.toString(),
                onChanged: (value) => threshold = double.tryParse(value) ?? 0.0,
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Surcharge Rate (%)",
                value: (surchargeRate * 100).toString(),
                onChanged: (value) => surchargeRate = (double.tryParse(value) ?? 0.0) / 100,
              ),
              SizedBox(height: spSm),
              QDatePicker(
                label: "Effective Date",
                value: DateTime.parse(effectiveDate),
                onChanged: (value) => effectiveDate = value.toString().split(' ')[0],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Status",
                items: [
                  {"label": "Active", "value": "Active"},
                  {"label": "Inactive", "value": "Inactive"},
                ],
                value: status,
                onChanged: (value, label) => status = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save Changes",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Fuel surcharge rule updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showAddSurchargeDialog() {
    String fuelType = "";
    double basePrice = 0.0;
    double threshold = 0.0;
    double surchargeRate = 0.0;
    String effectiveDate = DateTime.now().toString().split(' ')[0];
    String status = "Active";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Fuel Surcharge Rule"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Fuel Type",
                value: fuelType,
                onChanged: (value) => fuelType = value,
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Base Price (\$)",
                value: basePrice.toString(),
                onChanged: (value) => basePrice = double.tryParse(value) ?? 0.0,
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Threshold Price (\$)",
                value: threshold.toString(),
                onChanged: (value) => threshold = double.tryParse(value) ?? 0.0,
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Surcharge Rate (%)",
                value: (surchargeRate * 100).toString(),
                onChanged: (value) => surchargeRate = (double.tryParse(value) ?? 0.0) / 100,
              ),
              SizedBox(height: spSm),
              QDatePicker(
                label: "Effective Date",
                value: DateTime.parse(effectiveDate),
                onChanged: (value) => effectiveDate = value.toString().split(' ')[0],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Status",
                items: [
                  {"label": "Active", "value": "Active"},
                  {"label": "Inactive", "value": "Inactive"},
                ],
                value: status,
                onChanged: (value, label) => status = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Rule",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("New fuel surcharge rule added successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFuelPriceCard(String fuelType, Map<String, dynamic> priceData) {
    bool isPriceUp = (priceData["change"] as num) > 0;
    Color changeColor = isPriceUp ? dangerColor : successColor;
    IconData changeIcon = isPriceUp ? Icons.trending_up : Icons.trending_down;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.local_gas_station,
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
                      fuelType.toUpperCase(),
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Current Price",
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
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${(priceData["current_price"] as num).toStringAsFixed(3)}/gal",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: changeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      changeIcon,
                      color: changeColor,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${isPriceUp ? '+' : ''}${(priceData["change_percent"] as num).toStringAsFixed(2)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: changeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Last week: \$${(priceData["last_week"] as num).toStringAsFixed(3)}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurchargeRuleCard(Map<String, dynamic> rule) {
    bool isActive = rule["status"] == "Active";
    bool isSurchargeApplied = (rule["current_price"] as num) > (rule["threshold"] as num);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isActive ? (isSurchargeApplied ? warningColor : successColor) : disabledColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${rule["fuel_type"]} Surcharge Rule",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Rule ID: ${rule["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${rule["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isActive ? successColor : disabledColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showEditSurchargeDialog(rule),
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
                      "Base Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(rule["base_price"] as num).toStringAsFixed(3)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                      "Current Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(rule["current_price"] as num).toStringAsFixed(3)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                      "Threshold",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(rule["threshold"] as num).toStringAsFixed(3)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
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
                  children: [
                    Text(
                      "Surcharge Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${((rule["surcharge_rate"] as num) * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                      "Current Surcharge",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(rule["current_surcharge"] as num).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isSurchargeApplied ? dangerColor : successColor,
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
                      "Effective Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${rule["effective_date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (rule["applicable_services"] != null) ...[
            SizedBox(height: spSm),
            Text(
              "Applicable Services:",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (rule["applicable_services"] as List).map((service) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$service",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel Surcharge Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _showAddSurchargeDialog,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Fuel Type",
                    items: fuelTypeOptions,
                    value: selectedFuelType,
                    onChanged: (value, label) {
                      selectedFuelType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Region",
                    items: regionOptions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Current Fuel Prices
            Text(
              "Current Fuel Prices",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: currentFuelPrices.entries.map((entry) {
                return _buildFuelPriceCard(entry.key, entry.value);
              }).toList(),
            ),
            SizedBox(height: spMd),

            // Surcharge Rules
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Fuel Surcharge Rules",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Add Rule",
                  size: bs.sm,
                  onPressed: _showAddSurchargeDialog,
                ),
              ],
            ),
            SizedBox(height: spSm),
            Column(
              children: surchargeRules.map((rule) {
                return _buildSurchargeRuleCard(rule);
              }).toList(),
            ),
            SizedBox(height: spMd),

            // Price History Chart
            Container(
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
                    "7-Day Price History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    height: 200,
                    child: Column(
                      children: priceHistory.map((data) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${data["date"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${(data["price"] as num).toStringAsFixed(3)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Surcharge: \$${(data["surcharge"] as num).toStringAsFixed(2)}",
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
