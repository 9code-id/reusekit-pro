import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaSupportTicketsView extends StatefulWidget {
  const LtaSupportTicketsView({super.key});

  @override
  State<LtaSupportTicketsView> createState() => _LtaSupportTicketsViewState();
}

class _LtaSupportTicketsViewState extends State<LtaSupportTicketsView> {
  List<Map<String, dynamic>> tickets = [
    {
      "id": "TKT-001",
      "title": "Package not delivered",
      "description": "My package was supposed to be delivered yesterday but I haven't received it yet.",
      "priority": "High",
      "status": "Open",
      "category": "Delivery Issues",
      "customer": "John Smith",
      "customerEmail": "john.smith@email.com",
      "customerPhone": "+1234567890",
      "assignedTo": "Sarah Johnson",
      "createdAt": "2024-03-20T09:30:00",
      "updatedAt": "2024-03-20T14:15:00",
      "trackingNumber": "LTA123456789",
      "expectedResolution": "2024-03-21T17:00:00",
      "attachments": ["photo1.jpg", "receipt.pdf"],
    },
    {
      "id": "TKT-002",
      "title": "Damaged package received",
      "description": "The package arrived with significant damage to the contents. Need replacement or refund.",
      "priority": "Medium",
      "status": "In Progress",
      "category": "Damage Claims",
      "customer": "Maria Garcia",
      "customerEmail": "maria.garcia@email.com",
      "customerPhone": "+1234567891",
      "assignedTo": "Mike Chen",
      "createdAt": "2024-03-19T11:00:00",
      "updatedAt": "2024-03-20T10:30:00",
      "trackingNumber": "LTA123456790",
      "expectedResolution": "2024-03-22T12:00:00",
      "attachments": ["damage_photo1.jpg", "damage_photo2.jpg"],
    },
    {
      "id": "TKT-003",
      "title": "Billing inquiry",
      "description": "I was charged twice for the same shipment. Please review and refund the duplicate charge.",
      "priority": "Low",
      "status": "Resolved",
      "category": "Billing",
      "customer": "David Wilson",
      "customerEmail": "david.wilson@email.com",
      "customerPhone": "+1234567892",
      "assignedTo": "Lisa Park",
      "createdAt": "2024-03-18T14:20:00",
      "updatedAt": "2024-03-19T16:45:00",
      "trackingNumber": "LTA123456791",
      "expectedResolution": "2024-03-19T17:00:00",
      "attachments": ["invoice.pdf"],
    },
    {
      "id": "TKT-004",
      "title": "Change delivery address",
      "description": "Need to update delivery address before package arrives. Moving to new location.",
      "priority": "High",
      "status": "Open",
      "category": "Address Change",
      "customer": "Emma Thompson",
      "customerEmail": "emma.thompson@email.com",
      "customerPhone": "+1234567893",
      "assignedTo": "Alex Kumar",
      "createdAt": "2024-03-20T16:10:00",
      "updatedAt": "2024-03-20T16:10:00",
      "trackingNumber": "LTA123456792",
      "expectedResolution": "2024-03-21T09:00:00",
      "attachments": [],
    },
    {
      "id": "TKT-005",
      "title": "Lost package investigation",
      "description": "Package shows delivered but not received. Need investigation into delivery location.",
      "priority": "High",
      "status": "Under Investigation",
      "category": "Lost Package",
      "customer": "Robert Brown",
      "customerEmail": "robert.brown@email.com",
      "customerPhone": "+1234567894",
      "assignedTo": "Sarah Johnson",
      "createdAt": "2024-03-19T08:45:00",
      "updatedAt": "2024-03-20T11:20:00",
      "trackingNumber": "LTA123456793",
      "expectedResolution": "2024-03-23T15:00:00",
      "attachments": ["delivery_screenshot.jpg"],
    }
  ];

