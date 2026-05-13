import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsPriceComparisonView extends StatefulWidget {
  const BrsPriceComparisonView({super.key});

  @override
  State<BrsPriceComparisonView> createState() => _BrsPriceComparisonViewState();
}

class _BrsPriceComparisonViewState extends State<BrsPriceComparisonView> {
  String selectedService = "Haircut";
  String selectedArea = "Downtown";
  
  List<Map<String, dynamic>> serviceTypes = [
    {"label": "Haircut", "value": "Haircut"},
    {"label": "Beard Trim", "value": "Beard Trim"},
    {"label": "Hot Shave", "value": "Hot Shave"},
    {"label": "Hair Wash", "value": "Hair Wash"},
    {"label": "Styling", "value": "Styling"},
  ];

  List<Map<String, dynamic>> areas = [
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Uptown", "value": "Uptown"},
    {"label": "Suburbs", "value": "Suburbs"},
    {"label": "Business District", "value": "Business District"},
  ];

  List<Map<String, dynamic>> barbershops = [
    {
      "id": 1,
      "name": "Prime Cuts Barbershop",
      "area": "Downtown",
      "rating": 4.9,
      "reviews": 245,
      "distance": 0.8,
      "image": "https://picsum.photos/300/200?random=1&keyword=barbershop",
      "ourShop": true,
      "services": {
        "Haircut": {"price": 35.0, "duration": 45, "popular": true},
        "Beard Trim": {"price": 20.0, "duration": 25, "popular": false},
        "Hot Shave": {"price": 30.0, "duration": 35, "popular": true},
        "Hair Wash": {"price": 15.0, "duration": 20, "popular": false},
        "Styling": {"price": 25.0, "duration": 30, "popular": false},
      },
      "specialties": ["Classic Cuts", "Modern Styles", "Beard Care"],
      "benefits": ["Premium Products", "Experienced Barbers", "Relaxing Environment"],
    },
    {
      "id": 2,
      "name": "Classic Barber Co.",
      "area": "Downtown",
      "rating": 4.6,
      "reviews": 189,
      "distance": 1.2,
      "image": "https://picsum.photos/300/200?random=2&keyword=vintage+barbershop",
      "ourShop": false,
      "services": {
        "Haircut": {"price": 40.0, "duration": 50, "popular": true},
        "Beard Trim": {"price": 25.0, "duration": 30, "popular": false},
        "Hot Shave": {"price": 35.0, "duration": 40, "popular": false},
        "Hair Wash": {"price": 18.0, "duration": 25, "popular": false},
        "Styling": {"price": 30.0, "duration": 35, "popular": false},
      },
      "specialties": ["Traditional Cuts", "Straight Razor"],
      "benefits": ["Classic Techniques", "Vintage Atmosphere"],
    },
    {
      "id": 3,
      "name": "Urban Edge Cuts",
      "area": "Downtown",
      "rating": 4.4,
      "reviews": 156,
      "distance": 1.5,
      "image": "https://picsum.photos/300/200?random=3&keyword=modern+barbershop",
      "ourShop": false,
      "services": {
        "Haircut": {"price": 32.0, "duration": 40, "popular": true},
        "Beard Trim": {"price": 18.0, "duration": 20, "popular": false},
        "Hot Shave": {"price": 28.0, "duration": 30, "popular": false},
        "Hair Wash": {"price": 12.0, "duration": 15, "popular": false},
        "Styling": {"price": 22.0, "duration": 25, "popular": false},
      },
      "specialties": ["Trendy Styles", "Fades"],
      "benefits": ["Modern Techniques", "Quick Service"],
    },
    {
      "id": 4,
      "name": "Gentleman's Choice",
      "area": "Uptown",
      "rating": 4.7,
      "reviews": 203,
      "distance": 2.8,
      "image": "https://picsum.photos/300/200?random=4&keyword=luxury+barbershop",
      "ourShop": false,
      "services": {
        "Haircut": {"price": 45.0, "duration": 60, "popular": true},
        "Beard Trim": {"price": 28.0, "duration": 35, "popular": false},
        "Hot Shave": {"price": 40.0, "duration": 45, "popular": true},
        "Hair Wash": {"price": 20.0, "duration": 30, "popular": false},
        "Styling": {"price": 35.0, "duration": 40, "popular": false},
      },
      "specialties": ["Luxury Service", "Executive Cuts"],
      "benefits": ["Premium Location", "VIP Treatment"],
    },
    {
      "id": 5,
      "name": "Quick Clips",
      "area": "Suburbs",
      "rating": 4.1,
      "reviews": 98,
      "distance": 4.2,
      "image": "https://picsum.photos/300/200?random=5&keyword=budget+barbershop",
      "ourShop": false,
      "services": {
        "Haircut": {"price": 25.0, "duration": 30, "popular": true},
        "Beard Trim": {"price": 15.0, "duration": 20, "popular": false},
        "Hot Shave": {"price": 22.0, "duration": 25, "popular": false},
        "Hair Wash": {"price": 10.0, "duration": 15, "popular": false},
        "Styling": {"price": 18.0, "duration": 20, "popular": false},
      },
      "specialties": ["Budget Friendly", "Quick Service"],
      "benefits": ["Affordable Prices", "No Appointment Needed"],
    },
  ];

