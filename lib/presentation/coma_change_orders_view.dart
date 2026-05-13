import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaChangeOrdersView extends StatefulWidget {
  const ComaChangeOrdersView({Key? key}) : super(key: key);

  @override
  State<ComaChangeOrdersView> createState() => _ComaChangeOrdersViewState();
}

class _ComaChangeOrdersViewState extends State<ComaChangeOrdersView> {
  String selectedStatus = "all";
  String selectedType = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all", "count": 24},
    {"label": "Pending", "value": "pending", "count": 8},
    {"label": "Approved", "value": "approved", "count": 12},
    {"label": "Rejected", "value": "rejected", "count": 2},
    {"label": "Implemented", "value": "implemented", "count": 2},
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All Types", "value": "all", "count": 24},
    {"label": "Scope Change", "value": "scope", "count": 9},
    {"label": "Design Change", "value": "design", "count": 6},
    {"label": "Material Change", "value": "material", "count": 5},
    {"label": "Schedule Change", "value": "schedule", "count": 4},
  ];

  List<Map<String, dynamic>> changeOrders = [
    {
      "id": "CO-2024-001",
      "project_id": "PRJ-2024-001",
      "project_name": "Metro Downtown Complex",
      "change_order_number": "001",
      "title": "Foundation Depth Increase",
      "description": "Increase foundation depth from 8ft to 12ft due to soil conditions",
      "change_type": "scope",
      "priority": "high",
      "status": "approved",
      "requested_by": "Sarah Johnson",
      "request_date": "2024-06-15",
      "reviewed_by": "Michael Chen",
      "review_date": "2024-06-16",
      "approved_by": "Emily Rodriguez",
      "approval_date": "2024-06-17",
      "implementation_date": null,
      "original_cost": 450000.0,
      "additional_cost": 75000.0,
      "total_cost": 525000.0,
      "cost_impact": 75000.0,
      "schedule_impact_days": 5,
      "original_schedule": "2024-07-15",
      "new_schedule": "2024-07-20",
      "reason": "Soil test revealed unstable conditions requiring deeper foundation",
      "justification": "Critical for structural integrity and building safety",
      "impact_assessment": "Minimal schedule delay, essential for project success",
      "client_approval_required": true,
      "client_approved": true,
      "client_approval_date": "2024-06-17",
      "contractor": "Metro Foundation Specialists",
      "architect_approval": true,
      "engineer_approval": true,
      "permit_impact": true,
      "revised_drawings": true,
      "documentation_complete": true,
    },
    {
      "id": "CO-2024-002",
      "project_id": "PRJ-2024-002",
      "project_name": "Riverside Office Park",
      "change_order_number": "002",
      "title": "HVAC System Upgrade",
      "description": "Upgrade from standard HVAC to high-efficiency energy system",
      "change_type": "design",
      "priority": "medium",
      "status": "pending",
      "requested_by": "David Wilson",
      "request_date": "2024-06-16",
      "reviewed_by": null,
      "review_date": null,
      "approved_by": null,
      "approval_date": null,
      "implementation_date": null,
      "original_cost": 285000.0,
      "additional_cost": 45000.0,
      "total_cost": 330000.0,
      "cost_impact": 45000.0,
      "schedule_impact_days": 3,
      "original_schedule": "2024-08-30",
      "new_schedule": "2024-09-02",
      "reason": "Client request for improved energy efficiency and sustainability",
      "justification": "Long-term cost savings and environmental benefits",
      "impact_assessment": "Minor schedule impact, significant long-term value",
      "client_approval_required": true,
      "client_approved": false,
      "client_approval_date": null,
      "contractor": "Elite HVAC Solutions",
      "architect_approval": false,
      "engineer_approval": false,
      "permit_impact": false,
      "revised_drawings": false,
      "documentation_complete": false,
    },
    {
      "id": "CO-2024-003",
      "project_id": "PRJ-2024-003",
      "project_name": "Healthcare Facility Expansion",
      "change_order_number": "003",
      "title": "Medical Gas System Addition",
      "description": "Add medical gas lines to additional patient rooms",
      "change_type": "scope",
      "priority": "critical",
      "status": "approved",
      "requested_by": "Jennifer Park",
      "request_date": "2024-06-14",
      "reviewed_by": "Thomas Anderson",
      "review_date": "2024-06-15",
      "approved_by": "Emily Rodriguez",
      "approval_date": "2024-06-15",
      "implementation_date": "2024-06-18",
      "original_cost": 180000.0,
      "additional_cost": 65000.0,
      "total_cost": 245000.0,
      "cost_impact": 65000.0,
      "schedule_impact_days": 7,
      "original_schedule": "2024-09-15",
      "new_schedule": "2024-09-22",
      "reason": "Regulatory requirement for additional patient care capabilities",
      "justification": "Compliance with updated healthcare facility standards",
      "impact_assessment": "Schedule delay justified by regulatory compliance",
      "client_approval_required": true,
      "client_approved": true,
      "client_approval_date": "2024-06-15",
      "contractor": "Medical Systems Inc",
      "architect_approval": true,
      "engineer_approval": true,
      "permit_impact": true,
      "revised_drawings": true,
      "documentation_complete": true,
    },
    {
      "id": "CO-2024-004",
      "project_id": "PRJ-2024-001",
      "project_name": "Metro Downtown Complex",
      "change_order_number": "004",
      "title": "Premium Marble Flooring",
      "description": "Change from standard tile to premium marble in lobby areas",
      "change_type": "material",
      "priority": "low",
      "status": "rejected",
      "requested_by": "Carlos Rivera",
      "request_date": "2024-06-13",
      "reviewed_by": "Sarah Johnson",
      "review_date": "2024-06-14",
      "approved_by": null,
      "approval_date": null,
      "implementation_date": null,
      "original_cost": 45000.0,
      "additional_cost": 85000.0,
      "total_cost": 130000.0,
      "cost_impact": 85000.0,
      "schedule_impact_days": 0,
      "original_schedule": "2024-10-30",
      "new_schedule": "2024-10-30",
      "reason": "Client request for upgraded aesthetic appearance",
      "justification": "Enhanced building prestige and market value",
      "impact_assessment": "Significant cost increase without functional benefit",
      "rejection_reason": "Budget constraints and limited functional value",
      "client_approval_required": true,
      "client_approved": false,
      "client_approval_date": null,
      "contractor": "Premium Stone Works",
      "architect_approval": false,
      "engineer_approval": true,
      "permit_impact": false,
      "revised_drawings": false,
      "documentation_complete": false,
    },
    {
      "id": "CO-2024-005",
      "project_id": "PRJ-2024-004",
      "project_name": "Residential Tower A",
      "change_order_number": "005",
      "title": "Balcony Railing Design Change",
      "description": "Change from standard rails to custom glass balcony railings",
      "change_type": "design",
      "priority": "medium",
      "status": "implemented",
      "requested_by": "Maria Gonzalez",
      "request_date": "2024-06-10",
      "reviewed_by": "David Wilson",
      "review_date": "2024-06-11",
      "approved_by": "Thomas Anderson",
      "approval_date": "2024-06-12",
      "implementation_date": "2024-06-15",
      "original_cost": 125000.0,
      "additional_cost": 35000.0,
      "total_cost": 160000.0,
      "cost_impact": 35000.0,
      "schedule_impact_days": 2,
      "original_schedule": "2024-08-15",
      "new_schedule": "2024-08-17",
      "reason": "Improved aesthetics and market appeal for residential units",
      "justification": "Enhanced property value and competitive advantage",
      "impact_assessment": "Minimal schedule impact with significant value addition",
      "client_approval_required": true,
      "client_approved": true,
      "client_approval_date": "2024-06-11",
      "contractor": "Glass & Steel Specialists",
      "architect_approval": true,
      "engineer_approval": true,
      "permit_impact": false,
      "revised_drawings": true,
      "documentation_complete": true,
    },
    {
      "id": "CO-2024-006",
      "project_id": "PRJ-2024-002",
      "project_name": "Riverside Office Park",
      "change_order_number": "006",
      "title": "Parking Lot Expansion",
      "description": "Add 50 additional parking spaces to meet city requirements",
      "change_type": "scope",
      "priority": "high",
      "status": "pending",
      "requested_by": "Robert Martinez",
      "request_date": "2024-06-17",
      "reviewed_by": null,
      "review_date": null,
      "approved_by": null,
      "approval_date": null,
      "implementation_date": null,
      "original_cost": 85000.0,
      "additional_cost": 125000.0,
      "total_cost": 210000.0,
      "cost_impact": 125000.0,
      "schedule_impact_days": 10,
      "original_schedule": "2024-09-30",
      "new_schedule": "2024-10-10",
      "reason": "City planning department requirement for occupancy permit",
      "justification": "Mandatory compliance for project completion and occupancy",
      "impact_assessment": "Significant cost and schedule impact but required for permit",
      "client_approval_required": true,
      "client_approved": false,
      "client_approval_date": null,
      "contractor": "Metro Paving Solutions",
      "architect_approval": false,
      "engineer_approval": false,
      "permit_impact": true,
      "revised_drawings": false,
      "documentation_complete": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Orders"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addChangeOrder(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showChangeOrderAnalytics(),
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
                  _buildChangeOrderOverview(),
                  _buildSearchAndFilter(),
                  _buildStatusFilters(),
                  _buildImpactSummary(),
                  _buildChangeOrdersList(),
                ],
              ),
            ),
    );
  }

  Widget _buildChangeOrderOverview() {
    double totalCostImpact = changeOrders.fold(0.0, (sum, co) => sum + (co["cost_impact"] as double));
    int totalScheduleImpact = changeOrders.fold(0, (sum, co) => sum + (co["schedule_impact_days"] as int));
    int pendingCount = changeOrders.where((co) => co["status"] == "pending").length;
    int approvedCount = changeOrders.where((co) => co["status"] == "approved").length;

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
                child: Icon(Icons.change_circle, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Change Orders Overview",
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
              _buildOverviewCard("Total Cost Impact", "\$${(totalCostImpact).currency}", Icons.monetization_on, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Schedule Impact", "${totalScheduleImpact} days", Icons.schedule, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Pending", "$pendingCount", Icons.hourglass_empty, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Approved", "$approvedCount", Icons.check_circle, successColor),
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
                fontSize: 12,
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

  Widget _buildSearchAndFilter() {
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
                  label: "Search change orders...",
                  value: searchQuery,
                  hint: "Search by title, description, or project",
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
              Text(
                "Type:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QHorizontalScroll(
                  children: typeFilters.map((type) {
                    bool isSelected = selectedType == type["value"];
                    return Container(
                      margin: EdgeInsets.only(right: spSm),
                      child: GestureDetector(
                        onTap: () {
                          selectedType = type["value"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? primaryColor.withAlpha(30)
                                : Colors.grey.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Text(
                            "${type["label"]} (${type["count"]})",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilters() {
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
          Text(
            "Filter by Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: statusFilters.map((filter) {
              bool isSelected = selectedStatus == filter["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedStatus = filter["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? primaryColor.withAlpha(30)
                          : Colors.grey.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      "${filter["label"]} (${filter["count"]})",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactSummary() {
    double avgCostImpact = changeOrders.fold(0.0, (sum, co) => sum + (co["cost_impact"] as double)) / changeOrders.length;
    double avgScheduleImpact = changeOrders.fold(0.0, (sum, co) => sum + (co["schedule_impact_days"] as int)) / changeOrders.length;
    int clientApprovalRequired = changeOrders.where((co) => co["client_approval_required"] == true && co["client_approved"] == false).length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Impact Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildImpactCard("Avg. Cost Impact", "\$${(avgCostImpact).currency}", Icons.attach_money),
              SizedBox(width: spSm),
              _buildImpactCard("Avg. Schedule Impact", "${avgScheduleImpact.toInt()} days", Icons.schedule),
              SizedBox(width: spSm),
              _buildImpactCard("Pending Approval", "$clientApprovalRequired", Icons.pending_actions),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactCard(String title, String value, IconData icon) {
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
            Icon(icon, color: successColor, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: successColor,
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

  Widget _buildChangeOrdersList() {
    List<Map<String, dynamic>> filteredChangeOrders = _getFilteredChangeOrders();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Change Orders (${filteredChangeOrders.length})",
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
        ...filteredChangeOrders.map((changeOrder) => _buildChangeOrderCard(changeOrder)),
      ],
    );
  }

  Widget _buildChangeOrderCard(Map<String, dynamic> changeOrder) {
    Color statusColor = _getStatusColor(changeOrder["status"]);
    Color typeColor = _getTypeColor(changeOrder["change_type"]);
    Color priorityColor = _getPriorityColor(changeOrder["priority"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: statusColor,
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
                      "${changeOrder["id"]} - #${changeOrder["change_order_number"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${changeOrder["title"]}",
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
                  "${changeOrder["status"]}".toUpperCase(),
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
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${changeOrder["change_type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${changeOrder["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Project: ${changeOrder["project_name"]}",
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
              "${changeOrder["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.monetization_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Cost Impact: \$${((changeOrder["cost_impact"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: (changeOrder["cost_impact"] as double) > 0 ? dangerColor : successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Schedule: ${changeOrder["schedule_impact_days"]} days",
                style: TextStyle(
                  fontSize: 12,
                  color: (changeOrder["schedule_impact_days"] as int) > 0 ? dangerColor : successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Original: \$${((changeOrder["original_cost"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "New Total: \$${((changeOrder["total_cost"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Requested by: ${changeOrder["requested_by"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Date: ${changeOrder["request_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (changeOrder["approved_by"] != null)
            Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Approved by: ${changeOrder["approved_by"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                if (changeOrder["approval_date"] != null)
                  Text(
                    "on ${changeOrder["approval_date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
              ],
            ),
          if (changeOrder["rejection_reason"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.cancel, color: dangerColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Rejected: ${changeOrder["rejection_reason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              if (changeOrder["client_approval_required"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: (changeOrder["client_approved"] == true ? successColor : warningColor).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    changeOrder["client_approved"] == true ? "CLIENT APPROVED" : "CLIENT APPROVAL PENDING",
                    style: TextStyle(
                      fontSize: 10,
                      color: changeOrder["client_approved"] == true ? successColor : warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (changeOrder["permit_impact"] == true) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "PERMIT IMPACT",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              Spacer(),
              if (changeOrder["implementation_date"] != null)
                Text(
                  "Implemented: ${changeOrder["implementation_date"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          Container(
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
                  "Reason: ${changeOrder["reason"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Justification: ${changeOrder["justification"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Contractor: ${changeOrder["contractor"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewChangeOrderDetails(changeOrder["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editChangeOrder(changeOrder["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showChangeOrderOptions(changeOrder),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredChangeOrders() {
    List<Map<String, dynamic>> filtered = changeOrders;

    if (selectedStatus != "all") {
      filtered = filtered.where((co) => co["status"] == selectedStatus).toList();
    }

    if (selectedType != "all") {
      filtered = filtered.where((co) => co["change_type"] == selectedType).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((co) =>
          co["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          co["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          co["project_name"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return successColor;
      case 'pending':
        return warningColor;
      case 'rejected':
        return dangerColor;
      case 'implemented':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'scope':
        return primaryColor;
      case 'design':
        return infoColor;
      case 'material':
        return warningColor;
      case 'schedule':
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

  void _addChangeOrder() {
    ss("Add new change order");
  }

  void _showChangeOrderAnalytics() {
    ss("Change order analytics");
  }

  void _showAdvancedFilters() {
    ss("Advanced change order filters");
  }

  void _showSortOptions() {
    ss("Change order sort options");
  }

  void _viewChangeOrderDetails(String changeOrderId) {
    ss("Viewing change order details $changeOrderId");
  }

  void _editChangeOrder(String changeOrderId) {
    ss("Editing change order $changeOrderId");
  }

  void _showChangeOrderOptions(Map<String, dynamic> changeOrder) {
    ss("Change order options for ${changeOrder["id"]}");
  }
}
