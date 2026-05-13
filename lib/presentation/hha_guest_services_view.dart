import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGuestServicesView extends StatefulWidget {
  const HhaGuestServicesView({super.key});

  @override
  State<HhaGuestServicesView> createState() => _HhaGuestServicesViewState();
}

class _HhaGuestServicesViewState extends State<HhaGuestServicesView> {
  String searchQuery = "";
  String selectedCategory = "all";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Services", "value": "all"},
    {"label": "Room Services", "value": "room"},
    {"label": "Dining", "value": "dining"},
    {"label": "Wellness & Spa", "value": "spa"},
    {"label": "Recreation", "value": "recreation"},
    {"label": "Business", "value": "business"},
    {"label": "Transportation", "value": "transport"},
    {"label": "Concierge", "value": "concierge"},
  ];

  List<Map<String, dynamic>> services = [
    {
      "id": "srv_001",
      "name": "24/7 Room Service",
      "category": "room",
      "description": "Order delicious meals and beverages directly to your room, available around the clock",
      "price": "Menu varies",
      "duration": "30-45 minutes",
      "availability": "24/7",
      "icon": Icons.room_service,
      "image": "https://picsum.photos/300/200?random=1&keyword=room-service",
      "features": ["24/7 Availability", "Extensive Menu", "Hot Delivery", "Special Dietary Options"],
      "rating": 4.8,
      "reviews": 245,
    },
    {
      "id": "srv_002",
      "name": "Spa & Wellness Center",
      "category": "spa",
      "description": "Relax and rejuvenate with our comprehensive spa treatments and wellness facilities",
      "price": "From \$80",
      "duration": "60-90 minutes",
      "availability": "6:00 AM - 10:00 PM",
      "icon": Icons.spa,
      "image": "https://picsum.photos/300/200?random=2&keyword=spa",
      "features": ["Massage Therapy", "Facial Treatments", "Sauna", "Steam Room", "Aromatherapy"],
      "rating": 4.9,
      "reviews": 189,
    },
    {
      "id": "srv_003",
      "name": "Laundry & Dry Cleaning",
      "category": "room",
      "description": "Professional laundry and dry cleaning services with same-day return available",
      "price": "From \$15",
      "duration": "24-48 hours",
      "availability": "6:00 AM - 6:00 PM",
      "icon": Icons.local_laundry_service,
      "image": "https://picsum.photos/300/200?random=3&keyword=laundry",
      "features": ["Same-day Service", "Dry Cleaning", "Pressing", "Stain Removal"],
      "rating": 4.6,
      "reviews": 156,
    },
    {
      "id": "srv_004",
      "name": "Fine Dining Restaurant",
      "category": "dining",
      "description": "Experience exquisite cuisine prepared by our award-winning chefs",
      "price": "From \$45",
      "duration": "1-2 hours",
      "availability": "6:00 PM - 11:00 PM",
      "icon": Icons.restaurant,
      "image": "https://picsum.photos/300/200?random=4&keyword=restaurant",
      "features": ["Award-winning Chef", "Wine Pairing", "Private Dining", "Seasonal Menu"],
      "rating": 4.7,
      "reviews": 312,
    },
    {
      "id": "srv_005",
      "name": "Airport Transfer",
      "category": "transport",
      "description": "Comfortable and reliable transportation to and from the airport",
      "price": "From \$35",
      "duration": "45-60 minutes",
      "availability": "24/7",
      "icon": Icons.airport_shuttle,
      "image": "https://picsum.photos/300/200?random=5&keyword=airport",
      "features": ["Luxury Vehicles", "Professional Drivers", "Flight Tracking", "24/7 Service"],
      "rating": 4.5,
      "reviews": 98,
    },
    {
      "id": "srv_006",
      "name": "Business Center",
      "category": "business",
      "description": "Fully equipped business facilities for meetings and work requirements",
      "price": "From \$25/hour",
      "duration": "Flexible",
      "availability": "24/7",
      "icon": Icons.business_center,
      "image": "https://picsum.photos/300/200?random=6&keyword=business",
      "features": ["Meeting Rooms", "Printing Services", "High-speed Wi-Fi", "Video Conferencing"],
      "rating": 4.4,
      "reviews": 67,
    },
    {
      "id": "srv_007",
      "name": "Swimming Pool & Fitness",
      "category": "recreation",
      "description": "State-of-the-art fitness center and outdoor swimming pool with poolside service",
      "price": "Complimentary",
      "duration": "Unlimited",
      "availability": "5:00 AM - 11:00 PM",
      "icon": Icons.pool,
      "image": "https://picsum.photos/300/200?random=7&keyword=pool",
      "features": ["Olympic Pool", "Modern Gym", "Personal Trainer", "Poolside Bar"],
      "rating": 4.6,
      "reviews": 201,
    },
    {
      "id": "srv_008",
      "name": "Concierge Services",
      "category": "concierge",
      "description": "Personal assistance for reservations, recommendations, and special arrangements",
      "price": "Complimentary",
      "duration": "Varies",
      "availability": "24/7",
      "icon": Icons.room_service,
      "image": "https://picsum.photos/300/200?random=8&keyword=concierge",
      "features": ["Local Recommendations", "Ticket Booking", "Restaurant Reservations", "Tour Planning"],
      "rating": 4.8,
      "reviews": 134,
    },
  ];

  List<Map<String, dynamic>> get filteredServices {
    List<Map<String, dynamic>> filtered = services;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((service) => service["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((service) {
        return service["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               service["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }

  void _bookService(Map<String, dynamic> service) {
    // Navigate to service booking
    ss("Redirecting to ${service["name"]} booking...");
  }

  void _viewServiceDetails(Map<String, dynamic> service) {
    // Navigate to detailed service view
  }

  void _callService(Map<String, dynamic> service) {
    ss("Calling ${service["name"]}...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Services"),
        actions: [
          IconButton(
            onPressed: () {
              // View service history or favorites
            },
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                // Search Bar
                Row(
                  spacing: spSm,
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
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {
                        // Perform search
                      },
                    ),
                  ],
                ),
                
                // Category Filter
                QDropdownField(
                  label: "Filter by Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Quick Access Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Quick Access",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: _buildQuickAccessButton(
                        "Room Service",
                        Icons.room_service,
                        () => _bookService(services[0]),
                      ),
                    ),
                    Expanded(
                      child: _buildQuickAccessButton(
                        "Spa Booking",
                        Icons.spa,
                        () => _bookService(services[1]),
                      ),
                    ),
                    Expanded(
                      child: _buildQuickAccessButton(
                        "Concierge",
                        Icons.room_service,
                        () => _bookService(services[7]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Services List
          Expanded(
            child: filteredServices.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No services found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search or filter criteria",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = filteredServices[index];
                      return _buildServiceCard(service);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButton(String label, IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 28),
            SizedBox(height: spSm),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Service Image and Info
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  bottomLeft: Radius.circular(radiusMd),
                ),
                child: Image.network(
                  "${service["image"]}",
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(service["icon"], color: primaryColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${service["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "${service["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: disabledBoldColor),
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
                      
                      Row(
                        children: [
                          Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${service["availability"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${service["price"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, size: 16, color: Colors.amber),
                              SizedBox(width: spXs),
                              Text(
                                "${(service["rating"] as double).toStringAsFixed(1)} (${service["reviews"]})",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Service Features
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Features:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spSm,
                  runSpacing: spXs,
                  children: (service["features"] as List).map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$feature",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Action Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Book Now",
                    size: bs.sm,
                    onPressed: () => _bookService(service),
                  ),
                ),
                QButton(
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () => _viewServiceDetails(service),
                ),
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () => _callService(service),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
