import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsBookingCalendarView extends StatefulWidget {
  const RfsBookingCalendarView({super.key});

  @override
  State<RfsBookingCalendarView> createState() => _RfsBookingCalendarViewState();
}

class _RfsBookingCalendarViewState extends State<RfsBookingCalendarView> {
  DateTime selectedDate = DateTime.now();
  String selectedTimeSlot = "";
  String selectedView = "Day";
  
  String guestName = "";
  String guestPhone = "";
  String guestEmail = "";
  int partySize = 2;
  String specialRequests = "";
  String preferredTable = "";

  List<Map<String, dynamic>> viewTypes = [
    {"label": "Day View", "value": "Day"},
    {"label": "Week View", "value": "Week"},
    {"label": "Month View", "value": "Month"},
  ];

  List<Map<String, dynamic>> partySizeOptions = [
    {"label": "1 Guest", "value": 1},
    {"label": "2 Guests", "value": 2},
    {"label": "3 Guests", "value": 3},
    {"label": "4 Guests", "value": 4},
    {"label": "5 Guests", "value": 5},
    {"label": "6 Guests", "value": 6},
    {"label": "7 Guests", "value": 7},
    {"label": "8+ Guests", "value": 8},
  ];

  List<Map<String, dynamic>> tablePreferences = [
    {"label": "No Preference", "value": ""},
    {"label": "Window Table", "value": "Window"},
    {"label": "Booth", "value": "Booth"},
    {"label": "Bar Counter", "value": "Bar"},
    {"label": "Private Room", "value": "Private"},
    {"label": "Outdoor Terrace", "value": "Outdoor"},
  ];

  List<String> timeSlots = [
    "5:00 PM", "5:30 PM", "6:00 PM", "6:30 PM", "7:00 PM", "7:30 PM",
    "8:00 PM", "8:30 PM", "9:00 PM", "9:30 PM", "10:00 PM"
  ];

  Map<String, List<Map<String, dynamic>>> bookings = {
    "2025-06-19": [
      {
        "time": "6:00 PM",
        "guest": "Smith Family",
        "partySize": 4,
        "table": "12",
        "status": "Confirmed",
        "phone": "+1 234-567-8901",
      },
      {
        "time": "7:30 PM",
        "guest": "Johnson Party",
        "partySize": 6,
        "table": "VIP-1",
        "status": "Confirmed",
        "phone": "+1 234-567-8902",
      },
      {
        "time": "8:00 PM",
        "guest": "Davis",
        "partySize": 2,
        "table": "8",
        "status": "Pending",
        "phone": "+1 234-567-8903",
      },
    ],
    "2025-06-20": [
      {
        "time": "6:30 PM",
        "guest": "Williams",
        "partySize": 3,
        "table": "5",
        "status": "Confirmed",
        "phone": "+1 234-567-8904",
      },
      {
        "time": "7:00 PM",
        "guest": "Corporate Event",
        "partySize": 12,
        "table": "Private Room",
        "status": "Confirmed",
        "phone": "+1 234-567-8905",
      },
    ],
  };

  List<Map<String, dynamic>> get todayBookings {
    String dateKey = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    return bookings[dateKey] ?? [];
  }

