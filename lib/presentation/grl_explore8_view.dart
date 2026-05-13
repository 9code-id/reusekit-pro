import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExplore8View extends StatefulWidget {
  @override
  State<GrlExplore8View> createState() => _GrlExplore8ViewState();
}

class _GrlExplore8ViewState extends State<GrlExplore8View> {
  String searchQuery = "";
  String selectedCategory = "All Categories";
  String selectedLocation = "All Locations";
  String selectedType = "All Types";
  String selectedPrice = "All Prices";
  bool showAvailableOnly = true;
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Fitness", "value": "Fitness"},
    {"label": "Beauty & Spa", "value": "Beauty"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "Dining", "value": "Dining"},
    {"label": "Education", "value": "Education"},
    {"label": "Health", "value": "Health"},
    {"label": "Auto", "value": "Auto"},
  ];
  
  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Midtown", "value": "Midtown"},
    {"label": "Uptown", "value": "Uptown"},
    {"label": "Westside", "value": "Westside"},
    {"label": "Eastside", "value": "Eastside"},
  ];
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Single Service", "value": "Single"},
    {"label": "Package Deal", "value": "Package"},
    {"label": "Membership", "value": "Membership"},
    {"label": "Class/Course", "value": "Class"},
  ];
  
  List<Map<String, dynamic>> priceOptions = [
    {"label": "All Prices", "value": "All Prices"},
    {"label": "Under \$25", "value": "Under 25"},
    {"label": "\$25 - \$50", "value": "25-50"},
    {"label": "\$50 - \$100", "value": "50-100"},
    {"label": "Over \$100", "value": "Over 100"},
  ];
  
  List<Map<String, dynamic>> services = [
    {
      "id": 1,
      "title": "Full Body Massage",
      "business": "Zen Spa & Wellness",
      "category": "Beauty",
      "location": "Downtown",
      "type": "Single",
      "originalPrice": 120,
      "discountedPrice": 60,
      "discountPercent": 50,
      "rating": 4.8,
      "reviews": 342,
      "duration": "60 minutes",
      "availableSlots": 8,
      "distance": "1.2 miles",
      "image": "https://picsum.photos/400/250?random=1&keyword=spa",
      "highlights": ["Deep Tissue", "Hot Stone", "Aromatherapy"],
      "validUntil": "July 31, 2025",
      "purchased": 1247,
      "isPopular": true,
      "isNew": false,
    },
    {
      "id": 2,
      "title": "Personal Training Session",
      "business": "FitZone Gym",
      "category": "Fitness",
      "location": "Midtown",
      "type": "Single",
      "originalPrice": 80,
      "discountedPrice": 40,
      "discountPercent": 50,
      "rating": 4.6,
      "reviews": 189,
      "duration": "45 minutes",
      "availableSlots": 12,
      "distance": "0.8 miles",
      "image": "https://picsum.photos/400/250?random=2&keyword=gym",
      "highlights": ["One-on-One", "Custom Plan", "Progress Tracking"],
      "validUntil": "August 15, 2025",
      "purchased": 564,
      "isPopular": false,
      "isNew": true,
    },
    {
      "id": 3,
      "title": "Cooking Class - Italian Cuisine",
      "business": "Culinary Arts Studio",
      "category": "Education",
      "location": "Uptown",
      "type": "Class",
      "originalPrice": 95,
      "discountedPrice": 47,
      "discountPercent": 50,
      "rating": 4.9,
      "reviews": 278,
      "duration": "3 hours",
      "availableSlots": 6,
      "distance": "2.1 miles",
      "image": "https://picsum.photos/400/250?random=3&keyword=cooking",
      "highlights": ["Hands-on", "Take Home Food", "Wine Pairing"],
      "validUntil": "September 30, 2025",
      "purchased": 423,
      "isPopular": true,
      "isNew": false,
    },
    {
      "id": 4,
      "title": "Movie Night for Two",
      "business": "Premium Cinemas",
      "category": "Entertainment",
      "location": "Westside",
      "type": "Package",
      "originalPrice": 45,
      "discountedPrice": 25,
      "discountPercent": 44,
      "rating": 4.4,
      "reviews": 567,
      "duration": "2.5 hours",
      "availableSlots": 24,
      "distance": "1.5 miles",
      "image": "https://picsum.photos/400/250?random=4&keyword=cinema",
      "highlights": ["Premium Seats", "Popcorn & Drinks", "Latest Movies"],
      "validUntil": "July 20, 2025",
      "purchased": 2134,
      "isPopular": true,
      "isNew": false,
    },
    {
      "id": 5,
      "title": "Car Detailing Service",
      "business": "Auto Shine Pro",
      "category": "Auto",
      "location": "Eastside",
      "type": "Single",
      "originalPrice": 150,
      "discountedPrice": 75,
      "discountPercent": 50,
      "rating": 4.7,
      "reviews": 234,
      "duration": "2 hours",
      "availableSlots": 4,
      "distance": "3.2 miles",
      "image": "https://picsum.photos/400/250?random=5&keyword=car",
      "highlights": ["Interior & Exterior", "Wax Coating", "Pickup & Drop"],
      "validUntil": "August 10, 2025",
      "purchased": 156,
      "isPopular": false,
      "isNew": true,
    },
    {
      "id": 6,
      "title": "Dental Cleaning Package",
      "business": "Bright Smile Clinic",
      "category": "Health",
      "location": "Downtown",
      "type": "Package",
      "originalPrice": 200,
      "discountedPrice": 89,
      "discountPercent": 55,
      "rating": 4.5,
      "reviews": 445,
      "duration": "90 minutes",
      "availableSlots": 0,
      "distance": "0.5 miles",
      "image": "https://picsum.photos/400/250?random=6&keyword=dental",
      "highlights": ["Professional Cleaning", "Fluoride Treatment", "Consultation"],
      "validUntil": "December 31, 2025",
      "purchased": 789,
      "isPopular": false,
      "isNew": false,
    },
  ];
  
  List<Map<String, dynamic>> get filteredServices {
    return services.where((service) {
      bool matchesSearch = service["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          service["business"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All Categories" || service["category"] == selectedCategory;
      bool matchesLocation = selectedLocation == "All Locations" || service["location"] == selectedLocation;
      bool matchesType = selectedType == "All Types" || service["type"] == selectedType;
      bool matchesAvailable = !showAvailableOnly || (service["availableSlots"] as int) > 0;
      
      return matchesSearch && matchesCategory && matchesLocation && matchesType && matchesAvailable;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Services"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.map),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Deal Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Limited Time",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Up to 70% Off",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Local Services & Experiences",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Ends in 2 days",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.local_offer,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Search Bar
            QTextField(
              label: "Search services, businesses...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Category Pills
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QCategoryPicker(
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Filters Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locationOptions,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Service Type",
                    items: typeOptions,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Available Only Toggle
            Row(
              children: [
                Text(
                  "Show available services only",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Switch(
                  value: showAvailableOnly,
                  onChanged: (value) {
                    showAvailableOnly = value;
                    setState(() {});
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Results Header
            Row(
              children: [
                Text(
                  "${filteredServices.length} Services Found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        "Sort by Discount",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        Icons.sort,
                        color: secondaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Services List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                bool isAvailable = (service["availableSlots"] as int) > 0;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: !isAvailable ? Border.all(
                      color: disabledColor,
                      width: 1,
                    ) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Image with Badges
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${service["image"]}",
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                  color: !isAvailable ? Colors.grey.withAlpha(100) : null,
                                  colorBlendMode: !isAvailable ? BlendMode.overlay : null,
                                ),
                                if (!isAvailable)
                                  Container(
                                    width: double.infinity,
                                    height: 180,
                                    color: Colors.grey.withAlpha(100),
                                    child: Center(
                                      child: Text(
                                        "SOLD OUT",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          
                          // Discount Badge
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${service["discountPercent"]}% OFF",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          
                          // Status Badges
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (service["isNew"])
                                  Container(
                                    margin: EdgeInsets.only(bottom: spXs),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: infoColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "NEW",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                if (service["isPopular"])
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "Popular",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      // Service Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Business
                            Text(
                              "${service["title"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isAvailable ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "${service["business"]}",
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Rating and Reviews
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
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${service["reviews"]})",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${service["purchased"]} purchased",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Details Row
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${service["duration"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${service["distance"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                if (isAvailable)
                                  Text(
                                    "${service["availableSlots"]} slots left",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Price Section
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${service["discountedPrice"]}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: isAvailable ? successColor : disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "\$${service["originalPrice"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Valid until ${service["validUntil"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Highlights
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (service["highlights"] as List).map((highlight) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(
                                      color: primaryColor.withAlpha(50),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    "$highlight",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Action Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: isAvailable ? "Purchase Deal" : "Sold Out",
                                size: bs.sm,
                                onPressed: isAvailable ? () {} : null,
                              ),
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
