import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:math' as Math;

class SpaPriceHistoryView extends StatefulWidget {
  const SpaPriceHistoryView({super.key});

  @override
  State<SpaPriceHistoryView> createState() => _SpaPriceHistoryViewState();
}

class _SpaPriceHistoryViewState extends State<SpaPriceHistoryView> {
  String selectedService = "all";
  String selectedPeriod = "6_months";
  String selectedLocation = "all";
  
  List<Map<String, dynamic>> serviceItems = [
    {"label": "All Services", "value": "all"},
    {"label": "Facial Treatments", "value": "facial"},
    {"label": "Massage Therapy", "value": "massage"},
    {"label": "Body Treatments", "value": "body"},
    {"label": "Nail Services", "value": "nails"},
    {"label": "Hair Services", "value": "hair"},
  ];
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 3 Months", "value": "3_months"},
    {"label": "Last 6 Months", "value": "6_months"},
    {"label": "Last Year", "value": "1_year"},
    {"label": "Last 2 Years", "value": "2_years"},
  ];
  
  List<Map<String, dynamic>> locationItems = [
    {"label": "All Locations", "value": "all"},
    {"label": "Downtown Spa", "value": "downtown"},
    {"label": "Uptown Wellness", "value": "uptown"},
    {"label": "Seaside Retreat", "value": "seaside"},
    {"label": "Mountain View Spa", "value": "mountain"},
  ];
  
  List<Map<String, dynamic>> priceHistoryData = [
    {
      "service": "Deep Cleansing Facial",
      "category": "facial",
      "location": "downtown",
      "currentPrice": 85.0,
      "previousPrice": 80.0,
      "lowestPrice": 75.0,
      "highestPrice": 90.0,
      "averagePrice": 82.5,
      "priceChange": 5.0,
      "changePercentage": 6.25,
      "lastUpdated": "2024-01-15",
      "popularity": 85,
      "priceHistory": [75.0, 78.0, 80.0, 82.0, 85.0],
      "dates": ["2023-09", "2023-11", "2024-01", "2024-03", "2024-05"],
    },
    {
      "service": "Swedish Massage",
      "category": "massage",
      "location": "uptown",
      "currentPrice": 120.0,
      "previousPrice": 125.0,
      "lowestPrice": 110.0,
      "highestPrice": 130.0,
      "averagePrice": 120.0,
      "priceChange": -5.0,
      "changePercentage": -4.0,
      "lastUpdated": "2024-01-20",
      "popularity": 92,
      "priceHistory": [130.0, 125.0, 120.0, 115.0, 120.0],
      "dates": ["2023-09", "2023-11", "2024-01", "2024-03", "2024-05"],
    },
    {
      "service": "Hot Stone Therapy",
      "category": "massage",
      "location": "seaside",
      "currentPrice": 140.0,
      "previousPrice": 135.0,
      "lowestPrice": 130.0,
      "highestPrice": 145.0,
      "averagePrice": 137.5,
      "priceChange": 5.0,
      "changePercentage": 3.7,
      "lastUpdated": "2024-01-22",
      "popularity": 78,
      "priceHistory": [135.0, 130.0, 132.0, 138.0, 140.0],
      "dates": ["2023-09", "2023-11", "2024-01", "2024-03", "2024-05"],
    },
    {
      "service": "Body Scrub & Wrap",
      "category": "body",
      "location": "mountain",
      "currentPrice": 95.0,
      "previousPrice": 100.0,
      "lowestPrice": 90.0,
      "highestPrice": 105.0,
      "averagePrice": 97.5,
      "priceChange": -5.0,
      "changePercentage": -5.0,
      "lastUpdated": "2024-01-18",
      "popularity": 65,
      "priceHistory": [105.0, 100.0, 95.0, 90.0, 95.0],
      "dates": ["2023-09", "2023-11", "2024-01", "2024-03", "2024-05"],
    },
    {
      "service": "Manicure & Pedicure",
      "category": "nails",
      "location": "downtown",
      "currentPrice": 65.0,
      "previousPrice": 60.0,
      "lowestPrice": 55.0,
      "highestPrice": 70.0,
      "averagePrice": 62.5,
      "priceChange": 5.0,
      "changePercentage": 8.33,
      "lastUpdated": "2024-01-25",
      "popularity": 88,
      "priceHistory": [60.0, 55.0, 58.0, 62.0, 65.0],
      "dates": ["2023-09", "2023-11", "2024-01", "2024-03", "2024-05"],
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Price History"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () => _showPriceAnalytics(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFiltersSection(),
          _buildPriceStatsSection(),
          Expanded(
            child: _buildPriceHistoryList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Service Category",
                  items: serviceItems,
                  value: selectedService,
                  onChanged: (value, label) {
                    selectedService = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodItems,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Location",
            items: locationItems,
            value: selectedLocation,
            onChanged: (value, label) {
              selectedLocation = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildPriceStatsSection() {
    List<Map<String, dynamic>> filteredData = _getFilteredData();
    double avgPrice = filteredData.fold(0.0, (sum, item) => sum + (item["currentPrice"] as double)) / filteredData.length;
    double lowestPrice = filteredData.fold(double.infinity, (min, item) => Math.min(min, (item["lowestPrice"] as double)));
    double highestPrice = filteredData.fold(0.0, (max, item) => Math.max(max, (item["highestPrice"] as double)));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.all(spMd),
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
            "Price Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Average Price",
                  "\$${avgPrice.currency}",
                  Icons.analytics,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Lowest Price",
                  "\$${lowestPrice.currency}",
                  Icons.trending_down,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Highest Price",
                  "\$${highestPrice.currency}",
                  Icons.trending_up,
                  dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPriceHistoryList() {
    List<Map<String, dynamic>> filteredData = _getFilteredData();
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final service = filteredData[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${service["service"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${service["location"]}".replaceAll("_", " ").toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getPriceChangeColor((service["changePercentage"] as double)).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${(service["changePercentage"] as double) >= 0 ? '+' : ''}${(service["changePercentage"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getPriceChangeColor((service["changePercentage"] as double)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildPriceInfo(
                      "Current Price",
                      "\$${((service["currentPrice"] as double)).currency}",
                      Icons.attach_money,
                      primaryColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildPriceInfo(
                      "Previous Price",
                      "\$${((service["previousPrice"] as double)).currency}",
                      Icons.history,
                      disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildPriceInfo(
                      "Lowest",
                      "\$${((service["lowestPrice"] as double)).currency}",
                      Icons.trending_down,
                      successColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildPriceInfo(
                      "Highest",
                      "\$${((service["highestPrice"] as double)).currency}",
                      Icons.trending_up,
                      dangerColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildPriceInfo(
                      "Average",
                      "\$${((service["averagePrice"] as double)).currency}",
                      Icons.analytics,
                      infoColor,
                    ),
                  ),
                ],
              ),
              _buildPriceChart(service),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Popularity: ${service["popularity"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Updated: ${service["lastUpdated"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () => _viewPriceDetails(service),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Set Alert",
                      size: bs.sm,
                      onPressed: () => _setPriceAlert(service),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildPriceInfo(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildPriceChart(Map<String, dynamic> service) {
    List<double> prices = (service["priceHistory"] as List).cast<double>();
    double minPrice = prices.reduce((a, b) => Math.min(a, b));
    double maxPrice = prices.reduce((a, b) => Math.max(a, b));
    double range = maxPrice - minPrice;
    
    return Container(
      height: 80,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price Trend",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(prices.length, (index) {
                double price = prices[index];
                double height = range > 0 ? ((price - minPrice) / range) * 40 + 10 : 25;
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${service["dates"][index]}".substring(5),
                          style: TextStyle(
                            fontSize: 8,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
  
  List<Map<String, dynamic>> _getFilteredData() {
    List<Map<String, dynamic>> filtered = priceHistoryData;
    
    if (selectedService != "all") {
      filtered = filtered.where((item) => item["category"] == selectedService).toList();
    }
    
    if (selectedLocation != "all") {
      filtered = filtered.where((item) => item["location"] == selectedLocation).toList();
    }
    
    return filtered;
  }
  
  Color _getPriceChangeColor(double percentage) {
    if (percentage > 0) return dangerColor;
    if (percentage < 0) return successColor;
    return disabledBoldColor;
  }
  
  void _showPriceAnalytics() {
    si("Detailed price analytics available");
  }
  
  void _viewPriceDetails(Map<String, dynamic> service) {
    si("Viewing detailed price history for ${service["service"]}");
  }
  
  void _setPriceAlert(Map<String, dynamic> service) {
    ss("Price alert set for ${service["service"]}");
  }
}
