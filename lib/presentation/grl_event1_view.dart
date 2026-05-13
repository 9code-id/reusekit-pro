import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEvent1View extends StatefulWidget {
  @override
  State<GrlEvent1View> createState() => _GrlEvent1ViewState();
}

class _GrlEvent1ViewState extends State<GrlEvent1View> {
  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "AI in Healthcare Summit 2024",
      "description": "Join leading experts to discuss the future of artificial intelligence in healthcare and medical research.",
      "image": "https://picsum.photos/400/250?random=1&keyword=medical-conference",
      "date": "2024-12-25",
      "time": "09:00",
      "endTime": "17:00",
      "location": "San Francisco Convention Center",
      "address": "747 Howard St, San Francisco, CA 94103",
      "price": 299.0,
      "category": "Conference",
      "organizer": "MedTech Events",
      "attendees": 1247,
      "maxAttendees": 2000,
      "isOnline": false,
      "isFeatured": true,
      "tags": ["AI", "Healthcare", "Technology", "Research"],
      "speakers": [
        {"name": "Dr. Sarah Johnson", "title": "AI Research Director"},
        {"name": "Prof. Michael Chen", "title": "Healthcare Innovation Lead"},
        {"name": "Dr. Lisa Rodriguez", "title": "Medical AI Specialist"}
      ]
    },
    {
      "id": 2,
      "title": "Startup Pitch Competition",
      "description": "Emerging startups compete for seed funding in front of top venture capitalists and angel investors.",
      "image": "https://picsum.photos/400/250?random=2&keyword=startup-pitch",
      "date": "2024-12-22",
      "time": "14:00",
      "endTime": "18:00",
      "location": "Innovation Hub",
      "address": "123 Startup Way, Silicon Valley, CA",
      "price": 0.0,
      "category": "Competition",
      "organizer": "VentureStart",
      "attendees": 456,
      "maxAttendees": 500,
      "isOnline": true,
      "isFeatured": false,
      "tags": ["Startup", "Investment", "Pitch", "Business"],
      "speakers": [
        {"name": "James Wilson", "title": "Venture Capitalist"},
        {"name": "Amanda Kim", "title": "Angel Investor"}
      ]
    },
    {
      "id": 3,
      "title": "Climate Action Workshop",
      "description": "Interactive workshop on sustainable practices and climate change mitigation strategies for businesses.",
      "image": "https://picsum.photos/400/250?random=3&keyword=climate-workshop",
      "date": "2024-12-20",
      "time": "10:00",
      "endTime": "16:00",
      "location": "Green Center",
      "address": "456 Eco Drive, Portland, OR 97205",
      "price": 89.0,
      "category": "Workshop",
      "organizer": "EcoLearn",
      "attendees": 234,
      "maxAttendees": 300,
      "isOnline": false,
      "isFeatured": true,
      "tags": ["Climate", "Sustainability", "Environment", "Business"],
      "speakers": [
        {"name": "Dr. Rachel Green", "title": "Environmental Scientist"},
        {"name": "David Park", "title": "Sustainability Consultant"}
      ]
    },
    {
      "id": 4,
      "title": "Digital Marketing Masterclass",
      "description": "Learn advanced digital marketing strategies from industry experts and successful entrepreneurs.",
      "image": "https://picsum.photos/400/250?random=4&keyword=digital-marketing",
      "date": "2024-12-28",
      "time": "11:00",
      "endTime": "15:00",
      "location": "Online Event",
      "address": "Virtual Platform",
      "price": 149.0,
      "category": "Masterclass",
      "organizer": "MarketPro Academy",
      "attendees": 892,
      "maxAttendees": 1500,
      "isOnline": true,
      "isFeatured": false,
      "tags": ["Marketing", "Digital", "Social Media", "Strategy"],
      "speakers": [
        {"name": "Mark Thompson", "title": "Digital Marketing Expert"},
        {"name": "Jennifer Lee", "title": "Social Media Strategist"}
      ]
    },
    {
      "id": 5,
      "title": "Blockchain & Finance Forum",
      "description": "Explore the intersection of blockchain technology and modern finance with leading fintech innovators.",
      "image": "https://picsum.photos/400/250?random=5&keyword=blockchain",
      "date": "2024-12-30",
      "time": "13:00",
      "endTime": "19:00",
      "location": "Financial District Center",
      "address": "789 Wall Street, New York, NY 10005",
      "price": 399.0,
      "category": "Forum",
      "organizer": "FinTech Innovations",
      "attendees": 678,
      "maxAttendees": 1000,
      "isOnline": false,
      "isFeatured": true,
      "tags": ["Blockchain", "Finance", "Cryptocurrency", "Innovation"],
      "speakers": [
        {"name": "Alex Morgan", "title": "Blockchain Developer"},
        {"name": "Sophie Chen", "title": "Crypto Analyst"}
      ]
    }
  ];

  String searchQuery = "";
  String selectedCategory = "All";
  String selectedPrice = "All";
  String selectedType = "All";
  
  List<String> categories = ["All", "Conference", "Workshop", "Masterclass", "Competition", "Forum"];
  List<String> priceRanges = ["All", "Free", "Under \$100", "\$100-\$300", "Over \$300"];
  List<String> eventTypes = ["All", "In-Person", "Online", "Hybrid"];

  List<Map<String, dynamic>> get filteredEvents {
    return events.where((event) {
      bool matchesSearch = searchQuery.isEmpty || 
        event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        event["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || event["category"] == selectedCategory;
      
      bool matchesPrice = selectedPrice == "All" || _matchesPriceRange(event["price"], selectedPrice);
      
      bool matchesType = selectedType == "All" || _matchesEventType(event, selectedType);
      
      return matchesSearch && matchesCategory && matchesPrice && matchesType;
    }).toList();
  }

  bool _matchesPriceRange(double price, String range) {
    switch (range) {
      case "Free":
        return price == 0.0;
      case "Under \$100":
        return price > 0 && price < 100;
      case "\$100-\$300":
        return price >= 100 && price <= 300;
      case "Over \$300":
        return price > 300;
      default:
        return true;
    }
  }

  bool _matchesEventType(Map<String, dynamic> event, String type) {
    switch (type) {
      case "Online":
        return event["isOnline"] == true;
      case "In-Person":
        return event["isOnline"] == false;
      case "Hybrid":
        return false; // No hybrid events in sample data
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> featuredEvents = filteredEvents.where((e) => e["isFeatured"] == true).toList();
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Discover Events",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Find and join amazing events near you",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(60),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(Icons.event, color: Colors.white, size: 32),
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  
                  // Search Bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: disabledBoldColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search events, topics, organizers...",
                              hintStyle: TextStyle(color: disabledColor),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(Icons.tune, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filter Section
            QHorizontalScroll(
              children: [
                _buildFilterChip("Category", selectedCategory, categories, (value) {
                  selectedCategory = value;
                  setState(() {});
                }),
                _buildFilterChip("Price", selectedPrice, priceRanges, (value) {
                  selectedPrice = value;
                  setState(() {});
                }),
                _buildFilterChip("Type", selectedType, eventTypes, (value) {
                  selectedType = value;
                  setState(() {});
                }),
              ],
            ),

            SizedBox(height: spLg),

            // Featured Events
            if (featuredEvents.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    "Featured Events",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "View All",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              QHorizontalScroll(
                children: featuredEvents.map((event) {
                  return Container(
                    width: 300,
                    margin: EdgeInsets.only(right: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                              child: Image.network(
                                "${event["image"]}",
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Featured",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(100),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(Icons.bookmark_border, color: Colors.white, size: 16),
                              ),
                            ),
                            if (event["isOnline"]) ...[
                              Positioned(
                                bottom: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: infoColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "Online",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${event["category"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${event["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, color: disabledColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${event["date"]} at ${event["time"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: disabledColor, size: 14),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${event["location"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Text(
                                    (event["price"] as double) == 0.0 ? "Free" : "\$${(event["price"] as double).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: (event["price"] as double) == 0.0 ? successColor : primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${event["attendees"]}/${event["maxAttendees"]} attending",
                                    style: TextStyle(
                                      color: disabledColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spMd),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              
              SizedBox(height: spXl),
            ],

            // All Events
            Row(
              children: [
                Text(
                  "All Events",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredEvents.length} events found",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            if (filteredEvents.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spXl),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    Icon(Icons.event_busy, color: disabledColor, size: 64),
                    SizedBox(height: spMd),
                    Text(
                      "No events found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ] else ...[
              Column(
                children: filteredEvents.map((event) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
                          child: Image.network(
                            "${event["image"]}",
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: spMd),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${event["category"]}",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    if (event["isOnline"]) ...[
                                      Icon(Icons.videocam, color: infoColor, size: 16),
                                    ] else ...[
                                      Icon(Icons.location_on, color: disabledColor, size: 16),
                                    ],
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${event["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${event["date"]} • ${event["time"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      (event["price"] as double) == 0.0 ? "Free" : "\$${(event["price"] as double).toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: (event["price"] as double) == 0.0 ? successColor : primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spMd),
                                    Icon(Icons.people, color: disabledColor, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${event["attendees"]}",
                                      style: TextStyle(
                                        color: disabledColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            children: [
                              Icon(Icons.bookmark_border, color: disabledColor, size: 20),
                              SizedBox(height: spSm),
                              QButton(
                                label: "Join",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String selectedValue, List<String> options, Function(String) onChanged) {
    return Container(
      margin: EdgeInsets.only(right: spMd),
      child: GestureDetector(
        onTap: () => _showFilterOptions(label, options, selectedValue, onChanged),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
          decoration: BoxDecoration(
            color: selectedValue != options.first ? primaryColor : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: selectedValue != options.first ? primaryColor : disabledOutlineBorderColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$label: $selectedValue",
                style: TextStyle(
                  color: selectedValue != options.first ? Colors.white : disabledBoldColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: spXs),
              Icon(
                Icons.keyboard_arrow_down,
                color: selectedValue != options.first ? Colors.white : disabledBoldColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterOptions(String title, List<String> options, String selectedValue, Function(String) onChanged) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select $title",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...options.map((option) {
                return GestureDetector(
                  onTap: () {
                    onChanged(option);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spMd),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          option,
                          style: TextStyle(
                            color: selectedValue == option ? primaryColor : primaryColor,
                            fontWeight: selectedValue == option ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        Spacer(),
                        if (selectedValue == option)
                          Icon(Icons.check, color: primaryColor, size: 20),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
