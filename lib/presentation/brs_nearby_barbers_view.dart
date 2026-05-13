import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsNearbyBarbersView extends StatefulWidget {
  const BrsNearbyBarbersView({super.key});

  @override
  State<BrsNearbyBarbersView> createState() => _BrsNearbyBarbersViewState();
}

class _BrsNearbyBarbersViewState extends State<BrsNearbyBarbersView> {
  String selectedSortBy = "Distance";
  String selectedRadius = "2 km";
  bool showOpenOnly = false;
  
  List<Map<String, dynamic>> nearbyBarbers = [
    {
      "id": 1,
      "name": "Elite Cuts Barbershop",
      "rating": 4.8,
      "reviews": 156,
      "distance": "0.5 km",
      "estimatedTime": "5 min walk",
      "price": "\$25-35",
      "isOpen": true,
      "nextAvailable": "Available now",
      "image": "https://picsum.photos/300/200?random=1&keyword=barbershop",
      "specialties": ["Classic Cut", "Beard Trim", "Hot Towel"],
      "openTime": "9:00 AM",
      "closeTime": "8:00 PM",
      "isFavorite": true,
    },
    {
      "id": 2,
      "name": "Modern Grooming Studio",
      "rating": 4.9,
      "reviews": 203,
      "distance": "1.2 km",
      "estimatedTime": "12 min walk",
      "price": "\$30-45",
      "isOpen": true,
      "nextAvailable": "Available in 30 min",
      "image": "https://picsum.photos/300/200?random=2&keyword=barbershop",
      "specialties": ["Fade Cut", "Styling", "Beard Design"],
      "openTime": "8:00 AM",
      "closeTime": "9:00 PM",
      "isFavorite": false,
    },
    {
      "id": 3,
      "name": "Traditional Barber Co",
      "rating": 4.7,
      "reviews": 89,
      "distance": "1.8 km",
      "estimatedTime": "18 min walk",
      "price": "\$20-30",
      "isOpen": false,
      "nextAvailable": "Opens at 9:00 AM",
      "image": "https://picsum.photos/300/200?random=3&keyword=barbershop",
      "specialties": ["Traditional Cut", "Mustache", "Shave"],
      "openTime": "9:00 AM",
      "closeTime": "7:00 PM",
      "isFavorite": false,
    },
    {
      "id": 4,
      "name": "Premium Cuts Salon",
      "rating": 4.6,
      "reviews": 134,
      "distance": "2.5 km",
      "estimatedTime": "25 min walk",
      "price": "\$35-50",
      "isOpen": true,
      "nextAvailable": "Available in 1 hour",
      "image": "https://picsum.photos/300/200?random=4&keyword=barbershop",
      "specialties": ["Premium Styling", "Hair Treatment", "Massage"],
      "openTime": "10:00 AM",
      "closeTime": "10:00 PM",
      "isFavorite": true,
    },
    {
      "id": 5,
      "name": "Quick Trim Express",
      "rating": 4.4,
      "reviews": 67,
      "distance": "2.8 km",
      "estimatedTime": "8 min drive",
      "price": "\$15-25",
      "isOpen": true,
      "nextAvailable": "Available now",
      "image": "https://picsum.photos/300/200?random=5&keyword=barbershop",
      "specialties": ["Quick Cut", "Basic Trim", "Wash"],
      "openTime": "7:00 AM",
      "closeTime": "6:00 PM",
      "isFavorite": false,
    },
  ];

  List<String> sortOptions = ["Distance", "Rating", "Price (Low to High)", "Price (High to Low)", "Availability"];
  List<String> radiusOptions = ["1 km", "2 km", "5 km", "10 km", "All"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Barbers"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              si("Opening map view");
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              _showFilterSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Location & Quick Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 18,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Your Location - Downtown NYC",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        si("Change location");
                      },
                      child: Text(
                        "Change",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Text(
                      "${nearbyBarbers.length} barbers within $selectedRadius",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showOpenOnly = !showOpenOnly;
                        setState(() {});
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            showOpenOnly ? Icons.check_box : Icons.check_box_outline_blank,
                            color: showOpenOnly ? primaryColor : disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Open now",
                            style: TextStyle(
                              fontSize: 12,
                              color: showOpenOnly ? primaryColor : disabledBoldColor,
                              fontWeight: showOpenOnly ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Sort Bar
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Text(
                  "Sort by:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QHorizontalScroll(
                    children: sortOptions.map((option) {
                      bool isSelected = selectedSortBy == option;
                      return Container(
                        margin: EdgeInsets.only(right: spSm),
                        child: GestureDetector(
                          onTap: () {
                            selectedSortBy = option;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          
          // Barbers List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: nearbyBarbers.length,
              itemBuilder: (context, index) {
                final barber = nearbyBarbers[index];
                
                if (showOpenOnly && !(barber["isOpen"] as bool)) {
                  return SizedBox.shrink();
                }
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image & Basic Info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              bottomLeft: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${barber["image"]}",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${barber["name"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          barber["isFavorite"] = !(barber["isFavorite"] as bool);
                                          setState(() {});
                                          ss(barber["isFavorite"] as bool ? "Added to favorites" : "Removed from favorites");
                                        },
                                        child: Icon(
                                          (barber["isFavorite"] as bool) ? Icons.favorite : Icons.favorite_border,
                                          color: (barber["isFavorite"] as bool) ? dangerColor : disabledBoldColor,
                                          size: 20,
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
                                        "${barber["rating"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
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
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: (barber["isOpen"] as bool) ? successColor : dangerColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          (barber["isOpen"] as bool) ? "Open" : "Closed",
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
                                  
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, color: primaryColor, size: 14),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${barber["distance"]} • ${barber["estimatedTime"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: spXs),
                                  
                                  Text(
                                    "${barber["price"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Specialties
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Specialties:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              height: 25,
                              child: QHorizontalScroll(
                                children: (barber["specialties"] as List).map((specialty) {
                                  return Container(
                                    margin: EdgeInsets.only(right: spXs),
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$specialty",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Availability & Actions
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${barber["nextAvailable"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: (barber["isOpen"] as bool) ? successColor : dangerColor,
                                    ),
                                  ),
                                  Text(
                                    "Hours: ${barber["openTime"]} - ${barber["closeTime"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                QButton(
                                  icon: Icons.call,
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Calling ${barber["name"]}");
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.directions,
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Getting directions");
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  label: "Book",
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Booking appointment at ${barber["name"]}");
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
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Filter Options",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Search Radius",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 35,
                    child: QHorizontalScroll(
                      children: radiusOptions.map((radius) {
                        bool isSelected = selectedRadius == radius;
                        return Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              selectedRadius = radius;
                              setModalState(() {});
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Text(
                                radius,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show open barbers only",
                              "value": true,
                              "checked": showOpenOnly,
                            }
                          ],
                          value: [if (showOpenOnly) {"label": "Show open barbers only", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            showOpenOnly = values.isNotEmpty;
                            setModalState(() {});
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Apply Filters",
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Filters applied");
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
