import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaAppointmentsView extends StatefulWidget {
  const RmaAppointmentsView({super.key});

  @override
  State<RmaAppointmentsView> createState() => _RmaAppointmentsViewState();
}

class _RmaAppointmentsViewState extends State<RmaAppointmentsView> {
  String selectedFilter = "All";
  String selectedDate = "Today";
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> appointments = [
    {
      "id": "1",
      "type": "Property Showing",
      "client": "John Anderson",
      "property": "Modern Downtown Condo",
      "address": "123 Main Street, Downtown",
      "date": "2024-11-15",
      "time": "10:00 AM",
      "duration": 60,
      "status": "Confirmed",
      "agent": "Sarah Johnson",
      "phone": "+1 (555) 123-4567",
      "email": "john.anderson@email.com",
      "notes": "First-time buyer, interested in downtown location",
      "propertyImage": "https://picsum.photos/100/80?random=1&keyword=condo",
      "priority": "Medium"
    },
    {
      "id": "2",
      "type": "Listing Consultation",
      "client": "Maria Garcia",
      "property": "Family Home Consultation",
      "address": "456 Oak Avenue, Suburbs",
      "date": "2024-11-15",
      "time": "2:00 PM",
      "duration": 90,
      "status": "Pending",
      "agent": "Michael Chen",
      "phone": "+1 (555) 987-6543",
      "email": "maria.garcia@email.com",
      "notes": "Wants to sell family home, needs market analysis",
      "propertyImage": "https://picsum.photos/100/80?random=2&keyword=house",
      "priority": "High"
    },
    {
      "id": "3",
      "type": "Property Inspection",
      "client": "Robert Kim",
      "property": "Luxury Penthouse",
      "address": "789 Tower Plaza, City Center",
      "date": "2024-11-16",
      "time": "11:00 AM",
      "duration": 45,
      "status": "Confirmed",
      "agent": "Emily Rodriguez",
      "phone": "+1 (555) 456-7890",
      "email": "robert.kim@email.com",
      "notes": "Serious buyer, pre-approved for \$800K",
      "propertyImage": "https://picsum.photos/100/80?random=3&keyword=penthouse",
      "priority": "High"
    },
    {
      "id": "4",
      "type": "Contract Signing",
      "client": "Lisa Thompson",
      "property": "Charming Townhouse",
      "address": "321 Pine Street, Midtown",
      "date": "2024-11-16",
      "time": "3:00 PM",
      "duration": 30,
      "status": "Completed",
      "agent": "David Wilson",
      "phone": "+1 (555) 321-9876",
      "email": "lisa.thompson@email.com",
      "notes": "Final contract review and signing",
      "propertyImage": "https://picsum.photos/100/80?random=4&keyword=townhouse",
      "priority": "Critical"
    },
    {
      "id": "5",
      "type": "Market Analysis",
      "client": "James Parker",
      "property": "Investment Property Review",
      "address": "654 Business District, Commercial",
      "date": "2024-11-17",
      "time": "9:00 AM",
      "duration": 120,
      "status": "Cancelled",
      "agent": "Lisa Park",
      "phone": "+1 (555) 654-3210",
      "email": "james.parker@email.com",
      "notes": "Investor looking for commercial opportunities",
      "propertyImage": "https://picsum.photos/100/80?random=5&keyword=commercial",
      "priority": "Medium"
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"}
  ];

  List<Map<String, dynamic>> dateOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "Tomorrow", "value": "Tomorrow"},
    {"label": "This Week", "value": "This Week"},
    {"label": "Next Week", "value": "Next Week"}
  ];

  List<Map<String, dynamic>> get filteredAppointments {
    return appointments.where((appointment) {
      bool matchesFilter = selectedFilter == "All" || appointment["status"] == selectedFilter;
      bool matchesSearch = searchQuery.isEmpty || 
          appointment["client"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          appointment["property"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          appointment["type"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Completed":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Open calendar view
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Create new appointment
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search appointments...",
                          value: searchQuery,
                          hint: "Client, property, or type",
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
                          label: "Filter by Status",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Date Range",
                          items: dateOptions,
                          value: selectedDate,
                          onChanged: (value, label) {
                            selectedDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.event,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredAppointments.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${appointments.where((a) => a["status"] == "Confirmed").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Confirmed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: warningColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${appointments.where((a) => a["status"] == "Pending").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Today's Schedule
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Schedule",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "November 15, 2024",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: appointments.where((app) => app["date"] == "2024-11-15").map((appointment) {
                      return Container(
                        width: 280,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(appointment["status"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${appointment["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: getPriorityColor(appointment["priority"]),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${appointment["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${appointment["client"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                                SizedBox(width: 4),
                                Text(
                                  "${appointment["time"]} (${appointment["duration"]}min)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${appointment["address"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
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

            // All Appointments List
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Appointments",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredAppointments.length} appointments",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredAppointments.map((appointment) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Property Image
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${appointment["propertyImage"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              
                              // Appointment Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 4,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${appointment["type"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: getStatusColor(appointment["status"]),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${appointment["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${appointment["client"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${appointment["property"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "${appointment["date"]} • ${appointment["time"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: getPriorityColor(appointment["priority"]),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${appointment["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
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
                          
                          // Contact Info
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.phone, size: 14, color: primaryColor),
                                SizedBox(width: 4),
                                Text(
                                  "${appointment["phone"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.email, size: 14, color: primaryColor),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${appointment["email"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          if (appointment["notes"] != null && appointment["notes"].isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${appointment["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                          
                          SizedBox(height: spSm),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.call,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.message,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