  List<Map<String, dynamic>> filteredTickets = [];
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  String selectedCategory = "All";
  int selectedTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Open", "value": "Open"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Under Investigation", "value": "Under Investigation"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Delivery Issues", "value": "Delivery Issues"},
    {"label": "Damage Claims", "value": "Damage Claims"},
    {"label": "Billing", "value": "Billing"},
    {"label": "Address Change", "value": "Address Change"},
    {"label": "Lost Package", "value": "Lost Package"},
    {"label": "Technical Support", "value": "Technical Support"},
  ];

  @override
  void initState() {
    super.initState();
    _filterTickets();
  }

  void _filterTickets() {
    filteredTickets = tickets.where((ticket) {
      bool matchesSearch = ticket["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          ticket["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          ticket["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || ticket["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || ticket["priority"] == selectedPriority;
      bool matchesCategory = selectedCategory == "All" || ticket["category"] == selectedCategory;
      
      return matchesSearch && matchesStatus && matchesPriority && matchesCategory;
    }).toList();

    setState(() {});
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical": return dangerColor;
      case "High": return warningColor;
      case "Medium": return infoColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open": return warningColor;
      case "In Progress": return infoColor;
      case "Under Investigation": return primaryColor;
      case "Resolved": return successColor;
      case "Closed": return disabledColor;
      default: return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Support Tickets",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "All Tickets", icon: Icon(Icons.support)),
        Tab(text: "My Tickets", icon: Icon(Icons.person)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildAllTicketsTab(),
        _buildMyTicketsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildAllTicketsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                QTextField(
                  label: "Search Tickets",
                  value: searchQuery,
                  hint: "Search by ticket ID, title, or customer",
                  onChanged: (value) {
                    searchQuery = value;
                    _filterTickets();
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          _filterTickets();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Priority",
                        items: priorityOptions,
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          _filterTickets();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    _filterTickets();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Statistics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Tickets", tickets.length.toString(), Icons.support, primaryColor),
              _buildStatCard("Open", tickets.where((t) => t["status"] == "Open").length.toString(), Icons.notification_important, warningColor),
              _buildStatCard("In Progress", tickets.where((t) => t["status"] == "In Progress").length.toString(), Icons.hourglass_empty, infoColor),
              _buildStatCard("Resolved", tickets.where((t) => t["status"] == "Resolved").length.toString(), Icons.check_circle, successColor),
            ],
          ),
          SizedBox(height: spMd),

          // Tickets List
          if (filteredTickets.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(Icons.search_off, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No tickets found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search criteria",
                    style: TextStyle(color: disabledColor),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredTickets.length,
              itemBuilder: (context, index) {
                final ticket = filteredTickets[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _getPriorityColor(ticket["priority"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.support,
                            color: _getPriorityColor(ticket["priority"]),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${ticket["id"]} - ${ticket["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(ticket["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${ticket["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(ticket["status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: spXs),
                            Text("${ticket["customer"]} • ${ticket["category"]}"),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.priority_high, size: 16, color: _getPriorityColor(ticket["priority"])),
                                SizedBox(width: spXs),
                                Text(
                                  "${ticket["priority"]} Priority",
                                  style: TextStyle(
                                    color: _getPriorityColor(ticket["priority"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text("${DateTime.parse(ticket["createdAt"]).dMMMy}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${ticket["description"]}",
                              style: TextStyle(color: disabledBoldColor),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Tracking: ${ticket["trackingNumber"]}",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                                Spacer(),
                                if ((ticket["attachments"] as List).isNotEmpty)
                                  Row(
                                    children: [
                                      Icon(Icons.attach_file, size: 16, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${(ticket["attachments"] as List).length} files",
                                        style: TextStyle(color: disabledBoldColor),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      si("Viewing ticket details: ${ticket["id"]}");
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.message,
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Messaging customer for ticket: ${ticket["id"]}");
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.edit,
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Editing ticket: ${ticket["id"]}");
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
        ],
      ),
    );
  }

  Widget _buildMyTicketsTab() {
    final myTickets = tickets.where((ticket) => ticket["assignedTo"] == "Sarah Johnson").toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // My Statistics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Assigned to Me", myTickets.length.toString(), Icons.person, primaryColor),
              _buildStatCard("Open", myTickets.where((t) => t["status"] == "Open").length.toString(), Icons.notification_important, warningColor),
              _buildStatCard("In Progress", myTickets.where((t) => t["status"] == "In Progress").length.toString(), Icons.hourglass_empty, infoColor),
              _buildStatCard("Overdue", "2", Icons.warning, dangerColor),
            ],
          ),
          SizedBox(height: spMd),

          // My Tickets List
          if (myTickets.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(Icons.assignment_turned_in, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No tickets assigned",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Check the All Tickets tab for available tickets",
                    style: TextStyle(color: disabledColor),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: myTickets.length,
              itemBuilder: (context, index) {
                final ticket = myTickets[index];
                bool isOverdue = DateTime.now().isAfter(DateTime.parse(ticket["expectedResolution"]));
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isOverdue ? Border.all(color: dangerColor, width: 2) : null,
                  ),
                  child: Column(
                    children: [
                      if (isOverdue)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning, color: dangerColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "OVERDUE",
                                style: TextStyle(
                                  color: dangerColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _getPriorityColor(ticket["priority"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.support,
                            color: _getPriorityColor(ticket["priority"]),
                          ),
                        ),
                        title: Text(
                          "${ticket["id"]} - ${ticket["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: spXs),
                            Text("${ticket["customer"]} • ${ticket["priority"]} Priority"),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.schedule, size: 16, color: isOverdue ? dangerColor : disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Due: ${DateTime.parse(ticket["expectedResolution"]).dMMMy}",
                                  style: TextStyle(
                                    color: isOverdue ? dangerColor : disabledBoldColor,
                                    fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Work on Ticket",
                                size: bs.sm,
                                onPressed: () {
                                  si("Working on ticket: ${ticket["id"]}");
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.update,
                              size: bs.sm,
                              onPressed: () {
                                si("Updating status for ticket: ${ticket["id"]}");
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Analytics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Avg Resolution Time", "2.5 days", Icons.timer, infoColor),
              _buildStatCard("Customer Satisfaction", "4.2/5.0", Icons.star, warningColor),
              _buildStatCard("First Response Time", "4 hours", Icons.reply, successColor),
              _buildStatCard("Escalated Tickets", "3", Icons.trending_up, dangerColor),
            ],
          ),
          SizedBox(height: spMd),

          // Category Breakdown
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tickets by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ..._buildCategoryStats(),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Performance Metrics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Performance Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                _buildMetricItem("Tickets Resolved Today", "8", Icons.check_circle, successColor),
                _buildMetricItem("Average Response Time", "2.3 hours", Icons.access_time, infoColor),
                _buildMetricItem("Customer Satisfaction Rate", "92%", Icons.sentiment_very_satisfied, successColor),
                _buildMetricItem("Escalation Rate", "5%", Icons.trending_up, warningColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryStats() {
    Map<String, int> categoryCounts = {};
    for (var ticket in tickets) {
      String category = ticket["category"];
      categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
    }

    return categoryCounts.entries.map((entry) {
      double percentage = (entry.value / tickets.length) * 100;
      return Container(
        margin: EdgeInsets.only(bottom: spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry.key),
                Text("${entry.value} (${percentage.toStringAsFixed(1)}%)"),
              ],
            ),
            SizedBox(height: spXs),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: disabledColor.withAlpha(30),
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildMetricItem(String title, String value, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