  List<Map<String, dynamic>> get filteredBarbershops {
    return barbershops
        .where((shop) => selectedArea == "All" || shop["area"] == selectedArea)
        .toList()
      ..sort((a, b) {
        // Our shop first, then by rating
        if (a["ourShop"] && !b["ourShop"]) return -1;
        if (!a["ourShop"] && b["ourShop"]) return 1;
        return (b["rating"] as double).compareTo(a["rating"] as double);
      });
  }

  double get averagePrice {
    final prices = filteredBarbershops
        .map((shop) => (shop["services"] as Map)[selectedService]["price"] as double)
        .toList();
    return prices.fold(0.0, (sum, price) => sum + price) / prices.length;
  }

  Map<String, dynamic> get ourShopData {
    return barbershops.firstWhere((shop) => shop["ourShop"] == true);
  }

  @override
  Widget build(BuildContext context) {
    final ourShop = ourShopData;
    final ourPrice = (ourShop["services"] as Map)[selectedService]["price"] as double;
    final avgPrice = averagePrice;
    final savings = avgPrice - ourPrice;
    final savingsPercent = ((savings / avgPrice) * 100).abs();

    return Scaffold(
      appBar: AppBar(
        title: Text("Price Comparison"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Compare Prices",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "See how our prices compare to local competitors",
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.trending_down, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Best Value Guarantee",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Service Selection
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Service",
                    items: serviceTypes,
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
                    label: "Area",
                    items: areas,
                    value: selectedArea,
                    onChanged: (value, label) {
                      selectedArea = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Price Summary Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: savings > 0 ? successColor.withAlpha(30) : warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: savings > 0 ? successColor : warningColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Our Price",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${ourPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: savings > 0 ? successColor : dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              savings > 0 ? Icons.trending_down : Icons.trending_up,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              savings > 0 
                                ? "${savingsPercent.toStringAsFixed(1)}% LOWER"
                                : "${savingsPercent.toStringAsFixed(1)}% HIGHER",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
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
                        "Average Competitor Price: \$${avgPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (savings > 0)
                        Text(
                          "You save \$${savings.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Competition List
            Text(
              "Local Competition (${filteredBarbershops.length} shops)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Column(
              spacing: spSm,
              children: filteredBarbershops.map((shop) {
                final service = (shop["services"] as Map)[selectedService];
                final isOurShop = shop["ourShop"] as bool;
                final price = service["price"] as double;
                final duration = service["duration"] as int;
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: isOurShop
                        ? Border.all(color: primaryColor, width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${shop["image"]}",
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${shop["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: isOurShop ? primaryColor : Colors.black,
                                        ),
                                      ),
                                    ),
                                    if (isOurShop)
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "OUR SHOP",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: warningColor, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${shop["rating"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      " (${shop["reviews"]})",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(Icons.location_on, color: infoColor, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${shop["distance"]} km",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Service Details
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isOurShop ? primaryColor.withAlpha(30) : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$selectedService",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "$duration minutes",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\$${price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: isOurShop ? primaryColor : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Specialties
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (shop["specialties"] as List).map((specialty) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: isOurShop ? primaryColor.withAlpha(50) : Colors.grey[200],
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$specialty",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: isOurShop ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      if (isOurShop) ...[
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Book Now",
                            size: bs.sm,
                            onPressed: () {
                              ss("Redirecting to booking...");
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Why Choose Us Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Why Choose ${ourShop["name"]}?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: (ourShop["benefits"] as List).map((benefit) {
                      return Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "$benefit",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Book Your Appointment",
                      size: bs.md,
                      onPressed: () {
                        ss("Opening booking form...");
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Price Transparency Note
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: infoColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price Transparency",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Prices shown are current as of today. Competitor prices may vary and are subject to change. All prices include basic service only.",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
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
