import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMap7View extends StatefulWidget {
  @override
  State<GrlMap7View> createState() => _GrlMap7ViewState();
}

class _GrlMap7ViewState extends State<GrlMap7View> {
  String selectedEventType = "all";
  bool loading = false;
  
  final List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Summer Music Festival",
      "category": "music",
      "date": "Jul 15, 2024",
      "time": "7:00 PM",
      "location": "Golden Gate Park",
      "address": "Golden Gate Park, San Francisco",
      "price": 45.00,
      "latitude": 37.7694,
      "longitude": -122.4862,
      "image": "https://picsum.photos/300/200?random=1&keyword=concert",
      "attendees": 1250,
      "rating": 4.8,
      "description": "Join us for an amazing evening of live music featuring top local and international artists.",
      "organizer": "SF Music Events",
      "tickets": "available",
    },
    {
      "id": 2,
      "title": "Tech Innovation Conference",
      "category": "conference",
      "date": "Jul 20, 2024",
      "time": "9:00 AM",
      "location": "Moscone Center",
      "address": "747 Howard St, San Francisco",
      "price": 120.00,
      "latitude": 37.7843,
      "longitude": -122.4013,
      "image": "https://picsum.photos/300/200?random=2&keyword=conference",
      "attendees": 2500,
      "rating": 4.9,
      "description": "Discover the latest trends in technology and innovation with industry leaders.",
      "organizer": "TechSF",
      "tickets": "available",
    },
    {
      "id": 3,
      "title": "Food & Wine Festival",
      "category": "food",
      "date": "Jul 22, 2024",
      "time": "12:00 PM",
      "location": "Ferry Building",
      "address": "1 Ferry Building, San Francisco",
      "price": 65.00,
      "latitude": 37.7955,
      "longitude": -122.3937,
      "image": "https://picsum.photos/300/200?random=3&keyword=food",
      "attendees": 800,
      "rating": 4.7,
      "description": "Taste amazing food and wine from local restaurants and wineries.",
      "organizer": "SF Food Events",
      "tickets": "limited",
    },
    {
      "id": 4,
      "title": "Art Gallery Opening",
      "category": "art",
      "date": "Jul 25, 2024",
      "time": "6:00 PM",
      "location": "SFMOMA",
      "address": "151 3rd St, San Francisco",
      "price": 25.00,
      "latitude": 37.7857,
      "longitude": -122.4011,
      "image": "https://picsum.photos/300/200?random=4&keyword=art",
      "attendees": 300,
      "rating": 4.6,
      "description": "Experience contemporary art from emerging and established artists.",
      "organizer": "SF Art Collective",
      "tickets": "available",
    },
    {
      "id": 5,
      "title": "Marathon Training Run",
      "category": "sports",
      "date": "Jul 28, 2024",
      "time": "6:00 AM",
      "location": "Crissy Field",
      "address": "Crissy Field, San Francisco",
      "price": 0.00,
      "latitude": 37.8024,
      "longitude": -122.4662,
      "image": "https://picsum.photos/300/200?random=5&keyword=running",
      "attendees": 150,
      "rating": 4.5,
      "description": "Join our community for a long training run along the beautiful waterfront.",
      "organizer": "SF Runners Club",
      "tickets": "free",
    },
  ];

  List<Map<String, dynamic>> filteredEvents = [];
  Map<String, dynamic>? selectedEvent;

  @override
  void initState() {
    super.initState();
    filteredEvents = events;
  }

  void _filterEvents(String category) {
    selectedEventType = category;
    if (category == "all") {
      filteredEvents = events;
    } else {
      filteredEvents = events.where((event) => event["category"] == category).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Finder"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchSheet();
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              ss("Opening calendar view");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Event Category Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Stats Overview
                Row(
                  children: [
                    _buildEventStat("${events.length}", "Total Events", primaryColor),
                    SizedBox(width: spMd),
                    _buildEventStat("${events.where((e) => e["tickets"] == "available").length}", "Available", successColor),
                    SizedBox(width: spMd),
                    _buildEventStat("${events.where((e) => e["price"] == 0.0).length}", "Free", infoColor),
                    SizedBox(width: spMd),
                    _buildEventStat("${events.where((e) => e["tickets"] == "limited").length}", "Limited", warningColor),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Category Filter
                QHorizontalScroll(
                  children: [
                    _buildCategoryChip("all", "All Events", Icons.event),
                    _buildCategoryChip("music", "Music", Icons.music_note),
                    _buildCategoryChip("conference", "Conference", Icons.business),
                    _buildCategoryChip("food", "Food & Drink", Icons.restaurant),
                    _buildCategoryChip("art", "Art & Culture", Icons.palette),
                    _buildCategoryChip("sports", "Sports", Icons.sports),
                  ],
                ),
              ],
            ),
          ),
          
          // Event Map
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[50]!, Colors.blue[50]!],
                ),
              ),
              child: Stack(
                children: [
                  // Map Background
                  Center(
                    child: Text(
                      "Event Locations Map",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  
                  // Event Markers
                  ...filteredEvents.map((event) {
                    return Positioned(
                      left: ((event["longitude"] as double) + 122.4194) * 900,
                      top: (37.7749 - (event["latitude"] as double)) * 1800 + 100,
                      child: GestureDetector(
                        onTap: () {
                          _selectEvent(event);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: selectedEvent?["id"] == event["id"] 
                                ? primaryColor 
                                : _getCategoryColor("${event["category"]}"),
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowMd],
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getCategoryIcon("${event["category"]}"),
                                color: Colors.white,
                                size: 20,
                              ),
                              if (selectedEvent?["id"] == event["id"]) ...[
                                SizedBox(height: 2),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ],
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
                      spacing: spSm,
                      children: [
                        _buildMapButton(Icons.add, () {
                          ss("Zoom in");
                        }),
                        _buildMapButton(Icons.remove, () {
                          ss("Zoom out");
                        }),
                        _buildMapButton(Icons.my_location, () {
                          ss("Show my location");
                        }),
                        _buildMapButton(Icons.filter_list, () {
                          _showFilterSheet();
                        }),
                      ],
                    ),
                  ),
                  
                  // Category Legend
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Event Categories",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          _buildLegendItem(_getCategoryColor("music"), "Music", Icons.music_note),
                          _buildLegendItem(_getCategoryColor("conference"), "Conference", Icons.business),
                          _buildLegendItem(_getCategoryColor("food"), "Food & Drink", Icons.restaurant),
                          _buildLegendItem(_getCategoryColor("art"), "Art & Culture", Icons.palette),
                          _buildLegendItem(_getCategoryColor("sports"), "Sports", Icons.sports),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Event Details Panel
          if (selectedEvent != null)
            Container(
              height: 220,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
                boxShadow: [shadowSm],
              ),
              child: _buildEventDetails(selectedEvent!),
            ),
          
          // Event List
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Upcoming Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${filteredEvents.length} events",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredEvents.length,
                      itemBuilder: (context, index) {
                        final event = filteredEvents[index];
                        return _buildEventCard(event);
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

  Widget _buildEventStat(String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: color.withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String value, String label, IconData icon) {
    final isSelected = selectedEventType == value;
    return GestureDetector(
      onTap: () {
        _filterEvents(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        margin: EdgeInsets.only(right: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : disabledBoldColor,
            ),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(icon, color: Colors.white, size: 10),
          ),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: selectedEvent?["id"] == event["id"]
            ? Border.all(color: primaryColor, width: 2)
            : null,
      ),
      child: GestureDetector(
        onTap: () {
          _selectEvent(event);
        },
        child: Row(
          children: [
            // Event Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                image: DecorationImage(
                  image: NetworkImage("${event["image"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: spSm),
            
            // Event Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${event["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getCategoryColor("${event["category"]}"),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${event["category"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${event["date"]} • ${event["time"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${event["location"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      if ((event["price"] as double) > 0) ...[
                        Text(
                          "\$${((event["price"] as double)).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ] else ...[
                        Text(
                          "FREE",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                      Spacer(),
                      Icon(Icons.people, size: 12, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${event["attendees"]}",
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
          ],
        ),
      ),
    );
  }

  Widget _buildEventDetails(Map<String, dynamic> event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${event["title"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                selectedEvent = null;
                setState(() {});
              },
              child: Icon(
                Icons.close,
                color: disabledBoldColor,
                size: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                image: DecorationImage(
                  image: NetworkImage("${event["image"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: spSm),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "${event["date"]} at ${event["time"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: primaryColor),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${event["address"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: warningColor),
                      SizedBox(width: spXs),
                      Text(
                        "${event["rating"]} • ${event["attendees"]} attendees",
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if ((event["price"] as double) > 0) ...[
                  Text(
                    "\$${((event["price"] as double)).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ] else ...[
                  Text(
                    "FREE",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
                SizedBox(height: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getTicketStatusColor("${event["tickets"]}"),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${event["tickets"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        Text(
          "${event["description"]}",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        
        SizedBox(height: spMd),
        
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Get Tickets",
                icon: Icons.confirmation_number,
                size: bs.sm,
                onPressed: () {
                  ss("Opening ticket purchase for ${event["title"]}");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Get Directions",
                icon: Icons.directions,
                size: bs.sm,
                onPressed: () {
                  ss("Opening directions to ${event["location"]}");
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "music":
        return Colors.purple;
      case "conference":
        return Colors.blue;
      case "food":
        return Colors.orange;
      case "art":
        return Colors.pink;
      case "sports":
        return Colors.green;
      default:
        return primaryColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "music":
        return Icons.music_note;
      case "conference":
        return Icons.business;
      case "food":
        return Icons.restaurant;
      case "art":
        return Icons.palette;
      case "sports":
        return Icons.sports;
      default:
        return Icons.event;
    }
  }

  Color _getTicketStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "limited":
        return warningColor;
      case "sold_out":
        return dangerColor;
      case "free":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _selectEvent(Map<String, dynamic> event) {
    selectedEvent = event;
    setState(() {});
  }

  void _showSearchSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QTextField(
              label: "Search by event name, location, or organizer",
              value: "",
              hint: "Enter search terms...",
              onChanged: (value) {},
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Search Events",
                size: bs.md,
                onPressed: () {
                  back();
                  ss("Searching events...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Event Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            Text("Price Range"),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Min Price",
                    value: "0",
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Max Price",
                    value: "200",
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () {
                  back();
                  ss("Filters applied");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
