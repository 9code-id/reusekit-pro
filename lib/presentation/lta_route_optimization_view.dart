import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaRouteOptimizationView extends StatefulWidget {
  const LtaRouteOptimizationView({super.key});

  @override
  State<LtaRouteOptimizationView> createState() => _LtaRouteOptimizationViewState();
}

class _LtaRouteOptimizationViewState extends State<LtaRouteOptimizationView> {
  bool isOptimizing = false;
  String optimizationProgress = "";
  String selectedCriteria = "Time";
  
  List<Map<String, dynamic>> optimizationCriteria = [
    {"label": "Minimize Time", "value": "Time"},
    {"label": "Minimize Distance", "value": "Distance"},
    {"label": "Minimize Fuel Cost", "value": "Fuel"},
    {"label": "Minimize Tolls", "value": "Tolls"},
    {"label": "Balance All Factors", "value": "Balanced"},
  ];

  List<Map<String, dynamic>> deliveryStops = [
    {
      "id": 1,
      "name": "Downtown Office",
      "address": "123 Business St, Downtown",
      "priority": "High",
      "timeWindow": "9:00 AM - 11:00 AM",
      "serviceTime": "15 min",
      "packages": 3,
      "completed": false,
      "lat": 40.7128,
      "lng": -74.0060,
    },
    {
      "id": 2,
      "name": "Residential Area",
      "address": "456 Oak Ave, Suburbs",
      "priority": "Medium",
      "timeWindow": "1:00 PM - 3:00 PM",
      "serviceTime": "10 min",
      "packages": 1,
      "completed": false,
      "lat": 40.7589,
      "lng": -73.9851,
    },
    {
      "id": 3,
      "name": "Shopping Mall",
      "address": "789 Mall Rd, Shopping District",
      "priority": "Low",
      "timeWindow": "3:00 PM - 6:00 PM",
      "serviceTime": "20 min",
      "packages": 5,
      "completed": false,
      "lat": 40.7282,
      "lng": -73.7949,
    },
    {
      "id": 4,
      "name": "Industrial Zone",
      "address": "321 Factory Blvd, Industrial",
      "priority": "High",
      "timeWindow": "10:00 AM - 12:00 PM",
      "serviceTime": "25 min",
      "packages": 8,
      "completed": false,
      "lat": 40.6892,
      "lng": -74.0445,
    },
  ];

  Map<String, dynamic> originalRoute = {
    "totalDistance": 45.8,
    "totalTime": "2h 15m",
    "fuelCost": 25.60,
    "tollCost": 12.00,
    "totalCost": 37.60,
    "stops": [1, 2, 3, 4],
  };

  Map<String, dynamic> optimizedRoute = {
    "totalDistance": 38.2,
    "totalTime": "1h 52m",
    "fuelCost": 21.40,
    "tollCost": 8.00,
    "totalCost": 29.40,
    "stops": [1, 4, 3, 2],
    "savings": {
      "distance": 7.6,
      "time": "23 min",
      "cost": 8.20,
    },
  };

  List<Map<String, dynamic>> optimizationHistory = [
    {
      "id": 1,
      "date": "2024-01-15",
      "criteria": "Time",
      "originalDistance": 45.8,
      "optimizedDistance": 38.2,
      "timeSaved": "23 min",
      "costSaved": 8.20,
    },
    {
      "id": 2,
      "date": "2024-01-12", 
      "criteria": "Fuel",
      "originalDistance": 52.3,
      "optimizedDistance": 47.1,
      "timeSaved": "18 min",
      "costSaved": 6.50,
    },
  ];

