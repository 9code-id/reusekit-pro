import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRestaurantBookingView extends StatefulWidget {
  const HhaRestaurantBookingView({super.key});

  @override
  State<HhaRestaurantBookingView> createState() => _HhaRestaurantBookingViewState();
}

class _HhaRestaurantBookingViewState extends State<HhaRestaurantBookingView> {
  int selectedTab = 0;
  String selectedRestaurant = "Main Dining";
  String selectedDate = DateTime.now().toString().split(' ')[0];
  String selectedTime = "19:00";
  String partySize = "2";
  String specialRequests = "";
  String guestName = "";
  String guestPhone = "";
  String guestEmail = "";
  
  List<Map<String, dynamic>> restaurants = [
    {
      "name": "Main Dining",
      "cuisine": "International",
      "rating": 4.8,
      "image": "https://picsum.photos/300/200?random=1&keyword=restaurant",
      "capacity": 150,
      "priceRange": "\$\$\$",
      "features": ["Fine Dining", "Wine Pairing", "City View"]
    },
    {
      "name": "Rooftop Terrace",
      "cuisine": "Mediterranean",
      "rating": 4.9,
      "image": "https://picsum.photos/300/200?random=2&keyword=terrace",
      "capacity": 80,
      "priceRange": "\$\$\$\$",
      "features": ["Outdoor Seating", "Sunset View", "Live Music"]
    },
    {
      "name": "Sushi Bar",
      "cuisine": "Japanese",
      "rating": 4.7,
      "image": "https://picsum.photos/300/200?random=3&keyword=sushi",
      "capacity": 30,
      "priceRange": "\$\$\$\$",
      "features": ["Omakase", "Fresh Seafood", "Chef's Counter"]
    },
    {
      "name": "Poolside Grill",
      "cuisine": "American",
      "rating": 4.5,
      "image": "https://picsum.photos/300/200?random=4&keyword=grill",
      "capacity": 60,
      "priceRange": "\$\$",
      "features": ["Casual Dining", "Pool View", "BBQ Specialties"]
    },
  ];
  
