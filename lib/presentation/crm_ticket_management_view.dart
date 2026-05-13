import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmTicketManagementView extends StatefulWidget {
  const CrmTicketManagementView({super.key});

  @override
  State<CrmTicketManagementView> createState() => _CrmTicketManagementViewState();
}

class _CrmTicketManagementViewState extends State<CrmTicketManagementView> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedCategory = "all";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Open", "value": "open"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Pending", "value": "pending"},
    {"label": "Resolved", "value": "resolved"},
    {"label": "Closed", "value": "closed"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priority", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Technical Support", "value": "technical"},
    {"label": "Billing", "value": "billing"},
    {"label": "General Inquiry", "value": "general"},
    {"label": "Bug Report", "value": "bug"},
    {"label": "Feature Request", "value": "feature"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Ticket Management",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "All Tickets", icon: Icon(Icons.list_alt)),
        Tab(text: "My Tickets", icon: Icon(Icons.person)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildAllTicketsTab(),
        _buildMyTicketsTab(),
        _buildAnalyticsTab(),
        _buildSettingsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }

  Widget _buildAllTicketsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFilterSection(),
          _buildTicketStats(),
          _buildQuickActions(),
          _buildTicketsList(),
        ],
      ),
    );
  }

  Widget _buildMyTicketsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMyTicketsStats(),
          _buildMyTicketsList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsOverview(),
          _buildPerformanceMetrics(),
          _buildTrendCharts(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTicketSettings(),
          _buildNotificationSettings(),
          _buildIntegrationSettings(),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                  label: "Search tickets",
                  value: searchQuery,
                  hint: "Ticket ID, subject, or customer",
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
                  label: "Priority",
                  items: priorityOptions,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Category",
            items: categoryOptions,
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTicketStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.confirmation_number,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  "1,247",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Tickets",
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.pending_actions,
                  color: warningColor,
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  "87",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Open Tickets",
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
            padding: EdgeInsets.all(spMd),
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
                SizedBox(height: spSm),
                Text(
                  "1,160",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Resolved",
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
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Create Ticket",
                  size: bs.sm,
                  icon: Icons.add,
                  onPressed: () {
                    // Navigate to create ticket
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Bulk Actions",
                  size: bs.sm,
                  icon: Icons.checklist,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export Data",
                  size: bs.sm,
                  icon: Icons.download,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Import Tickets",
                  size: bs.sm,
                  icon: Icons.upload,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTicketsList() {
    List<Map<String, dynamic>> tickets = [
      {
        "id": "TKT-001",
        "subject": "Unable to login to account",
        "customer": "John Smith",
        "priority": "high",
        "status": "open",
        "category": "technical",
        "assignee": "Sarah Johnson",
        "created": "2024-06-19 09:00:00",
        "updated": "2024-06-19 10:30:00"
      },
      {
        "id": "TKT-002",
        "subject": "Billing inquiry for last month",
        "customer": "Emily Davis",
        "priority": "medium",
        "status": "in_progress",
        "category": "billing",
        "assignee": "Mike Wilson",
        "created": "2024-06-19 08:45:00",
        "updated": "2024-06-19 09:15:00"
      },
      {
        "id": "TKT-003",
        "subject": "Feature request: Dark mode",
        "customer": "Robert Brown",
        "priority": "low",
        "status": "pending",
        "category": "feature",
        "assignee": "Lisa Chen",
        "created": "2024-06-19 07:30:00",
        "updated": "2024-06-19 08:00:00"
      }
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Recent Tickets",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tickets.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return _buildTicketItem(ticket);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTicketItem(Map<String, dynamic> ticket) {
    Color priorityColor = ticket["priority"] == "critical" 
        ? dangerColor 
        : ticket["priority"] == "high" 
        ? dangerColor
        : ticket["priority"] == "medium" 
        ? warningColor 
        : successColor;

    Color statusColor = ticket["status"] == "open" 
        ? dangerColor 
        : ticket["status"] == "in_progress" 
        ? warningColor
        : ticket["status"] == "pending"
        ? infoColor
        : successColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${ticket["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${ticket["status"]}".replaceAll("_", " ").toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${ticket["subject"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Customer: ${ticket["customer"]}",
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
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${ticket["assignee"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${DateTime.parse(ticket["created"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${ticket["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to ticket detail
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.comment,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMyTicketsStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.assignment, color: primaryColor, size: 32),
                SizedBox(height: spSm),
                Text(
                  "24",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Assigned to Me",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.schedule, color: warningColor, size: 32),
                SizedBox(height: spSm),
                Text(
                  "8",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Pending Action",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMyTicketsList() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "My Active Tickets",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "You have 8 tickets that require your attention",
            style: TextStyle(fontSize: 14, color: disabledBoldColor),
          ),
          QButton(
            label: "View All My Tickets",
            size: bs.sm,
            icon: Icons.arrow_forward,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Analytics Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Performance metrics and insights for your support team",
            style: TextStyle(fontSize: 14, color: disabledBoldColor),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.timer, color: infoColor, size: 32),
                SizedBox(height: spSm),
                Text(
                  "2.4h",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Avg Response Time",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.sentiment_satisfied, color: successColor, size: 32),
                SizedBox(height: spSm),
                Text(
                  "94%",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Satisfaction Rate",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendCharts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Ticket Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            child: Center(
              child: Text(
                "Chart placeholder - Ticket volume over time",
                style: TextStyle(color: disabledBoldColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Ticket Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Configure default ticket properties and workflows",
            style: TextStyle(fontSize: 14, color: disabledBoldColor),
          ),
          QButton(
            label: "Manage Categories",
            size: bs.sm,
            icon: Icons.category,
            onPressed: () {},
          ),
          QButton(
            label: "Priority Settings",
            size: bs.sm,
            icon: Icons.priority_high,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Notifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Configure when and how you receive notifications",
            style: TextStyle(fontSize: 14, color: disabledBoldColor),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Integrations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Connect with external tools and services",
            style: TextStyle(fontSize: 14, color: disabledBoldColor),
          ),
        ],
      ),
    );
  }
}
