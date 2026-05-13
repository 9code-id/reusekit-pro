import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEvent4View extends StatefulWidget {
  @override
  State<GrlEvent4View> createState() => _GrlEvent4ViewState();
}

class _GrlEvent4ViewState extends State<GrlEvent4View> {
  bool isGridView = true;
  String selectedCategory = "All";  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Music", "value": "Music"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Business", "value": "Business"},
    {"label": "Food", "value": "Food"},
    {"label": "Arts", "value": "Arts"},
  ];

  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Jazz Night at Blue Moon",
      "category": "Music", 
      "date": "2025-07-15",
      "time": "19:00",
      "location": "Blue Moon Club, Downtown",
      "price": 25.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=jazz",
      "attendees": 156,
      "rating": 4.8,
      "organizer": "Blue Moon Entertainment"
    },
    {
      "id": 2,
      "title": "Marathon City Challenge",
      "category": "Sports",
      "date": "2025-08-20",
      "time": "06:00", 
      "location": "Central Park",
      "price": 45.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=marathon",
      "attendees": 892,
      "rating": 4.6,
      "organizer": "City Sports Association"
    },
    {
      "id": 3,
      "title": "Startup Pitch Competition",
      "category": "Business",
      "date": "2025-07-28",
      "time": "14:00",
      "location": "Tech Hub Conference Center",
      "price": 0.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=business",
      "attendees": 234,
      "rating": 4.7,
      "organizer": "Innovation Labs"
    },
    {
      "id": 4,
      "title": "Street Food Festival",
      "category": "Food",
      "date": "2025-08-05",
      "time": "11:00",
      "location": "Riverside Park",
      "price": 15.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=food",
      "attendees": 567,
      "rating": 4.9,
      "organizer": "Culinary Events Co."
    },
    {
      "id": 5,
      "title": "Contemporary Art Exhibition",
      "category": "Arts",
      "date": "2025-07-22",
      "time": "10:00",
      "location": "Modern Art Gallery",
      "price": 12.0,
      "image": "https://picsum.photos/300/200?random=5&keyword=art",
      "attendees": 89,
      "rating": 4.5,
      "organizer": "Art Collective"
    },
    {
      "id": 6,
      "title": "Electronic Music Festival",
      "category": "Music",
      "date": "2025-09-10",
      "time": "18:00",
      "location": "Warehouse District",
      "price": 65.0,
      "image": "https://picsum.photos/300/200?random=6&keyword=electronic",
      "attendees": 1200,
      "rating": 4.8,
      "organizer": "Beat Productions"
    }
  ];

  List<Map<String, dynamic>> get filteredEvents {
    return events.where((event) {
      bool matchesCategory = selectedCategory == "All" || event["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
        event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Events"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
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
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search events...",
                    value: searchQuery,
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

            // Category Filter
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Stats Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${filteredEvents.length} Events Found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Showing ${selectedCategory.toLowerCase()} events",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Events Display
            if (isGridView)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredEvents.map((event) {
                  return _buildEventCard(event);
                }).toList(),
              )
            else
              Column(
                spacing: spSm,
                children: filteredEvents.map((event) {
                  return _buildEventListItem(event);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
              image: DecorationImage(
                image: NetworkImage("${event["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${event["category"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Event Details
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${DateTime.parse(event["date"]).dMMMy}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: 4),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (event["price"] as double) == 0 ? "Free" : "\$${(event["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: warningColor),
                        SizedBox(width: 4),
                        Text(
                          "${event["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      ss("Event details for ${event["title"]}");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventListItem(Map<String, dynamic> event) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Event Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${event["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          SizedBox(width: spSm),
          
          // Event Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Text(
                  "${event["category"]} • ${DateTime.parse(event["date"]).dMMMy}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                
                Text(
                  "${event["location"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (event["price"] as double) == 0 ? "Free" : "\$${(event["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: warningColor),
                        SizedBox(width: 4),
                        Text(
                          "${event["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(width: spSm),
          
          QButton(
            label: "Book",
            size: bs.sm,
            onPressed: () {
              ss("Booking ${event["title"]}");
            },
          ),
        ],
      ),
    );
  }
}
