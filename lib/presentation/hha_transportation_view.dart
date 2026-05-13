import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaTransportationView extends StatefulWidget {
  const HhaTransportationView({super.key});

  @override
  State<HhaTransportationView> createState() => _HhaTransportationViewState();
}

class _HhaTransportationViewState extends State<HhaTransportationView> {
  int selectedTab = 0;
  String selectedService = "";
  String pickupLocation = "";
  String destination = "";
  String pickupDate = DateTime.now().toString().split(' ')[0];
  String pickupTime = "09:00";
  String numberOfPassengers = "1";
  String guestName = "";
  String guestPhone = "";
  String specialRequests = "";
  
  List<Map<String, dynamic>> transportServices = [
    {
      "name": "Airport Transfer",
      "description": "Luxury airport pickup and drop-off service",
      "image": "https://picsum.photos/300/200?random=1&keyword=airport",
      "basePrice": 50,
      "capacity": "1-4 passengers",
      "features": ["Flight Tracking", "Meet & Greet", "Luggage Assistance", "WiFi"],
      "vehicles": ["Sedan", "SUV", "Van"]
    },
    {
      "name": "City Tour",
      "description": "Guided city sightseeing tours with professional driver",
      "image": "https://picsum.photos/300/200?random=2&keyword=city",
      "basePrice": 80,
      "capacity": "1-6 passengers",
      "features": ["Professional Guide", "Route Planning", "Photo Stops", "Refreshments"],
      "vehicles": ["Sedan", "SUV", "Mini Bus"]
    },
    {
      "name": "Business Transfer",
      "description": "Executive transportation for business meetings",
      "image": "https://picsum.photos/300/200?random=3&keyword=business",
      "basePrice": 40,
      "capacity": "1-3 passengers",
      "features": ["Executive Vehicles", "WiFi", "Water", "Phone Charging"],
      "vehicles": ["Luxury Sedan", "Executive SUV"]
    },
    {
      "name": "Event Transport",
      "description": "Group transportation for special events",
      "image": "https://picsum.photos/300/200?random=4&keyword=event",
      "basePrice": 120,
      "capacity": "8-20 passengers",
      "features": ["Large Groups", "Event Coordination", "Multiple Stops", "Decorations"],
      "vehicles": ["Mini Bus", "Coach", "Party Bus"]
    },
  ];
  
  List<Map<String, dynamic>> bookings = [
    {
      "id": "TR001",
      "guestName": "John Smith",
      "service": "Airport Transfer",
      "from": "Hotel Lobby",
      "to": "International Airport",
      "date": "2025-06-15",
      "time": "06:00",
      "passengers": 2,
      "vehicle": "Luxury Sedan",
      "driver": "Mike Johnson",
      "status": "Confirmed",
      "price": 75,
      "flightNumber": "UA123"
    },
    {
      "id": "TR002",
      "guestName": "Sarah Wilson",
      "service": "City Tour",
      "from": "Hotel Lobby",
      "to": "City Center",
      "date": "2025-06-15",
      "time": "10:00",
      "passengers": 4,
      "vehicle": "SUV",
      "driver": "Emma Davis",
      "status": "In Progress",
      "price": 160,
      "duration": "4 hours"
    },
    {
      "id": "TR003",
      "guestName": "David Brown",
      "service": "Business Transfer",
      "from": "Hotel",
      "to": "Business District",
      "date": "2025-06-15",
      "time": "14:30",
      "passengers": 1,
      "vehicle": "Executive Sedan",
      "driver": "Robert Lee",
      "status": "Pending",
      "price": 45,
      "meetingLocation": "Tower Plaza Building"
    },
  ];

  List<Map<String, dynamic>> vehicles = [
    {
      "type": "Luxury Sedan",
      "capacity": 4,
      "features": ["Leather Seats", "Climate Control", "WiFi", "Water"],
      "hourlyRate": 40,
      "available": true,
      "image": "https://picsum.photos/200/120?random=5&keyword=sedan"
    },
    {
      "type": "Executive SUV",
      "capacity": 6,
      "features": ["Premium Interior", "Tinted Windows", "Phone Charging", "Snacks"],
      "hourlyRate": 60,
      "available": true,
      "image": "https://picsum.photos/200/120?random=6&keyword=suv"
    },
    {
      "type": "Mini Bus",
      "capacity": 12,
      "features": ["Group Seating", "Storage Space", "Air Conditioning", "Audio System"],
      "hourlyRate": 80,
      "available": false,
      "image": "https://picsum.photos/200/120?random=7&keyword=bus"
    },
    {
      "type": "Luxury Van",
      "capacity": 8,
      "features": ["Comfortable Seating", "Entertainment System", "Refreshments", "WiFi"],
      "hourlyRate": 70,
      "available": true,
      "image": "https://picsum.photos/200/120?random=8&keyword=van"
    },
  ];

