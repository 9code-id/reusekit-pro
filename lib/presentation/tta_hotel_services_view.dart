import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaHotelServicesView extends StatefulWidget {
  const TtaHotelServicesView({super.key});

  @override
  State<TtaHotelServicesView> createState() => _TtaHotelServicesViewState();
}

class _TtaHotelServicesViewState extends State<TtaHotelServicesView> {
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Room Service", "value": "Room Service"},
    {"label": "Spa & Wellness", "value": "Spa & Wellness"},
    {"label": "Dining", "value": "Dining"},
    {"label": "Recreation", "value": "Recreation"},
    {"label": "Business", "value": "Business"},
  ];

  List<Map<String, dynamic>> services = [
    {
      "title": "24/7 Room Service",
      "description": "Order food and beverages directly to your room",
      "category": "Room Service",
      "price": 0,
      "duration": "30-45 min",
      "icon": Icons.room_service,
      "color": primaryColor,
      "available": true,
      "rating": 4.8,
    },
    {
      "title": "Spa Treatment",
      "description": "Relaxing massage and wellness treatments",
      "category": "Spa & Wellness",
      "price": 120,
      "duration": "60-90 min",
      "icon": Icons.spa,
      "color": successColor,
      "available": true,
      "rating": 4.9,
    },
    {
      "title": "Fine Dining Restaurant",
      "description": "Exquisite cuisine with city view",
      "category": "Dining",
      "price": 80,
      "duration": "60-120 min",
      "icon": Icons.restaurant,
      "color": warningColor,
      "available": true,
      "rating": 4.7,
    },
    {
      "title": "Swimming Pool",
      "description": "Rooftop pool with panoramic views",
      "category": "Recreation",
      "price": 0,
      "duration": "All day",
      "icon": Icons.pool,
      "color": infoColor,
      "available": true,
      "rating": 4.6,
    },
    {
      "title": "Fitness Center",
      "description": "State-of-the-art gym equipment",
      "category": "Recreation",
      "price": 0,
      "duration": "24/7",
      "icon": Icons.fitness_center,
      "color": dangerColor,
      "available": true,
      "rating": 4.5,
    },
    {
      "title": "Business Center",
      "description": "Meeting rooms and office facilities",
      "category": "Business",
      "price": 50,
      "duration": "Per hour",
      "icon": Icons.business_center,
      "color": secondaryColor,
      "available": false,
      "rating": 4.3,
    },
    {
      "title": "Laundry Service",
      "description": "Professional cleaning and pressing",
      "category": "Room Service",
      "price": 25,
      "duration": "24 hours",
      "icon": Icons.local_laundry_service,
      "color": primaryColor,
      "available": true,
      "rating": 4.4,
    },
    {
      "title": "Airport Transfer",
      "description": "Luxury car service to/from airport",
      "category": "Room Service",
      "price": 75,
      "duration": "45-60 min",
      "icon": Icons.airport_shuttle,
      "color": infoColor,
      "available": true,
      "rating": 4.8,
    },
  ];

  List<Map<String, dynamic>> get filteredServices {
    return services.where((service) {
      bool categoryMatch = selectedCategory == "All" || 
                          service["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty ||
                        (service["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                        (service["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Services"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ss("Notifications opened");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search services...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spSm),

          // Services List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                final isAvailable = service["available"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isAvailable 
                          ? disabledOutlineBorderColor 
                          : disabledColor,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: (service["color"] as Color).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Icon(
                                service["icon"] as IconData,
                                color: isAvailable 
                                    ? service["color"] as Color
                                    : disabledColor,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${service["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isAvailable 
                                                ? primaryColor 
                                                : disabledColor,
                                          ),
                                        ),
                                      ),
                                      if (!isAvailable)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: dangerColor.withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "Unavailable",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: dangerColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${service["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isAvailable 
                                          ? disabledBoldColor 
                                          : disabledColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${service["rating"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: isAvailable 
                                              ? disabledBoldColor 
                                              : disabledColor,
                                        ),
                                      ),
                                      SizedBox(width: spMd),
                                      Icon(
                                        Icons.schedule,
                                        color: infoColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${service["duration"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isAvailable 
                                              ? disabledBoldColor 
                                              : disabledColor,
                                        ),
                                      ),
                                      Spacer(),
                                      if ((service["price"] as int) > 0)
                                        Text(
                                          "\$${service["price"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isAvailable 
                                                ? primaryColor 
                                                : disabledColor,
                                          ),
                                        )
                                      else
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "Free",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
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
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusMd),
                            bottomRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: QButton(
                          label: isAvailable ? "Book Service" : "Not Available",
                          size: bs.sm,
                          onPressed: isAvailable ? () {
                            ss("${service["title"]} booking started");
                          } : null,
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
    );
  }
}
