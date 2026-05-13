import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLive9View extends StatefulWidget {
  @override
  State<GrlLive9View> createState() => _GrlLive9ViewState();
}

class _GrlLive9ViewState extends State<GrlLive9View> {
  int currentTab = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> liveEvents = [
    {
      "title": "Global Music Festival 2024",
      "organizer": "MusicWorld Events",
      "startTime": "2024-07-15 20:00",
      "endTime": "2024-07-15 23:00",
      "category": "Music",
      "viewers": 125000,
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=concert",
      "isLive": true,
      "isPremium": true,
      "price": 25.99,
      "description": "Join us for an unforgettable night of music featuring top artists from around the world.",
    },
    {
      "title": "Tech Conference: Future of AI",
      "organizer": "TechGlobal",
      "startTime": "2024-07-16 09:00",
      "endTime": "2024-07-16 17:00",
      "category": "Technology",
      "viewers": 89000,
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=technology",
      "isLive": true,
      "isPremium": false,
      "price": 0,
      "description": "Discover the latest innovations in artificial intelligence and machine learning.",
    },
    {
      "title": "World Cup Finals",
      "organizer": "Sports Network",
      "startTime": "2024-07-17 16:00",
      "endTime": "2024-07-17 18:00",
      "category": "Sports",
      "viewers": 2500000,
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=soccer",
      "isLive": false,
      "isPremium": true,
      "price": 15.99,
      "description": "Watch the most anticipated football match of the year.",
    },
    {
      "title": "Cooking with Master Chef",
      "organizer": "Culinary Network",
      "startTime": "2024-07-18 14:00",
      "endTime": "2024-07-18 15:30",
      "category": "Cooking",
      "viewers": 45000,
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=cooking",
      "isLive": false,
      "isPremium": false,
      "price": 0,
      "description": "Learn professional cooking techniques from renowned chefs.",
    },
  ];

  List<Map<String, dynamic>> upcomingEvents = [
    {
      "title": "Gaming Championship Finals",
      "organizer": "ESports League",
      "startTime": "2024-07-20 19:00",
      "category": "Gaming",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=gaming",
      "expectedViewers": 150000,
      "isPremium": true,
      "price": 12.99,
    },
    {
      "title": "Art Exhibition Virtual Tour",
      "organizer": "Modern Art Museum",
      "startTime": "2024-07-21 11:00",
      "category": "Art",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=art",
      "expectedViewers": 25000,
      "isPremium": false,
      "price": 0,
    },
    {
      "title": "Investment Masterclass",
      "organizer": "Financial Experts",
      "startTime": "2024-07-22 18:00",
      "category": "Finance",
      "thumbnail": "https://picsum.photos/300/200?random=7&keyword=business",
      "expectedViewers": 75000,
      "isPremium": true,
      "price": 49.99,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.apps, "isSelected": true},
    {"name": "Music", "icon": Icons.music_note, "isSelected": false},
    {"name": "Sports", "icon": Icons.sports_soccer, "isSelected": false},
    {"name": "Technology", "icon": Icons.computer, "isSelected": false},
    {"name": "Gaming", "icon": Icons.sports_esports, "isSelected": false},
    {"name": "Education", "icon": Icons.school, "isSelected": false},
  ];

  void _joinEvent(Map<String, dynamic> event) {
    if (event["isPremium"] as bool && (event["price"] as double) > 0) {
      _showPurchaseDialog(event);
    } else {
      si("Joining ${event["title"]}...");
    }
  }

