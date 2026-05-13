import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaAppointmentListView extends StatefulWidget {
  const HcaAppointmentListView({super.key});

  @override
  State<HcaAppointmentListView> createState() => _HcaAppointmentListViewState();
}

class _HcaAppointmentListViewState extends State<HcaAppointmentListView> {
  String selectedFilter = "All";
  String selectedSort = "Date";
  bool isAscending = true;

  final List<String> filters = ["All", "Upcoming", "Completed", "Cancelled", "Pending"];
  final List<String> sortOptions = ["Date", "Doctor", "Type", "Status"];

  final List<Map<String, dynamic>> appointments = [
    {
      "id": "APT-2024-001",
      "date": "2024-12-28T10:30:00",
      "doctor": "Dr. Michael Chen",
      "doctorImage": "https://picsum.photos/60/60?random=1&keyword=doctor",
      "specialty": "Cardiology",
      "type": "Follow-up",
      "location": "Building A, Room 205",
      "status": "Confirmed",
      "statusColor": successColor,
      "duration": "30 min",
      "notes": "Routine cardiology check-up. Bring previous test results.",
      "cost": 150.00,
      "insurance": "Covered",
      "canReschedule": true,
      "canCancel": true,
    },
    {
      "id": "APT-2024-002",
      "date": "2025-01-05T14:15:00",
      "doctor": "Dr. Lisa Park",
      "doctorImage": "https://picsum.photos/60/60?random=2&keyword=doctor",
      "specialty": "Dermatology",
      "type": "Consultation",
      "location": "Building B, Room 301",
      "status": "Confirmed",
      "statusColor": successColor,
      "duration": "45 min",
      "notes": "Skin consultation for mole examination.",
      "cost": 200.00,
      "insurance": "Partial Coverage",
      "canReschedule": true,
      "canCancel": true,
    },
    {
      "id": "APT-2024-003",
      "date": "2025-01-12T09:00:00",
      "doctor": "Dr. James Wilson",
      "doctorImage": "https://picsum.photos/60/60?random=3&keyword=doctor",
      "specialty": "Laboratory",
      "type": "Blood Test",
      "location": "Lab Center, Level 1",
      "status": "Pending",
      "statusColor": warningColor,
      "duration": "15 min",
      "notes": "Fasting blood work required. No food 12 hours before.",
      "cost": 75.00,
      "insurance": "Covered",
      "canReschedule": true,
      "canCancel": true,
    },
    {
      "id": "APT-2024-004",
      "date": "2024-12-15T11:00:00",
      "doctor": "Dr. Sarah Martinez",
      "doctorImage": "https://picsum.photos/60/60?random=4&keyword=doctor",
      "specialty": "General Medicine",
      "type": "Check-up",
      "location": "Building A, Room 103",
      "status": "Completed",
      "statusColor": infoColor,
      "duration": "45 min",
      "notes": "Annual physical examination completed successfully.",
      "cost": 180.00,
      "insurance": "Covered",
      "canReschedule": false,
      "canCancel": false,
    },
    {
      "id": "APT-2024-005",
      "date": "2024-12-10T16:30:00",
      "doctor": "Dr. Robert Kim",
      "doctorImage": "https://picsum.photos/60/60?random=5&keyword=doctor",
      "specialty": "Orthopedics",
      "type": "Consultation",
      "location": "Building C, Room 201",
      "status": "Cancelled",
      "statusColor": dangerColor,
      "duration": "30 min",
      "notes": "Appointment cancelled due to patient request.",
      "cost": 0.00,
      "insurance": "N/A",
      "canReschedule": false,
      "canCancel": false,
    },
    {
      "id": "APT-2024-006",
      "date": "2025-01-20T13:45:00",
      "doctor": "Dr. Emily Davis",
      "doctorImage": "https://picsum.photos/60/60?random=6&keyword=doctor",
      "specialty": "Psychiatry",
      "type": "Therapy Session",
      "location": "Building D, Room 401",
      "status": "Confirmed",
      "statusColor": successColor,
      "duration": "60 min",
      "notes": "Regular therapy session. Continue current treatment plan.",
      "cost": 250.00,
      "insurance": "Partial Coverage",
      "canReschedule": true,
      "canCancel": true,
    },
  ];