  bool _isTimeSlotAvailable(String timeSlot) {
    return !todayBookings.any((booking) => booking["time"] == timeSlot);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _selectTimeSlot(String timeSlot) {
    if (_isTimeSlotAvailable(timeSlot)) {
      setState(() {
        selectedTimeSlot = timeSlot;
      });
    } else {
      se("This time slot is already booked");
    }
  }

  void _createReservation() async {
    if (guestName.isEmpty || guestPhone.isEmpty || selectedTimeSlot.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    bool isConfirmed = await confirm("Create reservation for $guestName on ${selectedDate.day}/${selectedDate.month}/${selectedDate.year} at $selectedTimeSlot?");
    if (isConfirmed) {
      String dateKey = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      
      if (bookings[dateKey] == null) {
        bookings[dateKey] = [];
      }
      
      bookings[dateKey]!.add({
        "time": selectedTimeSlot,
        "guest": guestName,
        "partySize": partySize,
        "table": "TBD",
        "status": "Pending",
        "phone": guestPhone,
        "email": guestEmail,
        "specialRequests": specialRequests,
        "preferredTable": preferredTable,
      });

      setState(() {
        guestName = "";
        guestPhone = "";
        guestEmail = "";
        partySize = 2;
        specialRequests = "";
        preferredTable = "";
        selectedTimeSlot = "";
      });

      ss("Reservation created successfully!");
    }
  }

  void _changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  void _viewBookingDetails(Map<String, dynamic> booking) {
    si("Viewing details for ${booking["guest"]} at ${booking["time"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Calendar"),
        actions: [
          QButton(
            icon: Icons.today,
            size: bs.sm,
            onPressed: () {
              setState(() {
                selectedDate = DateTime.now();
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Navigation
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  QButton(
                    icon: Icons.chevron_left,
                    size: bs.sm,
                    onPressed: () => _changeDate(-1),
                  ),
                  Expanded(
                    child: Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  QButton(
                    icon: Icons.chevron_right,
                    size: bs.sm,
                    onPressed: () => _changeDate(1),
                  ),
                ],
              ),
            ),

            // Calendar View Options
            QCategoryPicker(
              label: "Calendar View",
              items: viewTypes,
              value: selectedView,
              onChanged: (index, label, value, item) {
                selectedView = value;
                setState(() {});
              },
            ),

            // Time Slots Grid
            Text(
              "Available Time Slots",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: timeSlots.map((timeSlot) {
                bool isAvailable = _isTimeSlotAvailable(timeSlot);
                bool isSelected = selectedTimeSlot == timeSlot;
                
                return GestureDetector(
                  onTap: () => _selectTimeSlot(timeSlot),
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                        ? primaryColor.withAlpha(100)
                        : isAvailable 
                          ? Colors.white
                          : disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected 
                          ? primaryColor
                          : isAvailable 
                            ? disabledOutlineBorderColor
                            : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          isAvailable ? Icons.access_time : Icons.block,
                          color: isSelected 
                            ? primaryColor
                            : isAvailable 
                              ? successColor
                              : disabledBoldColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          timeSlot,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected 
                              ? primaryColor
                              : isAvailable 
                                ? primaryColor
                                : disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          isAvailable ? "Available" : "Booked",
                          style: TextStyle(
                            fontSize: 10,
                            color: isAvailable ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Current Bookings
            if (todayBookings.isNotEmpty) ...[
              Text(
                "Current Bookings (${todayBookings.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Column(
                spacing: spSm,
                children: todayBookings.map((booking) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getStatusColor(booking["status"]),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: primaryColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${booking["time"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(booking["status"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${booking["status"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.person, size: 14, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${booking["guest"]} (${booking["partySize"]} guests)",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              if (booking["table"] != "TBD")
                                Row(
                                  children: [
                                    Icon(Icons.table_restaurant, size: 14, color: disabledBoldColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "Table ${booking["table"]}",
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
                        QButton(
                          icon: Icons.visibility,
                          size: bs.sm,
                          onPressed: () => _viewBookingDetails(booking),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            // New Reservation Form
            if (selectedTimeSlot.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.add_circle, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "New Reservation - $selectedTimeSlot",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    QTextField(
                      label: "Guest Name*",
                      value: guestName,
                      hint: "Enter guest name",
                      onChanged: (value) {
                        guestName = value;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Phone Number*",
                            value: guestPhone,
                            hint: "+1 234-567-8900",
                            onChanged: (value) {
                              guestPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Party Size*",
                            items: partySizeOptions,
                            value: partySize,
                            onChanged: (value, label) {
                              partySize = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    QTextField(
                      label: "Email Address",
                      value: guestEmail,
                      hint: "guest@email.com",
                      onChanged: (value) {
                        guestEmail = value;
                        setState(() {});
                      },
                    ),

                    QDropdownField(
                      label: "Table Preference",
                      items: tablePreferences,
                      value: preferredTable,
                      onChanged: (value, label) {
                        preferredTable = value;
                        setState(() {});
                      },
                    ),

                    QMemoField(
                      label: "Special Requests",
                      value: specialRequests,
                      hint: "Allergies, dietary restrictions, special occasions...",
                      onChanged: (value) {
                        specialRequests = value;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Create Reservation",
                            onPressed: _createReservation,
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.clear,
                          size: bs.sm,
                          onPressed: () {
                            setState(() {
                              selectedTimeSlot = "";
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
