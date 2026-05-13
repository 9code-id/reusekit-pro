import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaCostTrackingView extends StatefulWidget {
  const ComaCostTrackingView({Key? key}) : super(key: key);

  @override
  State<ComaCostTrackingView> createState() => _ComaCostTrackingViewState();
}

class _ComaCostTrackingViewState extends State<ComaCostTrackingView> {
  String selectedPeriod = "current_month";
  String selectedCostType = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> periodFilters = [
    {"label": "Current Month", "value": "current_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Current Year", "value": "current_year"},
    {"label": "All Time", "value": "all_time"},
  ];

  List<Map<String, dynamic>> costTypeFilters = [
    {"label": "All Costs", "value": "all", "count": 156},
    {"label": "Labor", "value": "labor", "count": 58},
    {"label": "Materials", "value": "materials", "count": 42},
    {"label": "Equipment", "value": "equipment", "count": 28},
    {"label": "Overhead", "value": "overhead", "count": 28},
  ];

  List<Map<String, dynamic>> costEntries = [
    {
      "id": "CT-2024-001",
      "project_id": "PRJ-2024-001",
      "project_name": "Metro Downtown Complex",
      "cost_type": "labor",
      "cost_category": "Skilled Labor",
      "description": "Concrete pour crew - Foundation work",
      "amount": 12500.0,
      "quantity": 40,
      "unit": "hours",
      "unit_cost": 312.5,
      "date": "2024-06-17",
      "vendor_supplier": "Metro Construction Crew",
      "invoice_number": "INV-2024-1287",
      "approval_status": "approved",
      "approved_by": "Sarah Johnson",
      "approval_date": "2024-06-17",
      "phase": "Foundation & Structural",
      "cost_code": "LC-001",
      "billing_status": "invoiced",
      "payment_status": "paid",
      "payment_date": "2024-06-20",
      "tax_amount": 1062.5,
      "total_with_tax": 13562.5,
      "crew_lead": "Robert Martinez",
      "notes": "Overtime hours included for weekend pour",
    },
    {
      "id": "CT-2024-002",
      "project_id": "PRJ-2024-001",
      "project_name": "Metro Downtown Complex",
      "cost_type": "materials",
      "cost_category": "Concrete & Cement",
      "description": "Ready-mix concrete - Grade 40 for foundation",
      "amount": 18750.0,
      "quantity": 125,
      "unit": "cubic yards",
      "unit_cost": 150.0,
      "date": "2024-06-16",
      "vendor_supplier": "Metro Ready Mix Corp",
      "invoice_number": "RM-45681",
      "approval_status": "approved",
      "approved_by": "Michael Chen",
      "approval_date": "2024-06-16",
      "phase": "Foundation & Structural",
      "cost_code": "MT-002",
      "billing_status": "invoiced",
      "payment_status": "pending",
      "payment_date": null,
      "tax_amount": 1593.75,
      "total_with_tax": 20343.75,
      "delivery_date": "2024-06-16",
      "notes": "Premium grade concrete for critical foundation areas",
    },
    {
      "id": "CT-2024-003",
      "project_id": "PRJ-2024-002",
      "project_name": "Riverside Office Park",
      "cost_type": "equipment",
      "cost_category": "Heavy Machinery",
      "description": "Crane rental - 50-ton mobile crane",
      "amount": 8900.0,
      "quantity": 5,
      "unit": "days",
      "unit_cost": 1780.0,
      "date": "2024-06-15",
      "vendor_supplier": "Elite Equipment Rental",
      "invoice_number": "EER-9823",
      "approval_status": "approved",
      "approved_by": "Emily Rodriguez",
      "approval_date": "2024-06-15",
      "phase": "Structural Assembly",
      "cost_code": "EQ-015",
      "billing_status": "invoiced",
      "payment_status": "paid",
      "payment_date": "2024-06-18",
      "tax_amount": 756.5,
      "total_with_tax": 9656.5,
      "operator_included": true,
      "notes": "Includes certified operator and fuel costs",
    },
    {
      "id": "CT-2024-004",
      "project_id": "PRJ-2024-003",
      "project_name": "Healthcare Facility Expansion",
      "cost_type": "overhead",
      "cost_category": "Project Management",
      "description": "Site supervision and quality control",
      "amount": 6200.0,
      "quantity": 2,
      "unit": "weeks",
      "unit_cost": 3100.0,
      "date": "2024-06-14",
      "vendor_supplier": "Internal Staff",
      "invoice_number": "PM-2024-156",
      "approval_status": "pending",
      "approved_by": null,
      "approval_date": null,
      "phase": "MEP Installation",
      "cost_code": "OH-003",
      "billing_status": "draft",
      "payment_status": "not_applicable",
      "payment_date": null,
      "tax_amount": 0.0,
      "total_with_tax": 6200.0,
      "supervisor": "David Wilson",
      "notes": "Includes site safety inspection and progress reporting",
    },
    {
      "id": "CT-2024-005",
      "project_id": "PRJ-2024-001",
      "project_name": "Metro Downtown Complex",
      "cost_type": "materials",
      "cost_category": "Steel & Rebar",
      "description": "#4 Rebar for foundation reinforcement",
      "amount": 15200.0,
      "quantity": 38,
      "unit": "tons",
      "unit_cost": 400.0,
      "date": "2024-06-13",
      "vendor_supplier": "Steel Supply Solutions",
      "invoice_number": "SSS-7742",
      "approval_status": "approved",
      "approved_by": "Sarah Johnson",
      "approval_date": "2024-06-13",
      "phase": "Foundation & Structural",
      "cost_code": "MT-005",
      "billing_status": "invoiced",
      "payment_status": "paid",
      "payment_date": "2024-06-16",
      "tax_amount": 1292.0,
      "total_with_tax": 16492.0,
      "delivery_date": "2024-06-14",
      "notes": "Grade 60 steel, certified mill test reports included",
    },
    {
      "id": "CT-2024-006",
      "project_id": "PRJ-2024-004",
      "project_name": "Residential Tower A",
      "cost_type": "labor",
      "cost_category": "Specialized Labor",
      "description": "Electrical rough-in work - Floors 15-20",
      "amount": 22800.0,
      "quantity": 120,
      "unit": "hours",
      "unit_cost": 190.0,
      "date": "2024-06-12",
      "vendor_supplier": "Elite Electrical Contractors",
      "invoice_number": "EEC-4421",
      "approval_status": "approved",
      "approved_by": "David Wilson",
      "approval_date": "2024-06-12",
      "phase": "MEP Installation",
      "cost_code": "LC-008",
      "billing_status": "invoiced",
      "payment_status": "paid",
      "payment_date": "2024-06-15",
      "tax_amount": 1938.0,
      "total_with_tax": 24738.0,
      "crew_lead": "Carlos Rivera",
      "notes": "High-voltage work requiring specialized certifications",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Tracking"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addCostEntry(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showCostAnalytics(),
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
                  _buildCostOverview(),
                  _buildSearchAndPeriod(),
                  _buildCostTypeFilters(),
                  _buildCostBreakdown(),
                  _buildCostEntriesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildCostOverview() {
    double totalCosts = costEntries.fold(0.0, (sum, c) => sum + (c["amount"] as double));
    double laborCosts = costEntries.where((c) => c["cost_type"] == "labor").fold(0.0, (sum, c) => sum + (c["amount"] as double));
    double materialCosts = costEntries.where((c) => c["cost_type"] == "materials").fold(0.0, (sum, c) => sum + (c["amount"] as double));
    double equipmentCosts = costEntries.where((c) => c["cost_type"] == "equipment").fold(0.0, (sum, c) => sum + (c["amount"] as double));

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
                child: Icon(Icons.track_changes, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Cost Tracking Overview",
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
              _buildOverviewCard("Total Costs", "\$${(totalCosts).currency}", Icons.monetization_on, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Labor", "\$${(laborCosts).currency}", Icons.person, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Materials", "\$${(materialCosts).currency}", Icons.inventory, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Equipment", "\$${(equipmentCosts).currency}", Icons.construction, infoColor),
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

  Widget _buildSearchAndPeriod() {
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
                  label: "Search cost entries...",
                  value: searchQuery,
                  hint: "Search by description, vendor, or invoice",
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
                "Period:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QHorizontalScroll(
                  children: periodFilters.map((period) {
                    bool isSelected = selectedPeriod == period["value"];
                    return Container(
                      margin: EdgeInsets.only(right: spSm),
                      child: GestureDetector(
                        onTap: () {
                          selectedPeriod = period["value"];
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
                            "${period["label"]}",
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

  Widget _buildCostTypeFilters() {
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
            "Filter by Cost Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: costTypeFilters.map((filter) {
              bool isSelected = selectedCostType == filter["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedCostType = filter["value"];
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

  Widget _buildCostBreakdown() {
    int approvedCount = costEntries.where((c) => c["approval_status"] == "approved").length;
    int pendingCount = costEntries.where((c) => c["approval_status"] == "pending").length;
    double avgCost = costEntries.fold(0.0, (sum, c) => sum + (c["amount"] as double)) / costEntries.length;

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
            "Cost Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildBreakdownCard("Approved", "$approvedCount", Icons.check_circle),
              SizedBox(width: spSm),
              _buildBreakdownCard("Pending", "$pendingCount", Icons.hourglass_empty),
              SizedBox(width: spSm),
              _buildBreakdownCard("Avg. Cost", "\$${(avgCost).currency}", Icons.calculate),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownCard(String title, String value, IconData icon) {
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

  Widget _buildCostEntriesList() {
    List<Map<String, dynamic>> filteredEntries = _getFilteredEntries();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Cost Entries (${filteredEntries.length})",
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
        ...filteredEntries.map((entry) => _buildCostEntryCard(entry)),
      ],
    );
  }

  Widget _buildCostEntryCard(Map<String, dynamic> entry) {
    Color statusColor = _getApprovalStatusColor(entry["approval_status"]);
    Color typeColor = _getCostTypeColor(entry["cost_type"]);

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
                      "${entry["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${entry["description"]}",
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
                  "${entry["approval_status"]}".toUpperCase(),
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
                  "${entry["cost_type"]}".toUpperCase(),
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
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${entry["cost_category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Project: ${entry["project_name"]}",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Amount: \$${((entry["amount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Unit: \$${((entry["unit_cost"] as double)).currency}/${entry["unit"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Quantity: ${entry["quantity"]} ${entry["unit"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.business, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Vendor: ${entry["vendor_supplier"]}",
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
              Icon(Icons.receipt, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Invoice: ${entry["invoice_number"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (entry["tax_amount"] != null && (entry["tax_amount"] as double) > 0)
                Text(
                  "Tax: \$${((entry["tax_amount"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          if (entry["approved_by"] != null)
            Row(
              children: [
                Icon(Icons.person_add, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Approved by: ${entry["approved_by"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                if (entry["approval_date"] != null)
                  Text(
                    "on ${entry["approval_date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
              ],
            ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPaymentStatusColor(entry["payment_status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${entry["payment_status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPaymentStatusColor(entry["payment_status"]),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Date: ${entry["date"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (entry["notes"] != null && (entry["notes"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${entry["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Phase: ${entry["phase"]} • Code: ${entry["cost_code"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewCostDetails(entry["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editCostEntry(entry["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showCostOptions(entry),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredEntries() {
    List<Map<String, dynamic>> filtered = costEntries;

    if (selectedCostType != "all") {
      filtered = filtered.where((e) => e["cost_type"] == selectedCostType).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((e) =>
          e["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          e["vendor_supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          e["invoice_number"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getApprovalStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return successColor;
      case 'pending':
        return warningColor;
      case 'rejected':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCostTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'labor':
        return successColor;
      case 'materials':
        return warningColor;
      case 'equipment':
        return infoColor;
      case 'overhead':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPaymentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return successColor;
      case 'pending':
        return warningColor;
      case 'overdue':
        return dangerColor;
      case 'not_applicable':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  void _addCostEntry() {
    ss("Add cost entry");
  }

  void _showCostAnalytics() {
    ss("Cost analytics dashboard");
  }

  void _showAdvancedFilters() {
    ss("Advanced cost filters");
  }

  void _showSortOptions() {
    ss("Cost sort options");
  }

  void _viewCostDetails(String costId) {
    ss("Viewing cost details $costId");
  }

  void _editCostEntry(String costId) {
    ss("Editing cost entry $costId");
  }

  void _showCostOptions(Map<String, dynamic> entry) {
    ss("Cost options for ${entry["id"]}");
  }
}
