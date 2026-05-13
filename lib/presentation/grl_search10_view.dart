import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSearch10View extends StatefulWidget {
  @override
  State<GrlSearch10View> createState() => _GrlSearch10ViewState();
}

class _GrlSearch10ViewState extends State<GrlSearch10View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedCondition = "All";
  String selectedPriceRange = "All";
  String selectedLocation = "All";
  String sortBy = "Latest";
  bool showMyListings = false;

  List<Map<String, dynamic>> vehicles = [
    {
      "id": 1,
      "title": "2020 Toyota Camry Hybrid",
      "category": "Cars",
      "condition": "Excellent",
      "price": 25000.0,
      "mileage": 45000,
      "year": 2020,
      "location": "Downtown",
      "seller": "AutoDealer Plus",
      "images": [
        "https://picsum.photos/400/300?random=1&keyword=car",
        "https://picsum.photos/400/300?random=11&keyword=car",
        "https://picsum.photos/400/300?random=21&keyword=car"
      ],
      "description": "Well-maintained hybrid sedan with excellent fuel economy",
      "features": ["Hybrid Engine", "Backup Camera", "Lane Assist", "Apple CarPlay"],
      "rating": 4.8,
      "verified": true,
      "posted": "2 days ago",
      "views": 156,
      "inquiries": 12
    },
    {
      "id": 2,
      "title": "2019 Honda Civic Sport",
      "category": "Cars",
      "condition": "Good",
      "price": 18500.0,
      "mileage": 62000,
      "year": 2019,
      "location": "Midtown",
      "seller": "Private Seller",
      "images": [
        "https://picsum.photos/400/300?random=2&keyword=honda",
        "https://picsum.photos/400/300?random=12&keyword=honda"
      ],
      "description": "Sporty and reliable compact car, perfect for daily commuting",
      "features": ["Sport Mode", "Sunroof", "Heated Seats", "Bluetooth"],
      "rating": 4.6,
      "verified": false,
      "posted": "5 days ago",
      "views": 89,
      "inquiries": 8
    },
    {
      "id": 3,
      "title": "2021 Ford F-150 XLT",
      "category": "Trucks",
      "condition": "Like New",
      "price": 35000.0,
      "mileage": 28000,
      "year": 2021,
      "location": "Suburbs",
      "seller": "Truck Central",
      "images": [
        "https://picsum.photos/400/300?random=3&keyword=truck",
        "https://picsum.photos/400/300?random=13&keyword=truck",
        "https://picsum.photos/400/300?random=23&keyword=truck"
      ],
      "description": "Powerful pickup truck with towing capacity and modern features",
      "features": ["4WD", "Tow Package", "Crew Cab", "Navigation"],
      "rating": 4.9,
      "verified": true,
      "posted": "1 day ago",
      "views": 234,
      "inquiries": 18
    },
    {
      "id": 4,
      "title": "2018 BMW X3 M40i",
      "category": "SUVs",
      "condition": "Good",
      "price": 32000.0,
      "mileage": 55000,
      "year": 2018,
      "location": "Uptown",
      "seller": "Luxury Motors",
      "images": [
        "https://picsum.photos/400/300?random=4&keyword=bmw",
        "https://picsum.photos/400/300?random=14&keyword=bmw"
      ],
      "description": "Luxury SUV with premium features and performance",
      "features": ["Premium Package", "Panoramic Roof", "Leather Seats", "M Sport"],
      "rating": 4.7,
      "verified": true,
      "posted": "3 days ago",
      "views": 178,
      "inquiries": 15
    },
    {
      "id": 5,
      "title": "2017 Harley Davidson Street 750",
      "category": "Motorcycles",
      "condition": "Good",
      "price": 6500.0,
      "mileage": 12000,
      "year": 2017,
      "location": "Downtown",
      "seller": "Bike World",
      "images": [
        "https://picsum.photos/400/300?random=5&keyword=motorcycle",
        "https://picsum.photos/400/300?random=15&keyword=motorcycle"
      ],
      "description": "Classic Harley with low miles and great sound",
      "features": ["LED Lights", "Custom Exhaust", "Windshield", "Saddlebags"],
      "rating": 4.5,
      "verified": true,
      "posted": "1 week ago",
      "views": 92,
      "inquiries": 6
    },
    {
      "id": 6,
      "title": "2022 Tesla Model 3 Long Range",
      "category": "Electric",
      "condition": "Like New",
      "price": 42000.0,
      "mileage": 15000,
      "year": 2022,
      "location": "Tech District",
      "seller": "EV Solutions",
      "images": [
        "https://picsum.photos/400/300?random=6&keyword=tesla",
        "https://picsum.photos/400/300?random=16&keyword=tesla",
        "https://picsum.photos/400/300?random=26&keyword=tesla"
      ],
      "description": "Premium electric vehicle with autopilot and supercharging",
      "features": ["Autopilot", "Premium Interior", "Glass Roof", "Supercharging"],
      "rating": 4.9,
      "verified": true,
      "posted": "4 days ago",
      "views": 298,
      "inquiries": 24
    }
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "All"},
    {"label": "Cars", "value": "Cars"},
    {"label": "Trucks", "value": "Trucks"},
    {"label": "SUVs", "value": "SUVs"},
    {"label": "Motorcycles", "value": "Motorcycles"},
    {"label": "Electric", "value": "Electric"},
  ];

  List<Map<String, dynamic>> conditionItems = [
    {"label": "All Conditions", "value": "All"},
    {"label": "Like New", "value": "Like New"},
    {"label": "Excellent", "value": "Excellent"},
    {"label": "Good", "value": "Good"},
    {"label": "Fair", "value": "Fair"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "All Prices", "value": "All"},
    {"label": "Under \$10K", "value": "Under 10000"},
    {"label": "\$10K - \$25K", "value": "10000-25000"},
    {"label": "\$25K - \$50K", "value": "25000-50000"},
    {"label": "Over \$50K", "value": "Over 50000"},
  ];

  List<Map<String, dynamic>> locationItems = [
    {"label": "All Locations", "value": "All"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Midtown", "value": "Midtown"},
    {"label": "Uptown", "value": "Uptown"},
    {"label": "Suburbs", "value": "Suburbs"},
    {"label": "Tech District", "value": "Tech District"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Latest", "value": "Latest"},
    {"label": "Price: Low to High", "value": "Price Low"},
    {"label": "Price: High to Low", "value": "Price High"},
    {"label": "Mileage: Low to High", "value": "Mileage Low"},
    {"label": "Year: Newest First", "value": "Year New"},
  ];

  List<Map<String, dynamic>> get filteredVehicles {
    List<Map<String, dynamic>> filtered = vehicles.where((vehicle) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${vehicle["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${vehicle["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${vehicle["seller"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All" || vehicle["category"] == selectedCategory;
      bool matchesCondition = selectedCondition == "All" || vehicle["condition"] == selectedCondition;
      bool matchesLocation = selectedLocation == "All" || vehicle["location"] == selectedLocation;
      
      bool matchesPrice = selectedPriceRange == "All" ||
          (selectedPriceRange == "Under 10000" && (vehicle["price"] as double) < 10000) ||
          (selectedPriceRange == "10000-25000" && (vehicle["price"] as double) >= 10000 && (vehicle["price"] as double) <= 25000) ||
          (selectedPriceRange == "25000-50000" && (vehicle["price"] as double) >= 25000 && (vehicle["price"] as double) <= 50000) ||
          (selectedPriceRange == "Over 50000" && (vehicle["price"] as double) > 50000);

      return matchesSearch && matchesCategory && matchesCondition && matchesLocation && matchesPrice;
    }).toList();

    // Apply sorting
    if (sortBy == "Price Low") {
      filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
    } else if (sortBy == "Price High") {
      filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
    } else if (sortBy == "Mileage Low") {
      filtered.sort((a, b) => (a["mileage"] as int).compareTo(b["mileage"] as int));
    } else if (sortBy == "Year New") {
      filtered.sort((a, b) => (b["year"] as int).compareTo(a["year"] as int));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Marketplace"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterSheet();
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
              label: "Search vehicles...",
              value: searchQuery,
              hint: "Car model, brand, or keyword...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Quick Filters
            QCategoryPicker(
              label: "Vehicle Type",
              items: const [
                {"label": "All", "value": "All"},
                {"label": "Cars", "value": "Cars"},
                {"label": "Trucks", "value": "Trucks"},
                {"label": "SUVs", "value": "SUVs"},
                {"label": "Motorcycles", "value": "Motorcycles"},
                {"label": "Electric", "value": "Electric"},
              ],
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Filter and Sort Row
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortItems,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
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
              ],
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
                  Icon(Icons.directions_car, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "${filteredVehicles.length} vehicles available",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  if (searchQuery.isNotEmpty || selectedCategory != "All" || selectedCondition != "All" || selectedLocation != "All" || selectedPriceRange != "All")
                    GestureDetector(
                      onTap: () {
                        searchQuery = "";
                        selectedCategory = "All";
                        selectedCondition = "All";
                        selectedLocation = "All";
                        selectedPriceRange = "All";
                        setState(() {});
                      },
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Vehicle List
            if (filteredVehicles.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 48, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No vehicles found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                  ],
                ),
              )
            else
              ...filteredVehicles.map((vehicle) {
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
                      // Vehicle Images
                      if (vehicle["images"] != null && (vehicle["images"] as List).isNotEmpty)
                        Container(
                          height: 200,
                          child: QHorizontalScroll(
                            children: (vehicle["images"] as List).map((imageUrl) {
                              return Container(
                                width: 300,
                                margin: EdgeInsets.only(right: spSm),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "$imageUrl",
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                      SizedBox(height: spSm),

                      // Vehicle Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${vehicle["title"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (vehicle["verified"] == true)
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
                                  "${vehicle["year"]} • ${((vehicle["mileage"] as int) / 1000).toInt()}K miles • ${vehicle["condition"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${((vehicle["price"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${vehicle["seller"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Vehicle Description
                      Text(
                        "${vehicle["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Vehicle Details
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.location_on, color: primaryColor, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  "${vehicle["location"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.remove_red_eye, color: disabledBoldColor, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "${vehicle["views"]} views",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Row(
                            children: [
                              Icon(Icons.message, color: disabledBoldColor, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "${vehicle["inquiries"]} inquiries",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Vehicle Features
                      if (vehicle["features"] != null && (vehicle["features"] as List).isNotEmpty)
                        Column(
                          children: [
                            SizedBox(height: spSm),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (vehicle["features"] as List).take(4).map((feature) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(color: infoColor.withAlpha(40)),
                                  ),
                                  child: Text(
                                    "$feature",
                                    style: TextStyle(
                                      color: infoColor,
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
                              label: "Contact Seller",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.favorite_border,
                            size: bs.sm,
                            onPressed: () {},
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

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                  SizedBox(height: spMd),

                  Text(
                    "Filter Vehicles",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Condition Filter
                  QDropdownField(
                    label: "Condition",
                    items: conditionItems,
                    value: selectedCondition,
                    onChanged: (value, label) {
                      selectedCondition = value;
                      setModalState(() {});
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Price Range Filter
                  QDropdownField(
                    label: "Price Range",
                    items: priceRangeItems,
                    value: selectedPriceRange,
                    onChanged: (value, label) {
                      selectedPriceRange = value;
                      setModalState(() {});
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),

                  // Apply Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Apply Filters",
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: spSm),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
