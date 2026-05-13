import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsCategoryView extends StatefulWidget {
  const BrsCategoryView({super.key});

  @override
  State<BrsCategoryView> createState() => _BrsCategoryViewState();
}

class _BrsCategoryViewState extends State<BrsCategoryView> {
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categories = [
    {
      "id": 1,
      "name": "All",
      "icon": Icons.apps,
      "count": 45,
      "color": primaryColor,
    },
    {
      "id": 2,
      "name": "Classic Cuts",
      "icon": Icons.content_cut,
      "count": 12,
      "color": successColor,
    },
    {
      "id": 3,
      "name": "Modern Styling",
      "icon": Icons.auto_awesome,
      "count": 8,
      "color": warningColor,
    },
    {
      "id": 4,
      "name": "Beard & Mustache",
      "icon": Icons.face,
      "count": 15,
      "color": infoColor,
    },
    {
      "id": 5,
      "name": "Hot Towel Shave",
      "icon": Icons.spa,
      "count": 6,
      "color": dangerColor,
    },
    {
      "id": 6,
      "name": "Hair Washing",
      "icon": Icons.water_drop,
      "count": 4,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> services = [
    {
      "id": 1,
      "name": "Classic Gentleman's Cut",
      "category": "Classic Cuts",
      "price": 25,
      "duration": "30 min",
      "description": "Traditional haircut with scissors and comb",
      "image": "https://picsum.photos/300/200?random=1&keyword=haircut",
      "rating": 4.8,
      "bookings": 156,
      "isPopular": true,
    },
    {
      "id": 2,
      "name": "Fade Cut & Style",
      "category": "Modern Styling",
      "price": 35,
      "duration": "45 min",
      "description": "Modern fade cut with styling and finishing",
      "image": "https://picsum.photos/300/200?random=2&keyword=haircut",
      "rating": 4.9,
      "bookings": 203,
      "isPopular": true,
    },
    {
      "id": 3,
      "name": "Beard Trim & Design",
      "category": "Beard & Mustache",
      "price": 20,
      "duration": "25 min",
      "description": "Professional beard shaping and trimming",
      "image": "https://picsum.photos/300/200?random=3&keyword=beard",
      "rating": 4.7,
      "bookings": 89,
      "isPopular": false,
    },
    {
      "id": 4,
      "name": "Traditional Hot Shave",
      "category": "Hot Towel Shave",
      "price": 30,
      "duration": "40 min",
      "description": "Classic hot towel shave with straight razor",
      "image": "https://picsum.photos/300/200?random=4&keyword=shave",
      "rating": 4.9,
      "bookings": 134,
      "isPopular": true,
    },
    {
      "id": 5,
      "name": "Hair Wash & Treatment",
      "category": "Hair Washing",
      "price": 15,
      "duration": "20 min",
      "description": "Deep cleansing hair wash with conditioning",
      "image": "https://picsum.photos/300/200?random=5&keyword=hairwash",
      "rating": 4.6,
      "bookings": 67,
      "isPopular": false,
    },
    {
      "id": 6,
      "name": "Executive Style Package",
      "category": "Modern Styling",
      "price": 50,
      "duration": "60 min",
      "description": "Complete styling package for professionals",
      "image": "https://picsum.photos/300/200?random=6&keyword=hairstyle",
      "rating": 4.8,
      "bookings": 98,
      "isPopular": true,
    },
    {
      "id": 7,
      "name": "Mustache Grooming",
      "category": "Beard & Mustache",
      "price": 18,
      "duration": "20 min",
      "description": "Precision mustache shaping and styling",
      "image": "https://picsum.photos/300/200?random=7&keyword=mustache",
      "rating": 4.5,
      "bookings": 45,
      "isPopular": false,
    },
    {
      "id": 8,
      "name": "Senior Citizen Cut",
      "category": "Classic Cuts",
      "price": 20,
      "duration": "25 min",
      "description": "Gentle haircut service for seniors",
      "image": "https://picsum.photos/300/200?random=8&keyword=haircut",
      "rating": 4.7,
      "bookings": 76,
      "isPopular": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredServices = selectedCategory == "All" 
        ? services 
        : services.where((service) => service["category"] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Service Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              si("Opening search");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Browse by Category",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Find the perfect service for your grooming needs",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Categories Grid
          Container(
            padding: EdgeInsets.all(spMd),
            child: ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: categories.map((category) {
                bool isSelected = selectedCategory == category["name"];
                return GestureDetector(
                  onTap: () {
                    selectedCategory = "${category["name"]}";
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: isSelected ? [shadowMd] : [shadowSm],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : (category["color"] as Color).withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: isSelected ? primaryColor : category["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${category["name"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${category["count"]} services",
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Services List
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        selectedCategory == "All" ? "All Services" : selectedCategory,
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${filteredServices.length} services",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredServices.length,
                      itemBuilder: (context, index) {
                        final service = filteredServices[index];
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Service Image
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radiusMd),
                                      bottomLeft: Radius.circular(radiusMd),
                                    ),
                                    child: Image.network(
                                      "${service["image"]}",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (service["isPopular"] as bool)
                                    Positioned(
                                      top: spXs,
                                      left: spXs,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: warningColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Popular",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              
                              // Service Details
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(spSm),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${service["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      
                                      SizedBox(height: spXs),
                                      
                                      Text(
                                        "${service["description"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      
                                      SizedBox(height: spXs),
                                      
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: warningColor, size: 14),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${service["rating"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            " (${service["bookings"]})",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${service["duration"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                      SizedBox(height: spSm),
                                      
                                      Row(
                                        children: [
                                          Text(
                                            "\$${service["price"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Spacer(),
                                          QButton(
                                            label: "Book Now",
                                            size: bs.sm,
                                            onPressed: () {
                                              si("Booking ${service["name"]}");
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
