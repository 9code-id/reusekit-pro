import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPriceHistoryView extends StatefulWidget {
  const ReaPriceHistoryView({super.key});

  @override
  State<ReaPriceHistoryView> createState() => _ReaPriceHistoryViewState();
}

class _ReaPriceHistoryViewState extends State<ReaPriceHistoryView> {
  String selectedPropertyId = "1";
  String selectedTimeFrame = "1 Year";
  String selectedMetric = "Sale Price";
  
  List<Map<String, dynamic>> properties = [
    {"label": "Prestige Song of the South", "value": "1"},
    {"label": "Brigade Panorama", "value": "2"},
    {"label": "Sobha Royal Pavilion", "value": "3"},
    {"label": "Godrej Reflections", "value": "4"},
  ];
  
  List<Map<String, dynamic>> timeFrames = [
    {"label": "6 Months", "value": "6 Months"},
    {"label": "1 Year", "value": "1 Year"},
    {"label": "2 Years", "value": "2 Years"},
    {"label": "5 Years", "value": "5 Years"},
  ];
  
  List<Map<String, dynamic>> metrics = [
    {"label": "Sale Price", "value": "Sale Price"},
    {"label": "Price per Sq Ft", "value": "Price per Sq Ft"},
    {"label": "Market Value", "value": "Market Value"},
    {"label": "Rental Value", "value": "Rental Value"},
  ];

  Map<String, dynamic> propertyInfo = {
    "id": 1,
    "title": "Prestige Song of the South",
    "location": "Begur Road, Bangalore",
    "type": "3 BHK Apartment",
    "area": 1450,
    "currentPrice": 8500000,
    "originalPrice": 7200000,
    "builder": "Prestige Group",
    "ageOfProperty": "5 Years",
    "appreciation": 18.1
  };

  List<Map<String, dynamic>> priceHistory = [
    {
      "date": "2020-01",
      "salePrice": 7200000,
      "marketValue": 7000000,
      "pricePerSqft": 4966,
      "rentalValue": 35000,
      "event": "Initial Purchase"
    },
    {
      "date": "2020-06",
      "salePrice": 7350000,
      "marketValue": 7100000,
      "pricePerSqft": 5069,
      "rentalValue": 36000,
      "event": null
    },
    {
      "date": "2021-01",
      "salePrice": 7500000,
      "marketValue": 7250000,
      "pricePerSqft": 5172,
      "rentalValue": 37000,
      "event": "Market Recovery"
    },
    {
      "date": "2021-06",
      "salePrice": 7650000,
      "marketValue": 7400000,
      "pricePerSqft": 5276,
      "rentalValue": 38000,
      "event": null
    },
    {
      "date": "2022-01",
      "salePrice": 7800000,
      "marketValue": 7600000,
      "pricePerSqft": 5379,
      "rentalValue": 39000,
      "event": "Infrastructure Development"
    },
    {
      "date": "2022-06",
      "salePrice": 8000000,
      "marketValue": 7800000,
      "pricePerSqft": 5517,
      "rentalValue": 40000,
      "event": null
    },
    {
      "date": "2023-01",
      "salePrice": 8200000,
      "marketValue": 8000000,
      "pricePerSqft": 5655,
      "rentalValue": 41000,
      "event": "Metro Connectivity"
    },
    {
      "date": "2023-06",
      "salePrice": 8350000,
      "marketValue": 8150000,
      "pricePerSqft": 5759,
      "rentalValue": 42000,
      "event": null
    },
    {
      "date": "2024-01",
      "salePrice": 8450000,
      "marketValue": 8300000,
      "pricePerSqft": 5828,
      "rentalValue": 43000,
      "event": "Mall Opening"
    },
    {
      "date": "2024-06",
      "salePrice": 8500000,
      "marketValue": 8350000,
      "pricePerSqft": 5862,
      "rentalValue": 44000,
      "event": null
    },
    {
      "date": "2025-01",
      "salePrice": 8500000,
      "marketValue": 8400000,
      "pricePerSqft": 5862,
      "rentalValue": 45000,
      "event": "Current"
    }
  ];

