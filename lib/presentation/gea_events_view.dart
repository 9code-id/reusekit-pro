import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaEventsView extends StatefulWidget {
  const GeaEventsView({super.key});

  @override
  State<GeaEventsView> createState() => _GeaEventsViewState();
}

class _GeaEventsViewState extends State<GeaEventsView> {
  int currentTab = 0;
  String selectedCategory = "All";
  List<String> categories = ["All", "Tournaments", "Matches", "Streams"];
  
  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Championship Finals 2024",
      "game": "Valorant",
      "type": "Tournament",
      "date": "2024-08-15",
      "time": "19:00",
      "status": "Live",
      "participants": 16,
      "prize": 50000,
      "image": "https://picsum.photos/300/200?random=1&keyword=gaming",
      "viewers": 125000,
      "category": "Tournaments"
    },
    {
      "id": 2,
      "title": "Pro League Match",
      "game": "CS2",
      "type": "Match",
      "date": "2024-08-16",
      "time": "20:30",
      "status": "Upcoming",
      "participants": 2,
      "prize": 15000,
      "image": "https://picsum.photos/300/200?random=2&keyword=esports",
      "viewers": 0,
      "category": "Matches"
    },
    {
      "id": 3,
      "title": "Weekly Tournament",
      "game": "League of Legends",
      "type": "Tournament",
      "date": "2024-08-17",
      "time": "18:00",
      "status": "Registration",
      "participants": 64,
      "prize": 25000,
      "image": "https://picsum.photos/300/200?random=3&keyword=tournament",
      "viewers": 0,
      "category": "Tournaments"
    }
  ];

  List<Map<String, dynamic>> get filteredEvents {
    if (selectedCategory == "All") return events;
    return events.where((event) => event["category"] == selectedCategory).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Live":
        return dangerColor;
      case "Upcoming":
        return warningColor;
      case "Registration":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Gaming Events",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Events", icon: Icon(Icons.event)),
        Tab(text: "Live", icon: Icon(Icons.live_tv)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildEventsTab(),
        _buildLiveTab(),
        _buildScheduleTab(),
      ],
    );
  }

  Widget _buildEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories
          QCategoryPicker(
            items: categories.map((category) => {
              "label": category,
              "value": category,
            }).toList(),
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Featured Event
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/400/200?random=10&keyword=gaming"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(180),
                  ],
                ),
              ),
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "World Championship 2024",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.people, color: Colors.white, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "250,000 viewers",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Spacer(),
                      Text(
                        "\$100,000 Prize",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Events List
          Text(
            "All Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredEvents.length,
            itemBuilder: (context, index) {
              final event = filteredEvents[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        bottomLeft: Radius.circular(radiusMd),
                      ),
                      child: Image.network(
                        "${event["image"]}",
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
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: getStatusColor("${event["status"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${event["status"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${event["game"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${event["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${event["date"]} ${event["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "\$${((event["prize"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                if ((event["viewers"] as int) > 0)
                                  Row(
                                    children: [
                                      Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${((event["viewers"] as int) / 1000).toStringAsFixed(0)}K",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLiveTab() {
    final liveEvents = events.where((event) => event["status"] == "Live").toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          if (liveEvents.isEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Icon(
                    Icons.tv_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No Live Events",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Check back later for live gaming events",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: spSm,
                mainAxisSpacing: spSm,
                childAspectRatio: 0.8,
              ),
              itemCount: liveEvents.length,
              itemBuilder: (context, index) {
                final event = liveEvents[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${event["image"]}",
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.circle, color: Colors.white, size: 8),
                                  SizedBox(width: spXs),
                                  Text(
                                    "LIVE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${event["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${event["game"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${((event["viewers"] as int) / 1000).toStringAsFixed(0)}K",
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
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    final upcomingEvents = events.where((event) => event["status"] != "Live").toList();
    
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
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: upcomingEvents.length,
            itemBuilder: (context, index) {
              final event = upcomingEvents[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${event["date"]}".split('-')[2],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${event["date"]}".split('-')[1],
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
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
                          Text(
                            "${event["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${event["game"]} • ${event["time"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: getStatusColor("${event["status"]}").withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${event["status"]}",
                              style: TextStyle(
                                color: getStatusColor("${event["status"]}"),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${((event["prize"] as int).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${event["participants"]} teams",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