  void startOptimization() {
    isOptimizing = true;
    optimizationProgress = "Analyzing stops...";
    setState(() {});

    // Simulate optimization steps
    Future.delayed(Duration(seconds: 1), () {
      optimizationProgress = "Calculating distances...";
      setState(() {});
    });

    Future.delayed(Duration(seconds: 2), () {
      optimizationProgress = "Finding optimal sequence...";
      setState(() {});
    });

    Future.delayed(Duration(seconds: 3), () {
      optimizationProgress = "Validating time windows...";
      setState(() {});
    });

    Future.delayed(Duration(seconds: 4), () {
      optimizationProgress = "Optimization complete!";
      isOptimizing = false;
      setState(() {});
    });
  }

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Optimization"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // View optimization history
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Optimization settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Optimization Criteria
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
                  Text(
                    "Optimization Criteria",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Optimize for",
                    items: optimizationCriteria,
                    value: selectedCriteria,
                    onChanged: (value, label) {
                      selectedCriteria = value;
                      setState(() {});
                    },
                  ),
                  if (!isOptimizing) ...[
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start Optimization",
                        size: bs.md,
                        onPressed: startOptimization,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Optimization Progress
            if (isOptimizing) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            optimizationProgress,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      backgroundColor: infoColor.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                    ),
                  ],
                ),
              ),
            ],

            // Route Comparison
            if (!isOptimizing && optimizationProgress == "Optimization complete!") ...[
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
                    Text(
                      "Route Comparison",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Original Route",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text("Distance: ${originalRoute["totalDistance"]} km"),
                                    Text("Time: ${originalRoute["totalTime"]}"),
                                    Text("Cost: \$${(originalRoute["totalCost"] as double).toStringAsFixed(2)}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Optimized Route",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: successColor.withAlpha(50)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text("Distance: ${optimizedRoute["totalDistance"]} km"),
                                    Text("Time: ${optimizedRoute["totalTime"]}"),
                                    Text("Cost: \$${(optimizedRoute["totalCost"] as double).toStringAsFixed(2)}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    // Savings Summary
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.savings,
                                color: successColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Optimization Savings",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Distance: -${(optimizedRoute["savings"] as Map)["distance"]} km",
                                  style: TextStyle(fontSize: 12, color: successColor),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Time: -${(optimizedRoute["savings"] as Map)["time"]}",
                                  style: TextStyle(fontSize: 12, color: successColor),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Cost Savings: \$${((optimizedRoute["savings"] as Map)["cost"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Delivery Stops
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
                  Text(
                    optimizationProgress == "Optimization complete!" 
                        ? "Optimized Stop Sequence" 
                        : "Current Stop Sequence",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...deliveryStops.map((stop) {
                    int order = optimizationProgress == "Optimization complete!" 
                        ? (optimizedRoute["stops"] as List).indexOf(stop["id"]) + 1
                        : (originalRoute["stops"] as List).indexOf(stop["id"]) + 1;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "$order",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${stop["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getPriorityColor("${stop["priority"]}"),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${stop["priority"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${stop["address"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${stop["timeWindow"]} • ${stop["serviceTime"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.inventory_2,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${stop["packages"]} packages",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Edit stop details
                            },
                            child: Icon(
                              Icons.edit,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Optimization History
            if (optimizationHistory.isNotEmpty) ...[
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
                    Text(
                      "Recent Optimizations",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...optimizationHistory.take(3).map((history) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.trending_down,
                                color: successColor,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${history["date"]} • ${history["criteria"]} optimization",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Saved ${history["timeSaved"]} • \$${(history["costSaved"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],

            // Action Buttons
            if (!isOptimizing) ...[
              Row(
                children: [
                  if (optimizationProgress == "Optimization complete!") ...[
                    Expanded(
                      child: QButton(
                        label: "Use Original",
                        size: bs.md,
                        onPressed: () {
                          //navigateTo('LtaDeliveryRoutesView')
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Use Optimized",
                        size: bs.md,
                        onPressed: () {
                          //navigateTo('LtaDeliveryRoutesView')
                        },
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: QButton(
                        label: "Add Stop",
                        size: bs.md,
                        onPressed: () {
                          // Add new delivery stop
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "View Routes",
                        size: bs.md,
                        onPressed: () {
                          //navigateTo('LtaDeliveryRoutesView')
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