  List<Map<String, dynamic>> comparableProperties = [
    {
      "title": "Brigade Golden Triangle",
      "location": "Begur Road, Bangalore",
      "currentPrice": 8200000,
      "priceChange": 15.2,
      "area": 1420,
      "type": "3 BHK"
    },
    {
      "title": "Sobha Windfall",
      "location": "Begur Road, Bangalore", 
      "currentPrice": 8750000,
      "priceChange": 19.8,
      "area": 1480,
      "type": "3 BHK"
    },
    {
      "title": "Godrej E-City",
      "location": "Electronic City, Bangalore",
      "currentPrice": 7800000,
      "priceChange": 12.5,
      "area": 1380,
      "type": "3 BHK"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Price History"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.compare),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Overview Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price History Analysis",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Track property value over time",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
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
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "₹${((propertyInfo["currentPrice"] as int).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Current Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
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
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "+${(propertyInfo["appreciation"] as num).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Appreciation",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
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
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "₹${((((propertyInfo["currentPrice"] as int) - (propertyInfo["originalPrice"] as int))).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Total Gain",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Filter Section
            Text(
              "Property & Timeline",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            QDropdownField(
              label: "Select Property",
              items: properties,
              value: selectedPropertyId,
              onChanged: (value, label) {
                selectedPropertyId = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Frame",
                    items: timeFrames,
                    value: selectedTimeFrame,
                    onChanged: (value, label) {
                      selectedTimeFrame = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Metric",
                    items: metrics,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Property Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${propertyInfo["title"]}",
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
                        Icons.location_on,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${propertyInfo["location"]} • ${propertyInfo["type"]} • ${propertyInfo["area"]} sq ft",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "By ${propertyInfo["builder"]} • ${propertyInfo["ageOfProperty"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "₹${((propertyInfo["currentPrice"] as int) / (propertyInfo["area"] as int)).toStringAsFixed(0)}/sq ft",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Price Chart Placeholder
            Text(
              "Price Trend Chart",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price Trend (${selectedMetric})",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Upward Trend",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.show_chart,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Interactive chart will be displayed here",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Price History Timeline
            Text(
              "Historical Data",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: priceHistory.length,
              itemBuilder: (context, index) {
                final record = priceHistory[index];
                final isLatest = index == priceHistory.length - 1;
                final hasEvent = record["event"] != null;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isLatest ? Border.all(color: primaryColor.withAlpha(100), width: 1) : null,
                  ),
                  child: Row(
                    children: [
                      // Timeline indicator
                      Container(
                        width: 40,
                        child: Column(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: isLatest ? primaryColor : hasEvent ? warningColor : disabledBoldColor,
                                borderRadius: BorderRadius.circular(radiusXl),
                              ),
                            ),
                            if (index < priceHistory.length - 1)
                              Container(
                                width: 2,
                                height: 30,
                                color: disabledColor,
                                margin: EdgeInsets.only(top: spXs),
                              ),
                          ],
                        ),
                      ),
                      
                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${record["date"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "₹${((record["salePrice"] as int).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isLatest ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            if (hasEvent) ...[
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${record["event"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ),
                            ],
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "₹${record["pricePerSqft"]}/sq ft",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Market: ₹${((record["marketValue"] as int).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Rent: ₹${record["rentalValue"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            
            SizedBox(height: spLg),
            
            // Comparable Properties
            Text(
              "Comparable Properties",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comparableProperties.length,
              itemBuilder: (context, index) {
                final property = comparableProperties[index];
                final priceChange = property["priceChange"] as num;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${property["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${property["location"]} • ${property["type"]} • ${property["area"]} sq ft",
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
                            "₹${((property["currentPrice"] as int).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "+${priceChange.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
