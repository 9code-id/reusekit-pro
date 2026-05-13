import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaVehicleValueView extends StatefulWidget {
  const CmaVehicleValueView({super.key});

  @override
  State<CmaVehicleValueView> createState() => _CmaVehicleValueViewState();
}

class _CmaVehicleValueViewState extends State<CmaVehicleValueView> {
  int currentTab = 0;
  
  // Vehicle Information
  String vehicleMake = "";
  String vehicleModel = "";
  String vehicleYear = "";
  String vehicleTrim = "";
  String vehicleMileage = "";
  String vehicleCondition = "";
  String vehicleColor = "";
  String vehicleVin = "";

  // Value Results
  Map<String, dynamic>? valueResults;
  bool isLoading = false;

  List<Map<String, dynamic>> makes = [
    {"label": "Acura", "value": "Acura"},
    {"label": "Audi", "value": "Audi"},
    {"label": "BMW", "value": "BMW"},
    {"label": "Chevrolet", "value": "Chevrolet"},
    {"label": "Ford", "value": "Ford"},
    {"label": "Honda", "value": "Honda"},
    {"label": "Hyundai", "value": "Hyundai"},
    {"label": "Lexus", "value": "Lexus"},
    {"label": "Mercedes-Benz", "value": "Mercedes-Benz"},
    {"label": "Nissan", "value": "Nissan"},
    {"label": "Toyota", "value": "Toyota"},
    {"label": "Volkswagen", "value": "Volkswagen"},
  ];

  List<Map<String, dynamic>> conditions = [
    {"label": "Excellent", "value": "excellent"},
    {"label": "Very Good", "value": "very_good"},
    {"label": "Good", "value": "good"},
    {"label": "Fair", "value": "fair"},
    {"label": "Poor", "value": "poor"},
  ];

  List<Map<String, dynamic>> years = List.generate(25, (index) {
    int year = DateTime.now().year - index;
    return {"label": year.toString(), "value": year.toString()};
  });