  List<Map<String, dynamic>> drivers = [
    {
      "name": "Mike Johnson",
      "experience": "8 years",
      "rating": 4.9,
      "languages": ["English", "Spanish"],
      "specialties": ["Airport Transfers", "City Tours"],
      "available": true,
      "image": "https://picsum.photos/100/100?random=9&keyword=man"
    },
    {
      "name": "Emma Davis",
      "experience": "6 years",
      "rating": 4.8,
      "languages": ["English", "French", "German"],
      "specialties": ["City Tours", "Business Transfers"],
      "available": true,
      "image": "https://picsum.photos/100/100?random=10&keyword=woman"
    },
    {
      "name": "Robert Lee",
      "experience": "10 years",
      "rating": 5.0,
      "languages": ["English", "Mandarin"],
      "specialties": ["Executive Services", "VIP Transport"],
      "available": false,
      "image": "https://picsum.photos/100/100?random=11&keyword=driver"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Transportation Service",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Book Transport", icon: Icon(Icons.directions_car)),
        Tab(text: "Active Bookings", icon: Icon(Icons.local_taxi)),
        Tab(text: "Services", icon: Icon(Icons.airport_shuttle)),
        Tab(text: "Fleet", icon: Icon(Icons.garage)),
      ],
      tabChildren: [
        _buildBookTransportTab(),
        _buildActiveBookingsTab(),
        _buildServicesTab(),
        _buildFleetTab(),
      ],
    );
  }

  Widget _buildBookTransportTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Service Selection
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
                  "Transportation Service",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Service Type",
                  items: transportServices.map((service) => {
                    "label": "${service["name"]} - \$${service["basePrice"]}",
                    "value": service["name"],
                  }).toList(),
                  value: selectedService,
                  onChanged: (value, label) {
                    selectedService = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Number of Passengers",
                  value: numberOfPassengers,
                  onChanged: (value) {
                    numberOfPassengers = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Location Details
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
                  "Trip Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Pickup Location",
                  value: pickupLocation,
                  hint: "Hotel lobby, room number, or specific address",
                  onChanged: (value) {
                    pickupLocation = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Destination",
                  value: destination,
                  hint: "Airport, business address, or landmark",
                  onChanged: (value) {
                    destination = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Schedule
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
                        label: "Pickup Date",
                        value: DateTime.parse(pickupDate),
                        onChanged: (value) {
                          pickupDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QTimePicker(
                        label: "Pickup Time",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2025-01-01 $pickupTime")),
                        onChanged: (value) {
                          pickupTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Guest Information
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
                  "Guest Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Guest Name",
                  value: guestName,
                  onChanged: (value) {
                    guestName = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Phone Number",
                  value: guestPhone,
                  onChanged: (value) {
                    guestPhone = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Special Requests",
                  value: specialRequests,
                  hint: "Child seats, wheelchair access, stops along the way...",
                  onChanged: (value) {
                    specialRequests = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Booking Summary
          if (selectedService.isNotEmpty && pickupLocation.isNotEmpty && destination.isNotEmpty) ...[
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
                    "Booking Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Service:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(selectedService),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Route:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Expanded(
                        child: Text(
                          "$pickupLocation → $destination",
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date & Time:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("$pickupDate at $pickupTime"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Passengers:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("$numberOfPassengers person(s)"),
                    ],
                  ),
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
                  onPressed: () => sw("Transportation booking saved as draft"),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Book Transport",
                  size: bs.md,
                  onPressed: () => ss("Transportation booked successfully!"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveBookingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildStatCard("Today's Trips", "${bookings.length}", Icons.directions_car, primaryColor),
              _buildStatCard("In Progress", "${bookings.where((b) => b["status"] == "In Progress").length}", Icons.navigation, infoColor),
              _buildStatCard("Confirmed", "${bookings.where((b) => b["status"] == "Confirmed").length}", Icons.check_circle, successColor),
              _buildStatCard("Pending", "${bookings.where((b) => b["status"] == "Pending").length}", Icons.schedule, warningColor),
            ],
          ),

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
                    {"label": "In Progress", "value": "in_progress"},
                    {"label": "Pending", "value": "pending"},
                    {"label": "Completed", "value": "completed"},
                  ],
                  value: "all",
                  onChanged: (value, label) {},
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Search Guest",
                  value: "",
                  hint: "Guest name...",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),

          // Bookings List
          ...bookings.map((booking) {
            Color statusColor = booking["status"] == "Confirmed" ? successColor :
                               booking["status"] == "In Progress" ? infoColor :
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
                        "Trip #${booking["id"]}",
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
                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${booking["guestName"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.airport_shuttle, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${booking["service"]} - ${booking["vehicle"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.route, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text("${booking["from"]} → ${booking["to"]}"),
                      ),
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
                      Text("${booking["passengers"]} passenger(s)"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Driver: ${booking["driver"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("\$${((booking["price"] as int).toDouble()).currency}"),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    spacing: spXs,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Driver",
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () => si("Calling driver ${booking["driver"]}"),
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Track",
                          color: successColor,
                          size: bs.sm,
                          onPressed: () => ss("Tracking vehicle location"),
                        ),
                      ),
                      if (booking["status"] == "Pending") ...[
                        Expanded(
                          child: QButton(
                            label: "Cancel",
                            color: dangerColor,
                            size: bs.sm,
                            onPressed: () => se("Trip cancelled"),
                          ),
                        ),
                      ],
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

  Widget _buildServicesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: transportServices.map((service) {
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
                    "${service["image"]}",
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
                            "${service["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "From \$${service["basePrice"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${service["description"]}",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                      Text(
                        "Capacity: ${service["capacity"]}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (service["features"] as List).map((feature) {
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
                          label: "Book This Service",
                          size: bs.sm,
                          onPressed: () {
                            selectedService = service["name"];
                            selectedTab = 0;
                            setState(() {});
                            ss("Service selected for booking");
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

  Widget _buildFleetTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Fleet Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildStatCard("Total Vehicles", "${vehicles.length}", Icons.directions_car, primaryColor),
              _buildStatCard("Available", "${vehicles.where((v) => v["available"]).length}", Icons.check_circle, successColor),
              _buildStatCard("In Use", "${vehicles.where((v) => !v["available"]).length}", Icons.directions, infoColor),
              _buildStatCard("Drivers", "${drivers.length}", Icons.person, warningColor),
            ],
          ),

          // Vehicles List
          Text(
            "Vehicle Fleet",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...vehicles.map((vehicle) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: vehicle["available"] ? successColor : dangerColor,
                  ),
                ),
              ),
              child: Row(
                spacing: spSm,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${vehicle["image"]}",
                      width: 100,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${vehicle["type"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: vehicle["available"] ? 
                                  successColor.withAlpha(100) : dangerColor.withAlpha(100),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                vehicle["available"] ? "Available" : "In Use",
                                style: TextStyle(
                                  color: vehicle["available"] ? successColor : dangerColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Capacity: ${vehicle["capacity"]} passengers",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "\$${vehicle["hourlyRate"]}/hour",
                          style: TextStyle(
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: spXs,
                          children: (vehicle["features"] as List).take(3).map((feature) {
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
                ],
              ),
            );
          }).toList(),

          SizedBox(height: spMd),

          // Drivers Section
          Text(
            "Available Drivers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...drivers.map((driver) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: driver["available"] ? successColor : dangerColor,
                  ),
                ),
              ),
              child: Row(
                spacing: spSm,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${driver["image"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${driver["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                Text(
                                  "${driver["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text("Experience: ${driver["experience"]}"),
                        Text("Languages: ${(driver["languages"] as List).join(", ")}"),
                        Text("Specialties: ${(driver["specialties"] as List).join(", ")}",
                          style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: driver["available"] ? 
                        successColor.withAlpha(100) : dangerColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      driver["available"] ? "Available" : "On Duty",
                      style: TextStyle(
                        color: driver["available"] ? successColor : dangerColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(width: 3, color: color),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
