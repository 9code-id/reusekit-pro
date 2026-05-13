import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsMapView extends StatefulWidget {
  const BrsMapView({super.key});

  @override
  State<BrsMapView> createState() => _BrsMapViewState();
}

class _BrsMapViewState extends State<BrsMapView> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool showNearbyOnly = true;

  List<Map<String, dynamic>> barbershops = [
    {
      "id": 1,
      "name": "Elite Cuts Barbershop",
      "address": "123 Main Street, Downtown",
      "rating": 4.8,
      "reviews": 245,
      "distance": 0.8,
      "openNow": true,
      "services": ["Haircut", "Beard Trim", "Styling"],
      "priceRange": "\$\$",
      "latitude": 37.7749,
      "longitude": -122.4194,
      "phone": "+1 555-0123",
      "image": "https://picsum.photos/300/200?random=1&keyword=barbershop"
    },
    {
      "id": 2,
      "name": "Modern Gentleman",
      "address": "456 Oak Avenue, Midtown",
      "rating": 4.6,
      "reviews": 189,
      "distance": 1.2,
      "openNow": true,
      "services": ["Premium Cut", "Hot Towel", "Massage"],
      "priceRange": "\$\$\$",
      "latitude": 37.7849,
      "longitude": -122.4094,
      "phone": "+1 555-0456",
      "image": "https://picsum.photos/300/200?random=2&keyword=barbershop"
    },
    {
      "id": 3,
      "name": "Classic Barber Co.",
      "address": "789 Pine Street, Uptown",
      "rating": 4.9,
      "reviews": 312,
      "distance": 2.1,
      "openNow": false,
      "services": ["Traditional Cut", "Straight Razor", "Beard Oil"],
      "priceRange": "\$\$",
      "latitude": 37.7649,
      "longitude": -122.4294,
      "phone": "+1 555-0789",
      "image": "https://picsum.photos/300/200?random=3&keyword=barbershop"
    },
    {
      "id": 4,
      "name": "Quick Trim Studio",
      "address": "321 Cedar Lane, Westside",
      "rating": 4.3,
      "reviews": 98,
      "distance": 3.5,
      "openNow": true,
      "services": ["Express Cut", "Kids Cut", "Student Discount"],
      "priceRange": "\$",
      "latitude": 37.7549,
      "longitude": -122.4394,
      "phone": "+1 555-0321",
      "image": "https://picsum.photos/300/200?random=4&keyword=barbershop"
    },
    {
      "id": 5,
      "name": "Luxury Cuts Lounge",
      "address": "654 Maple Drive, Eastside",
      "rating": 4.7,
      "reviews": 156,
      "distance": 4.2,
      "openNow": true,
      "services": ["VIP Service", "Wine Bar", "Facial"],
      "priceRange": "\$\$\$\$",
      "latitude": 37.7949,
      "longitude": -122.3994,
      "phone": "+1 555-0654",
      "image": "https://picsum.photos/300/200?random=5&keyword=barbershop"
    },
  ];

  List<Map<String, dynamic>> get filteredBarbershops {
    var filtered = barbershops.where((shop) {
      bool matchesSearch = shop["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          shop["address"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" ||
                          (selectedFilter == "Open Now" && shop["openNow"] == true) ||
                          (selectedFilter == "Nearby" && (shop["distance"] as double) <= 2.0) ||
                          (selectedFilter == "Top Rated" && (shop["rating"] as double) >= 4.7);
      
      return matchesSearch && matchesFilter;
    }).toList();

    filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barbershop Map"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              ss("Location updated");
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search barbershops...",
                        prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.tune, color: Colors.white),
                    onPressed: () {
                      _showFilterBottomSheet();
                    },
                  ),
                ),
              ],
            ),
          ),

          // Map Container (Placeholder)
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  // Map Background
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      gradient: LinearGradient(
                        colors: [Colors.blue[100]!, Colors.green[100]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  
                  // Barbershop Markers
                  ...filteredBarbershops.map((barber) {
                    return Positioned(
                      left: ((barber["longitude"] as double) + 122.4194) * 1000,
                      top: (37.7749 - (barber["latitude"] as double)) * 2000 + 200,
                      child: GestureDetector(
                        onTap: () {
                          _showBarberDetails(barber);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: barber["openNow"] ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [shadowMd],
                          ),
                          child: Icon(
                            Icons.content_cut,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  // Map Controls
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              ss("Zoom in");
                            },
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              ss("Zoom out");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Current Location Button
                  Positioned(
                    bottom: spMd,
                    right: spMd,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowMd],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.my_location, color: Colors.white),
                        onPressed: () {
                          ss("Centered to your location");
                        },
                      ),
                    ),
                  ),

                  // Legend
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildLegendItem(successColor, "Open"),
                          SizedBox(width: spSm),
                          _buildLegendItem(dangerColor, "Closed"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Quick Filter Pills
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QHorizontalScroll(
              children: ["All", "Open Now", "Nearby", "Top Rated"].map((filter) {
                bool isSelected = selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    selectedFilter = filter;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Barbershop List
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nearby Barbershops (${filteredBarbershops.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to full list
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredBarbershops.length,
                      itemBuilder: (context, index) {
                        final barber = filteredBarbershops[index];
                        return _buildBarberCard(barber);
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

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBarberCard(Map<String, dynamic> barber) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${barber["image"]}",
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
                        "${barber["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: barber["openNow"] ? successColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        barber["openNow"] ? "Open" : "Closed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${barber["address"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 14),
                    SizedBox(width: 2),
                    Text(
                      "${barber["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      " (${barber["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.location_on, color: infoColor, size: 14),
                    SizedBox(width: 2),
                    Text(
                      "${(barber["distance"] as double).toStringAsFixed(1)} km",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                label: "Book",
                size: bs.sm,
                onPressed: () {
                  // Navigate to booking
                },
              ),
              SizedBox(height: spXs),
              GestureDetector(
                onTap: () {
                  _showBarberDetails(barber);
                },
                child: Text(
                  "Details",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Show nearby only (within 5km)",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Switch(
                        value: showNearbyOnly,
                        onChanged: (value) {
                          showNearbyOnly = value;
                          setModalState(() {});
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Quick Filters",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    children: ["All", "Open Now", "Nearby", "Top Rated"].map((filter) {
                      bool isSelected = selectedFilter == filter;
                      return GestureDetector(
                        onTap: () {
                          selectedFilter = filter;
                          setModalState(() {});
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Reset",
                          color: Colors.grey[400],
                          onPressed: () {
                            selectedFilter = "All";
                            showNearbyOnly = true;
                            setModalState(() {});
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Apply",
                          onPressed: () {
                            back();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showBarberDetails(Map<String, dynamic> barber) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${barber["image"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${barber["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${barber["address"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${barber["rating"]} (${barber["reviews"]} reviews)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Distance",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(barber["distance"] as double).toStringAsFixed(1)} km",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price Range",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${barber["priceRange"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: barber["openNow"] ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            barber["openNow"] ? "Open Now" : "Closed",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "Services",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Wrap(
                spacing: spSm,
                children: (barber["services"] as List).map((service) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$service",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Call",
                      color: infoColor,
                      onPressed: () {
                        ss("Calling ${barber["phone"]}");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Get Directions",
                      color: successColor,
                      onPressed: () {
                        ss("Opening directions");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Book Now",
                      onPressed: () {
                        back();
                        // Navigate to booking
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
