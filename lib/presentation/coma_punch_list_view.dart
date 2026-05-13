import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaPunchListView extends StatefulWidget {
  const ComaPunchListView({Key? key}) : super(key: key);

  @override
  State<ComaPunchListView> createState() => _ComaPunchListViewState();
}

class _ComaPunchListViewState extends State<ComaPunchListView> {
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedTrade = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all", "count": 47},
    {"label": "Open", "value": "open", "count": 23},
    {"label": "In Progress", "value": "in_progress", "count": 15},
    {"label": "Completed", "value": "completed", "count": 7},
    {"label": "Verified", "value": "verified", "count": 2},
  ];

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All Priority", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> tradeFilters = [
    {"label": "All Trades", "value": "all"},
    {"label": "General Contractor", "value": "general"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Plumbing", "value": "plumbing"},
    {"label": "HVAC", "value": "hvac"},
    {"label": "Flooring", "value": "flooring"},
    {"label": "Painting", "value": "painting"},
    {"label": "Carpentry", "value": "carpentry"},
  ];

  List<Map<String, dynamic>> punchListItems = [
    {
      "id": "PL-2024-001",
      "item_number": "001",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "location": "Unit 204 - Master Bathroom",
      "trade": "plumbing",
      "trade_contractor": "Elite Plumbing Solutions",
      "description": "Faucet in master bathroom has loose handle and minor leak",
      "priority": "medium",
      "status": "open",
      "identified_by": "Sarah Johnson",
      "identification_date": "2024-06-15",
      "assigned_to": "Mike Rodriguez",
      "due_date": "2024-06-20",
      "completed_date": null,
      "verified_date": null,
      "estimated_cost": 125.0,
      "actual_cost": null,
      "estimated_hours": 2.0,
      "actual_hours": null,
      "defect_type": "installation",
      "quality_impact": "medium",
      "safety_impact": "low",
      "schedule_impact": "none",
      "images": ["https://picsum.photos/300/200?random=1&keyword=plumbing"],
      "notes": "Customer reported loose handle during final walkthrough",
      "resolution_notes": null,
      "rework_required": false,
      "warranty_impact": true,
      "client_visible": true,
      "code_compliance": true,
    },
    {
      "id": "PL-2024-002",
      "item_number": "002",
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "location": "Conference Room B - Ceiling",
      "trade": "electrical",
      "trade_contractor": "Power Systems Inc",
      "description": "Light fixture not properly secured, hanging loose from ceiling",
      "priority": "high",
      "status": "in_progress",
      "identified_by": "Michael Chen",
      "identification_date": "2024-06-14",
      "assigned_to": "David Wilson",
      "due_date": "2024-06-18",
      "completed_date": null,
      "verified_date": null,
      "estimated_cost": 85.0,
      "actual_cost": null,
      "estimated_hours": 1.5,
      "actual_hours": 0.5,
      "defect_type": "installation",
      "quality_impact": "high",
      "safety_impact": "high",
      "schedule_impact": "none",
      "images": ["https://picsum.photos/300/200?random=2&keyword=electrical"],
      "notes": "Safety hazard - fixture could fall and cause injury",
      "resolution_notes": "Ordered new mounting hardware, installation in progress",
      "rework_required": true,
      "warranty_impact": false,
      "client_visible": true,
      "code_compliance": false,
    },
    {
      "id": "PL-2024-003",
      "item_number": "003",
      "project_id": "PRJ-003",
      "project_name": "Healthcare Facility Expansion",
      "location": "Patient Room 315 - Wall",
      "trade": "painting",
      "trade_contractor": "Premier Paint Works",
      "description": "Paint finish uneven with visible brush marks on wall surface",
      "priority": "low",
      "status": "completed",
      "identified_by": "Jennifer Park",
      "identification_date": "2024-06-12",
      "assigned_to": "Carlos Rivera",
      "due_date": "2024-06-17",
      "completed_date": "2024-06-16",
      "verified_date": null,
      "estimated_cost": 150.0,
      "actual_cost": 145.0,
      "estimated_hours": 3.0,
      "actual_hours": 2.5,
      "defect_type": "workmanship",
      "quality_impact": "medium",
      "safety_impact": "none",
      "schedule_impact": "none",
      "images": ["https://picsum.photos/300/200?random=3&keyword=painting"],
      "notes": "Wall surface preparation was inadequate",
      "resolution_notes": "Wall properly sanded and repainted with smooth finish",
      "rework_required": true,
      "warranty_impact": false,
      "client_visible": true,
      "code_compliance": true,
    },
    {
      "id": "PL-2024-004",
      "item_number": "004",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "location": "Lobby - Main Entrance",
      "trade": "flooring",
      "trade_contractor": "Precision Flooring Co",
      "description": "Marble tile has visible crack and uneven joint spacing",
      "priority": "critical",
      "status": "open",
      "identified_by": "Emily Rodriguez",
      "identification_date": "2024-06-16",
      "assigned_to": "Antonio Martinez",
      "due_date": "2024-06-19",
      "completed_date": null,
      "verified_date": null,
      "estimated_cost": 450.0,
      "actual_cost": null,
      "estimated_hours": 6.0,
      "actual_hours": null,
      "defect_type": "material",
      "quality_impact": "critical",
      "safety_impact": "medium",
      "schedule_impact": "minor",
      "images": ["https://picsum.photos/300/200?random=4&keyword=flooring"],
      "notes": "High-visibility area, client has expressed concern",
      "resolution_notes": null,
      "rework_required": true,
      "warranty_impact": true,
      "client_visible": true,
      "code_compliance": true,
    },
    {
      "id": "PL-2024-005",
      "item_number": "005",
      "project_id": "PRJ-004",
      "project_name": "Residential Tower A",
      "location": "Unit 1205 - Kitchen",
      "trade": "carpentry",
      "trade_contractor": "Master Woodworks",
      "description": "Cabinet door alignment off, gaps uneven between doors",
      "priority": "medium",
      "status": "verified",
      "identified_by": "Thomas Anderson",
      "identification_date": "2024-06-10",
      "assigned_to": "Robert Garcia",
      "due_date": "2024-06-15",
      "completed_date": "2024-06-14",
      "verified_date": "2024-06-15",
      "estimated_cost": 95.0,
      "actual_cost": 85.0,
      "estimated_hours": 2.0,
      "actual_hours": 1.5,
      "defect_type": "installation",
      "quality_impact": "medium",
      "safety_impact": "none",
      "schedule_impact": "none",
      "images": ["https://picsum.photos/300/200?random=5&keyword=cabinet"],
      "notes": "Hinges needed adjustment for proper alignment",
      "resolution_notes": "All cabinet doors adjusted and aligned perfectly",
      "rework_required": false,
      "warranty_impact": false,
      "client_visible": true,
      "code_compliance": true,
    },
    {
      "id": "PL-2024-006",
      "item_number": "006",
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "location": "HVAC Room - Mechanical Floor",
      "trade": "hvac",
      "trade_contractor": "Climate Control Experts",
      "description": "Ductwork connection loose, air leakage detected during testing",
      "priority": "high",
      "status": "in_progress",
      "identified_by": "Maria Gonzalez",
      "identification_date": "2024-06-13",
      "assigned_to": "James Wilson",
      "due_date": "2024-06-17",
      "completed_date": null,
      "verified_date": null,
      "estimated_cost": 275.0,
      "actual_cost": null,
      "estimated_hours": 4.0,
      "actual_hours": 2.0,
      "defect_type": "installation",
      "quality_impact": "high",
      "safety_impact": "low",
      "schedule_impact": "minor",
      "images": ["https://picsum.photos/300/200?random=6&keyword=hvac"],
      "notes": "Impacts system efficiency, needs immediate attention",
      "resolution_notes": "Replacing connection seals and retesting system",
      "rework_required": true,
      "warranty_impact": true,
      "client_visible": false,
      "code_compliance": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Punch List"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addPunchListItem(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showPunchListAnalytics(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildPunchListOverview(),
                  _buildFilters(),
                  _buildPriorityDistribution(),
                  _buildPunchListItems(),
                ],
              ),
            ),
    );
  }

  Widget _buildPunchListOverview() {
    int totalItems = punchListItems.length;
    int openItems = punchListItems.where((item) => item["status"] == "open").length;
    int inProgressItems = punchListItems.where((item) => item["status"] == "in_progress").length;
    int completedItems = punchListItems.where((item) => item["status"] == "completed").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.checklist, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Punch List Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildOverviewCard("Total Items", "$totalItems", Icons.list, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Open", "$openItems", Icons.error, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("In Progress", "$inProgressItems", Icons.construction, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Completed", "$completedItems", Icons.check_circle, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search punch list items...",
                  value: searchQuery,
                  hint: "Search by description, location, or trade",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () => _showAdvancedFilters(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusFilters,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityFilters,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Trade",
                  items: tradeFilters,
                  value: selectedTrade,
                  onChanged: (value, label) {
                    selectedTrade = value;
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

  Widget _buildPriorityDistribution() {
    int criticalItems = punchListItems.where((item) => item["priority"] == "critical").length;
    int highItems = punchListItems.where((item) => item["priority"] == "high").length;
    int mediumItems = punchListItems.where((item) => item["priority"] == "medium").length;
    int lowItems = punchListItems.where((item) => item["priority"] == "low").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: warningColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Priority Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: warningColor,
            ),
          ),
          Row(
            children: [
              _buildPriorityCard("Critical", "$criticalItems", dangerColor),
              SizedBox(width: spSm),
              _buildPriorityCard("High", "$highItems", warningColor),
              SizedBox(width: spSm),
              _buildPriorityCard("Medium", "$mediumItems", primaryColor),
              SizedBox(width: spSm),
              _buildPriorityCard("Low", "$lowItems", successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPunchListItems() {
    List<Map<String, dynamic>> filteredItems = _getFilteredItems();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Punch List Items (${filteredItems.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredItems.map((item) => _buildPunchListCard(item)),
      ],
    );
  }

  Widget _buildPunchListCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item["status"]);
    Color priorityColor = _getPriorityColor(item["priority"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: priorityColor,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["id"]} - Item #${item["item_number"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${item["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${item["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["trade"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Project: ${item["project_name"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${item["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          ),
          if ((item["images"] as List).isNotEmpty)
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: (item["images"] as List).map((imageUrl) => Container(
                  width: 160,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("$imageUrl"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )).toList(),
              ),
            ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Identified by: ${item["identified_by"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Date: ${item["identification_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.assignment_ind, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Assigned to: ${item["assigned_to"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Due: ${item["due_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            "Contractor: ${item["trade_contractor"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Cost: \$${((item["estimated_cost"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (item["actual_cost"] != null) ...[
                      Text(
                        " → \$${((item["actual_cost"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    Spacer(),
                    Text(
                      "Est. Hours: ${item["estimated_hours"]}h",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    if (item["actual_hours"] != null) ...[
                      Text(
                        " (${item["actual_hours"]}h)",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Type: ${item["defect_type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Quality Impact: ${item["quality_impact"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: _getImpactColor(item["quality_impact"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (item["notes"] != null && item["notes"].toString().isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${item["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (item["resolution_notes"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Resolution: ${item["resolution_notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              if (item["rework_required"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "REWORK REQUIRED",
                    style: TextStyle(
                      fontSize: 10,
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (item["client_visible"] == true) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "CLIENT VISIBLE",
                    style: TextStyle(
                      fontSize: 10,
                      color: dangerColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              if (item["warranty_impact"] == true) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "WARRANTY IMPACT",
                    style: TextStyle(
                      fontSize: 10,
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              Spacer(),
              if (item["completed_date"] != null)
                Text(
                  "Completed: ${item["completed_date"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Safety Impact: ${item["safety_impact"]} | Schedule Impact: ${item["schedule_impact"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewItemDetails(item["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editItem(item["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showItemOptions(item),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    List<Map<String, dynamic>> filtered = punchListItems;

    if (selectedStatus != "all") {
      filtered = filtered.where((item) => item["status"] == selectedStatus).toList();
    }

    if (selectedPriority != "all") {
      filtered = filtered.where((item) => item["priority"] == selectedPriority).toList();
    }

    if (selectedTrade != "all") {
      filtered = filtered.where((item) => item["trade"] == selectedTrade).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) =>
          item["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["location"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["trade"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'verified':
        return infoColor;
      case 'in_progress':
        return warningColor;
      case 'open':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return primaryColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return primaryColor;
      case 'low':
        return successColor;
      case 'none':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addPunchListItem() {
    ss("Add new punch list item");
  }

  void _showPunchListAnalytics() {
    ss("Punch list analytics");
  }

  void _showAdvancedFilters() {
    ss("Advanced punch list filters");
  }

  void _showSortOptions() {
    ss("Punch list sort options");
  }

  void _viewItemDetails(String itemId) {
    ss("Viewing punch list item $itemId");
  }

  void _editItem(String itemId) {
    ss("Editing punch list item $itemId");
  }

  void _showItemOptions(Map<String, dynamic> item) {
    ss("Punch list options for ${item["id"]}");
  }
}
