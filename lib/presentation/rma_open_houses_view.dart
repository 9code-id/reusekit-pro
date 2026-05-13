import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaOpenHousesView extends StatefulWidget {
  const RmaOpenHousesView({super.key});

  @override
  State<RmaOpenHousesView> createState() => _RmaOpenHousesViewState();
}

class _RmaOpenHousesViewState extends State<RmaOpenHousesView> {
  String selectedFilter = "All";
  String selectedMonth = "November";
  String searchQuery = "";
  int selectedCalendarDay = 15;

  List<Map<String, dynamic>> openHouses = [
    {
      "id": "1",
      "property": "Modern Downtown Condo",
      "address": "123 Main Street, Downtown",
      "price": 450000,
      "date": "2024-11-15",
      "time": "10:00 AM - 12:00 PM",
      "status": "Scheduled",
      "attendees": 12,
      "maxAttendees": 20,
      "agent": "Sarah Johnson",
      "images": ["https://picsum.photos/300/200?random=1&keyword=condo"],
      "bedrooms": 2,
      "bathrooms": 2,
      "sqft": 1200,
      "type": "Condo"
    },
    {
      "id": "2",
      "property": "Luxury Family Home",
      "address": "456 Oak Avenue, Suburbs",
      "price": 750000,
      "date": "2024-11-16",
      "time": "2:00 PM - 4:00 PM",
      "status": "Active",
      "attendees": 8,
      "maxAttendees": 15,
      "agent": "Michael Chen",
      "images": ["https://picsum.photos/300/200?random=2&keyword=house"],
      "bedrooms": 4,
      "bathrooms": 3,
      "sqft": 2800,
      "type": "House"
    },
    {
      "id": "3",
      "property": "Charming Townhouse",
      "address": "789 Pine Street, Midtown",
      "price": 525000,
      "date": "2024-11-17",
      "time": "11:00 AM - 1:00 PM",
      "status": "Completed",
      "attendees": 15,
      "maxAttendees": 18,
      "agent": "Emily Rodriguez",
      "images": ["https://picsum.photos/300/200?random=3&keyword=townhouse"],
      "bedrooms": 3,
      "bathrooms": 2,
      "sqft": 1800,
      "type": "Townhouse"
    },
    {
      "id": "4",
      "property": "Waterfront Villa",
      "address": "321 Beach Road, Waterfront",
      "price": 1200000,
      "date": "2024-11-18",
      "time": "1:00 PM - 3:00 PM",
      "status": "Cancelled",
      "attendees": 0,
      "maxAttendees": 25,
      "agent": "David Wilson",
      "images": ["https://picsum.photos/300/200?random=4&keyword=villa"],
      "bedrooms": 5,
      "bathrooms": 4,
      "sqft": 3500,
      "type": "Villa"
    },
    {
      "id": "5",
      "property": "Urban Loft Space",
      "address": "654 Industrial Way, Arts District",
      "price": 380000,
      "date": "2024-11-19",
      "time": "3:00 PM - 5:00 PM",
      "status": "Scheduled",
      "attendees": 6,
      "maxAttendees": 12,
      "agent": "Lisa Park",
      "images": ["https://picsum.photos/300/200?random=5&keyword=loft"],
      "bedrooms": 1,
      "bathrooms": 1,
      "sqft": 950,
      "type": "Loft"
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Active", "value": "Active"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"}
  ];

  List<Map<String, dynamic>> monthOptions = [
    {"label": "October", "value": "October"},
    {"label": "November", "value": "November"},
    {"label": "December", "value": "December"}
  ];

  List<Map<String, dynamic>> get filteredOpenHouses {
    return openHouses.where((house) {
      bool matchesFilter = selectedFilter == "All" || house["status"] == selectedFilter;
      bool matchesSearch = searchQuery.isEmpty || 
          house["property"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          house["address"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return infoColor;
      case "Active":
        return successColor;
      case "Completed":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Houses"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create open house
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search properties...",
                          value: searchQuery,
                          hint: "Property name or address",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Status",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Month",
                          items: monthOptions,
                          value: selectedMonth,
                          onChanged: (value, label) {
                            selectedMonth = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Calendar Preview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "November 2024",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.chevron_left, size: 20),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.chevron_right, size: 20),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: List.generate(30, (index) {
                      int day = index + 1;
                      bool hasOpenHouse = [15, 16, 17, 18, 19].contains(day);
                      bool isSelected = day == selectedCalendarDay;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedCalendarDay = day;
                          setState(() {});
                        },
                        child: Container(
                          width: 60,
                          height: 70,
                          margin: EdgeInsets.only(right: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : (hasOpenHouse ? infoColor.withAlpha(30) : Colors.grey.withAlpha(20)),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: hasOpenHouse ? Border.all(color: infoColor, width: 1) : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$day",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : primaryColor,
                                ),
                              ),
                              if (hasOpenHouse)
                                Container(
                                  width: 6,
                                  height: 6,
                                  margin: EdgeInsets.only(top: spXxs),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : infoColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.event,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredOpenHouses.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Events",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.people,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${openHouses.fold(0, (sum, house) => sum + (house["attendees"] as int))}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Attendees",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Open Houses List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Open Houses",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredOpenHouses.length} properties",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredOpenHouses.map((house) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          // Property Image
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                              image: DecorationImage(
                                image: NetworkImage("${(house["images"] as List)[0]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: getStatusColor(house["status"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${house["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(150),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "\$${((house["price"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Property Details
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${house["property"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        "${house["address"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                
                                // Property Features
                                Row(
                                  children: [
                                    _buildFeature(Icons.bed, "${house["bedrooms"]} beds"),
                                    SizedBox(width: spSm),
                                    _buildFeature(Icons.bathtub, "${house["bathrooms"]} baths"),
                                    SizedBox(width: spSm),
                                    _buildFeature(Icons.square_foot, "${house["sqft"]} sqft"),
                                  ],
                                ),
                                
                                // Date and Time
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time, size: 16, color: infoColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${house["date"]} • ${house["time"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Agent and Attendees
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person, size: 16, color: disabledBoldColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "${house["agent"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.people, size: 16, color: primaryColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "${house["attendees"]}/${house["maxAttendees"]}",
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
                                
                                SizedBox(height: spXs),
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
                                    QButton(
                                      icon: Icons.edit,
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                    SizedBox(width: spXs),
                                    QButton(
                                      icon: Icons.share,
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: disabledBoldColor),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
