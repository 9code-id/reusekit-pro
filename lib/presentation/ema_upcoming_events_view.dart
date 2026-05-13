import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaUpcomingEventsView extends StatefulWidget {
  const EmaUpcomingEventsView({super.key});

  @override
  State<EmaUpcomingEventsView> createState() => _EmaUpcomingEventsViewState();
}

class _EmaUpcomingEventsViewState extends State<EmaUpcomingEventsView> {
  String selectedTimeRange = "week";
  String selectedCategory = "All";
  bool showRemindersOnly = false;
  
  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Next 3 Months", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Music", "value": "Music"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Food & Drinks", "value": "Food"},
    {"label": "Business", "value": "Business"},
    {"label": "Arts", "value": "Arts"},
  ];

  List<Map<String, dynamic>> upcomingEvents = [
    {
      "id": "upcoming1",
      "title": "Web Development Bootcamp",
      "date": "2024-06-25",
      "time": "10:00",
      "endTime": "18:00",
      "location": "Tech Campus",
      "price": 199.00,
      "image": "https://picsum.photos/400/250?random=31&keyword=programming",
      "category": "Technology",
      "attendees": 500,
      "rating": 4.8,
      "organizer": "Code Academy",
      "daysUntil": 8,
      "hasReminder": true,
      "reminderTime": "1 day before",
      "isEarlyBird": true,
      "earlyBirdDiscount": 25.0,
      "tags": ["Programming", "Web Dev", "Workshop"],
      "description": "Intensive bootcamp covering modern web development technologies.",
      "prerequisites": "Basic HTML knowledge",
      "duration": "8 hours",
    },
    {
      "id": "upcoming2",
      "title": "Jazz Night Under Stars",
      "date": "2024-06-28",
      "time": "19:30",
      "endTime": "23:00",
      "location": "Rooftop Lounge",
      "price": 65.00,
      "image": "https://picsum.photos/400/250?random=32&keyword=jazz",
      "category": "Music",
      "attendees": 200,
      "rating": 4.9,
      "organizer": "City Jazz Society",
      "daysUntil": 11,
      "hasReminder": false,
      "reminderTime": "",
      "isEarlyBird": false,
      "earlyBirdDiscount": 0.0,
      "tags": ["Jazz", "Live Music", "Outdoor"],
      "description": "Intimate jazz performance featuring local and international artists.",
      "prerequisites": "None",
      "duration": "3.5 hours",
    },
    {
      "id": "upcoming3",
      "title": "Marathon Training Workshop",
      "date": "2024-07-05",
      "time": "06:00",
      "endTime": "10:00",
      "location": "Central Park",
      "price": 45.00,
      "image": "https://picsum.photos/400/250?random=33&keyword=running",
      "category": "Sports",
      "attendees": 150,
      "rating": 4.7,
      "organizer": "Running Club",
      "daysUntil": 18,
      "hasReminder": true,
      "reminderTime": "3 days before",
      "isEarlyBird": true,
      "earlyBirdDiscount": 15.0,
      "tags": ["Running", "Training", "Fitness"],
      "description": "Professional training session for aspiring marathon runners.",
      "prerequisites": "Basic running experience",
      "duration": "4 hours",
    },
    {
      "id": "upcoming4",
      "title": "Gourmet Cooking Class",
      "date": "2024-07-12",
      "time": "14:00",
      "endTime": "17:00",
      "location": "Culinary Institute",
      "price": 120.00,
      "image": "https://picsum.photos/400/250?random=34&keyword=cooking",
      "category": "Food",
      "attendees": 80,
      "rating": 4.9,
      "organizer": "Chef Masters",
      "daysUntil": 25,
      "hasReminder": true,
      "reminderTime": "1 week before",
      "isEarlyBird": false,
      "earlyBirdDiscount": 0.0,
      "tags": ["Cooking", "Gourmet", "Hands-on"],
      "description": "Learn advanced cooking techniques from professional chefs.",
      "prerequisites": "Basic cooking skills",
      "duration": "3 hours",
    },
    {
      "id": "upcoming5",
      "title": "Startup Networking Event",
      "date": "2024-08-02",
      "time": "18:00",
      "endTime": "21:00",
      "location": "Business Hub",
      "price": 35.00,
      "image": "https://picsum.photos/400/250?random=35&keyword=networking",
      "category": "Business",
      "attendees": 300,
      "rating": 4.6,
      "organizer": "Entrepreneur Network",
      "daysUntil": 46,
      "hasReminder": false,
      "reminderTime": "",
      "isEarlyBird": true,
      "earlyBirdDiscount": 20.0,
      "tags": ["Networking", "Startups", "Business"],
      "description": "Connect with fellow entrepreneurs and potential investors.",
      "prerequisites": "None",
      "duration": "3 hours",
    },
    {
      "id": "upcoming6",
      "title": "Modern Art Workshop",
      "date": "2024-08-15",
      "time": "11:00",
      "endTime": "16:00",
      "location": "Art Studio",
      "price": 85.00,
      "image": "https://picsum.photos/400/250?random=36&keyword=art",
      "category": "Arts",
      "attendees": 60,
      "rating": 4.8,
      "organizer": "Creative Arts Center",
      "daysUntil": 59,
      "hasReminder": true,
      "reminderTime": "2 weeks before",
      "isEarlyBird": false,
      "earlyBirdDiscount": 0.0,
      "tags": ["Art", "Workshop", "Creative"],
      "description": "Explore contemporary art techniques with professional artists.",
      "prerequisites": "Basic art knowledge",
      "duration": "5 hours",
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = upcomingEvents;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((event) => event["category"] == selectedCategory).toList();
    }
    
    if (showRemindersOnly) {
      filtered = filtered.where((event) => event["hasReminder"] == true).toList();
    }
    
    return filtered..sort((a, b) => (a["daysUntil"] as int).compareTo(b["daysUntil"] as int));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Events"),
        actions: [
          Icon(
            Icons.schedule,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, infoColor.withAlpha(180)],
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
                      Icon(
                        Icons.upcoming,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upcoming Events",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Never miss an event again",
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
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${upcomingEvents.where((e) => e["hasReminder"] == true).length} with reminders",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spMd),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_offer,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${upcomingEvents.where((e) => e["isEarlyBird"] == true).length} early bird deals",
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
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Range",
                    items: timeRangeOptions,
                    value: selectedTimeRange,
                    onChanged: (value, label) {
                      selectedTimeRange = value;
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

            SizedBox(height: spMd),

            // Reminder Toggle
            QSwitch(
              items: [
                {
                  "label": "Show only events with reminders",
                  "value": true,
                  "checked": showRemindersOnly,
                }
              ],
              value: [if (showRemindersOnly) {"label": "Show only events with reminders", "value": true, "checked": true}],
              onChanged: (values, ids) {
                showRemindersOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: [
                _buildStatCard("Next Event", "${filteredEvents.isEmpty ? 'None' : '${filteredEvents.first["daysUntil"]} days'}", Icons.schedule, infoColor),
                _buildStatCard("This Week", "${filteredEvents.where((e) => (e["daysUntil"] as int) <= 7).length}", Icons.calendar_today, successColor),
                _buildStatCard("With Reminders", "${filteredEvents.where((e) => e["hasReminder"] == true).length}", Icons.notifications, warningColor),
                _buildStatCard("Early Bird", "${filteredEvents.where((e) => e["isEarlyBird"] == true).length}", Icons.local_offer, primaryColor),
              ],
            ),

            SizedBox(height: spLg),

            // Timeline Header
            Text(
              "Event Timeline",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            // Upcoming Events Timeline
            Column(
              children: filteredEvents.map((event) => _buildUpcomingEventCard(event)).toList(),
            ),

            if (filteredEvents.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No upcoming events found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters to see more events",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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

  Widget _buildUpcomingEventCard(Map<String, dynamic> event) {
    int daysUntil = event["daysUntil"] as int;
    bool isUrgent = daysUntil <= 3;
    bool isThisWeek = daysUntil <= 7;

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
            color: isUrgent ? dangerColor : isThisWeek ? warningColor : infoColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Header with Countdown
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isUrgent ? dangerColor.withAlpha(25) : isThisWeek ? warningColor.withAlpha(25) : infoColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$daysUntil",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: isUrgent ? dangerColor : isThisWeek ? warningColor : infoColor,
                        ),
                      ),
                      Text(
                        daysUntil == 1 ? "day" : "days",
                        style: TextStyle(
                          fontSize: 12,
                          color: isUrgent ? dangerColor : isThisWeek ? warningColor : infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${event["category"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          if (event["isEarlyBird"] == true) ...[
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Early Bird",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                          if (event["hasReminder"] == true) ...[
                            SizedBox(width: spSm),
                            Icon(
                              Icons.notifications_active,
                              color: warningColor,
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${event["title"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${event["organizer"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
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
                            Icons.schedule,
                            color: disabledBoldColor,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${event["time"]} - ${event["endTime"]} (${event["duration"]})",
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
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: disabledBoldColor,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${event["attendees"]} attending",
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

            // Tags
            QHorizontalScroll(
              children: (event["tags"] as List).map((tag) => Container(
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              )).toList(),
            ),

            SizedBox(height: spMd),

            // Reminder Section
            if (event["hasReminder"] == true)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications_active,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Reminder set for ${event["reminderTime"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),

            if (event["hasReminder"] == true) SizedBox(height: spMd),

            // Price and Actions
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (event["isEarlyBird"] == true) ...[
                      Text(
                        "\$${(((event["price"] as double) * (1 + (event["earlyBirdDiscount"] as double) / 100)).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "\$${((event["price"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "-${event["earlyBirdDiscount"]}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Text(
                        "\$${((event["price"] as double).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
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
                Row(
                  children: [
                    if (event["hasReminder"] == false)
                      QButton(
                        icon: Icons.notifications,
                        size: bs.sm,
                        onPressed: () {
                          ss("Reminder set for this event!");
                        },
                      ),
                    if (event["hasReminder"] == false) SizedBox(width: spSm),
                    QButton(
                      label: "Book Now",
                      size: bs.sm,
                      onPressed: () {
                        ss("Booking upcoming event!");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
