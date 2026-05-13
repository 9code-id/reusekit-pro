import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaEventBookingView extends StatefulWidget {
  const HhaEventBookingView({super.key});

  @override
  State<HhaEventBookingView> createState() => _HhaEventBookingViewState();
}

class _HhaEventBookingViewState extends State<HhaEventBookingView> {
  int selectedTab = 0;
  String selectedEvent = "";
  String selectedDate = DateTime.now().toString().split(' ')[0];
  String selectedTime = "18:00";
  String numberOfGuests = "50";
  String eventRequirements = "";
  String clientName = "";
  String clientPhone = "";
  String clientEmail = "";
  String eventBudget = "";
  
  List<Map<String, dynamic>> eventTypes = [
    {
      "name": "Wedding Reception",
      "description": "Elegant wedding celebrations with full service",
      "image": "https://picsum.photos/300/200?random=1&keyword=wedding",
      "capacity": "200 guests",
      "basePrice": 5000,
      "features": ["Bridal Suite", "Decorations", "Photography", "Catering"]
    },
    {
      "name": "Corporate Conference",
      "description": "Professional business events and conferences",
      "image": "https://picsum.photos/300/200?random=2&keyword=conference",
      "capacity": "150 guests",
      "basePrice": 3000,
      "features": ["AV Equipment", "WiFi", "Catering", "Parking"]
    },
    {
      "name": "Birthday Party",
      "description": "Memorable birthday celebrations for all ages",
      "image": "https://picsum.photos/300/200?random=3&keyword=birthday",
      "capacity": "100 guests",
      "basePrice": 2000,
      "features": ["Decorations", "Entertainment", "Cake", "Photography"]
    },
    {
      "name": "Gala Dinner",
      "description": "Formal dinner events and award ceremonies",
      "image": "https://picsum.photos/300/200?random=4&keyword=gala",
      "capacity": "300 guests",
      "basePrice": 8000,
      "features": ["Fine Dining", "Entertainment", "Awards Ceremony", "Red Carpet"]
    },
  ];
  
  List<Map<String, dynamic>> bookings = [
    {
      "id": "EVT001",
      "clientName": "Smith & Associates",
      "eventType": "Corporate Conference",
      "date": "2025-06-20",
      "time": "09:00",
      "guests": 120,
      "status": "Confirmed",
      "budget": 4500,
      "requirements": "Full AV setup, lunch catering, parking for 100 cars"
    },
    {
      "id": "EVT002",
      "clientName": "Johnson Wedding",
      "eventType": "Wedding Reception",
      "date": "2025-06-25",
      "time": "18:00",
      "guests": 180,
      "status": "Planning",
      "budget": 12000,
      "requirements": "Garden ceremony, reception hall, bridal suite preparation"
    },
    {
      "id": "EVT003",
      "clientName": "Tech Innovation Awards",
      "eventType": "Gala Dinner",
      "date": "2025-07-01",
      "time": "19:00",
      "guests": 250,
      "status": "Pending",
      "budget": 15000,
      "requirements": "Stage setup, lighting, awards presentation, live streaming"
    },
  ];

