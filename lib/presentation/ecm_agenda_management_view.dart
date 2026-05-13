import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmAgendaManagementView extends StatefulWidget {
  const EcmAgendaManagementView({super.key});

  @override
  State<EcmAgendaManagementView> createState() => _EcmAgendaManagementViewState();
}

class _EcmAgendaManagementViewState extends State<EcmAgendaManagementView> {
  String searchQuery = "";
  String selectedDay = "All";
  String selectedTrack = "All";
  bool showFavoritesOnly = false;

  List<Map<String, dynamic>> dayOptions = [
    {"label": "All Days", "value": "All"},
    {"label": "Day 1 - Jan 15", "value": "2024-01-15"},
    {"label": "Day 2 - Jan 16", "value": "2024-01-16"},
    {"label": "Day 3 - Jan 17", "value": "2024-01-17"},
  ];

  List<Map<String, dynamic>> trackOptions = [
    {"label": "All Tracks", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Business", "value": "Business"},
    {"label": "Design", "value": "Design"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Keynote", "value": "Keynote"},
  ];

  List<Map<String, dynamic>> agendaItems = [
    {
      "id": "1",
      "title": "Opening Keynote: The Future of Technology",
      "description": "Join us for an inspiring keynote about emerging technologies and their impact on society.",
      "date": "2024-01-15",
      "start_time": "09:00",
      "end_time": "10:00",
      "track": "Keynote",
      "location": "Main Auditorium",
      "speaker": "Dr. Sarah Johnson",
      "speaker_title": "Chief Technology Officer",
      "speaker_company": "TechCorp",
      "speaker_avatar": "https://picsum.photos/100/100?random=1&keyword=speaker",
      "attendees_count": 1200,
      "capacity": 1500,
      "is_favorite": true,
      "is_registered": true,
      "session_type": "keynote",
      "status": "confirmed",
      "tags": ["technology", "future", "innovation"]
    },
    {
      "id": "2",
      "title": "Building Scalable Web Applications",
      "description": "Learn best practices for building web applications that can handle millions of users.",
      "date": "2024-01-15",
      "start_time": "10:30",
      "end_time": "11:30",
      "track": "Technology",
      "location": "Tech Hall A",
      "speaker": "Michael Chen",
      "speaker_title": "Senior Software Engineer",
      "speaker_company": "DevStudio",
      "speaker_avatar": "https://picsum.photos/100/100?random=2&keyword=speaker",
      "attendees_count": 85,
      "capacity": 100,
      "is_favorite": false,
      "is_registered": true,
      "session_type": "workshop",
      "status": "confirmed",
      "tags": ["web-development", "scalability", "architecture"]
    },
    {
      "id": "3",
      "title": "Design Thinking for Product Innovation",
      "description": "Discover how design thinking can drive innovation in your product development process.",
      "date": "2024-01-15",
      "start_time": "13:00",
      "end_time": "14:00",
      "track": "Design",
      "location": "Design Studio",
      "speaker": "Emily Rodriguez",
      "speaker_title": "Head of Design",
      "speaker_company": "Creative Solutions",
      "speaker_avatar": "https://picsum.photos/100/100?random=3&keyword=speaker",
      "attendees_count": 67,
      "capacity": 80,
      "is_favorite": true,
      "is_registered": false,
      "session_type": "presentation",
      "status": "confirmed",
      "tags": ["design-thinking", "innovation", "product-development"]
    },
    {
      "id": "4",
      "title": "Digital Marketing Strategies for 2024",
      "description": "Explore the latest digital marketing trends and strategies for the coming year.",
      "date": "2024-01-16",
      "start_time": "09:30",
      "end_time": "10:30",
      "track": "Marketing",
      "location": "Marketing Hub",
      "speaker": "David Wilson",
      "speaker_title": "Marketing Director",
      "speaker_company": "Growth Partners",
      "speaker_avatar": "https://picsum.photos/100/100?random=4&keyword=speaker",
      "attendees_count": 92,
      "capacity": 120,
      "is_favorite": false,
      "is_registered": true,
      "session_type": "presentation",
      "status": "confirmed",
      "tags": ["digital-marketing", "strategy", "trends"]
    },
    {
      "id": "5",
      "title": "Leadership in Times of Change",
      "description": "Navigate organizational change with effective leadership strategies and communication.",
      "date": "2024-01-16",
      "start_time": "11:00",
      "end_time": "12:00",
      "track": "Business",
      "location": "Business Center",
      "speaker": "Lisa Park",
      "speaker_title": "CEO",
      "speaker_company": "Leadership Consulting",
      "speaker_avatar": "https://picsum.photos/100/100?random=5&keyword=speaker",
      "attendees_count": 156,
      "capacity": 200,
      "is_favorite": true,
      "is_registered": false,
      "session_type": "panel",
      "status": "confirmed",
      "tags": ["leadership", "change-management", "communication"]
    },
    {
      "id": "6",
      "title": "Networking Lunch & Exhibition",
      "description": "Connect with attendees while exploring sponsor exhibitions and enjoying lunch.",
      "date": "2024-01-16",
      "start_time": "12:00",
      "end_time": "13:30",
      "track": "Networking",  
      "location": "Exhibition Hall",
      "speaker": "Conference Team",
      "speaker_title": "Event Organizers",
      "speaker_company": "EventCorp",
      "speaker_avatar": "https://picsum.photos/100/100?random=6&keyword=team",
      "attendees_count": 800,
      "capacity": 1000,
      "is_favorite": false,
      "is_registered": true,
      "session_type": "networking",
      "status": "confirmed",
      "tags": ["networking", "exhibition", "lunch"]
    },
  ];

  List<Map<String, dynamic>> get filteredAgenda {
    List<Map<String, dynamic>> filtered = agendaItems;
    
    if (selectedDay != "All") {
      filtered = filtered.where((item) => item["date"] == selectedDay).toList();
    }
    
    if (selectedTrack != "All") {
      filtered = filtered.where((item) => item["track"] == selectedTrack).toList();
    }
    
    if (showFavoritesOnly) {
      filtered = filtered.where((item) => item["is_favorite"] == true).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        return item["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               item["description"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               item["speaker"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               (item["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    // Sort by date and time
    filtered.sort((a, b) {
      int dateComparison = a["date"].compareTo(b["date"]);
      if (dateComparison != 0) return dateComparison;
      return a["start_time"].compareTo(b["start_time"]);
    });
    
    return filtered;
  }

  String _getSessionTypeColor(String sessionType) {
    switch (sessionType) {
      case "keynote":
        return "primary";
      case "workshop":
        return "success";
      case "presentation":
        return "info";
      case "panel":
        return "warning";
      case "networking":
        return "secondary";
      default:
        return "disabled";
    }
  }

  Color _getSessionTypeColorValue(String sessionType) {
    switch (sessionType) {
      case "keynote":
        return primaryColor;
      case "workshop":
        return successColor;
      case "presentation":
        return infoColor;
      case "panel":
        return warningColor;
      case "networking":
        return secondaryColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite),
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
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Conference Agenda",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Manage your personalized conference schedule",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search sessions",
                    value: searchQuery,
                    hint: "Search by title, speaker, or tags",
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
                    label: "Day",
                    items: dayOptions,
                    value: selectedDay,
                    onChanged: (value, label) {
                      selectedDay = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Track",
                    items: trackOptions,
                    value: selectedTrack,
                    onChanged: (value, label) {
                      selectedTrack = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QSwitch(
              items: [
                {
                  "label": "Show Favorites Only",
                  "value": true,
                  "checked": showFavoritesOnly,
                }
              ],
              value: [
                if (showFavoritesOnly)
                  {
                    "label": "Show Favorites Only",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showFavoritesOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

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
                    children: [
                      Icon(
                        Icons.event_note,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Session Schedule",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${filteredAgenda.length} sessions",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (filteredAgenda.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No sessions found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or filters",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...List.generate(filteredAgenda.length, (index) {
                      final session = filteredAgenda[index];
                      final sessionColor = _getSessionTypeColorValue(session["session_type"]);
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: sessionColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: sessionColor.withAlpha(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${session["speaker_avatar"]}"),
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
                                          Expanded(
                                            child: Text(
                                              "${session["title"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              session["is_favorite"] = !session["is_favorite"];
                                              setState(() {});
                                            },
                                            child: Icon(
                                              session["is_favorite"] ? Icons.favorite : Icons.favorite_border,
                                              size: 20,
                                              color: session["is_favorite"] ? dangerColor : disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${session["speaker"]} • ${session["speaker_title"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${session["speaker_company"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${session["description"]}",
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
                                  Icons.access_time,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${DateTime.parse(session["date"]).dMMMy} • ${session["start_time"]} - ${session["end_time"]}",
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
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${session["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.people,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${session["attendees_count"]}/${session["capacity"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: sessionColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${session["session_type"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: sessionColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${session["track"]}",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                if ((session["tags"] as List).isNotEmpty)
                                  ...List.generate(
                                    (session["tags"] as List).length > 2 ? 2 : (session["tags"] as List).length,
                                    (tagIndex) {
                                      final tag = (session["tags"] as List)[tagIndex];
                                      return Container(
                                        margin: EdgeInsets.only(left: 4),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "#$tag",
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: infoColor,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 36,
                                    child: QButton(
                                      label: session["is_registered"] ? "Registered" : "Register",
                                      size: bs.sm,
                                      onPressed: () {
                                        if (session["is_registered"]) {
                                          sw("You are already registered for this session");
                                        } else {
                                          session["is_registered"] = true;
                                          session["attendees_count"] = (session["attendees_count"] as int) + 1;
                                          setState(() {});
                                          ss("Successfully registered for session!");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Container(
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "View Details",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.share,
                                      size: 18,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
