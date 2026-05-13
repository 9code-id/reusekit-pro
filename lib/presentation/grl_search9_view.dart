import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSearch9View extends StatefulWidget {
  @override
  State<GrlSearch9View> createState() => _GrlSearch9ViewState();
}

class _GrlSearch9ViewState extends State<GrlSearch9View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLocation = "All";
  String selectedPriceRange = "All";
  String selectedRating = "All";
  bool showFavorites = false;

  List<Map<String, dynamic>> services = [
    {
      "id": 1,
      "name": "Premium House Cleaning",
      "category": "Cleaning",
      "provider": "CleanPro Services",
      "rating": 4.9,
      "reviews": 156,
      "price": 85.0,
      "location": "Downtown",
      "image": "https://picsum.photos/300/200?random=1&keyword=cleaning",
      "description": "Professional deep cleaning service for your home",
      "verified": true,
      "responseTime": "Within 2 hours",
      "availability": "Available Today",
      "tags": ["Eco-friendly", "Insured", "Background Check"]
    },
    {
      "id": 2,
      "name": "Home Plumbing Repair",
      "category": "Plumbing",
      "provider": "FixIt Fast",
      "rating": 4.7,
      "reviews": 89,
      "price": 120.0,
      "location": "Midtown",
      "image": "https://picsum.photos/300/200?random=2&keyword=plumbing",
      "description": "24/7 emergency plumbing services",
      "verified": true,
      "responseTime": "Within 1 hour",
      "availability": "24/7 Available",
      "tags": ["Emergency", "Licensed", "Warranty"]
    },
    {
      "id": 3,
      "name": "Electrical Installation",
      "category": "Electrical",
      "provider": "PowerUp Electric",
      "rating": 4.8,
      "reviews": 124,
      "price": 95.0,
      "location": "Uptown",
      "image": "https://picsum.photos/300/200?random=3&keyword=electrical",
      "description": "Complete electrical installation and repair",
      "verified": true,
      "responseTime": "Same day",
      "availability": "Mon-Sat 8AM-8PM",
      "tags": ["Certified", "Safety First", "Guarantee"]
    },
    {
      "id": 4,
      "name": "Garden Landscaping",
      "category": "Gardening",
      "provider": "Green Thumb Co.",
      "rating": 4.6,
      "reviews": 73,
      "price": 200.0,
      "location": "Suburbs",
      "image": "https://picsum.photos/300/200?random=4&keyword=gardening",
      "description": "Transform your outdoor space beautifully",
      "verified": true,
      "responseTime": "Within 24 hours",
      "availability": "Weekdays 9AM-5PM",
      "tags": ["Design", "Maintenance", "Seasonal"]
    },
    {
      "id": 5,
      "name": "AC Repair & Maintenance",
      "category": "HVAC",
      "provider": "Cool Air Solutions",
      "rating": 4.9,
      "reviews": 198,
      "price": 75.0,
      "location": "Downtown",
      "image": "https://picsum.photos/300/200?random=5&keyword=aircon",
      "description": "Professional AC repair and maintenance",
      "verified": true,
      "responseTime": "Within 3 hours",
      "availability": "Available Today",
      "tags": ["Fast Service", "Parts Warranty", "Experienced"]
    },
    {
      "id": 6,
      "name": "Interior Painting",
      "category": "Painting",
      "provider": "Color Masters",
      "rating": 4.8,
      "reviews": 145,
      "price": 150.0,
      "location": "Midtown",
      "image": "https://picsum.photos/300/200?random=6&keyword=painting",
      "description": "High-quality interior painting services",
      "verified": true,
      "responseTime": "Next day",
      "availability": "Mon-Fri 8AM-6PM",
      "tags": ["Quality Paint", "Clean Work", "Free Estimate"]
    }
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Cleaning", "value": "Cleaning"},
    {"label": "Plumbing", "value": "Plumbing"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "Gardening", "value": "Gardening"},
    {"label": "HVAC", "value": "HVAC"},
    {"label": "Painting", "value": "Painting"},
  ];

  List<Map<String, dynamic>> locationItems = [
    {"label": "All Locations", "value": "All"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Midtown", "value": "Midtown"},
    {"label": "Uptown", "value": "Uptown"},
    {"label": "Suburbs", "value": "Suburbs"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "All Prices", "value": "All"},
    {"label": "Under \$100", "value": "Under 100"},
    {"label": "\$100 - \$200", "value": "100-200"},
    {"label": "Over \$200", "value": "Over 200"},
  ];

  List<Map<String, dynamic>> ratingItems = [
    {"label": "All Ratings", "value": "All"},
    {"label": "4.5+ Stars", "value": "4.5+"},
    {"label": "4.0+ Stars", "value": "4.0+"},
    {"label": "3.5+ Stars", "value": "3.5+"},
  ];

  List<Map<String, dynamic>> get filteredServices {
    return services.where((service) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${service["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${service["provider"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${service["description"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All" || service["category"] == selectedCategory;
      bool matchesLocation = selectedLocation == "All" || service["location"] == selectedLocation;
      
      bool matchesPrice = selectedPriceRange == "All" ||
          (selectedPriceRange == "Under 100" && (service["price"] as double) < 100) ||
          (selectedPriceRange == "100-200" && (service["price"] as double) >= 100 && (service["price"] as double) <= 200) ||
          (selectedPriceRange == "Over 200" && (service["price"] as double) > 200);

      bool matchesRating = selectedRating == "All" ||
          (selectedRating == "4.5+" && (service["rating"] as double) >= 4.5) ||
          (selectedRating == "4.0+" && (service["rating"] as double) >= 4.0) ||
          (selectedRating == "3.5+" && (service["rating"] as double) >= 3.5);

      return matchesSearch && matchesCategory && matchesLocation && matchesPrice && matchesRating;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Services"),
        actions: [
          IconButton(
            icon: Icon(showFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              showFavorites = !showFavorites;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search services...",
              value: searchQuery,
              hint: "Cleaning, plumbing, electrical...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Category Filter
            QCategoryPicker(
              label: "Service Category",
              items: const [
                {"label": "All", "value": "All"},
                {"label": "Cleaning", "value": "Cleaning"},
                {"label": "Plumbing", "value": "Plumbing"},
                {"label": "Electrical", "value": "Electrical"},
                {"label": "HVAC", "value": "HVAC"},
                {"label": "Painting", "value": "Painting"},
              ],
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Filters Row
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locationItems,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Price Range",
                    items: priceRangeItems,
                    value: selectedPriceRange,
                    onChanged: (value, label) {
                      selectedPriceRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Rating Filter
            QDropdownField(
              label: "Minimum Rating",
              items: ratingItems,
              value: selectedRating,
              onChanged: (value, label) {
                selectedRating = value;
                setState(() {});
              },
            ),

            // Results Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "${filteredServices.length} services found",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  if (searchQuery.isNotEmpty || selectedCategory != "All" || selectedLocation != "All" || selectedPriceRange != "All" || selectedRating != "All")
                    GestureDetector(
                      onTap: () {
                        searchQuery = "";
                        selectedCategory = "All";
                        selectedLocation = "All";
                        selectedPriceRange = "All";
                        selectedRating = "All";
                        setState(() {});
                      },
                      child: Text(
                        "Clear Filters",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Service List
            if (filteredServices.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 48, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No services found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                  ],
                ),
              )
            else
              ...filteredServices.map((service) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Header
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${service["image"]}",
                              width: 60,
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
                                        "${service["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (service["verified"] == true)
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "VERIFIED",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${service["provider"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: warningColor, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      "${service["rating"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "(${service["reviews"]} reviews)",
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

                      // Service Description
                      Text(
                        "${service["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Service Details
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on, color: primaryColor, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      "${service["location"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, color: primaryColor, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      "${service["responseTime"]}",
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${((service["price"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${service["availability"]}",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Service Tags
                      if (service["tags"] != null && (service["tags"] as List).isNotEmpty)
                        Column(
                          children: [
                            SizedBox(height: spSm),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (service["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(color: primaryColor.withAlpha(40)),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                      SizedBox(height: spSm),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Book Now",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