  void _showPurchaseDialog(Map<String, dynamic> event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                  Spacer(),
                  Text(
                    "Premium Event",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(width: 24),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Image.network(
                        "${event["thumbnail"]}",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Event details
                    Text(
                      "${event["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "by ${event["organizer"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${event["description"] ?? "Premium live event with exclusive content and features."}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Features
                    Text(
                      "Premium Features",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Column(
                      children: [
                        "HD Quality Streaming",
                        "Interactive Chat Features",
                        "Exclusive Behind-the-Scenes",
                        "Priority Customer Support",
                        "Event Recording Access"
                      ].map((feature) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                feature,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: spMd),

                    // Price
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Premium Access",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "One-time payment",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${(event["price"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Purchase button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Purchase Access - \$${(event["price"] as double).toStringAsFixed(2)}",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                          ss("Premium access purchased! Joining event...");
                        },
                      ),
                    ),

                    SizedBox(height: spMd),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setReminder(Map<String, dynamic> event) {
    ss("Reminder set for ${event["title"]}");
  }

  String _formatDateTime(String dateTime) {
    try {
      DateTime dt = DateTime.parse(dateTime);
      return "${dt.day}/${dt.month} at ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Live Events",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Live Now", icon: Icon(Icons.live_tv)),
        Tab(text: "Upcoming", icon: Icon(Icons.schedule)),
        Tab(text: "My Events", icon: Icon(Icons.bookmark)),
      ],
      tabChildren: [
        _buildLiveEventsTab(),
        _buildUpcomingTab(),
        _buildMyEventsTab(),
      ],
    );
  }

  Widget _buildLiveEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and filter
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search events...",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: disabledBoldColor),
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.filter_list,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Categories
          QHorizontalScroll(
            children: categories.map((category) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    for (var cat in categories) {
                      cat["isSelected"] = false;
                    }
                    category["isSelected"] = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: (category["isSelected"] as bool) 
                        ? primaryColor 
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        category["icon"] as IconData,
                        color: (category["isSelected"] as bool) 
                            ? Colors.white 
                            : disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${category["name"]}",
                        style: TextStyle(
                          color: (category["isSelected"] as bool) 
                              ? Colors.white 
                              : disabledBoldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: spMd),

          // Live events
          Text(
            "Live Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),

          ...liveEvents.map((event) {
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
                  // Event thumbnail
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${event["thumbnail"]}",
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      // Live indicator
                      if (event["isLive"] as bool)
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
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "LIVE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Premium badge
                      if (event["isPremium"] as bool)
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "PREMIUM",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Viewer count
                      Positioned(
                        bottom: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(160),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.visibility,
                                color: Colors.white,
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${event["viewers"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Play button
                      Positioned(
                        bottom: spSm,
                        right: spSm,
                        child: GestureDetector(
                          onTap: () => _joinEvent(event),
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Event info
                  Padding(
                    padding: EdgeInsets.all(spSm),
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
                                    "${event["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "by ${event["organizer"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if ((event["isPremium"] as bool) && (event["price"] as double) > 0)
                              Text(
                                "\$${(event["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: spSm),

                        // Time and category
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              _formatDateTime("${event["startTime"]}"),
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(40),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${event["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        if (event["description"] != null)
                          Column(
                            children: [
                              SizedBox(height: spSm),
                              Text(
                                "${event["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),

                        SizedBox(height: spSm),

                        // Action button
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: (event["isLive"] as bool) 
                                ? "Join Event"
                                : "Watch Replay",
                            size: bs.sm,
                            onPressed: () => _joinEvent(event),
                          ),
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
    );
  }

  Widget _buildUpcomingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),

          ...upcomingEvents.map((event) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  // Thumbnail
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${event["thumbnail"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  SizedBox(width: spSm),
                  
                  // Event info
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
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (event["isPremium"] as bool)
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "by ${event["organizer"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 12,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              _formatDateTime("${event["startTime"]}"),
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${event["expectedViewers"]} expected",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            if ((event["isPremium"] as bool) && (event["price"] as double) > 0)
                              Text(
                                "\$${(event["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(width: spSm),
                  
                  // Reminder button
                  QButton(
                    label: "Remind Me",
                    size: bs.sm,
                    onPressed: () => _setReminder(event),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMyEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // No events message
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Icon(
                  Icons.event_available,
                  size: 80,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No Saved Events",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Events you purchase or set reminders for will appear here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                QButton(
                  label: "Browse Events",
                  size: bs.md,
                  onPressed: () {
                    setState(() {
                      currentTab = 0;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
