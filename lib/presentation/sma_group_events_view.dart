import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaGroupEventsView extends StatefulWidget {
  const SmaGroupEventsView({super.key});

  @override
  State<SmaGroupEventsView> createState() => _SmaGroupEventsViewState();
}

class _SmaGroupEventsViewState extends State<SmaGroupEventsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";

  final List<String> eventFilters = ["All", "Upcoming", "This Month", "My Events"];

  final List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Flutter Meetup 2024",
      "description": "Join us for an exciting Flutter meetup with guest speakers from Google and industry experts. We'll cover the latest Flutter updates, best practices, and networking opportunities.",
      "date": "2024-02-15",
      "time": "18:00",
      "endTime": "21:00",
      "location": "Tech Hub, San Francisco",
      "locationAddress": "123 Tech Street, San Francisco, CA",
      "attendees": 67,
      "maxAttendees": 100,
      "isAttending": false,
      "organizer": "John Doe",
      "organizerImage": "https://picsum.photos/40/40?random=10&keyword=organizer",
      "image": "https://picsum.photos/300/200?random=1&keyword=meetup",
      "category": "Meetup",
      "isPaid": false,
      "tags": ["Flutter", "Mobile", "Development"],
    },
    {
      "id": 2,
      "title": "Online Workshop: Advanced Flutter",
      "description": "Learn advanced Flutter concepts including custom animations, performance optimization, and state management patterns. Perfect for intermediate to advanced developers.",
      "date": "2024-02-20",
      "time": "14:00",
      "endTime": "17:00",
      "location": "Online",
      "locationAddress": "Zoom Meeting",
      "attendees": 234,
      "maxAttendees": 500,
      "isAttending": true,
      "organizer": "Jane Smith",
      "organizerImage": "https://picsum.photos/40/40?random=11&keyword=organizer",
      "image": "https://picsum.photos/300/200?random=2&keyword=workshop",
      "category": "Workshop",
      "isPaid": true,
      "price": 49.99,
      "tags": ["Flutter", "Advanced", "Online"],
    },
    {
      "id": 3,
      "title": "Flutter Community Hackathon",
      "description": "48-hour hackathon where teams compete to build innovative Flutter applications. Prizes, mentorship, and networking opportunities available.",
      "date": "2024-02-25",
      "time": "09:00",
      "endTime": "09:00",
      "endDate": "2024-02-27",
      "location": "Innovation Center, Austin",
      "locationAddress": "456 Innovation Blvd, Austin, TX",
      "attendees": 89,
      "maxAttendees": 150,
      "isAttending": false,
      "organizer": "Mike Johnson",
      "organizerImage": "https://picsum.photos/40/40?random=12&keyword=organizer",
      "image": "https://picsum.photos/300/200?random=3&keyword=hackathon",
      "category": "Hackathon",
      "isPaid": false,
      "tags": ["Flutter", "Competition", "Innovation"],
    },
    {
      "id": 4,
      "title": "Flutter for Beginners",
      "description": "Perfect for newcomers to Flutter. Learn the basics of Flutter development, widget system, and build your first mobile app.",
      "date": "2024-03-05",
      "time": "10:00",
      "endTime": "16:00",
      "location": "Learning Center, Seattle",
      "locationAddress": "789 Education Ave, Seattle, WA",
      "attendees": 45,
      "maxAttendees": 80,
      "isAttending": true,
      "organizer": "Sarah Wilson",
      "organizerImage": "https://picsum.photos/40/40?random=13&keyword=organizer",
      "image": "https://picsum.photos/300/200?random=4&keyword=training",
      "category": "Training",
      "isPaid": true,
      "price": 99.99,
      "tags": ["Flutter", "Beginner", "Fundamentals"],
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = events;

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((event) {
        return event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               event["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Apply category filter
    if (selectedFilter != "All") {
      if (selectedFilter == "Upcoming") {
        DateTime now = DateTime.now();
        filtered = filtered.where((event) {
          DateTime eventDate = DateTime.parse(event["date"]);
          return eventDate.isAfter(now);
        }).toList();
      } else if (selectedFilter == "This Month") {
        DateTime now = DateTime.now();
        filtered = filtered.where((event) {
          DateTime eventDate = DateTime.parse(event["date"]);
          return eventDate.month == now.month && eventDate.year == now.year;
        }).toList();
      } else if (selectedFilter == "My Events") {
        filtered = filtered.where((event) => event["isAttending"] as bool).toList();
      }
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Group Events",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "All Events", icon: Icon(Icons.event)),
        Tab(text: "My Events", icon: Icon(Icons.event_available)),
        Tab(text: "Create", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildAllEventsTab(),
        _buildMyEventsTab(),
        _buildCreateEventTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildAllEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search Bar
          QTextField(
            label: "Search events",
            value: searchQuery,
            hint: "Find events...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Filter Chips
          Container(
            height: 40,
            child: QHorizontalScroll(
              children: eventFilters.map((filter) {
                bool isSelected = selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    selectedFilter = filter;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Colors.white : primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Events List
          ...filteredEvents.map((event) {
            return _buildEventCard(event);
          }).toList(),

          if (filteredEvents.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No events found",
                    style: TextStyle(
                      fontSize: fsH6,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or filter criteria",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMyEventsTab() {
    List<Map<String, dynamic>> myEvents = events.where((event) => event["isAttending"] as bool).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // My Events Stats
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.event_available,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Registered Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${myEvents.length} events registered",
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // My Events List
          if (myEvents.isNotEmpty)
            ...myEvents.map((event) {
              return _buildEventCard(event, showActions: true);
            }).toList()
          else
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.event_note,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No events registered",
                    style: TextStyle(
                      fontSize: fsH6,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Browse events and register to see them here",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCreateEventTab() {
    String eventTitle = "";
    String eventDescription = "";
    String eventDate = "";
    String eventTime = "";
    String eventLocation = "";
    String eventLocationAddress = "";
    String eventCategory = "Meetup";
    bool isPaid = false;
    double price = 0.0;
    int maxAttendees = 50;

    final List<String> categoryOptions = ["Meetup", "Workshop", "Training", "Hackathon", "Conference"];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header
          Text(
            "Create New Event",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Event Title
          QTextField(
            label: "Event Title",
            value: eventTitle,
            hint: "Enter event title",
            onChanged: (value) {
              eventTitle = value;
              setState(() {});
            },
          ),

          // Event Description
          QMemoField(
            label: "Description",
            value: eventDescription,
            hint: "Describe your event...",
            maxLines: 4,
            onChanged: (value) {
              eventDescription = value;
              setState(() {});
            },
          ),

          // Date and Time
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Event Date",
                  value: eventDate.isNotEmpty ? DateTime.parse(eventDate) : DateTime.now(),
                  onChanged: (value) {
                    eventDate = value.toIso8601String().split('T')[0];
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTimePicker(
                  label: "Start Time",
                  value: eventTime.isNotEmpty 
                      ? TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $eventTime:00"))
                      : TimeOfDay.now(),
                  onChanged: (value) {
                    eventTime = value!.kkmm;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Location
          QTextField(
            label: "Event Location",
            value: eventLocation,
            hint: "Enter location name",
            onChanged: (value) {
              eventLocation = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Location Address",
            value: eventLocationAddress,
            hint: "Enter full address",
            onChanged: (value) {
              eventLocationAddress = value;
              setState(() {});
            },
          ),

          // Category and Capacity
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions.map((cat) => {"label": cat, "value": cat}).toList(),
                  value: eventCategory,
                  onChanged: (value, label) {
                    eventCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Max Attendees",
                  value: maxAttendees.toString(),
                  onChanged: (value) {
                    maxAttendees = int.tryParse(value) ?? 50;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Paid Event Toggle
          QSwitch(
            label: "Event Pricing",
            items: [
              {
                "label": "This is a paid event",
                "value": true,
                "checked": isPaid,
              }
            ],
            value: [
              if (isPaid)
                {
                  "label": "This is a paid event",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isPaid = values.isNotEmpty;
              setState(() {});
            },
          ),

          // Price (if paid)
          if (isPaid)
            QNumberField(
              label: "Price (\$)",
              value: price.toString(),
              onChanged: (value) {
                price = double.tryParse(value) ?? 0.0;
                setState(() {});
              },
            ),

          // Event Guidelines
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: infoColor.withAlpha(100),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Event Guidelines",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "• Ensure event details are accurate and complete\n• Respect attendee privacy and safety\n• Provide clear cancellation policies\n• Follow community guidelines and local regulations",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),

          // Create Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Event",
              size: bs.md,
              onPressed: () {
                _createEvent();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event, {bool showActions = false}) {
    DateTime eventDate = DateTime.parse(event["date"]);
    bool isUpcoming = eventDate.isAfter(DateTime.now());

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusSm),
              topRight: Radius.circular(radiusSm),
            ),
            child: Stack(
              children: [
                Image.network(
                  "${event["image"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${event["category"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (event["isPaid"] as bool)
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "\$${((event["price"] as double)).toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Event Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Title
                Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),

                // Event Description
                Text(
                  "${event["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),

                // Event Details
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${eventDate.dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["time"]}",
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
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${event["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                // Organizer and Attendees
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage("${event["organizerImage"]}"),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["organizer"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${event["attendees"]}/${event["maxAttendees"]} attending",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                // Action Buttons
                if (showActions)
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to event details
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Cancel",
                        size: bs.sm,
                        onPressed: () {
                          _cancelEventAttendance(event["id"]);
                        },
                      ),
                    ],
                  )
                else
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: event["isAttending"] as bool
                          ? "Already Registered"
                          : isUpcoming
                              ? "Register"
                              : "Event Ended",
                      size: bs.sm,
                      onPressed: (event["isAttending"] as bool) || !isUpcoming
                          ? null
                          : () {
                              _toggleEventAttendance(event["id"]);
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

  void _toggleEventAttendance(int eventId) {
    int index = events.indexWhere((event) => event["id"] == eventId);
    if (index != -1) {
      events[index]["isAttending"] = !(events[index]["isAttending"] as bool);
      if (events[index]["isAttending"] as bool) {
        events[index]["attendees"] = (events[index]["attendees"] as int) + 1;
        ss("Successfully registered for the event!");
      } else {
        events[index]["attendees"] = (events[index]["attendees"] as int) - 1;
        ss("Registration cancelled");
      }
      setState(() {});
    }
  }

  void _cancelEventAttendance(int eventId) {
    _toggleEventAttendance(eventId);
  }

  void _createEvent() {
    ss("Event created successfully!");
    selectedTab = 0;
    setState(() {});
  }
}
