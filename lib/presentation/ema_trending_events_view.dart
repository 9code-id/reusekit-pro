import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaTrendingEventsView extends StatefulWidget {
  const EmaTrendingEventsView({super.key});

  @override
  State<EmaTrendingEventsView> createState() => _EmaTrendingEventsViewState();
}

class _EmaTrendingEventsViewState extends State<EmaTrendingEventsView> {
  String selectedTimeframe = "24h";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 24 Hours", "value": "24h"},
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Music", "value": "Music"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Food", "value": "Food"},
    {"label": "Business", "value": "Business"},
  ];

  List<Map<String, dynamic>> trendingEvents = [
    {
      "id": "trend1",
      "title": "AI Revolution Summit",
      "date": "2024-08-10",
      "time": "09:00",
      "location": "Tech Center",
      "price": 299.00,
      "image": "https://picsum.photos/400/250?random=21&keyword=ai",
      "category": "Technology",
      "attendees": 3500,
      "rating": 4.9,
      "organizer": "AI Innovations",
      "trendScore": 98.5,
      "growthRate": 45.2,
      "bookingVelocity": "5.2/min",
      "socialMentions": 12500,
      "rank": 1,
      "tags": ["AI", "Future Tech", "Innovation"],
      "description": "Explore the future of artificial intelligence with industry pioneers.",
    },
    {
      "id": "trend2",
      "title": "Electronic Music Festival",
      "date": "2024-07-25",
      "time": "18:00",
      "location": "Downtown Arena",
      "price": 150.00,
      "image": "https://picsum.photos/400/250?random=22&keyword=electronic",
      "category": "Music",
      "attendees": 15000,
      "rating": 4.8,
      "organizer": "Beat Events",
      "trendScore": 95.3,
      "growthRate": 38.7,
      "bookingVelocity": "8.1/min",
      "socialMentions": 25000,
      "rank": 2,
      "tags": ["Electronic", "Dance", "Festival"],
      "description": "The biggest electronic music festival of the summer.",
    },
    {
      "id": "trend3",
      "title": "Esports Championship",
      "date": "2024-08-03",
      "time": "14:00",
      "location": "Gaming Arena",
      "price": 75.00,
      "image": "https://picsum.photos/400/250?random=23&keyword=gaming",
      "category": "Sports",
      "attendees": 8000,
      "rating": 4.7,
      "organizer": "Pro Gaming League",
      "trendScore": 92.1,
      "growthRate": 52.3,
      "bookingVelocity": "12.5/min",
      "socialMentions": 18500,
      "rank": 3,
      "tags": ["Gaming", "Esports", "Competition"],
      "description": "Watch the best gamers compete for the ultimate prize.",
    },
    {
      "id": "trend4",
      "title": "Gourmet Street Food Festival",
      "date": "2024-07-28",
      "time": "11:00",
      "location": "City Square",
      "price": 25.00,
      "image": "https://picsum.photos/400/250?random=24&keyword=streetfood",
      "category": "Food",
      "attendees": 12000,
      "rating": 4.6,
      "organizer": "Food Culture Events",
      "trendScore": 89.7,
      "growthRate": 41.8,
      "bookingVelocity": "7.3/min",
      "socialMentions": 8200,
      "rank": 4,
      "tags": ["Street Food", "Culture", "Festival"],
      "description": "Taste authentic street food from around the world.",
    },
    {
      "id": "trend5",
      "title": "Startup Pitch Battle",
      "date": "2024-08-15",
      "time": "16:00",
      "location": "Innovation Hub",
      "price": 50.00,
      "image": "https://picsum.photos/400/250?random=25&keyword=startup",
      "category": "Business",
      "attendees": 1200,
      "rating": 4.8,
      "organizer": "Venture Capital Network",
      "trendScore": 87.4,
      "growthRate": 65.1,
      "bookingVelocity": "3.8/min",
      "socialMentions": 5500,
      "rank": 5,
      "tags": ["Startups", "Investment", "Pitch"],
      "description": "Watch innovative startups pitch to top investors.",
    },
    {
      "id": "trend6",
      "title": "Crypto Conference 2024",
      "date": "2024-09-01",
      "time": "10:00",
      "location": "Financial District",
      "price": 199.00,
      "image": "https://picsum.photos/400/250?random=26&keyword=crypto",
      "category": "Technology",
      "attendees": 2500,
      "rating": 4.7,
      "organizer": "Blockchain Society",
      "trendScore": 85.2,
      "growthRate": 29.4,
      "bookingVelocity": "4.2/min",
      "socialMentions": 9800,
      "rank": 6,
      "tags": ["Crypto", "Blockchain", "Finance"],
      "description": "Learn about the latest developments in cryptocurrency.",
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    if (selectedCategory == "All") {
      return trendingEvents;
    }
    return trendingEvents.where((event) => event["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Events"),
        actions: [
          Icon(
            Icons.whatshot,
            color: dangerColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Fire Theme
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dangerColor, dangerColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "🔥",
                        style: TextStyle(fontSize: 32),
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trending Events",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Hottest events right now",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withAlpha(220),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Based on bookings, social buzz & growth rate",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Trending Stats
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: [
                _buildTrendingStatCard("Trending Score", "${filteredEvents.isEmpty ? 0 : (filteredEvents.fold(0.0, (sum, event) => sum + (event["trendScore"] as double)) / filteredEvents.length).toStringAsFixed(1)}", Icons.trending_up, dangerColor),
                _buildTrendingStatCard("Avg Growth", "${filteredEvents.isEmpty ? 0 : (filteredEvents.fold(0.0, (sum, event) => sum + (event["growthRate"] as double)) / filteredEvents.length).toStringAsFixed(1)}%", Icons.show_chart, successColor),
                _buildTrendingStatCard("Social Buzz", "${filteredEvents.fold(0, (sum, event) => sum + (event["socialMentions"] as int)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}+", Icons.share, infoColor),
                _buildTrendingStatCard("Hot Events", "${filteredEvents.length}", Icons.whatshot, warningColor),
              ],
            ),

            SizedBox(height: spLg),

            // Trending Rankings Header
            Row(
              children: [
                Text(
                  "Trending Rankings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "LIVE",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "Updated 2 min ago",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Trending Events List
            Column(
              children: filteredEvents.map((event) => _buildTrendingEventCard(event)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingEventCard(Map<String, dynamic> event) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getRankColor(event["rank"] as int),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Rank and Category
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getRankColor(event["rank"] as int),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Center(
                    child: Text(
                      "#${event["rank"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${event["title"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${event["category"]} • ${event["organizer"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "🔥",
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(width: 2),
                      Text(
                        "${event["trendScore"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Event Image and Details
            Row(
              children: [
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    image: DecorationImage(
                      image: NetworkImage("${event["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${event["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: disabledBoldColor,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${event["date"]} at ${event["time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: disabledBoldColor,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${event["location"]}",
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

            SizedBox(height: spMd),

            // Trending Metrics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "+${event["growthRate"]}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Growth Rate",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${event["bookingVelocity"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Bookings/min",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((event["socialMentions"] as int) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Social Buzz",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((event["attendees"] as int) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Attendees",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Tags and Action
            Row(
              children: [
                Expanded(
                  child: QHorizontalScroll(
                    children: (event["tags"] as List).map((tag) => Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getRankColor(event["rank"] as int).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getRankColor(event["rank"] as int),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Price and Book Button
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${((event["price"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 14,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${event["rating"]} rating",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                QButton(
                  label: "Book Trending",
                  size: bs.md,
                  onPressed: () {
                    ss("Booking trending event #${event["rank"]}!");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return dangerColor;
      case 2:
        return warningColor;
      case 3:
        return successColor;
      default:
        return primaryColor;
    }
  }
}