  List<Map<String, dynamic>> get filteredAppointments {
    List<Map<String, dynamic>> filtered = appointments;

    // Apply status filter
    if (selectedFilter != "All") {
      filtered = filtered.where((apt) => apt["status"] == selectedFilter).toList();
    }

    // Apply sorting
    filtered.sort((a, b) {
      int comparison = 0;
      switch (selectedSort) {
        case "Date":
          comparison = DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"]));
          break;
        case "Doctor":
          comparison = a["doctor"].compareTo(b["doctor"]);
          break;
        case "Type":
          comparison = a["type"].compareTo(b["type"]);
          break;
        case "Status":
          comparison = a["status"].compareTo(b["status"]);
          break;
      }
      return isAscending ? comparison : -comparison;
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Appointments"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              si("Opening calendar view...");
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Book new appointment");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter and Sort Controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Filter Row
                Row(
                  children: [
                    Text(
                      "Filter:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QHorizontalScroll(
                        children: filters.map((filter) {
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
                                color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusMd),
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                filter,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Sort Row
                Row(
                  children: [
                    Text(
                      "Sort by:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "",
                        items: sortOptions.map((option) => {
                          "label": option,
                          "value": option,
                        }).toList(),
                        value: selectedSort,
                        onChanged: (value, label) {
                          selectedSort = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        isAscending = !isAscending;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                          size: 20,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Appointments List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredAppointments.length,
              itemBuilder: (context, index) {
                final appointment = filteredAppointments[index];
                final appointmentDate = DateTime.parse(appointment["date"]);
                final isUpcoming = appointmentDate.isAfter(DateTime.now());
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: appointment["statusColor"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          // Doctor Image
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusMd),
                              child: Image.network(
                                "${appointment["doctorImage"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          // Appointment Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${appointment["doctor"]}",
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
                                        color: (appointment["statusColor"] as Color).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${appointment["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: appointment["statusColor"] as Color,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${appointment["specialty"]} - ${appointment["type"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${appointmentDate.dMMMy} at ${TimeOfDay.fromDateTime(appointmentDate).kkmm}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.schedule,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${appointment["duration"]}",
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

                      SizedBox(height: spSm),

                      // Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${appointment["location"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Notes
                      if (appointment["notes"].isNotEmpty) ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (appointment["statusColor"] as Color).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notes:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${appointment["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spSm),
                      ],

                      // Cost and Insurance
                      Row(
                        children: [
                          if ((appointment["cost"] as double) > 0) ...[
                            Text(
                              "Cost: \$${(appointment["cost"] as double).currency}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                          ],
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: appointment["insurance"] == "Covered" 
                                  ? successColor.withAlpha(20)
                                  : appointment["insurance"] == "Partial Coverage"
                                      ? warningColor.withAlpha(20)
                                      : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${appointment["insurance"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: appointment["insurance"] == "Covered" 
                                    ? successColor
                                    : appointment["insurance"] == "Partial Coverage"
                                        ? warningColor
                                        : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Action Buttons
                      Row(
                        children: [
                          // View Details
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                si("Opening appointment details for ${appointment["id"]}");
                              },
                            ),
                          ),
                          
                          if (appointment["canReschedule"]) ...[
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Reschedule",
                                size: bs.sm,
                                onPressed: () {
                                  si("Rescheduling appointment ${appointment["id"]}");
                                },
                              ),
                            ),
                          ],
                          
                          if (appointment["canCancel"]) ...[
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () async {
                                bool isConfirmed = await confirm("Are you sure you want to cancel this appointment?");
                                if (isConfirmed) {
                                  sw("Appointment cancelled");
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: dangerColor.withAlpha(30),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ss("Book new appointment");
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
