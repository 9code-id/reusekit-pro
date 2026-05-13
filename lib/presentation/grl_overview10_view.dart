import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOverview10View extends StatefulWidget {
  @override
  State<GrlOverview10View> createState() => _GrlOverview10ViewState();
}

class _GrlOverview10ViewState extends State<GrlOverview10View> {
  List<Map<String, dynamic>> eventStats = [
    {
      "title": "Upcoming Events",
      "value": 18,
      "subtitle": "Next 30 days",
      "color": Colors.blue,
      "icon": Icons.event,
      "change": 12.5
    },
    {
      "title": "Total Attendees",
      "value": 2450,
      "subtitle": "This month",
      "color": Colors.green,
      "icon": Icons.people,
      "change": 8.3
    },
    {
      "title": "Revenue Generated",
      "value": 125000,
      "subtitle": "From events",
      "color": Colors.purple,
      "icon": Icons.attach_money,
      "change": 15.7
    },
    {
      "title": "Active Venues",
      "value": 8,
      "subtitle": "Locations",
      "color": Colors.orange,
      "icon": Icons.location_on,
      "change": 0.0
    },
  ];

  List<Map<String, dynamic>> upcomingEvents = [
    {
      "name": "Annual Tech Conference",
      "date": "2024-02-20",
      "time": "9:00 AM",
      "venue": "Convention Center",
      "capacity": 500,
      "registered": 456,
      "status": "Confirmed",
      "type": "Conference",
      "price": 299.99
    },
    {
      "name": "Product Launch Event",
      "date": "2024-02-25",
      "time": "6:00 PM",
      "venue": "Grand Ballroom",
      "capacity": 200,
      "registered": 180,
      "status": "Confirmed",
      "type": "Launch",
      "price": 150.00
    },
    {
      "name": "Networking Dinner",
      "date": "2024-03-05",
      "time": "7:30 PM",
      "venue": "Rooftop Restaurant",
      "capacity": 80,
      "registered": 65,
      "status": "Planning",
      "type": "Networking",
      "price": 75.00
    },
    {
      "name": "Workshop Series",
      "date": "2024-03-10",
      "time": "2:00 PM",
      "venue": "Training Room A",
      "capacity": 50,
      "registered": 42,
      "status": "Confirmed",
      "type": "Workshop",
      "price": 99.00
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "title": "New registration for Tech Conference",
      "attendee": "Sarah Johnson",
      "time": "5 minutes ago",
      "type": "registration",
      "amount": 299.99
    },
    {
      "title": "Payment received",
      "attendee": "Mike Brown",
      "time": "15 minutes ago",
      "type": "payment",
      "amount": 150.00
    },
    {
      "title": "Event venue confirmed",
      "attendee": "Grand Ballroom",
      "time": "1 hour ago",
      "type": "venue",
      "amount": 0
    },
    {
      "title": "Speaker confirmed",
      "attendee": "Dr. Emily Davis",
      "time": "2 hours ago",
      "type": "speaker",
      "amount": 0
    },
  ];

  List<Map<String, dynamic>> popularEvents = [
    {
      "name": "AI & Machine Learning Summit",
      "registrations": 850,
      "rating": 4.8,
      "category": "Technology",
      "revenue": 255000
    },
    {
      "name": "Digital Marketing Masterclass",
      "registrations": 620,
      "rating": 4.6,
      "category": "Marketing",
      "revenue": 186000
    },
    {
      "name": "Startup Pitch Competition",
      "registrations": 400,
      "rating": 4.9,
      "category": "Business",
      "revenue": 80000
    },
    {
      "name": "Design Thinking Workshop",
      "registrations": 320,
      "rating": 4.7,
      "category": "Design",
      "revenue": 96000
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event Dashboard",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Manage events, track registrations, and monitor performance",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "23% increase in bookings",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.event_available,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),

            // Event Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: eventStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          if ((stat["change"] as double) != 0.0)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: (stat["change"] as double) >= 0 
                                    ? successColor.withAlpha(50)
                                    : dangerColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    (stat["change"] as double) >= 0 
                                        ? Icons.trending_up 
                                        : Icons.trending_down,
                                    size: 12,
                                    color: (stat["change"] as double) >= 0 
                                        ? successColor 
                                        : dangerColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(stat["change"] as double) >= 0 ? '+' : ''}${(stat["change"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: (stat["change"] as double) >= 0 
                                          ? successColor 
                                          : dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        stat["title"] == "Revenue Generated"
                            ? "\$${((stat["value"] as int).toDouble()).currency}"
                            : "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["subtitle"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Upcoming Events
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.event_note,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upcoming Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: upcomingEvents.map((event) {
                      Color statusColor = _getStatusColor("${event["status"]}");
                      Color typeColor = _getEventTypeColor("${event["type"]}");
                      double occupancyRate = (event["registered"] as int) / (event["capacity"] as int);
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: typeColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${event["type"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: typeColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${event["status"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${event["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${event["date"]} at ${event["time"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${event["venue"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${event["registered"]}/${event["capacity"]} registered",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "${(occupancyRate * 100).toInt()}%",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: _getOccupancyColor(occupancyRate),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Container(
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: disabledColor.withAlpha(100),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: occupancyRate,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _getOccupancyColor(occupancyRate),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Price",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "\$${((event["price"] as double)).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Recent Activities
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Activities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: recentActivities.map((activity) {
                      Color activityColor;
                      IconData activityIcon;
                      
                      switch (activity["type"]) {
                        case "registration":
                          activityColor = Colors.blue;
                          activityIcon = Icons.person_add;
                          break;
                        case "payment":
                          activityColor = Colors.green;
                          activityIcon = Icons.payment;
                          break;
                        case "venue":
                          activityColor = Colors.purple;
                          activityIcon = Icons.location_on;
                          break;
                        case "speaker":
                          activityColor = Colors.orange;
                          activityIcon = Icons.mic;
                          break;
                        default:
                          activityColor = Colors.grey;
                          activityIcon = Icons.info;
                      }
                      
                      return Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: activityColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              activityIcon,
                              color: activityColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${activity["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${activity["attendee"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      " • ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${activity["time"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if ((activity["amount"] as double) > 0)
                            Text(
                              "\$${((activity["amount"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Popular Events
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Top Performing Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QHorizontalScroll(
                    children: popularEvents.map((event) {
                      return Container(
                        width: 250,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${event["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(event["rating"] as double).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "${event["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${event["registrations"]} attendees",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\$${((event["revenue"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Create Event",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View Reports",
                    icon: Icons.analytics,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return successColor;
      case 'planning':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      default:
        return infoColor;
    }
  }

  Color _getEventTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'conference':
        return Colors.blue;
      case 'launch':
        return Colors.purple;
      case 'networking':
        return Colors.green;
      case 'workshop':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getOccupancyColor(double rate) {
    if (rate >= 0.9) return dangerColor;
    if (rate >= 0.7) return warningColor;
    return successColor;
  }
}