  List<Map<String, dynamic>> venues = [
    {
      "name": "Grand Ballroom",
      "capacity": 300,
      "features": ["Crystal Chandeliers", "Stage", "Dance Floor"],
      "hourlyRate": 500,
      "image": "https://picsum.photos/250/150?random=5&keyword=ballroom"
    },
    {
      "name": "Garden Pavilion",
      "capacity": 150,
      "features": ["Outdoor Setting", "Garden View", "Natural Lighting"],
      "hourlyRate": 300,
      "image": "https://picsum.photos/250/150?random=6&keyword=garden"
    },
    {
      "name": "Conference Center",
      "capacity": 200,
      "features": ["AV Equipment", "Presentation Screens", "WiFi"],
      "hourlyRate": 400,
      "image": "https://picsum.photos/250/150?random=7&keyword=conference"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Event Booking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "New Event", icon: Icon(Icons.event)),
        Tab(text: "Bookings", icon: Icon(Icons.calendar_today)),
        Tab(text: "Event Types", icon: Icon(Icons.category)),
        Tab(text: "Venues", icon: Icon(Icons.place)),
      ],
      tabChildren: [
        _buildNewEventTab(),
        _buildBookingsTab(),
        _buildEventTypesTab(),
        _buildVenuesTab(),
      ],
    );
  }

  Widget _buildNewEventTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Event Type Selection
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Event Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Event Type",
                  items: eventTypes.map((event) => {
                    "label": "${event["name"]} - ${event["capacity"]}",
                    "value": event["name"],
                  }).toList(),
                  value: selectedEvent,
                  onChanged: (value, label) {
                    selectedEvent = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Number of Guests",
                  value: numberOfGuests,
                  onChanged: (value) {
                    numberOfGuests = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Date & Time Selection
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Schedule",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Event Date",
                        value: DateTime.parse(selectedDate),
                        onChanged: (value) {
                          selectedDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QTimePicker(
                        label: "Start Time",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2025-01-01 $selectedTime")),
                        onChanged: (value) {
                          selectedTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Budget & Requirements
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Event Specifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QNumberField(
                  label: "Budget (\$)",
                  value: eventBudget,
                  onChanged: (value) {
                    eventBudget = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Special Requirements",
                  value: eventRequirements,
                  hint: "Describe any special needs, equipment, catering preferences, decorations...",
                  onChanged: (value) {
                    eventRequirements = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Client Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Client Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Client Name",
                  value: clientName,
                  onChanged: (value) {
                    clientName = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Phone Number",
                  value: clientPhone,
                  onChanged: (value) {
                    clientPhone = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Email Address",
                  value: clientEmail,
                  onChanged: (value) {
                    clientEmail = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Event Summary
          if (selectedEvent.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Event Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Event Type:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(selectedEvent),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date & Time:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("$selectedDate at $selectedTime"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Guests:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("$numberOfGuests people"),
                    ],
                  ),
                  if (eventBudget.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Budget:", style: TextStyle(fontWeight: FontWeight.w600)),
                        Text("\$$eventBudget"),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Save Draft",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () => sw("Event booking saved as draft"),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Submit Request",
                  size: bs.md,
                  onPressed: () => ss("Event booking request submitted successfully!"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filter Options
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status Filter",
                  items: [
                    {"label": "All Status", "value": "all"},
                    {"label": "Confirmed", "value": "confirmed"},
                    {"label": "Planning", "value": "planning"},
                    {"label": "Pending", "value": "pending"},
                    {"label": "Completed", "value": "completed"},
                  ],
                  value: "all",
                  onChanged: (value, label) {},
                ),
              ),
              Expanded(
                child: QDatePicker(
                  label: "Filter by Date",
                  value: DateTime.now(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),

          // Event Bookings List
          ...bookings.map((booking) {
            Color statusColor = booking["status"] == "Confirmed" ? successColor :
                               booking["status"] == "Planning" ? infoColor :
                               booking["status"] == "Pending" ? warningColor : dangerColor;
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(width: 4, color: statusColor),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Event #${booking["id"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          booking["status"],
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  Row(
                    children: [
                      Icon(Icons.business, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${booking["clientName"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.event, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${booking["eventType"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${booking["date"]} at ${booking["time"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.group, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${booking["guests"]} guests"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("\$${((booking["budget"] as int).toDouble()).currency}"),
                    ],
                  ),
                  if (booking["requirements"].isNotEmpty) ...[
                    SizedBox(height: spXs),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Requirements: ${booking["requirements"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: spSm),
                  Row(
                    spacing: spXs,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Edit",
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () => si("Edit event details"),
                        ),
                      ),
                      if (booking["status"] == "Pending") ...[
                        Expanded(
                          child: QButton(
                            label: "Approve",
                            color: successColor,
                            size: bs.sm,
                            onPressed: () => ss("Event approved"),
                          ),
                        ),
                      ],
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          color: dangerColor,
                          size: bs.sm,
                          onPressed: () => se("Event cancelled"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEventTypesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: eventTypes.map((eventType) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  child: Image.network(
                    "${eventType["image"]}",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${eventType["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "From \$${((eventType["basePrice"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${eventType["description"]}",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                      Text(
                        "Capacity: ${eventType["capacity"]}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (eventType["features"] as List).map((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Select Event Type",
                          size: bs.sm,
                          onPressed: () {
                            selectedEvent = eventType["name"];
                            selectedTab = 0;
                            setState(() {});
                            ss("Event type selected");
                          },
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
    );
  }

  Widget _buildVenuesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: venues.map((venue) {
          return Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              spacing: spSm,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${venue["image"]}",
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "${venue["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Capacity: ${venue["capacity"]} guests",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "\$${venue["hourlyRate"]}/hour",
                        style: TextStyle(
                          color: successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: spXs,
                        children: (venue["features"] as List).take(2).map((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Column(
                  spacing: spXs,
                  children: [
                    QButton(
                      label: "Book",
                      size: bs.sm,
                      onPressed: () => ss("Venue booking initiated"),
                    ),
                    QButton(
                      label: "Details",
                      color: infoColor,
                      size: bs.sm,
                      onPressed: () => si("View venue details"),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
