import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaRecentlySoldView extends StatefulWidget {
  const ReaRecentlySoldView({super.key});

  @override
  State<ReaRecentlySoldView> createState() => _ReaRecentlySoldViewState();
}

class _ReaRecentlySoldViewState extends State<ReaRecentlySoldView> {
  String selectedTimeFrame = "This Month";
  String selectedCategory = "All";
  String selectedLocation = "All Areas";
  
  List<Map<String, dynamic>> timeFrames = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
  ];
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Apartments", "value": "Apartments"},
    {"label": "Houses", "value": "Houses"},
    {"label": "Villas", "value": "Villas"},
    {"label": "Plots", "value": "Plots"},
  ];
  
  List<Map<String, dynamic>> locations = [
    {"label": "All Areas", "value": "All Areas"},
    {"label": "Whitefield", "value": "Whitefield"},
    {"label": "Electronic City", "value": "Electronic City"},
    {"label": "Koramangala", "value": "Koramangala"},
    {"label": "Indiranagar", "value": "Indiranagar"},
  ];

  List<Map<String, dynamic>> soldProperties = [
    {
      "id": 1,
      "title": "Prestige Song of the South",
      "location": "Begur Road, Bangalore",
      "soldPrice": 8500000,
      "originalPrice": 9200000,
      "type": "3 BHK Apartment",
      "area": 1450,
      "image": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "soldDate": "2025-06-10",
      "daysOnMarket": 45,
      "priceChange": -7.6,
      "buyer": "Residential",
      "amenities": ["Swimming Pool", "Gym", "Security", "Parking"],
      "builder": "Prestige Group",
      "floor": "12th Floor",
      "facing": "East",
      "ageOfProperty": "Ready to Move"
    },
    {
      "id": 2,
      "title": "Brigade Panorama",
      "location": "Hebbal, Bangalore",
      "soldPrice": 12500000,
      "originalPrice": 12800000,
      "type": "4 BHK Apartment",
      "area": 2200,
      "image": "https://picsum.photos/300/200?random=2&keyword=luxury",
      "soldDate": "2025-06-08",
      "daysOnMarket": 32,
      "priceChange": -2.3,
      "buyer": "Investment",
      "amenities": ["Swimming Pool", "Spa", "Security", "Club"],
      "builder": "Brigade Group",
      "floor": "18th Floor",
      "facing": "North",
      "ageOfProperty": "3 Years Old"
    },
    {
      "id": 3,
      "title": "Sobha Royal Pavilion",
      "location": "Sarjapur Road, Bangalore",
      "soldPrice": 15200000,
      "originalPrice": 14800000,
      "type": "4 BHK Villa",
      "area": 2850,
      "image": "https://picsum.photos/300/200?random=3&keyword=villa",
      "soldDate": "2025-06-05",
      "daysOnMarket": 28,
      "priceChange": 2.7,
      "buyer": "Residential",
      "amenities": ["Private Garden", "Swimming Pool", "Security", "Club"],
      "builder": "Sobha Limited",
      "floor": "Independent",
      "facing": "South",
      "ageOfProperty": "New Construction"
    },
    {
      "id": 4,
      "title": "Godrej Reflections",
      "location": "Hinjewadi, Pune",
      "soldPrice": 7800000,
      "originalPrice": 8200000,
      "type": "2 BHK Apartment",
      "area": 1180,
      "image": "https://picsum.photos/300/200?random=4&keyword=apartment",
      "soldDate": "2025-06-03",
      "daysOnMarket": 52,
      "priceChange": -4.9,
      "buyer": "Investment",
      "amenities": ["Swimming Pool", "Gym", "Landscaped Gardens", "Security"],
      "builder": "Godrej Properties",
      "floor": "8th Floor",
      "facing": "West",
      "ageOfProperty": "2 Years Old"
    },
    {
      "id": 5,
      "title": "Embassy Springs",
      "location": "Devanahalli, Bangalore",
      "soldPrice": 18500000,
      "originalPrice": 17900000,
      "type": "5 BHK Villa",
      "area": 3200,
      "image": "https://picsum.photos/300/200?random=5&keyword=mansion",
      "soldDate": "2025-06-01",
      "daysOnMarket": 21,
      "priceChange": 3.4,
      "buyer": "Residential",
      "amenities": ["Golf Course", "Swimming Pool", "Concierge", "Security"],
      "builder": "Embassy Group",
      "floor": "Independent",
      "facing": "North",
      "ageOfProperty": "Ready to Move"
    },
    {
      "id": 6,
      "title": "Puravankara Purva Zenium",
      "location": "Kanakapura Road, Bangalore",
      "soldPrice": 5800000,
      "originalPrice": 6100000,
      "type": "2 BHK Apartment",
      "area": 1050,
      "image": "https://picsum.photos/300/200?random=6&keyword=apartment",
      "soldDate": "2025-05-28",
      "daysOnMarket": 67,
      "priceChange": -4.9,
      "buyer": "Residential",
      "amenities": ["Clubhouse", "Swimming Pool", "Gym", "Children's Play Area"],
      "builder": "Puravankara Limited",
      "floor": "6th Floor",
      "facing": "East",
      "ageOfProperty": "1 Year Old"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recently Sold"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.analytics),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Market Activity Card
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
                        Icons.analytics,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Market Activity",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Recent sales data and trends",
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
                                "₹68.3Cr",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Total Sales",
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
                                "6",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Properties",
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
                                "41",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Avg Days",
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
              "Filter Recent Sales",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
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
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            QDropdownField(
              label: "Location",
              items: locations,
              value: selectedLocation,
              onChanged: (value, label) {
                selectedLocation = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Properties List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recently Sold Properties",
                  style: TextStyle(
                    fontSize: fsH6,
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
                    "${soldProperties.length} Sales",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Properties List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: soldProperties.length,
              itemBuilder: (context, index) {
                final property = soldProperties[index];
                final priceChange = property["priceChange"] as num;
                final isPositive = priceChange > 0;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: successColor.withAlpha(100),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Image with Sold Badge
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Colors.grey.withAlpha(100),
                                BlendMode.overlay,
                              ),
                              child: Image.network(
                                "${property["image"]}",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "SOLD",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: isPositive ? successColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${isPositive ? '+' : ''}${priceChange.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Sold on ${property["soldDate"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Property Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${property["title"]}",
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
                                Expanded(
                                  child: Text(
                                    "${property["location"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            // Sale Price Details
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sold for ₹${((property["soldPrice"] as int).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                                        style: TextStyle(
                                          fontSize: fsH5,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      if ((property["originalPrice"] as int) != (property["soldPrice"] as int))
                                        Text(
                                          "Listed at ₹${((property["originalPrice"] as int).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      Text(
                                        "${property["type"]}",
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
                                      "${property["area"]} sq ft",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "₹${((property["soldPrice"] as int) / (property["area"] as int)).toStringAsFixed(0)}/sq ft",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Sale Details
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${property["daysOnMarket"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: infoColor,
                                          ),
                                        ),
                                        Text(
                                          "Days on Market",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: infoColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${property["buyer"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: warningColor,
                                          ),
                                        ),
                                        Text(
                                          "Buyer Type",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: warningColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${property["floor"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Floor",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Property Features
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "By ${property["builder"]} • ${property["facing"]} Facing",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: secondaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${property["ageOfProperty"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: secondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Similar",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Find similar properties
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.compare_arrows,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Compare with current market
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Share sale data
                                  },
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
          ],
        ),
      ),
    );
  }
}
