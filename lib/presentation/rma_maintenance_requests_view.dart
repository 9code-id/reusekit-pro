import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaMaintenanceRequestsView extends StatefulWidget {
  const RmaMaintenanceRequestsView({super.key});

  @override
  State<RmaMaintenanceRequestsView> createState() => _RmaMaintenanceRequestsViewState();
}

class _RmaMaintenanceRequestsViewState extends State<RmaMaintenanceRequestsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  String selectedCategory = "All";

  List<Map<String, dynamic>> maintenanceRequests = [
    {
      "id": "MR001",
      "title": "Leaking Kitchen Faucet",
      "description": "Kitchen faucet has been dripping continuously for 3 days",
      "tenant": "Sarah Johnson",
      "unit": "Unit 204",
      "property": "Downtown Apartment Complex",
      "category": "Plumbing",
      "priority": "Medium",
      "status": "In Progress",
      "reported_date": "2024-12-10",
      "assigned_to": "Mike's Plumbing Services",
      "estimated_cost": 150.0,
      "actual_cost": null,
      "scheduled_date": "2024-12-16",
      "completion_date": null,
      "photos": ["https://picsum.photos/300/200?random=1&keyword=plumbing"],
      "notes": "Tenant reports water waste, affecting monthly bill",
      "contact_info": "+1 (555) 123-4567",
      "urgency_level": 3,
    },
    {
      "id": "MR002",
      "title": "Broken Air Conditioning",
      "description": "AC unit not cooling, making loud noises",
      "tenant": "Michael Chen",
      "unit": "Villa 3",
      "property": "Riverside Villa Community",
      "category": "HVAC",
      "priority": "High",
      "status": "Open",
      "reported_date": "2024-12-12",
      "assigned_to": null,
      "estimated_cost": 450.0,
      "actual_cost": null,
      "scheduled_date": null,
      "completion_date": null,
      "photos": ["https://picsum.photos/300/200?random=2&keyword=aircon"],
      "notes": "Urgent repair needed, temperatures rising",
      "contact_info": "+1 (555) 234-5678",
      "urgency_level": 5,
    },
    {
      "id": "MR003",
      "title": "Exterior Paint Touch-up",
      "description": "Front entrance paint is peeling and needs touch-up",
      "tenant": "Property Management",
      "unit": "Common Area",
      "property": "Garden Heights Condos",
      "category": "Cosmetic",
      "priority": "Low",
      "status": "Scheduled",
      "reported_date": "2024-12-05",
      "assigned_to": "Elite Painting Co.",
      "estimated_cost": 300.0,
      "actual_cost": null,
      "scheduled_date": "2024-12-20",
      "completion_date": null,
      "photos": ["https://picsum.photos/300/200?random=3&keyword=paint"],
      "notes": "Weather dependent, schedule for dry days",
      "contact_info": "N/A",
      "urgency_level": 1,
    },
    {
      "id": "MR004",
      "title": "Garbage Disposal Malfunction",
      "description": "Garbage disposal jammed and not working",
      "tenant": "Emily Rodriguez",
      "unit": "Condo 12B",
      "property": "Garden Heights Condos",
      "category": "Appliance",
      "priority": "Medium",
      "status": "Completed",
      "reported_date": "2024-12-08",
      "assigned_to": "Appliance Repair Plus",
      "estimated_cost": 120.0,
      "actual_cost": 95.0,
      "scheduled_date": "2024-12-11",
      "completion_date": "2024-12-11",
      "photos": ["https://picsum.photos/300/200?random=4&keyword=disposal"],
      "notes": "Replaced grinding mechanism, tested thoroughly",
      "contact_info": "+1 (555) 345-6789",
      "urgency_level": 3,
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Open", "value": "Open"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Completed", "value": "Completed"},
    {"label": "On Hold", "value": "On Hold"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Emergency", "value": "Emergency"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Plumbing", "value": "Plumbing"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "HVAC", "value": "HVAC"},
    {"label": "Appliance", "value": "Appliance"},
    {"label": "Cosmetic", "value": "Cosmetic"},
    {"label": "Security", "value": "Security"},
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return maintenanceRequests.where((request) {
      bool matchesSearch = request["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          request["tenant"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          request["unit"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || request["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || request["priority"] == selectedPriority;
      bool matchesCategory = selectedCategory == "All" || request["category"] == selectedCategory;
      
      return matchesSearch && matchesStatus && matchesPriority && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Maintenance Requests",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Requests", icon: Icon(Icons.build)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Vendors", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildRequestsTab(),
        _buildAnalyticsTab(),
        _buildVendorsTab(),
      ],
    );
  }

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRequestsOverview(),
          _buildFilters(),
          _buildRequestsList(),
        ],
      ),
    );
  }

  Widget _buildRequestsOverview() {
    int totalRequests = maintenanceRequests.length;
    int openRequests = maintenanceRequests.where((r) => r["status"] == "Open").length;
    int inProgressRequests = maintenanceRequests.where((r) => r["status"] == "In Progress").length;
    int highPriorityRequests = maintenanceRequests.where((r) => r["priority"] == "High" || r["priority"] == "Emergency").length;

    return Container(
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
            "Maintenance Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildOverviewCard("Total Requests", "$totalRequests", Icons.build, primaryColor),
              _buildOverviewCard("Open", "$openRequests", Icons.pending, warningColor),
              _buildOverviewCard("In Progress", "$inProgressRequests", Icons.build_circle, infoColor),
              _buildOverviewCard("High Priority", "$highPriorityRequests", Icons.priority_high, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
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
                  label: "Search Requests",
                  value: searchQuery,
                  hint: "Search by title, tenant, or unit",
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
                  items: statusItems,
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
                  items: priorityItems,
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
                  label: "Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsList() {
    return Column(
      spacing: spSm,
      children: filteredRequests.map((request) {
        Color priorityColor = _getPriorityColor(request["priority"]);
        Color statusColor = _getStatusColor(request["status"]);
        
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${request["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: priorityColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${request["priority"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: priorityColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${request["unit"]} - ${request["property"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Reported by: ${request["tenant"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: spXs,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${request["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${request["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${request["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (request["notes"] != null)
                      Text(
                        "Notes: ${request["notes"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                children: [
                  if ((request["photos"] as List).isNotEmpty)
                    Container(
                      width: 60,
                      height: 40,
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusXs),
                        image: DecorationImage(
                          image: NetworkImage("${(request["photos"] as List)[0]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildRequestDetail("Reported", "${request["reported_date"]}", Icons.calendar_today),
                            ),
                            if (request["scheduled_date"] != null)
                              Expanded(
                                child: _buildRequestDetail("Scheduled", "${request["scheduled_date"]}", Icons.schedule),
                              ),
                            if (request["completion_date"] != null)
                              Expanded(
                                child: _buildRequestDetail("Completed", "${request["completion_date"]}", Icons.check_circle),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            if (request["estimated_cost"] != null)
                              Expanded(
                                child: _buildRequestDetail("Estimated", "\$${((request["estimated_cost"] as num).toDouble()).currency}", Icons.monetization_on),
                              ),
                            if (request["actual_cost"] != null)
                              Expanded(
                                child: _buildRequestDetail("Actual Cost", "\$${((request["actual_cost"] as num).toDouble()).currency}", Icons.receipt),
                              ),
                            if (request["assigned_to"] != null)
                              Expanded(
                                child: _buildRequestDetail("Assigned To", "${request["assigned_to"]}", Icons.person),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Contact: ${request["contact_info"]} • ID: ${request["id"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      if (request["status"] != "Completed")
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      QButton(
                        icon: Icons.message,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      QButton(
                        label: request["status"] == "Completed" ? "View Details" : "Update Status",
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
      }).toList(),
    );
  }

  Widget _buildRequestDetail(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12,
          color: primaryColor,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      case "Emergency":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Scheduled":
        return primaryColor;
      case "Completed":
        return successColor;
      case "On Hold":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMaintenanceMetrics(),
          _buildCategoryAnalysis(),
          _buildResponseTimeAnalysis(),
        ],
      ),
    );
  }

  Widget _buildMaintenanceMetrics() {
    return Container(
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
            "Maintenance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildMetricCard("Avg Response Time", "2.3 days", Icons.schedule, infoColor),
              _buildMetricCard("Completion Rate", "85%", Icons.check_circle, successColor),
              _buildMetricCard("Monthly Cost", "\$1,245", Icons.monetization_on, warningColor),
              _buildMetricCard("Tenant Satisfaction", "4.2/5", Icons.star, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryAnalysis() {
    List<Map<String, dynamic>> categoryData = [
      {"category": "Plumbing", "count": 12, "avg_cost": 185.0, "avg_time": 1.5},
      {"category": "HVAC", "count": 8, "avg_cost": 425.0, "avg_time": 3.2},
      {"category": "Electrical", "count": 6, "avg_cost": 275.0, "avg_time": 2.1},
      {"category": "Appliance", "count": 4, "avg_cost": 195.0, "avg_time": 1.8},
      {"category": "Cosmetic", "count": 3, "avg_cost": 320.0, "avg_time": 4.5},
    ];

    return Container(
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
            "Maintenance by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...categoryData.map((data) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      _getCategoryIcon(data["category"]),
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${data["category"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildCategoryStat("Requests", "${data["count"]}"),
                  ),
                  Expanded(
                    child: _buildCategoryStat("Avg Cost", "\$${((data["avg_cost"] as num).toDouble()).currency}"),
                  ),
                  Expanded(
                    child: _buildCategoryStat("Avg Time", "${(data["avg_time"] as num).toStringAsFixed(1)} days"),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Plumbing":
        return Icons.plumbing;
      case "HVAC":
        return Icons.ac_unit;
      case "Electrical":
        return Icons.electrical_services;
      case "Appliance":
        return Icons.kitchen;
      case "Cosmetic":
        return Icons.format_paint;
      default:
        return Icons.build;
    }
  }

  Widget _buildCategoryStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildResponseTimeAnalysis() {
    List<Map<String, dynamic>> responseData = [
      {"priority": "Emergency", "target_hours": 2, "avg_hours": 1.5, "within_target": 95},
      {"priority": "High", "target_hours": 24, "avg_hours": 18, "within_target": 88},
      {"priority": "Medium", "target_hours": 72, "avg_hours": 55, "within_target": 92},
      {"priority": "Low", "target_hours": 168, "avg_hours": 120, "within_target": 98},
    ];

    return Container(
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
            "Response Time Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...responseData.map((data) {
            Color priorityColor = _getPriorityColor(data["priority"]);
            int withinTarget = data["within_target"] as int;
            Color performanceColor = withinTarget >= 95 ? successColor :
                                   withinTarget >= 85 ? warningColor : dangerColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: priorityColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: priorityColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.priority_high,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${data["priority"]} Priority",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildResponseStat("Target", "${data["target_hours"]}h"),
                  ),
                  Expanded(
                    child: _buildResponseStat("Actual", "${data["avg_hours"]}h"),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: performanceColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$withinTarget%",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: performanceColor,
                        ),
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

  Widget _buildResponseStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildVendorsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildVendorOverview(),
          _buildVendorList(),
          _buildVendorPerformance(),
        ],
      ),
    );
  }

  Widget _buildVendorOverview() {
    return Container(
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Vendor Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Vendor",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildVendorStatCard("Active Vendors", "12", Icons.people, primaryColor),
              _buildVendorStatCard("This Month Jobs", "28", Icons.work, infoColor),
              _buildVendorStatCard("Avg Rating", "4.3/5", Icons.star, successColor),
              _buildVendorStatCard("Total Spent", "\$8,450", Icons.monetization_on, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVendorStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorList() {
    List<Map<String, dynamic>> vendors = [
      {
        "name": "Mike's Plumbing Services",
        "category": "Plumbing",
        "phone": "+1 (555) 111-2222",
        "email": "mike@plumbingservices.com",
        "rating": 4.8,
        "jobs_completed": 15,
        "avg_cost": 185.0,
        "response_time": "Same Day",
        "license": "PL-2024-001",
        "status": "Active",
      },
      {
        "name": "Cool Air HVAC",
        "category": "HVAC",
        "phone": "+1 (555) 333-4444",
        "email": "service@coolair.com",
        "rating": 4.5,
        "jobs_completed": 8,
        "avg_cost": 425.0,
        "response_time": "Next Day",
        "license": "HVAC-2024-002",
        "status": "Active",
      },
      {
        "name": "Elite Painting Co.",
        "category": "Cosmetic",
        "phone": "+1 (555) 555-6666",
        "email": "info@elitepainting.com",
        "rating": 4.2,
        "jobs_completed": 6,
        "avg_cost": 320.0,
        "response_time": "2-3 Days",
        "license": "PAINT-2024-003",
        "status": "Active",
      },
      {
        "name": "Quick Fix Electric",
        "category": "Electrical",
        "phone": "+1 (555) 777-8888",
        "email": "help@quickfixelectric.com",
        "rating": 4.6,
        "jobs_completed": 12,
        "avg_cost": 275.0,
        "response_time": "Same Day",
        "license": "ELC-2024-004",
        "status": "On Hold",
      },
    ];

    return Container(
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
            "Vendor Directory",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...vendors.map((vendor) {
            Color statusColor = vendor["status"] == "Active" ? successColor : warningColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledColor),
                boxShadow: [shadowXs],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          _getCategoryIcon(vendor["category"]),
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${vendor["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${vendor["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${vendor["category"]} • ${vendor["phone"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${vendor["email"]} • License: ${vendor["license"]}",
                              style: TextStyle(
                                fontSize: 11,
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
                      Expanded(
                        child: _buildVendorStat("Rating", "${(vendor["rating"] as num).toStringAsFixed(1)}★"),
                      ),
                      Expanded(
                        child: _buildVendorStat("Jobs", "${vendor["jobs_completed"]}"),
                      ),
                      Expanded(
                        child: _buildVendorStat("Avg Cost", "\$${((vendor["avg_cost"] as num).toDouble()).currency}"),
                      ),
                      Expanded(
                        child: _buildVendorStat("Response", "${vendor["response_time"]}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Row(
                        spacing: spSm,
                        children: [
                          QButton(
                            icon: Icons.phone,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          QButton(
                            icon: Icons.email,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          QButton(
                            label: "View Profile",
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildVendorStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildVendorPerformance() {
    List<Map<String, dynamic>> topVendors = [
      {
        "name": "Mike's Plumbing Services",
        "category": "Plumbing",
        "rating": 4.8,
        "completion_rate": 98,
        "response_time": 1.2,
        "total_revenue": 2850.0,
      },
      {
        "name": "Quick Fix Electric",
        "category": "Electrical",
        "rating": 4.6,
        "completion_rate": 95,
        "response_time": 1.8,
        "total_revenue": 3300.0,
      },
      {
        "name": "Cool Air HVAC",
        "category": "HVAC",
        "rating": 4.5,
        "completion_rate": 92,
        "response_time": 2.1,
        "total_revenue": 3400.0,
      },
    ];

    return Container(
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
            "Top Performing Vendors",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topVendors.map((vendor) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${vendor["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${vendor["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _buildPerformanceStat("Rating", "${(vendor["rating"] as num).toStringAsFixed(1)}"),
                  ),
                  Expanded(
                    child: _buildPerformanceStat("Completion", "${vendor["completion_rate"]}%"),
                  ),
                  Expanded(
                    child: _buildPerformanceStat("Response", "${(vendor["response_time"] as num).toStringAsFixed(1)}h"),
                  ),
                  Expanded(
                    child: _buildPerformanceStat("Revenue", "\$${((vendor["total_revenue"] as num).toDouble()).currency}"),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPerformanceStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: successColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
