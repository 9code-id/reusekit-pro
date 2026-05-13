import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPriceDropsView extends StatefulWidget {
  const ReaPriceDropsView({super.key});

  @override
  State<ReaPriceDropsView> createState() => _ReaPriceDropsViewState();
}

class _ReaPriceDropsViewState extends State<ReaPriceDropsView> {
  String selectedCategory = "All";
  String selectedDropRange = "Any";
  String selectedTimeFrame = "This Week";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Apartments", "value": "Apartments"},
    {"label": "Houses", "value": "Houses"},
    {"label": "Villas", "value": "Villas"},
    {"label": "Plots", "value": "Plots"},
  ];
  
  List<Map<String, dynamic>> dropRanges = [
    {"label": "Any", "value": "Any"},
    {"label": "5-10%", "value": "5-10%"},
    {"label": "10-20%", "value": "10-20%"},
    {"label": "20-30%", "value": "20-30%"},
    {"label": "Above 30%", "value": "Above 30%"},
  ];
  
  List<Map<String, dynamic>> timeFrames = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
  ];

  List<Map<String, dynamic>> priceDropProperties = [
    {
      "id": 1,
      "title": "Mantri Espana",
      "location": "Bellandur, Bangalore",
      "originalPrice": 12500000,
      "currentPrice": 9800000,
      "type": "3 BHK Apartment",
      "area": 1650,
      "image": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "dropPercentage": 21.6,
      "dropAmount": 2700000,
      "reason": "Builder Promotion",
      "validTill": "2025-07-15",
      "amenities": ["Swimming Pool", "Gym", "Security", "Parking"],
      "builder": "Mantri Developers",
      "status": "Ready to Move",
      "possession": "Immediate"
    },
    {
      "id": 2,
      "title": "Shriram Codename Dune",
      "location": "Bagalur, Bangalore",
      "originalPrice": 7800000,
      "currentPrice": 6500000,
      "type": "2 BHK Apartment",
      "area": 1180,
      "image": "https://picsum.photos/300/200?random=2&keyword=building",
      "dropPercentage": 16.7,
      "dropAmount": 1300000,
      "reason": "End of Financial Year",
      "validTill": "2025-06-30",
      "amenities": ["Clubhouse", "Garden", "Security", "Power Backup"],
      "builder": "Shriram Properties",
      "status": "Under Construction",
      "possession": "Dec 2025"
    },
    {
      "id": 3,
      "title": "Ozone Metrozone",
      "location": "Anna Nagar, Bangalore",
      "originalPrice": 15200000,
      "currentPrice": 11400000,
      "type": "4 BHK Apartment",
      "area": 2200,
      "image": "https://picsum.photos/300/200?random=3&keyword=luxury",
      "dropPercentage": 25.0,
      "dropAmount": 3800000,
      "reason": "Inventory Clearance",
      "validTill": "2025-08-31",
      "amenities": ["Swimming Pool", "Spa", "Security", "Club"],
      "builder": "Ozone Group",
      "status": "Ready to Move",
      "possession": "Immediate"
    },
    {
      "id": 4,
      "title": "Salarpuria Sattva Divinity",
      "location": "Kogilu Cross, Bangalore",
      "originalPrice": 8900000,
      "currentPrice": 7200000,
      "type": "3 BHK Apartment",
      "area": 1450,
      "image": "https://picsum.photos/300/200?random=4&keyword=residential",
      "dropPercentage": 19.1,
      "dropAmount": 1700000,
      "reason": "Festival Offer",
      "validTill": "2025-07-01",
      "amenities": ["Swimming Pool", "Gym", "Landscaped Gardens", "Security"],
      "builder": "Salarpuria Sattva",
      "status": "Under Construction",
      "possession": "Mar 2026"
    },
    {
      "id": 5,
      "title": "Brigade Orchards",
      "location": "Devanahalli, Bangalore",
      "originalPrice": 6800000,
      "currentPrice": 5700000,
      "type": "2 BHK Villa",
      "area": 1850,
      "image": "https://picsum.photos/300/200?random=5&keyword=villa",
      "dropPercentage": 16.2,
      "dropAmount": 1100000,
      "reason": "Pre-Launch Offer",
      "validTill": "2025-06-25",
      "amenities": ["Private Garden", "Swimming Pool", "Security", "Club"],
      "builder": "Brigade Group",
      "status": "Under Construction",
      "possession": "Jun 2025"
    },
    {
      "id": 6,
      "title": "Lodha Belmondo",
      "location": "Gahunje, Pune",
      "originalPrice": 11200000,
      "currentPrice": 8400000,
      "type": "3 BHK Apartment",
      "area": 1580,
      "image": "https://picsum.photos/300/200?random=6&keyword=apartment",
      "dropPercentage": 25.0,
      "dropAmount": 2800000,
      "reason": "Limited Period Offer",
      "validTill": "2025-07-10",
      "amenities": ["Clubhouse", "Swimming Pool", "Gym", "Children's Play Area"],
      "builder": "Lodha Group",
      "status": "Ready to Move",
      "possession": "Immediate"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Price Drops"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price Drop Alert Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dangerColor, dangerColor.withAlpha(150)],
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
                        Icons.trending_down,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price Drop Alert",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Properties with significant price reductions",
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
                                "₹2.8Cr",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Total Savings",
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
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Filter Section
            Text(
              "Filter by Drop Range",
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
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Drop Range",
                    items: dropRanges,
                    value: selectedDropRange,
                    onChanged: (value, label) {
                      selectedDropRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            QDropdownField(
              label: "Time Frame",
              items: timeFrames,
              value: selectedTimeFrame,
              onChanged: (value, label) {
                selectedTimeFrame = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Properties List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price Drop Properties",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${priceDropProperties.length} Deals",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
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
              itemCount: priceDropProperties.length,
              itemBuilder: (context, index) {
                final property = priceDropProperties[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: dangerColor.withAlpha(100),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Image with Price Drop Badge
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${property["image"]}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_down,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(property["dropPercentage"] as num).toStringAsFixed(1)}% OFF",
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
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${property["reason"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.bookmark_border,
                                color: Colors.white,
                                size: 20,
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
                            
                            // Price Comparison
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "₹${((property["originalPrice"] as int).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: disabledBoldColor,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: dangerColor.withAlpha(50),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "SAVE ₹${((property["dropAmount"] as int).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: dangerColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "₹${((property["currentPrice"] as int).toDouble() / 1000000).toStringAsFixed(2)}Cr",
                                        style: TextStyle(
                                          fontSize: fsH5,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
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
                                      "₹${((property["currentPrice"] as int) / (property["area"] as int)).toStringAsFixed(0)}/sq ft",
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
                            
                            // Offer Valid Till
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(
                                  color: warningColor.withAlpha(100),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: warningColor,
                                    size: 14,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Offer valid till ${property["validTill"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Status and Builder Info
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "By ${property["builder"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${property["status"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
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
                                    label: "Grab Deal",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Navigate to property detail
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.phone,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Call builder
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Share deal
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
