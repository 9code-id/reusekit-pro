import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaMaintenanceCostsView extends StatefulWidget {
  const RmaMaintenanceCostsView({super.key});

  @override
  State<RmaMaintenanceCostsView> createState() => _RmaMaintenanceCostsViewState();
}

class _RmaMaintenanceCostsViewState extends State<RmaMaintenanceCostsView> {
  String selectedCategory = "all";
  String selectedPriority = "all";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "HVAC", "value": "hvac"},
    {"label": "Plumbing", "value": "plumbing"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Roofing", "value": "roofing"},
    {"label": "Landscaping", "value": "landscaping"},
    {"label": "Interior", "value": "interior"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];
  
  Map<String, dynamic> maintenanceSummary = {
    "annual_budget": 5800.00,
    "spent_ytd": 3245.50,
    "remaining_budget": 2554.50,
    "emergency_fund": 2000.00,
  };
  
  List<Map<String, dynamic>> maintenanceItems = [
    {
      "category": "hvac",
      "title": "HVAC System Service",
      "description": "Annual maintenance and filter replacement",
      "cost": 285.00,
      "priority": "high",
      "frequency": "Annual",
      "last_done": "2023-09-15",
      "next_due": "2024-09-15",
      "status": "upcoming",
      "vendor": "Cool Air Services",
      "icon": Icons.air,
    },
    {
      "category": "plumbing",
      "title": "Water Heater Maintenance",
      "description": "Flush tank and check heating elements",
      "cost": 150.00,
      "priority": "medium",
      "frequency": "Annual",
      "last_done": "2024-02-20",
      "next_due": "2025-02-20",
      "status": "scheduled",
      "vendor": "Metro Plumbing",
      "icon": Icons.hot_tub,
    },
    {
      "category": "roofing",
      "title": "Gutter Cleaning",
      "description": "Clean gutters and downspouts",
      "cost": 125.00,
      "priority": "medium",
      "frequency": "Bi-annual",
      "last_done": "2024-03-10",
      "next_due": "2024-09-10",
      "status": "upcoming",
      "vendor": "Heights Roofing",
      "icon": Icons.roofing,
    },
    {
      "category": "electrical",
      "title": "Electrical Panel Inspection",
      "description": "Safety inspection and testing",
      "cost": 200.00,
      "priority": "high",
      "frequency": "Every 3 years",
      "last_done": "2022-06-15",
      "next_due": "2025-06-15",
      "status": "scheduled",
      "vendor": "Bright Electric",
      "icon": Icons.electrical_services,
    },
    {
      "category": "landscaping",
      "title": "Tree Trimming",
      "description": "Trim large oak tree near house",
      "cost": 350.00,
      "priority": "medium",
      "frequency": "Every 2 years",
      "last_done": "2023-04-20",
      "next_due": "2025-04-20",
      "status": "scheduled",
      "vendor": "Green Thumb Tree Care",
      "icon": Icons.park,
    },
    {
      "category": "interior",
      "title": "Carpet Deep Cleaning",
      "description": "Professional steam cleaning",
      "cost": 180.00,
      "priority": "low",
      "frequency": "Annual",
      "last_done": "2024-01-15",
      "next_due": "2025-01-15",
      "status": "scheduled",
      "vendor": "Fresh Clean Services",
      "icon": Icons.cleaning_services,
    },
    {
      "category": "plumbing",
      "title": "Leak Detection Service",
      "description": "Check for hidden leaks",
      "cost": 95.00,
      "priority": "critical",
      "frequency": "As needed",
      "last_done": "2024-05-05",
      "next_due": "Immediate",
      "status": "overdue",
      "vendor": "Metro Plumbing",
      "icon": Icons.water_drop,
    },
    {
      "category": "hvac",
      "title": "Duct Cleaning",
      "description": "Clean air ducts and vents",
      "cost": 295.00,
      "priority": "medium",
      "frequency": "Every 3 years",
      "last_done": "2021-08-10",
      "next_due": "2024-08-10",
      "status": "upcoming",
      "vendor": "Air Quality Pro",
      "icon": Icons.wind_power,
    },
  ];
  
  List<Map<String, dynamic>> maintenanceSchedule = [
    {"month": "July 2024", "items": 2, "cost": 420.00},
    {"month": "August 2024", "items": 3, "cost": 680.00},
    {"month": "September 2024", "items": 2, "cost": 410.00},
    {"month": "October 2024", "items": 1, "cost": 150.00},
    {"month": "November 2024", "items": 1, "cost": 180.00},
    {"month": "December 2024", "items": 0, "cost": 0.00},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maintenance Costs"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new maintenance item
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMaintenanceSummary(),
            _buildFilters(),
            _buildMaintenanceItems(),
            _buildUpcomingSchedule(),
            _buildMaintenanceTips(),
            _buildVendorContacts(),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceSummary() {
    double budgetUsedPercentage = (maintenanceSummary["spent_ytd"] as double) / 
                                 (maintenanceSummary["annual_budget"] as double) * 100;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Annual Maintenance Budget",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${(maintenanceSummary["annual_budget"] as double).currency}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${budgetUsedPercentage.toStringAsFixed(1)}% used • \$${(maintenanceSummary["remaining_budget"] as double).currency} remaining",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(Icons.emergency, color: Colors.white, size: 20),
                    SizedBox(height: spXs),
                    Text(
                      "Emergency",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "\$${((maintenanceSummary["emergency_fund"] as double) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter Maintenance Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
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
        ],
      ),
    );
  }

  Widget _buildMaintenanceItems() {
    List<Map<String, dynamic>> filteredItems = maintenanceItems.where((item) {
      bool categoryMatch = selectedCategory == "all" || item["category"] == selectedCategory;
      bool priorityMatch = selectedPriority == "all" || item["priority"] == selectedPriority;
      return categoryMatch && priorityMatch;
    }).toList();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Maintenance Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredItems.length} items",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...filteredItems.map((item) => _buildMaintenanceCard(item)),
        ],
      ),
    );
  }

  Widget _buildMaintenanceCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item["status"]);
    Color priorityColor = _getPriorityColor(item["priority"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: priorityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              item["icon"] as IconData,
              color: priorityColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${item["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["priority"]}",
                        style: TextStyle(
                          fontSize: 9,
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Cost: \$${(item["cost"] as double).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Due: ${item["next_due"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Vendor: ${item["vendor"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Schedule or manage maintenance item
            },
            child: Icon(
              Icons.schedule,
              color: statusColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingSchedule() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "6-Month Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...maintenanceSchedule.map((schedule) => _buildScheduleCard(schedule)),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Center(
              child: Text(
                "${schedule["month"]}".split(" ")[0],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${schedule["month"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${schedule["items"]} items scheduled",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${(schedule["cost"] as double).currency}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceTips() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Maintenance Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildTipItem(
            "Preventive Maintenance",
            "Regular maintenance prevents costly emergency repairs",
            Icons.construction,
            successColor,
          ),
          _buildTipItem(
            "Seasonal Preparation",
            "Prepare HVAC and plumbing systems before extreme weather",
            Icons.wb_sunny,
            warningColor,
          ),
          _buildTipItem(
            "Professional Inspections",
            "Annual professional inspections catch issues early",
            Icons.search,
            infoColor,
          ),
          _buildTipItem(
            "Emergency Fund",
            "Maintain 1-3% of home value for unexpected repairs",
            Icons.emergency,
            dangerColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorContacts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trusted Vendors",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildVendorItem("Cool Air Services", "HVAC", "(555) 123-4567", Icons.air),
          _buildVendorItem("Metro Plumbing", "Plumbing", "(555) 234-5678", Icons.plumbing),
          _buildVendorItem("Bright Electric", "Electrical", "(555) 345-6789", Icons.electrical_services),
          _buildVendorItem("Heights Roofing", "Roofing", "(555) 456-7890", Icons.roofing),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View All Vendors",
              size: bs.md,
              onPressed: () {
                // Navigate to vendor directory
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorItem(String name, String category, String phone, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 16),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Call vendor
            },
            child: Row(
              children: [
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: spXs),
                Icon(Icons.phone, color: primaryColor, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "overdue":
        return dangerColor;
      case "upcoming":
        return warningColor;
      case "scheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
