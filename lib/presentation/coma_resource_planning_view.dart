import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaResourcePlanningView extends StatefulWidget {
  const ComaResourcePlanningView({Key? key}) : super(key: key);

  @override
  State<ComaResourcePlanningView> createState() => _ComaResourcePlanningViewState();
}

class _ComaResourcePlanningViewState extends State<ComaResourcePlanningView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedProject = "All";

  List<Map<String, dynamic>> resourcesData = [
    {
      "id": "RES001",
      "resource_name": "Tower Crane TC-450",
      "category": "Equipment",
      "subcategory": "Heavy Machinery",
      "project": "City Mall Development",
      "status": "In Use",
      "availability": "Busy",
      "location": "Site Zone A",
      "quantity_total": 1,
      "quantity_available": 0,
      "quantity_in_use": 1,
      "daily_rate": 850.0,
      "weekly_rate": 5500.0,
      "monthly_rate": 22000.0,
      "specifications": {
        "max_load": "45 tons",
        "jib_length": "60 meters",
        "max_height": "180 meters",
        "power": "380V/50Hz"
      },
      "maintenance_status": "Good",
      "last_maintenance": "2024-09-15",
      "next_maintenance": "2024-12-15",
      "operator_required": true,
      "operator_certification": "CCO Certified",
      "supplier": "Crane Solutions Ltd",
      "supplier_contact": "+1 555-0100",
      "scheduled_dates": [
        {"start": "2024-10-15", "end": "2024-11-30", "project": "City Mall Development"}
      ],
      "usage_hours_week": 45,
      "fuel_consumption": "120 L/day",
      "safety_requirements": ["Hard Hat", "Safety Vest", "Fall Protection"]
    },
    {
      "id": "RES002",
      "resource_name": "Concrete Pump CKE-2500",
      "category": "Equipment",
      "subcategory": "Concrete Equipment",
      "project": "Highway Bridge Construction",
      "status": "Available",
      "availability": "Available",
      "location": "Equipment Yard",
      "quantity_total": 2,
      "quantity_available": 1,
      "quantity_in_use": 1,
      "daily_rate": 450.0,
      "weekly_rate": 2800.0,
      "monthly_rate": 11200.0,
      "specifications": {
        "output": "160 m³/hour",
        "vertical_reach": "52 meters",
        "horizontal_reach": "46 meters",
        "pressure": "85 bar"
      },
      "maintenance_status": "Excellent",
      "last_maintenance": "2024-10-01",
      "next_maintenance": "2024-01-01",
      "operator_required": true,
      "operator_certification": "Concrete Pump Operator",
      "supplier": "Concrete Equipment Co",
      "supplier_contact": "+1 555-0200",
      "scheduled_dates": [
        {"start": "2024-10-22", "end": "2024-10-25", "project": "Highway Bridge Construction"}
      ],
      "usage_hours_week": 32,
      "fuel_consumption": "85 L/day",
      "safety_requirements": ["Hard Hat", "Safety Vest", "Steel Toe Boots"]
    },
    {
      "id": "RES003",
      "resource_name": "Steel Beams Grade A572",
      "category": "Material",
      "subcategory": "Structural Steel",
      "project": "Office Tower Downtown",
      "status": "Ordered",
      "availability": "Incoming",
      "location": "Supplier Warehouse",
      "quantity_total": 2500,
      "quantity_available": 0,
      "quantity_in_use": 0,
      "daily_rate": 0.0,
      "weekly_rate": 0.0,
      "monthly_rate": 0.0,
      "specifications": {
        "grade": "ASTM A572 Grade 50",
        "length": "Various (6-12m)",
        "weight": "2500 tons total",
        "coating": "Fire Resistant"
      },
      "maintenance_status": "N/A",
      "last_maintenance": "N/A",
      "next_maintenance": "N/A",
      "operator_required": false,
      "operator_certification": "N/A",
      "supplier": "Steel Masters Inc",
      "supplier_contact": "+1 555-0300",
      "scheduled_dates": [
        {"start": "2024-10-28", "end": "2024-11-15", "project": "Office Tower Downtown"}
      ],
      "usage_hours_week": 0,
      "fuel_consumption": "N/A",
      "safety_requirements": ["Hard Hat", "Safety Vest", "Work Gloves"]
    },
    {
      "id": "RES004",
      "resource_name": "Excavation Team Alpha",
      "category": "Labor",
      "subcategory": "Skilled Workers",
      "project": "Residential Complex Phase II",
      "status": "Assigned",
      "availability": "Busy",
      "location": "Site Zone B",
      "quantity_total": 8,
      "quantity_available": 0,
      "quantity_in_use": 8,
      "daily_rate": 320.0,
      "weekly_rate": 2240.0,
      "monthly_rate": 9600.0,
      "specifications": {
        "team_size": "8 workers",
        "skill_level": "Experienced",
        "shift": "Day Shift",
        "certifications": "OSHA 10, Excavation Safety"
      },
      "maintenance_status": "N/A",
      "last_maintenance": "N/A",
      "next_maintenance": "N/A",
      "operator_required": false,
      "operator_certification": "N/A",
      "supplier": "Labor Solutions LLC",
      "supplier_contact": "+1 555-0400",
      "scheduled_dates": [
        {"start": "2024-10-15", "end": "2024-10-30", "project": "Residential Complex Phase II"}
      ],
      "usage_hours_week": 40,
      "fuel_consumption": "N/A",
      "safety_requirements": ["Hard Hat", "Safety Vest", "Steel Toe Boots", "Excavation PPE"]
    },
    {
      "id": "RES005",
      "resource_name": "Ready Mix Concrete C30",
      "category": "Material",
      "subcategory": "Concrete",
      "project": "Industrial Warehouse Complex",
      "status": "Available",
      "availability": "Available",
      "location": "Supplier Plant",
      "quantity_total": 800,
      "quantity_available": 650,
      "quantity_in_use": 150,
      "daily_rate": 0.0,
      "weekly_rate": 0.0,
      "monthly_rate": 0.0,
      "specifications": {
        "strength": "C30/37 (30 MPa)",
        "slump": "150-200mm",
        "aggregate_size": "20mm max",
        "additive": "Plasticizer included"
      },
      "maintenance_status": "Fresh",
      "last_maintenance": "N/A",
      "next_maintenance": "N/A",
      "operator_required": false,
      "operator_certification": "N/A",
      "supplier": "Concrete Solutions Ltd",
      "supplier_contact": "+1 555-0500",
      "scheduled_dates": [
        {"start": "2024-10-20", "end": "2024-11-10", "project": "Industrial Warehouse Complex"}
      ],
      "usage_hours_week": 0,
      "fuel_consumption": "N/A",
      "safety_requirements": ["Hard Hat", "Safety Vest", "Work Gloves", "Eye Protection"]
    },
    {
      "id": "RES006",
      "resource_name": "Welding Specialists Team",
      "category": "Labor",
      "subcategory": "Specialized Workers",
      "project": "Healthcare Facility Expansion",
      "status": "Available",
      "availability": "Available",
      "location": "Ready for Assignment",
      "quantity_total": 6,
      "quantity_available": 4,
      "quantity_in_use": 2,
      "daily_rate": 480.0,
      "weekly_rate": 3360.0,
      "monthly_rate": 14400.0,
      "specifications": {
        "team_size": "6 welders",
        "skill_level": "Certified",
        "specialization": "Structural & Pipe Welding",
        "certifications": "AWS D1.1, ASME IX"
      },
      "maintenance_status": "N/A",
      "last_maintenance": "N/A",
      "next_maintenance": "N/A",
      "operator_required": false,
      "operator_certification": "AWS Certified",
      "supplier": "Skilled Trades Inc",
      "supplier_contact": "+1 555-0600",
      "scheduled_dates": [
        {"start": "2024-11-01", "end": "2024-12-15", "project": "Healthcare Facility Expansion"}
      ],
      "usage_hours_week": 48,
      "fuel_consumption": "N/A",
      "safety_requirements": ["Welding Helmet", "Welding Gloves", "Fire Resistant Clothing"]
    },
    {
      "id": "RES007",
      "resource_name": "Formwork System Doka",
      "category": "Equipment",
      "subcategory": "Formwork",
      "project": "Multiple Projects",
      "status": "Partially Available",
      "availability": "Partially Available",
      "location": "Multiple Sites",
      "quantity_total": 5000,
      "quantity_available": 2000,
      "quantity_in_use": 3000,
      "daily_rate": 2.5,
      "weekly_rate": 15.0,
      "monthly_rate": 60.0,
      "specifications": {
        "type": "Modular Formwork",
        "material": "Steel Frame + Plywood",
        "max_pressure": "80 kN/m²",
        "reuse_cycles": "100+ uses"
      },
      "maintenance_status": "Good",
      "last_maintenance": "2024-09-30",
      "next_maintenance": "2024-12-30",
      "operator_required": false,
      "operator_certification": "Formwork Training",
      "supplier": "Formwork Systems Ltd",
      "supplier_contact": "+1 555-0700",
      "scheduled_dates": [
        {"start": "2024-10-25", "end": "2024-11-20", "project": "Multiple Projects"}
      ],
      "usage_hours_week": 0,
      "fuel_consumption": "N/A",
      "safety_requirements": ["Hard Hat", "Safety Harness", "Work Gloves"]
    },
    {
      "id": "RES008",
      "resource_name": "Quality Control Team",
      "category": "Labor",
      "subcategory": "Technical Staff",
      "project": "All Projects",
      "status": "Active",
      "availability": "Available",
      "location": "Mobile",
      "quantity_total": 5,
      "quantity_available": 2,
      "quantity_in_use": 3,
      "daily_rate": 400.0,
      "weekly_rate": 2800.0,
      "monthly_rate": 12000.0,
      "specifications": {
        "team_size": "5 inspectors",
        "skill_level": "Expert",
        "specialization": "Material & Process QC",
        "certifications": "ACI, ASTM, ISO 9001"
      },
      "maintenance_status": "N/A",
      "last_maintenance": "N/A",
      "next_maintenance": "N/A",
      "operator_required": false,
      "operator_certification": "QC Certifications",
      "supplier": "Quality Assurance Corp",
      "supplier_contact": "+1 555-0800",
      "scheduled_dates": [
        {"start": "2024-10-15", "end": "2024-12-31", "project": "All Projects"}
      ],
      "usage_hours_week": 40,
      "fuel_consumption": "N/A",
      "safety_requirements": ["Hard Hat", "Safety Vest", "Testing Equipment PPE"]
    }
  ];

  List<Map<String, dynamic>> get filteredResources {
    return resourcesData.where((resource) {
      bool matchesSearch = resource["resource_name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          resource["supplier"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          resource["location"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || resource["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || resource["status"] == selectedStatus;
      bool matchesProject = selectedProject == "All" || resource["project"] == selectedProject;
      
      return matchesSearch && matchesCategory && matchesStatus && matchesProject;
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Equipment":
        return primaryColor;
      case "Material":
        return warningColor;
      case "Labor":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "In Use":
        return warningColor;
      case "Assigned":
        return infoColor;
      case "Ordered":
        return primaryColor;
      case "Maintenance":
        return dangerColor;
      case "Partially Available":
        return warningColor;
      case "Active":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "Available":
        return successColor;
      case "Busy":
        return dangerColor;
      case "Partially Available":
        return warningColor;
      case "Incoming":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Equipment":
        return Icons.build;
      case "Material":
        return Icons.inventory;
      case "Labor":
        return Icons.people;
      default:
        return Icons.category;
    }
  }

  Color _getMaintenanceColor(String status) {
    switch (status) {
      case "Excellent":
        return successColor;
      case "Good":
        return warningColor;
      case "Fair":
        return infoColor;
      case "Poor":
        return dangerColor;
      case "Fresh":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalResources = resourcesData.length;
    int availableResources = resourcesData.where((res) => res["availability"] == "Available").length;
    int inUseResources = resourcesData.where((res) => res["availability"] == "Busy").length;
    double totalDailyRate = resourcesData.fold(0.0, (sum, res) => sum + (res["daily_rate"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Resource Planning"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Resources", totalResources.toString(), Icons.category, primaryColor),
                _buildStatCard("Available", availableResources.toString(), Icons.check_circle, successColor),
                _buildStatCard("In Use", inUseResources.toString(), Icons.build, warningColor),
                _buildStatCard("Daily Cost", "\$${totalDailyRate.toStringAsFixed(0)}", Icons.attach_money, dangerColor),
              ],
            ),

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
                    label: "Search Resources",
                    value: searchQuery,
                    hint: "Search by name, supplier, or location...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            {"label": "All Categories", "value": "All"},
                            {"label": "Equipment", "value": "Equipment"},
                            {"label": "Material", "value": "Material"},
                            {"label": "Labor", "value": "Labor"},
                          ],
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "All"},
                            {"label": "Available", "value": "Available"},
                            {"label": "In Use", "value": "In Use"},
                            {"label": "Assigned", "value": "Assigned"},
                            {"label": "Ordered", "value": "Ordered"},
                            {"label": "Maintenance", "value": "Maintenance"},
                            {"label": "Partially Available", "value": "Partially Available"},
                            {"label": "Active", "value": "Active"},
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: [
                            {"label": "All Projects", "value": "All"},
                            {"label": "Highway Bridge Construction", "value": "Highway Bridge Construction"},
                            {"label": "City Mall Development", "value": "City Mall Development"},
                            {"label": "Residential Complex Phase II", "value": "Residential Complex Phase II"},
                            {"label": "Office Tower Downtown", "value": "Office Tower Downtown"},
                            {"label": "Industrial Warehouse Complex", "value": "Industrial Warehouse Complex"},
                            {"label": "Healthcare Facility Expansion", "value": "Healthcare Facility Expansion"},
                          ],
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Resources List
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredResources.map((resource) {
                bool requiresOperator = resource["operator_required"] == true;
                bool hasSchedule = (resource["scheduled_dates"] as List).isNotEmpty;
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: resource["availability"] == "Available" 
                        ? Border.all(color: successColor.withAlpha(100), width: 2)
                        : resource["availability"] == "Busy"
                            ? Border.all(color: dangerColor.withAlpha(100), width: 2)
                            : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header with Category and Status
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(resource["category"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getCategoryIcon(resource["category"]),
                              size: 20,
                              color: _getCategoryColor(resource["category"]),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${resource["category"]} • ${resource["subcategory"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getCategoryColor(resource["category"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "ID: ${resource["id"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(resource["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${resource["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor(resource["status"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Resource Name
                      Text(
                        "${resource["resource_name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      // Availability and Location
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getAvailabilityColor(resource["availability"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${resource["availability"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getAvailabilityColor(resource["availability"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${resource["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Project Assignment
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.business, size: 16, color: infoColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${resource["project"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Quantity Information
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${resource["quantity_total"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Available",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${resource["quantity_available"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "In Use",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${resource["quantity_in_use"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Rate Information
                      if ((resource["daily_rate"] as double) > 0)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Daily: \$${resource["daily_rate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Weekly: \$${resource["weekly_rate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Monthly: \$${resource["monthly_rate"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Specifications
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Specifications:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(resource["specifications"] as Map<String, dynamic>).entries.take(2).map((spec) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Text(
                                      "${spec.key}:",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${spec.value}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                      // Maintenance Status (for Equipment)
                      if (resource["category"] == "Equipment" && resource["maintenance_status"] != "N/A")
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: _getMaintenanceColor(resource["maintenance_status"]).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.build,
                                    size: 16,
                                    color: _getMaintenanceColor(resource["maintenance_status"]),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Maintenance: ${resource["maintenance_status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getMaintenanceColor(resource["maintenance_status"]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Last: ${resource["last_maintenance"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Next: ${resource["next_maintenance"]}",
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

                      // Operator Requirements
                      if (requiresOperator)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.person, size: 16, color: Colors.orange.shade700),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Operator Required",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.orange.shade700,
                                      ),
                                    ),
                                    Text(
                                      "Cert: ${resource["operator_certification"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.orange.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Usage Information
                      if ((resource["usage_hours_week"] as int) > 0)
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade50,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Usage/Week",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${resource["usage_hours_week"]}h",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (resource["fuel_consumption"] != "N/A") ...[
                              SizedBox(width: spSm),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.shade50,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Fuel/Day",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${resource["fuel_consumption"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                      // Supplier Information
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.cyan.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.business, size: 16, color: Colors.cyan.shade700),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${resource["supplier"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.cyan.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 12, color: Colors.cyan.shade600),
                                SizedBox(width: spXs),
                                Text(
                                  "${resource["supplier_contact"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.cyan.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Schedule Dates
                      if (hasSchedule)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Scheduled Usage:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.indigo.shade700,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(resource["scheduled_dates"] as List).map((schedule) {
                                return Text(
                                  "${schedule["start"]} to ${schedule["end"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.indigo.shade600,
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),

                      // Safety Requirements
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.shield, size: 16, color: dangerColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Safety Requirements:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              children: (resource["safety_requirements"] as List).map((req) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$req",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: dangerColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      // Actions
                      Row(
                        spacing: spXs,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Schedule",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Contact",
                              size: bs.sm,
                              onPressed: () {},
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
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