  List<Map<String, dynamic>> savedVehicles = [
    {
      "id": "1",
      "make": "Honda",
      "model": "Civic",
      "year": "2020",
      "trim": "LX",
      "mileage": "45000",
      "condition": "Good",
      "currentValue": 18500.00,
      "lastUpdated": "2024-12-15",
      "purchasePrice": 22000.00,
      "image": "https://picsum.photos/300/200?random=1&keyword=civic",
    },
    {
      "id": "2",
      "make": "Toyota",
      "model": "Camry",
      "year": "2019",
      "trim": "LE",
      "mileage": "62000",
      "condition": "Very Good",
      "currentValue": 21200.00,
      "lastUpdated": "2024-12-10",
      "purchasePrice": 25500.00,
      "image": "https://picsum.photos/300/200?random=2&keyword=camry",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Vehicle Value",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Value Check", icon: Icon(Icons.assessment)),
        Tab(text: "My Vehicles", icon: Icon(Icons.directions_car)),
        Tab(text: "Market Trends", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildValueCheckTab(),
        _buildMyVehiclesTab(),
        _buildMarketTrendsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildValueCheckTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.assessment, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Get Your Vehicle's Value",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Enter your vehicle information to get current market value, trade-in value, and private party value estimates.",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Vehicle Information Form
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vehicle Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Year",
                        items: years,
                        value: vehicleYear,
                        onChanged: (value, label) {
                          vehicleYear = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Make",
                        items: makes,
                        value: vehicleMake,
                        onChanged: (value, label) {
                          vehicleMake = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Model",
                  value: vehicleModel,
                  hint: "e.g., Civic, Camry, F-150",
                  onChanged: (value) {
                    vehicleModel = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Trim Level",
                  value: vehicleTrim,
                  hint: "e.g., LX, EX, Limited (optional)",
                  onChanged: (value) {
                    vehicleTrim = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Mileage",
                        value: vehicleMileage,
                        hint: "Current mileage",
                        onChanged: (value) {
                          vehicleMileage = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Condition",
                        items: conditions,
                        value: vehicleCondition,
                        onChanged: (value, label) {
                          vehicleCondition = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Color",
                  value: vehicleColor,
                  hint: "Vehicle color (optional)",
                  onChanged: (value) {
                    vehicleColor = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "VIN",
                  value: vehicleVin,
                  hint: "Vehicle Identification Number (optional)",
                  onChanged: (value) {
                    vehicleVin = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Get Value Button
          QButton(
            label: isLoading ? "Calculating..." : "Get Vehicle Value",
            size: bs.md,
            onPressed: _canGetValue() && !isLoading ? _getVehicleValue : null,
          ),

          // Value Results
          if (valueResults != null) _buildValueResults(),
        ],
      ),
    );
  }

  Widget _buildValueResults() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Value Estimate Results",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Vehicle Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${valueResults!["year"]} ${valueResults!["make"]} ${valueResults!["model"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (valueResults!["trim"] != null && (valueResults!["trim"] as String).isNotEmpty)
                  Text("Trim: ${valueResults!["trim"]}"),
                Text("Mileage: ${valueResults!["mileage"]} miles"),
                Text("Condition: ${valueResults!["condition"]}"),
              ],
            ),
          ),

          // Value Estimates
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Trade-In Value",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "\$${(valueResults!["tradeInValue"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Private Party",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${(valueResults!["privatePartyValue"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: warningColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Dealer Retail",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "\$${(valueResults!["dealerRetailValue"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Market Average",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "\$${(valueResults!["marketAverage"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Additional Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Confidence Level:", style: TextStyle(fontSize: 12)),
                    Text("${valueResults!["confidenceLevel"]}%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Last Updated:", style: TextStyle(fontSize: 12)),
                    Text("${valueResults!["lastUpdated"]}", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Market Trend:", style: TextStyle(fontSize: 12)),
                    Row(
                      children: [
                        Icon(
                          valueResults!["trend"] == "up" ? Icons.trending_up : 
                          valueResults!["trend"] == "down" ? Icons.trending_down : Icons.trending_flat,
                          size: 16,
                          color: valueResults!["trend"] == "up" ? successColor :
                                 valueResults!["trend"] == "down" ? dangerColor : disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${valueResults!["trendPercentage"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: valueResults!["trend"] == "up" ? successColor :
                                   valueResults!["trend"] == "down" ? dangerColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save Vehicle",
                  size: bs.sm,
                  onPressed: _saveVehicle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Get Report",
                  size: bs.sm,
                  onPressed: _generateReport,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMyVehiclesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Vehicles",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          if (savedVehicles.isEmpty)
            Center(
              child: Column(
                spacing: spMd,
                children: [
                  SizedBox(height: 100),
                  Icon(
                    Icons.directions_car,
                    size: 80,
                    color: disabledBoldColor,
                  ),
                  Text(
                    "No saved vehicles",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Save vehicles to track their value over time",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  QButton(
                    label: "Value Check",
                    size: bs.sm,
                    onPressed: () {
                      currentTab = 0;
                      setState(() {});
                    },
                  ),
                ],
              ),
            )
          else
            ...savedVehicles.map((vehicle) {
              double valueChange = (vehicle["currentValue"] as double) - (vehicle["purchasePrice"] as double);
              double valueChangePercent = (valueChange / (vehicle["purchasePrice"] as double)) * 100;
              bool isPositive = valueChange >= 0;
              
              return Container(
                padding: EdgeInsets.all(spSm),
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${vehicle["image"]}",
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${vehicle["year"]} ${vehicle["make"]} ${vehicle["model"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              if ((vehicle["trim"] as String).isNotEmpty)
                                Text(
                                  "${vehicle["trim"]} • ${vehicle["mileage"]} miles",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              Text(
                                "Condition: ${vehicle["condition"]}",
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

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(vehicle["currentValue"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Value Change",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isPositive ? Icons.trending_up : Icons.trending_down,
                                    size: 16,
                                    color: isPositive ? successColor : dangerColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${isPositive ? '+' : ''}\$${valueChange.abs().toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isPositive ? successColor : dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${isPositive ? '+' : ''}${valueChangePercent.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isPositive ? successColor : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Purchase Price",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(vehicle["purchasePrice"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          "Last updated: ${vehicle["lastUpdated"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Update Value",
                          size: bs.sm,
                          onPressed: () => _updateVehicleValue(vehicle),
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () => _showVehicleOptions(vehicle),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildMarketTrendsTab() {
    List<Map<String, dynamic>> trends = [
      {
        "category": "Compact Cars",
        "trend": "up",
        "percentage": 3.2,
        "description": "Increased demand for fuel-efficient vehicles",
        "popularModels": ["Honda Civic", "Toyota Corolla", "Nissan Sentra"],
      },
      {
        "category": "SUVs",
        "trend": "up",
        "percentage": 5.8,
        "description": "Continued strong demand for family vehicles",
        "popularModels": ["Toyota RAV4", "Honda CR-V", "Ford Explorer"],
      },
      {
        "category": "Luxury Vehicles",
        "trend": "down",
        "percentage": -2.1,
        "description": "Market softening for high-end vehicles",
        "popularModels": ["BMW 3 Series", "Mercedes C-Class", "Audi A4"],
      },
      {
        "category": "Electric Vehicles",
        "trend": "up",
        "percentage": 12.5,
        "description": "Strong growth in EV market adoption",
        "popularModels": ["Tesla Model 3", "Nissan Leaf", "Chevrolet Bolt"],
      },
      {
        "category": "Pickup Trucks",
        "trend": "flat",
        "percentage": 0.3,
        "description": "Stable market with seasonal variations",
        "popularModels": ["Ford F-150", "Chevrolet Silverado", "RAM 1500"],
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Text(
            "Current automotive market trends and value changes by category",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          ...trends.map((trend) {
            Color trendColor = trend["trend"] == "up" ? successColor :
                              trend["trend"] == "down" ? dangerColor : disabledBoldColor;
            IconData trendIcon = trend["trend"] == "up" ? Icons.trending_up :
                                trend["trend"] == "down" ? Icons.trending_down : Icons.trending_flat;
            
            return Container(
              padding: EdgeInsets.all(spSm),
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
                      Expanded(
                        child: Text(
                          "${trend["category"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: trendColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(trendIcon, size: 16, color: trendColor),
                            SizedBox(width: spXs),
                            Text(
                              "${trend["percentage"] >= 0 ? '+' : ''}${(trend["percentage"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: trendColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "${trend["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  Text(
                    "Popular Models:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    children: (trend["popularModels"] as List).map((model) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$model",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            );
          }),

          // Market Insights
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: infoColor),
                    SizedBox(width: spSm),
                    Text(
                      "Market Insights",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Electric vehicles showing strongest value retention",
                  style: TextStyle(fontSize: 14, color: infoColor),
                ),
                Text(
                  "• Chip shortage affecting newer vehicle availability",
                  style: TextStyle(fontSize: 14, color: infoColor),
                ),
                Text(
                  "• Used car market stabilizing after 2-year surge",
                  style: TextStyle(fontSize: 14, color: infoColor),
                ),
                Text(
                  "• Fuel efficiency becoming major value factor",
                  style: TextStyle(fontSize: 14, color: infoColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _canGetValue() {
    return vehicleMake.isNotEmpty &&
           vehicleModel.isNotEmpty &&
           vehicleYear.isNotEmpty &&
           vehicleMileage.isNotEmpty &&
           vehicleCondition.isNotEmpty;
  }

  void _getVehicleValue() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 3));

    // Generate mock results
    double baseValue = 20000.0;
    
    // Adjust for year
    int yearDiff = DateTime.now().year - int.parse(vehicleYear);
    baseValue -= yearDiff * 1200;
    
    // Adjust for mileage
    int miles = int.tryParse(vehicleMileage) ?? 50000;
    baseValue -= (miles / 1000) * 80;
    
    // Adjust for condition
    switch (vehicleCondition) {
      case "excellent":
        baseValue *= 1.15;
        break;
      case "very_good":
        baseValue *= 1.05;
        break;
      case "good":
        baseValue *= 1.0;
        break;
      case "fair":
        baseValue *= 0.85;
        break;
      case "poor":
        baseValue *= 0.65;
        break;
    }

    valueResults = {
      "year": vehicleYear,
      "make": vehicleMake,
      "model": vehicleModel,
      "trim": vehicleTrim,
      "mileage": vehicleMileage,
      "condition": vehicleCondition,
      "tradeInValue": baseValue * 0.75,
      "privatePartyValue": baseValue * 0.95,
      "dealerRetailValue": baseValue * 1.15,
      "marketAverage": baseValue,
      "confidenceLevel": 85,
      "lastUpdated": DateTime.now().toString().substring(0, 10),
      "trend": "up",
      "trendPercentage": 2.3,
    };

    setState(() {
      isLoading = false;
    });

    ss("Vehicle value calculated successfully!");
  }

  void _saveVehicle() {
    ss("Vehicle saved to your collection!");
  }

  void _generateReport() {
    si("Generating detailed value report...");
  }

  void _updateVehicleValue(Map<String, dynamic> vehicle) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Vehicle value updated!");
    vehicle["lastUpdated"] = DateTime.now().toString().substring(0, 10);
    setState(() {});
  }

  void _showVehicleOptions(Map<String, dynamic> vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Vehicle Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Vehicle"),
              onTap: () {
                Navigator.pop(context);
                si("Edit vehicle functionality");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Remove Vehicle"),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Remove this vehicle from your collection?");
                if (isConfirmed) {
                  savedVehicles.removeWhere((v) => v["id"] == vehicle["id"]);
                  setState(() {});
                  se("Vehicle removed");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