  List<Map<String, dynamic>> bookings = [
    {
      "id": "RB001",
      "guestName": "John Smith",
      "restaurant": "Main Dining",
      "date": "2025-06-15",
      "time": "19:00",
      "partySize": 4,
      "status": "Confirmed",
      "specialRequests": "Anniversary dinner, window table preferred"
    },
    {
      "id": "RB002",
      "guestName": "Sarah Johnson",
      "restaurant": "Rooftop Terrace",
      "date": "2025-06-15",
      "time": "20:30",
      "partySize": 2,
      "status": "Pending",
      "specialRequests": "Vegetarian menu required"
    },
    {
      "id": "RB003",
      "guestName": "Mike Chen",
      "restaurant": "Sushi Bar",
      "date": "2025-06-16",
      "time": "18:00",
      "partySize": 6,
      "status": "Confirmed",
      "specialRequests": "Omakase tasting menu"
    },
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"time": "17:00", "available": true},
    {"time": "17:30", "available": true},
    {"time": "18:00", "available": false},
    {"time": "18:30", "available": true},
    {"time": "19:00", "available": true},
    {"time": "19:30", "available": false},
    {"time": "20:00", "available": true},
    {"time": "20:30", "available": true},
    {"time": "21:00", "available": true},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Restaurant Booking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "New Booking", icon: Icon(Icons.add_circle)),
        Tab(text: "Reservations", icon: Icon(Icons.restaurant)),
        Tab(text: "Restaurants", icon: Icon(Icons.dining)),
      ],
      tabChildren: [
        _buildNewBookingTab(),
        _buildReservationsTab(),
        _buildRestaurantsTab(),
      ],
    );
  }

  Widget _buildNewBookingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Restaurant Selection
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
                  "Select Restaurant",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Restaurant",
                  items: restaurants.map((restaurant) => {
                    "label": "${restaurant["name"]} - ${restaurant["cuisine"]}",
                    "value": restaurant["name"],
                  }).toList(),
                  value: selectedRestaurant,
                  onChanged: (value, label) {
                    selectedRestaurant = value;
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
                  "Date & Time",
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
                        label: "Reservation Date",
                        value: DateTime.parse(selectedDate),
                        onChanged: (value) {
                          selectedDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QTimePicker(
                        label: "Time",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2025-01-01 $selectedTime")),
                        onChanged: (value) {
                          selectedTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                // Available Time Slots
                Text("Available Time Slots:", style: TextStyle(fontWeight: FontWeight.w600)),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: timeSlots.map((slot) {
                    bool isSelected = slot["time"] == selectedTime;
                    bool isAvailable = slot["available"];
                    return GestureDetector(
                      onTap: isAvailable ? () {
                        selectedTime = slot["time"];
                        setState(() {});
                      } : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: !isAvailable ? disabledColor : 
                                 isSelected ? primaryColor : Colors.white,
                          border: Border.all(
                            color: !isAvailable ? disabledBoldColor :
                                   isSelected ? primaryColor : disabledBoldColor,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          slot["time"],
                          style: TextStyle(
                            color: !isAvailable ? disabledBoldColor :
                                   isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Party Details
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
                  "Party Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QNumberField(
                  label: "Party Size",
                  value: partySize,
                  onChanged: (value) {
                    partySize = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Special Requests",
                  value: specialRequests,
                  hint: "Dietary restrictions, special occasions, seating preferences...",
                  onChanged: (value) {
                    specialRequests = value;
                    setState(() {});
                  },
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
                QTextField(
                  label: "Email Address",
                  value: guestEmail,
                  onChanged: (value) {
                    guestEmail = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Booking Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(100)),
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
                    color: infoColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Restaurant:", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(selectedRestaurant),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date:", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(selectedDate),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Time:", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(selectedTime),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Party Size:", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("$partySize guests"),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Save Draft",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () => sw("Booking saved as draft"),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Confirm Booking",
                  size: bs.md,
                  onPressed: () => ss("Restaurant booking confirmed successfully!"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReservationsTab() {
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
                    {"label": "Pending", "value": "pending"},
                    {"label": "Cancelled", "value": "cancelled"},
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

          // Reservations List
          ...bookings.map((booking) {
            Color statusColor = booking["status"] == "Confirmed" ? successColor :
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
                        "Booking #${booking["id"]}",
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
                      Icon(Icons.restaurant, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${booking["restaurant"]}"),
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
                      Text("${booking["partySize"]} guests"),
                    ],
                  ),
                  if (booking["specialRequests"].isNotEmpty) ...[
                    SizedBox(height: spXs),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Special Requests: ${booking["specialRequests"]}",
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
                          onPressed: () => si("Edit booking functionality"),
                        ),
                      ),
                      if (booking["status"] == "Pending") ...[
                        Expanded(
                          child: QButton(
                            label: "Confirm",
                            color: successColor,
                            size: bs.sm,
                            onPressed: () => ss("Booking confirmed"),
                          ),
                        ),
                      ],
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          color: dangerColor,
                          size: bs.sm,
                          onPressed: () => se("Booking cancelled"),
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

  Widget _buildRestaurantsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: restaurants.map((restaurant) {
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
                    "${restaurant["image"]}",
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
                            "${restaurant["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${restaurant["rating"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "${restaurant["cuisine"]} Cuisine",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Capacity: ${restaurant["capacity"]} seats"),
                          Text("${restaurant["priceRange"]}", 
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (restaurant["features"] as List).map((feature) {
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
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Menu",
                              color: infoColor,
                              size: bs.sm,
                              onPressed: () => si("View menu for ${restaurant["name"]}"),
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Book Table",
                              size: bs.sm,
                              onPressed: () {
                                selectedRestaurant = restaurant["name"];
                                selectedTab = 0;
                                setState(() {});
                                ss("Restaurant selected for booking");
                              },
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
        }).toList(),
      ),
    );
  }
}
