import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmBookingRequestsView extends StatefulWidget {
  const FsmBookingRequestsView({super.key});

  @override
  State<FsmBookingRequestsView> createState() => _FsmBookingRequestsViewState();
}

class _FsmBookingRequestsViewState extends State<FsmBookingRequestsView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedPriority = "";
  String selectedService = "";

  List<Map<String, dynamic>> bookingRequests = [
    {
      "id": "REQ-001",
      "customerName": "Sarah Johnson",
      "customerPhone": "+1 234 567 8901",
      "customerEmail": "sarah.j@email.com",
      "serviceType": "HVAC Repair",
      "priority": "High",
      "status": "Pending",
      "requestDate": "2024-12-20 09:15:00",
      "preferredDate": "2024-12-22 14:00:00",
      "description": "Air conditioning unit not cooling properly. Strange noises coming from the outdoor unit.",
      "location": "123 Oak Street, Springfield",
      "estimatedCost": 450.0,
      "urgencyLevel": "Critical",
      "attachments": 2,
    },
    {
      "id": "REQ-002",
      "customerName": "Michael Chen",
      "customerPhone": "+1 234 567 8902",
      "customerEmail": "m.chen@email.com",
      "serviceType": "Plumbing",
      "priority": "Medium",
      "status": "Approved",
      "requestDate": "2024-12-20 11:30:00",
      "preferredDate": "2024-12-23 10:00:00",
      "description": "Kitchen sink drainage issue and water pressure problems in main bathroom.",
      "location": "456 Pine Avenue, Downtown",
      "estimatedCost": 275.0,
      "urgencyLevel": "Moderate",
      "attachments": 1,
    },
    {
      "id": "REQ-003",
      "customerName": "Emily Rodriguez",
      "customerPhone": "+1 234 567 8903",
      "customerEmail": "emily.r@email.com",
      "serviceType": "Electrical",
      "priority": "Low",
      "status": "In Review",
      "requestDate": "2024-12-20 13:45:00",
      "preferredDate": "2024-12-24 09:00:00",
      "description": "Install additional outlets in home office and upgrade circuit breaker panel.",
      "location": "789 Maple Drive, Suburbs",
      "estimatedCost": 680.0,
      "urgencyLevel": "Normal",
      "attachments": 3,
    },
    {
      "id": "REQ-004",
      "customerName": "David Wilson",
      "customerPhone": "+1 234 567 8904",
      "customerEmail": "d.wilson@email.com",
      "serviceType": "Landscaping",
      "priority": "High",
      "status": "Scheduled",
      "requestDate": "2024-12-20 15:20:00",
      "preferredDate": "2024-12-25 08:00:00",
      "description": "Seasonal lawn maintenance and tree trimming for commercial property.",
      "location": "321 Business Blvd, Industrial Area",
      "estimatedCost": 1250.0,
      "urgencyLevel": "High",
      "attachments": 0,
    },
    {
      "id": "REQ-005",
      "customerName": "Lisa Thompson",
      "customerPhone": "+1 234 567 8905",
      "customerEmail": "lisa.t@email.com",
      "serviceType": "Cleaning",
      "priority": "Medium",
      "status": "Rejected",
      "requestDate": "2024-12-20 16:10:00",
      "preferredDate": "2024-12-21 12:00:00",
      "description": "Deep cleaning service for office building after renovation work.",
      "location": "654 Corporate Center, Business District",
      "estimatedCost": 380.0,
      "urgencyLevel": "Low",
      "attachments": 1,
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return bookingRequests.where((request) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${request["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${request["serviceType"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${request["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus.isEmpty || request["status"] == selectedStatus;
      bool matchesPriority = selectedPriority.isEmpty || request["priority"] == selectedPriority;
      bool matchesService = selectedService.isEmpty || request["serviceType"] == selectedService;
      return matchesSearch && matchesStatus && matchesPriority && matchesService;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Approved":
        return successColor;
      case "In Review":
        return infoColor;
      case "Scheduled":
        return primaryColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
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
        title: Text("Booking Requests"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('CreateBookingRequestView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
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
                  QTextField(
                    label: "Search requests...",
                    value: searchQuery,
                    hint: "Search by customer, service, or ID",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": ""},
                            {"label": "Pending", "value": "Pending"},
                            {"label": "Approved", "value": "Approved"},
                            {"label": "In Review", "value": "In Review"},
                            {"label": "Scheduled", "value": "Scheduled"},
                            {"label": "Rejected", "value": "Rejected"},
                          ],
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
                          label: "Priority",
                          items: [
                            {"label": "All Priority", "value": ""},
                            {"label": "High", "value": "High"},
                            {"label": "Medium", "value": "Medium"},
                            {"label": "Low", "value": "Low"},
                          ],
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Cards
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
                        Icon(Icons.pending_actions, color: warningColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${bookingRequests.where((r) => r["status"] == "Pending").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
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
                        Icon(Icons.check_circle, color: successColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${bookingRequests.where((r) => r["status"] == "Approved").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Approved",
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
                        Icon(Icons.schedule, color: primaryColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${bookingRequests.where((r) => r["status"] == "Scheduled").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Scheduled",
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

            // Booking Requests List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.list_alt, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Booking Requests (${filteredRequests.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...filteredRequests.map((request) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getStatusColor("${request["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${request["id"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getPriorityColor("${request["priority"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${request["priority"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${((request["estimatedCost"] as num).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${request["customerName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${request["serviceType"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${request["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  "${request["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "Preferred: ${DateTime.parse("${request["preferredDate"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              if ((request["attachments"] as int) > 0)
                                Row(
                                  children: [
                                    Icon(Icons.attach_file, size: 14, color: disabledBoldColor),
                                    Text(
                                      "${request["attachments"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo('BookingRequestDetailView')
                                },
                              ),
                              SizedBox(width: spSm),
                              if ("${request["status"]}" == "Pending")
                                QButton(
                                  label: "Approve",
                                  size: bs.sm,
                                  color: successColor,
                                  onPressed: () async {
                                    bool isConfirmed = await confirm("Approve this booking request?");
                                    if (isConfirmed) {
                                      ss("Booking request approved successfully");
                                    }
                                  },
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
