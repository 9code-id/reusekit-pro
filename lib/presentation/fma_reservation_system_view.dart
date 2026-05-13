import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaReservationSystemView extends StatefulWidget {
  const FmaReservationSystemView({super.key});

  @override
  State<FmaReservationSystemView> createState() => _FmaReservationSystemViewState();
}

class _FmaReservationSystemViewState extends State<FmaReservationSystemView> {
  int currentTab = 0;
  String selectedDate = DateTime.now().toString().split(' ')[0];
  String selectedStatus = "All";
  String selectedTimeSlot = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Seated", "value": "Seated"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
    {"label": "No Show", "value": "No Show"},
  ];
  
  List<Map<String, dynamic>> timeSlotOptions = [
    {"label": "All", "value": "All"},
    {"label": "Breakfast (7-11 AM)", "value": "Breakfast"},
    {"label": "Lunch (11 AM-3 PM)", "value": "Lunch"},
    {"label": "Dinner (5-10 PM)", "value": "Dinner"},
    {"label": "Late Night (10 PM+)", "value": "Late Night"},
  ];

  List<Map<String, dynamic>> reservations = [
    {
      "id": "RES001",
      "customer_name": "John Smith",
      "customer_phone": "+1 555-0123",
      "customer_email": "john.smith@email.com",
      "party_size": 4,
      "date": "2024-01-15",
      "time": "19:30",
      "table": "T005",
      "status": "Confirmed",
      "special_requests": "Window seat, birthday celebration",
      "created_at": "2024-01-10T10:30:00",
      "deposit": 50.0,
      "estimated_duration": 120,
      "source": "Website",
      "notes": "Regular customer, prefers quiet seating",
    },
    {
      "id": "RES002",
      "customer_name": "Sarah Johnson",
      "customer_phone": "+1 555-0456",
      "customer_email": "sarah.j@email.com",
      "party_size": 2,
      "date": "2024-01-15",
      "time": "20:00",
      "table": "T012",
      "status": "Pending",
      "special_requests": "Vegetarian menu, anniversary dinner",
      "created_at": "2024-01-12T14:15:00",
      "deposit": 0.0,
      "estimated_duration": 90,
      "source": "Phone",
      "notes": "First time customer",
    },
    {
      "id": "RES003",
      "customer_name": "Mike Wilson",
      "customer_phone": "+1 555-0789",
      "customer_email": "mike.wilson@email.com",
      "party_size": 6,
      "date": "2024-01-15",
      "time": "18:00",
      "table": "T018",
      "status": "Seated",
      "special_requests": "Business dinner, quiet area",
      "created_at": "2024-01-08T09:45:00",
      "deposit": 100.0,
      "estimated_duration": 150,
      "source": "App",
      "notes": "Corporate account holder",
    },
    {
      "id": "RES004",
      "customer_name": "Emma Davis",
      "customer_phone": "+1 555-0321",
      "customer_email": "emma.davis@email.com",
      "party_size": 3,
      "date": "2024-01-15",
      "time": "19:00",
      "table": "T008",
      "status": "Completed",
      "special_requests": "Child-friendly, high chair needed",
      "created_at": "2024-01-13T16:20:00",
      "deposit": 25.0,
      "estimated_duration": 75,
      "source": "Walk-in",
      "notes": "Left positive review",
    },
  ];

  List<Map<String, dynamic>> tables = [
    {"id": "T001", "seats": 2, "location": "Window", "available": true},
    {"id": "T002", "seats": 4, "location": "Main", "available": false},
    {"id": "T003", "seats": 6, "location": "Private", "available": true},
    {"id": "T004", "seats": 8, "location": "Terrace", "available": true},
    {"id": "T005", "seats": 4, "location": "Window", "available": false},
    {"id": "T006", "seats": 2, "location": "Bar", "available": true},
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"time": "17:00", "available": 3, "total": 5},
    {"time": "17:30", "available": 2, "total": 5},
    {"time": "18:00", "available": 1, "total": 5},
    {"time": "18:30", "available": 4, "total": 5},
    {"time": "19:00", "available": 2, "total": 5},
    {"time": "19:30", "available": 0, "total": 5},
    {"time": "20:00", "available": 3, "total": 5},
    {"time": "20:30", "available": 5, "total": 5},
    {"time": "21:00", "available": 4, "total": 5},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Seated":
        return infoColor;
      case "Completed":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      case "No Show":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildReservationsList() {
    final filteredReservations = reservations.where((reservation) {
      if (selectedStatus != "All" && reservation["status"] != selectedStatus) return false;
      if (reservation["date"] != selectedDate) return false;
      return true;
    }).toList();

    return Column(
      spacing: spMd,
      children: [
        // Summary Cards
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Text("Total", style: TextStyle(color: primaryColor, fontSize: 12)),
                    Text("${reservations.length}", 
                         style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: fsH5)),
                  ],
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Text("Confirmed", style: TextStyle(color: successColor, fontSize: 12)),
                    Text("${reservations.where((r) => r["status"] == "Confirmed").length}", 
                         style: TextStyle(color: successColor, fontWeight: FontWeight.bold, fontSize: fsH5)),
                  ],
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Text("Pending", style: TextStyle(color: warningColor, fontSize: 12)),
                    Text("${reservations.where((r) => r["status"] == "Pending").length}", 
                         style: TextStyle(color: warningColor, fontWeight: FontWeight.bold, fontSize: fsH5)),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Reservations List
        Expanded(
          child: ListView.builder(
            itemCount: filteredReservations.length,
            itemBuilder: (context, index) {
              final reservation = filteredReservations[index];
              final statusColor = _getStatusColor(reservation["status"]);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusSm),
                          topRight: Radius.circular(radiusSm),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${reservation["customer_name"]}",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6),
                                ),
                                Text(
                                  "ID: ${reservation["id"]}",
                                  style: TextStyle(color: disabledBoldColor, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${reservation["status"]}",
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Details
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        children: [
                          // Time and Party Info
                          Row(
                            children: [
                              Icon(Icons.access_time, color: primaryColor, size: 16),
                              SizedBox(width: spXs),
                              Text("${reservation["time"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: spMd),
                              Icon(Icons.group, color: primaryColor, size: 16),
                              SizedBox(width: spXs),
                              Text("${reservation["party_size"]} guests"),
                              SizedBox(width: spMd),
                              Icon(Icons.table_restaurant, color: primaryColor, size: 16),
                              SizedBox(width: spXs),
                              Text("${reservation["table"]}"),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Contact Info
                          Row(
                            children: [
                              Icon(Icons.phone, color: disabledBoldColor, size: 14),
                              SizedBox(width: spXs),
                              Text("${reservation["customer_phone"]}", style: TextStyle(fontSize: 12)),
                              SizedBox(width: spMd),
                              Icon(Icons.email, color: disabledBoldColor, size: 14),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${reservation["customer_email"]}", 
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Special Requests
                          if ((reservation["special_requests"] as String).isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline, color: infoColor, size: 14),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${reservation["special_requests"]}",
                                      style: TextStyle(fontSize: 11, color: infoColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          
                          SizedBox(height: spSm),
                          
                          // Action Buttons
                          Row(
                            children: [
                              if (reservation["status"] == "Pending")
                                Expanded(
                                  child: QButton(
                                    label: "Confirm",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Confirm reservation
                                    },
                                  ),
                                ),
                              if (reservation["status"] == "Confirmed")
                                Expanded(
                                  child: QButton(
                                    label: "Seat Now",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Mark as seated
                                    },
                                  ),
                                ),
                              if (reservation["status"] == "Seated")
                                Expanded(
                                  child: QButton(
                                    label: "Complete",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Mark as completed
                                    },
                                  ),
                                ),
                              if (["Pending", "Confirmed"].contains(reservation["status"]))
                                SizedBox(width: spSm),
                              if (["Pending", "Confirmed"].contains(reservation["status"]))
                                QButton(
                                  icon: Icons.cancel,
                                  size: bs.sm,
                                  onPressed: () async {
                                    bool isConfirmed = await confirm("Cancel this reservation?");
                                    if (isConfirmed) {
                                      // Cancel reservation
                                    }
                                  },
                                ),
                              Spacer(),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {
                                  // Edit reservation
                                },
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
        ),
      ],
    );
  }

  Widget _buildAvailability() {
    return Column(
      spacing: spMd,
      children: [
        // Date Selector
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6)),
              SizedBox(height: spSm),
              QDatePicker(
                label: "Reservation Date",
                value: DateTime.parse(selectedDate),
                onChanged: (value) {
                  selectedDate = value.toString().split(' ')[0];
                  setState(() {});
                },
              ),
            ],
          ),
        ),

        // Time Slots
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Time Slot Availability", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6)),
              SizedBox(height: spMd),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: timeSlots.map((slot) {
                  final available = slot["available"] as int;
                  final total = slot["total"] as int;
                  final percentage = available / total;
                  
                  Color slotColor;
                  if (percentage > 0.6) {
                    slotColor = successColor;
                  } else if (percentage > 0.3) {
                    slotColor = warningColor;
                  } else {
                    slotColor = dangerColor;
                  }
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: slotColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: slotColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${slot["time"]}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$available/$total available",
                          style: TextStyle(color: slotColor, fontSize: 12),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: slotColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
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

        // Table Availability
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Table Availability", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6)),
              SizedBox(height: spMd),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: tables.map((table) {
                  final isAvailable = table["available"] as bool;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isAvailable 
                          ? successColor.withAlpha(20)
                          : dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isAvailable 
                            ? successColor.withAlpha(50)
                            : dangerColor.withAlpha(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${table["id"]}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6),
                            ),
                            Spacer(),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isAvailable ? successColor : dangerColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.people, color: disabledBoldColor, size: 14),
                            SizedBox(width: spXs),
                            Text("${table["seats"]} seats", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: disabledBoldColor, size: 14),
                            SizedBox(width: spXs),
                            Text("${table["location"]}", style: TextStyle(fontSize: 12)),
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
      ],
    );
  }

  Widget _buildNewReservation() {
    String customerName = "";
    String customerPhone = "";
    String customerEmail = "";
    int partySize = 2;
    DateTime reservationDate = DateTime.now();
    TimeOfDay reservationTime = TimeOfDay.now();
    String selectedTable = "";
    String specialRequests = "";
    String source = "Walk-in";
    
    List<Map<String, dynamic>> sourceOptions = [
      {"label": "Walk-in", "value": "Walk-in"},
      {"label": "Phone", "value": "Phone"},
      {"label": "Website", "value": "Website"},
      {"label": "App", "value": "App"},
      {"label": "Third Party", "value": "Third Party"},
    ];
    
    List<Map<String, dynamic>> tableOptions = [
      {"label": "Auto Assign", "value": ""},
      ...tables.where((table) => table["available"] as bool).map((table) => {
        "label": "${table["id"]} - ${table["seats"]} seats (${table["location"]})",
        "value": table["id"],
      }).toList(),
    ];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Text("Create New Reservation", style: TextStyle(fontSize: fsH5, fontWeight: FontWeight.bold)),
            
            // Customer Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text("Customer Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6)),
                  QTextField(
                    label: "Customer Name",
                    value: customerName,
                    onChanged: (value) {
                      customerName = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Phone Number",
                          value: customerPhone,
                          onChanged: (value) {
                            customerPhone = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Email Address",
                          value: customerEmail,
                          onChanged: (value) {
                            customerEmail = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Reservation Details
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text("Reservation Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6)),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Party Size",
                          value: partySize.toString(),
                          onChanged: (value) {
                            partySize = int.tryParse(value) ?? 2;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Source",
                          items: sourceOptions,
                          value: source,
                          onChanged: (value, label) {
                            source = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Date",
                          value: reservationDate,
                          onChanged: (value) {
                            reservationDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTimePicker(
                          label: "Time",
                          value: reservationTime,
                          onChanged: (value) {
                            reservationTime = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Table Preference",
                    items: tableOptions,
                    value: selectedTable,
                    onChanged: (value, label) {
                      selectedTable = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Special Requests
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text("Additional Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6)),
                  QMemoField(
                    label: "Special Requests",
                    value: specialRequests,
                    hint: "Any special requests, dietary restrictions, celebrations, etc.",
                    onChanged: (value) {
                      specialRequests = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save as Pending",
                    size: bs.md,
                    onPressed: () {
                      // Save reservation as pending
                      ss("Reservation saved as pending");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Confirm Reservation",
                    size: bs.md,
                    onPressed: () {
                      // Save and confirm reservation
                      ss("Reservation confirmed successfully");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reservation System",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Reservations", icon: Icon(Icons.event_seat)),
        Tab(text: "Availability", icon: Icon(Icons.schedule)),
        Tab(text: "New Booking", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        Column(
          children: [
            // Filter Controls
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spSm,
                children: [
                  QDatePicker(
                    label: "Select Date",
                    value: DateTime.parse(selectedDate),
                    onChanged: (value) {
                      selectedDate = value.toString().split(' ')[0];
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Time Slot",
                          items: timeSlotOptions,
                          value: selectedTimeSlot,
                          onChanged: (value, label) {
                            selectedTimeSlot = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: _buildReservationsList(),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildAvailability(),
        ),
        _buildNewReservation(),
      ],
    );
  }
}
