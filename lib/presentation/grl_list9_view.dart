import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlList9View extends StatefulWidget {
  @override
  State<GrlList9View> createState() => _GrlList9ViewState();
}

class _GrlList9ViewState extends State<GrlList9View> {
  String searchQuery = "";
  String selectedPriority = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Open", "value": "Open"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> tickets = [
    {
      "id": "TKT-001",
      "title": "Unable to Login to Account",
      "description": "User cannot access their account after password reset. Getting error message 'Invalid credentials'.",
      "customer": "John Smith",
      "email": "john.smith@email.com",
      "priority": "High",
      "status": "Open",
      "category": "Authentication",
      "assignee": "Sarah Johnson",
      "createdDate": "2024-12-15",
      "lastUpdate": "2024-12-15",
      "responseTime": "2 hours",
      "tags": ["Login", "Password", "Authentication"],
      "attachments": 2,
      "avatar": "https://picsum.photos/100/100?random=81&keyword=person",
    },
    {
      "id": "TKT-002",
      "title": "Payment Processing Error",
      "description": "Credit card payment fails during checkout. Transaction is declined but amount is held.",
      "customer": "Emily Davis",
      "email": "emily.davis@email.com",
      "priority": "Critical",
      "status": "In Progress",
      "category": "Payment",
      "assignee": "Michael Chen",
      "createdDate": "2024-12-14",
      "lastUpdate": "2024-12-15",
      "responseTime": "30 minutes",
      "tags": ["Payment", "Checkout", "Credit Card"],
      "attachments": 1,
      "avatar": "https://picsum.photos/100/100?random=82&keyword=person",
    },
    {
      "id": "TKT-003",
      "title": "Feature Request: Dark Mode",
      "description": "User requesting dark mode option for the mobile application to reduce eye strain during night usage.",
      "customer": "Alex Rodriguez",
      "email": "alex.rodriguez@email.com",
      "priority": "Low",
      "status": "Open",
      "category": "Feature Request",
      "assignee": "Lisa Wang",
      "createdDate": "2024-12-13",
      "lastUpdate": "2024-12-14",
      "responseTime": "1 day",
      "tags": ["Feature", "Mobile", "UI"],
      "attachments": 0,
      "avatar": "https://picsum.photos/100/100?random=83&keyword=person",
    },
    {
      "id": "TKT-004",
      "title": "Data Export Not Working",
      "description": "Export function returns empty CSV file. Should contain user activity data for the past month.",
      "customer": "Maria Garcia",
      "email": "maria.garcia@email.com",
      "priority": "Medium",
      "status": "Resolved",
      "category": "Data Export",
      "assignee": "David Kim",
      "createdDate": "2024-12-12",
      "lastUpdate": "2024-12-14",
      "responseTime": "4 hours",
      "tags": ["Export", "CSV", "Data"],
      "attachments": 3,
      "avatar": "https://picsum.photos/100/100?random=84&keyword=person",
    },
    {
      "id": "TKT-005",
      "title": "Mobile App Crashes on Startup",
      "description": "iOS app crashes immediately after launch. Occurs on iPhone 14 with latest iOS version.",
      "customer": "Robert Wilson",
      "email": "robert.wilson@email.com",
      "priority": "Critical",
      "status": "In Progress",
      "category": "Mobile Bug",
      "assignee": "Jennifer Park",
      "createdDate": "2024-12-11",
      "lastUpdate": "2024-12-15",
      "responseTime": "1 hour",
      "tags": ["iOS", "Crash", "Mobile"],
      "attachments": 2,
      "avatar": "https://picsum.photos/100/100?random=85&keyword=person",
    },
  ];

  List<Map<String, dynamic>> get filteredTickets {
    return tickets.where((ticket) {
      bool matchesSearch = "${ticket["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${ticket["customer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${ticket["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesPriority = selectedPriority == "All" || ticket["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "All" || ticket["status"] == selectedStatus;
      return matchesSearch && matchesPriority && matchesStatus;
    }).toList();
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return Color(0xFFDC2626);
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Open":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Tickets"),
        actions: [
          Icon(Icons.add),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(30)),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Critical",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${tickets.where((t) => t["priority"] == "Critical").length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
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
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(30)),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "In Progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${tickets.where((t) => t["status"] == "In Progress").length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
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
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Resolved",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${tickets.where((t) => t["status"] == "Resolved").length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search tickets",
                    value: searchQuery,
                    hint: "Search by title, customer, or ticket ID...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: priorityOptions,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
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
              ],
            ),

            Text(
              "Tickets (${filteredTickets.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredTickets.length,
              itemBuilder: (context, index) {
                final ticket = filteredTickets[index];
                final priorityColor = getPriorityColor("${ticket["priority"]}");
                final statusColor = getStatusColor("${ticket["status"]}");
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage("${ticket["avatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${ticket["id"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Row(
                                      spacing: spXs,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: priorityColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${ticket["priority"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: priorityColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${ticket["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: statusColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "${ticket["customer"]}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${ticket["email"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "${ticket["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${ticket["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Category",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${ticket["category"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Assigned To",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${ticket["assignee"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Response Time",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${ticket["responseTime"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                                if ((ticket["attachments"] as int) > 0)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "Attachments",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        spacing: spXs,
                                        children: [
                                          Icon(
                                            Icons.attach_file,
                                            color: primaryColor,
                                            size: 16,
                                          ),
                                          Text(
                                            "${ticket["attachments"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Tags:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (ticket["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Created: ${ticket["createdDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Updated: ${ticket["lastUpdate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: spSm,
                            children: [
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
