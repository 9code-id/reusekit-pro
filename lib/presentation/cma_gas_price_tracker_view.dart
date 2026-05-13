import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaGasPriceTrackerView extends StatefulWidget {
  const CmaGasPriceTrackerView({super.key});

  @override
  State<CmaGasPriceTrackerView> createState() => _CmaGasPriceTrackerViewState();
}

class _CmaGasPriceTrackerViewState extends State<CmaGasPriceTrackerView> {
  String selectedFuelType = "Regular";
  String selectedLocation = "All Locations";
  String radiusFilter = "10 km";
  
  List<Map<String, dynamic>> gasPrices = [
    {
      "id": 1,
      "stationName": "Shell",
      "address": "123 Main St",
      "distance": 2.5,
      "fuelType": "Regular",
      "price": 1.45,
      "lastUpdated": "2025-06-19 08:30",
      "trend": "down",
      "change": -0.03,
      "brand": "Shell",
      "hasCarWash": true,
      "hasConvenience": true,
      "rating": 4.2,
    },
    {
      "id": 2,
      "stationName": "Petro Canada",
      "address": "456 Oak Ave",
      "distance": 3.8,
      "fuelType": "Regular",
      "price": 1.42,
      "lastUpdated": "2025-06-19 07:45",
      "trend": "up",
      "change": 0.02,
      "brand": "Petro Canada",
      "hasCarWash": false,
      "hasConvenience": true,
      "rating": 4.0,
    },
    {
      "id": 3,
      "stationName": "Esso",
      "address": "789 Pine Rd",
      "distance": 1.2,
      "fuelType": "Regular",
      "price": 1.48,
      "lastUpdated": "2025-06-19 09:15",
      "trend": "stable",
      "change": 0.00,
      "brand": "Esso",
      "hasCarWash": true,
      "hasConvenience": true,
      "rating": 4.5,
    },
    {
      "id": 4,
      "stationName": "Costco Gas",
      "address": "321 Shopping Blvd",
      "distance": 8.9,
      "fuelType": "Regular",
      "price": 1.38,
      "lastUpdated": "2025-06-19 10:00",
      "trend": "down",
      "change": -0.05,
      "brand": "Costco",
      "hasCarWash": false,
      "hasConvenience": false,
      "rating": 4.7,
    },
  ];

  List<Map<String, dynamic>> get filteredPrices {
    return gasPrices.where((price) => 
      price["fuelType"] == selectedFuelType
    ).toList()..sort((a, b) => 
      (a["price"] as double).compareTo(b["price"] as double)
    );
  }

  double get lowestPrice {
    if (filteredPrices.isEmpty) return 0.0;
    return filteredPrices.first["price"] as double;
  }

  double get averagePrice {
    if (filteredPrices.isEmpty) return 0.0;
    return filteredPrices.fold(0.0, (sum, price) => 
      sum + (price["price"] as double)
    ) / filteredPrices.length;
  }

  String get priceRangeText {
    if (filteredPrices.isEmpty) return "No data";
    final lowest = filteredPrices.first["price"] as double;
    final highest = filteredPrices.last["price"] as double;
    return "\$${lowest.toStringAsFixed(2)} - \$${highest.toStringAsFixed(2)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gas Price Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              // Find nearby stations
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh prices
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Search Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Fuel Type",
                          items: [
                            {"label": "Regular", "value": "Regular"},
                            {"label": "Mid-Grade", "value": "Mid-Grade"},
                            {"label": "Premium", "value": "Premium"},
                            {"label": "Diesel", "value": "Diesel"},
                          ],
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
                          label: "Search Radius",
                          items: [
                            {"label": "5 km", "value": "5 km"},
                            {"label": "10 km", "value": "10 km"},
                            {"label": "25 km", "value": "25 km"},
                            {"label": "50 km", "value": "50 km"},
                          ],
                          value: radiusFilter,
                          onChanged: (value, label) {
                            radiusFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_down,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Lowest Price",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${lowestPrice.toStringAsFixed(2)}/L",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.bar_chart,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Average Price",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${averagePrice.toStringAsFixed(2)}/L",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.compare_arrows,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Price Range",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        priceRangeText,
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Gas Stations List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(Icons.local_gas_station, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Gas Stations Near You",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredPrices.length} stations",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredPrices.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledColor,
                    ),
                    itemBuilder: (context, index) {
                      final station = filteredPrices[index];
                      final isLowest = index == 0;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            // Price Badge
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: isLowest 
                                  ? successColor 
                                  : primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${(station["price"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "per L",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            // Station Info
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${station["stationName"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (isLowest) ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "LOWEST",
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: successColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${station["address"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${(station["distance"] as double).toStringAsFixed(1)} km",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      // Rating
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 14,
                                            color: warningColor,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${station["rating"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: spSm),
                                      
                                      // Amenities
                                      if (station["hasCarWash"] as bool) ...[
                                        Icon(
                                          Icons.local_car_wash,
                                          size: 14,
                                          color: infoColor,
                                        ),
                                        SizedBox(width: spXs),
                                      ],
                                      if (station["hasConvenience"] as bool) ...[
                                        Icon(
                                          Icons.store,
                                          size: 14,
                                          color: infoColor,
                                        ),
                                        SizedBox(width: spXs),
                                      ],
                                      
                                      Spacer(),
                                      
                                      // Price Trend
                                      Row(
                                        children: [
                                          Icon(
                                            station["trend"] == "up" 
                                              ? Icons.trending_up
                                              : station["trend"] == "down"
                                                ? Icons.trending_down
                                                : Icons.trending_flat,
                                            size: 14,
                                            color: station["trend"] == "up" 
                                              ? dangerColor
                                              : station["trend"] == "down"
                                                ? successColor
                                                : disabledBoldColor,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            station["change"] == 0.0 
                                              ? "No change"
                                              : "${(station["change"] as double) > 0 ? '+' : ''}${(station["change"] as double).toStringAsFixed(2)}¢",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: station["trend"] == "up" 
                                                ? dangerColor
                                                : station["trend"] == "down"
                                                  ? successColor
                                                  : disabledBoldColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Updated: ${station["lastUpdated"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Action Button
                            Column(
                              children: [
                                QButton(
                                  icon: Icons.directions,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to station
                                  },
                                ),
                                SizedBox(height: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Show more options
                                  },
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
          ],
        ),
      ),
    );
  }
}
