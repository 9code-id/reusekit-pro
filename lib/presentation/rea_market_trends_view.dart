import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaMarketTrendsView extends StatefulWidget {
  const ReaMarketTrendsView({super.key});

  @override
  State<ReaMarketTrendsView> createState() => _ReaMarketTrendsViewState();
}

class _ReaMarketTrendsViewState extends State<ReaMarketTrendsView> {
  String selectedTimeframe = "6_months";
  String selectedPropertyType = "all";
  String selectedLocation = "all";
  bool loading = false;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "3 Months", "value": "3_months"},
    {"label": "6 Months", "value": "6_months"},
    {"label": "1 Year", "value": "1_year"},
    {"label": "2 Years", "value": "2_years"},
  ];

  List<Map<String, dynamic>> propertyTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "House", "value": "house"},
    {"label": "Apartment", "value": "apartment"},
    {"label": "Condo", "value": "condo"},
    {"label": "Townhouse", "value": "townhouse"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "all"},
    {"label": "Downtown", "value": "downtown"},
    {"label": "Suburban", "value": "suburban"},
    {"label": "Waterfront", "value": "waterfront"},
    {"label": "Historic District", "value": "historic"},
  ];

  List<Map<String, dynamic>> marketData = [
    {
      "title": "Average Price",
      "value": "\$485,000",
      "change": "+3.2%",
      "isPositive": true,
      "icon": Icons.home,
    },
    {
      "title": "Price per Sq Ft",
      "value": "\$245",
      "change": "+1.8%",
      "isPositive": true,
      "icon": Icons.straighten,
    },
    {
      "title": "Days on Market",
      "value": "28 days",
      "change": "-5.4%",
      "isPositive": true,
      "icon": Icons.access_time,
    },
    {
      "title": "New Listings",
      "value": "342",
      "change": "+8.1%",
      "isPositive": true,
      "icon": Icons.add_home,
    },
  ];

  List<Map<String, dynamic>> priceHistory = [
    {"month": "Jan", "value": 465000},
    {"month": "Feb", "value": 468000},
    {"month": "Mar", "value": 472000},
    {"month": "Apr", "value": 478000},
    {"month": "May", "value": 482000},
    {"month": "Jun", "value": 485000},
  ];

  List<Map<String, dynamic>> topAreas = [
    {
      "name": "Downtown Core",
      "averagePrice": 525000,
      "change": "+4.2%",
      "listings": 45,
      "soldLastMonth": 38,
    },
    {
      "name": "Riverside District",
      "averagePrice": 485000,
      "change": "+3.8%",
      "listings": 32,
      "soldLastMonth": 28,
    },
    {
      "name": "Green Valley",
      "averagePrice": 445000,
      "change": "+2.1%",
      "listings": 58,
      "soldLastMonth": 42,
    },
    {
      "name": "Oak Hill",
      "averagePrice": 395000,
      "change": "+1.5%",
      "listings": 26,
      "soldLastMonth": 19,
    },
  ];

  List<Map<String, dynamic>> insights = [
    {
      "title": "Market Heating Up",
      "description": "Properties are selling 15% faster than last quarter",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Inventory Shortage",
      "description": "New listings down 8% compared to same period last year",
      "icon": Icons.inventory,
      "color": warningColor,
    },
    {
      "title": "Price Growth Steady",
      "description": "Consistent 3-4% annual appreciation across all property types",
      "icon": Icons.show_chart,
      "color": infoColor,
    },
  ];

  void _refreshData() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    ss("Market data updated successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Market Trends"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async => _refreshData(),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Filters Section
                    Container(
                      padding: EdgeInsets.all(spMd),
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
                            "Filter Trends",
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
                                  label: "Timeframe",
                                  items: timeframeOptions,
                                  value: selectedTimeframe,
                                  onChanged: (value, label) {
                                    selectedTimeframe = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QDropdownField(
                                  label: "Property Type",
                                  items: propertyTypeOptions,
                                  value: selectedPropertyType,
                                  onChanged: (value, label) {
                                    selectedPropertyType = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          QDropdownField(
                            label: "Location",
                            items: locationOptions,
                            value: selectedLocation,
                            onChanged: (value, label) {
                              selectedLocation = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Market Overview Cards
                    Text(
                      "Market Overview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 150,
                      children: marketData.map((data) {
                        return Container(
                          padding: EdgeInsets.all(spMd),
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
                                  Icon(
                                    data["icon"],
                                    color: primaryColor,
                                    size: 24,
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (data["isPositive"] as bool)
                                          ? successColor.withAlpha(20)
                                          : dangerColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${data["change"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: (data["isPositive"] as bool)
                                            ? successColor
                                            : dangerColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${data["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${data["value"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

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
                        spacing: spSm,
                        children: [
                          Text(
                            "Price History",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            height: 200,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: priceHistory.map((data) {
                                      double maxValue = priceHistory
                                          .map((e) => e["value"] as int)
                                          .reduce((a, b) => a > b ? a : b)
                                          .toDouble();
                                      double height = ((data["value"] as int) / maxValue) * 150;
                                      
                                      return Expanded(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 4),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: height,
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(radiusXs),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: spXs),
                                              Text(
                                                "${data["month"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
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

                    // Top Areas
                    Text(
                      "Top Performing Areas",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...topAreas.map((area) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        margin: EdgeInsets.only(bottom: spSm),
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
                                Expanded(
                                  child: Text(
                                    "${area["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${area["change"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\$${((area["averagePrice"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Active: ${area["listings"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Sold: ${area["soldLastMonth"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    // Market Insights
                    Text(
                      "Market Insights",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...insights.map((insight) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: insight["color"],
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (insight["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                insight["icon"],
                                color: insight["color"],
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
                                    "${insight["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${insight["description"]}",
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
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
    );
  }
}
