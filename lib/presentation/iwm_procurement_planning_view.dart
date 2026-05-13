import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmProcurementPlanningView extends StatefulWidget {
  const IwmProcurementPlanningView({super.key});

  @override
  State<IwmProcurementPlanningView> createState() => _IwmProcurementPlanningViewState();
}

class _IwmProcurementPlanningViewState extends State<IwmProcurementPlanningView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "";
  String selectedStatus = "";
  String selectedPriority = "";
  String selectedQuarter = "";
  
  // Form fields for new procurement plan
  String itemName = "";
  String category = "";
  String description = "";
  String vendor = "";
  String estimatedCost = "";
  String quantity = "";
  String targetQuarter = "";
  String requestedBy = "";
  String justification = "";
  String priority = "";
  
  final List<Map<String, dynamic>> procurementPlans = [
    {
      "id": "PP-2024-001",
      "item_name": "Industrial Welding Equipment",
      "category": "equipment",
      "description": "High-precision MIG welding machines for production line",
      "vendor": "WeldTech Solutions",
      "estimated_cost": 125000,
      "quantity": 5,
      "unit": "units",
      "target_quarter": "Q2 2024",
      "requested_by": "John Smith",
      "department": "Manufacturing",
      "status": "approved",
      "priority": "high",
      "budget_allocated": 130000,
      "justification": "Current equipment reaching end of life, increased demand requires additional capacity",
      "approval_date": "2024-03-15",
      "expected_delivery": "2024-06-30",
      "supplier_quotes": 3,
      "approved_by": "Sarah Johnson",
    },
    {
      "id": "PP-2024-002",
      "item_name": "Safety Helmets & Protective Gear",
      "category": "safety",
      "description": "OSHA-compliant safety equipment for all workers",
      "vendor": "SafeGuard Industries",
      "estimated_cost": 25000,
      "quantity": 200,
      "unit": "sets",
      "target_quarter": "Q1 2024",
      "requested_by": "Maria Garcia",
      "department": "Safety & Compliance",
      "status": "in_progress",
      "priority": "high",
      "budget_allocated": 28000,
      "justification": "Mandatory safety equipment replacement as per OSHA requirements",
      "approval_date": "2024-02-20",
      "expected_delivery": "2024-04-15",
      "supplier_quotes": 2,
      "approved_by": "David Miller",
    },
    {
      "id": "PP-2024-003",
      "item_name": "Office Furniture Upgrade",
      "category": "office_supplies",
      "description": "Ergonomic desks and chairs for administrative offices",
      "vendor": "ErgoSpace Solutions",
      "estimated_cost": 45000,
      "quantity": 75,
      "unit": "sets",
      "target_quarter": "Q3 2024",
      "requested_by": "Jennifer Lee",
      "department": "Human Resources",
      "status": "pending",
      "priority": "medium",
      "budget_allocated": 50000,
      "justification": "Improve employee comfort and productivity with ergonomic furniture",
      "approval_date": null,
      "expected_delivery": "2024-08-30",
      "supplier_quotes": 4,
      "approved_by": null,
    },
    {
      "id": "PP-2024-004",
      "item_name": "Quality Control Software",
      "category": "software",
      "description": "Advanced QC management system with real-time monitoring",
      "vendor": "QualityPro Systems",
      "estimated_cost": 85000,
      "quantity": 1,
      "unit": "license",
      "target_quarter": "Q2 2024",
      "requested_by": "Robert Kim",
      "department": "Quality Assurance",
      "status": "rejected",
      "priority": "medium",
      "budget_allocated": 0,
      "justification": "Streamline quality control processes and reduce manual errors",
      "approval_date": null,
      "expected_delivery": null,
      "supplier_quotes": 2,
      "approved_by": null,
    },
    {
      "id": "PP-2024-005",
      "item_name": "Forklift Fleet Expansion",
      "category": "vehicles",
      "description": "Electric forklifts for warehouse operations",
      "vendor": "LiftMaster Corp",
      "estimated_cost": 180000,
      "quantity": 8,
      "unit": "vehicles",
      "target_quarter": "Q4 2024",
      "requested_by": "Michael Chen",
      "department": "Warehouse Operations",
      "status": "under_review",
      "priority": "high",
      "budget_allocated": 200000,
      "justification": "Expand warehouse capacity and improve operational efficiency",
      "approval_date": null,
      "expected_delivery": "2024-12-15",
      "supplier_quotes": 3,
      "approved_by": null,
    },
  ];

  final List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": ""},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Safety", "value": "safety"},
    {"label": "Office Supplies", "value": "office_supplies"},
    {"label": "Software", "value": "software"},
    {"label": "Vehicles", "value": "vehicles"},
    {"label": "Materials", "value": "materials"},
    {"label": "Services", "value": "services"},
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All Statuses", "value": ""},
    {"label": "Pending", "value": "pending"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Approved", "value": "approved"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Rejected", "value": "rejected"},
  ];

  final List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": ""},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  final List<Map<String, dynamic>> quarterOptions = [
    {"label": "All Quarters", "value": ""},
    {"label": "Q1 2024", "value": "Q1 2024"},
    {"label": "Q2 2024", "value": "Q2 2024"},
    {"label": "Q3 2024", "value": "Q3 2024"},
    {"label": "Q4 2024", "value": "Q4 2024"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return successColor;
      case 'in_progress':
        return infoColor;
      case 'pending':
        return warningColor;
      case 'under_review':
        return warningColor;
      case 'rejected':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'approved':
        return 'Approved';
      case 'in_progress':
        return 'In Progress';
      case 'pending':
        return 'Pending';
      case 'under_review':
        return 'Under Review';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  List<Map<String, dynamic>> get filteredPlans {
    return procurementPlans.where((plan) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${plan["item_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${plan["vendor"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${plan["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || plan["category"] == selectedCategory;
      bool matchesStatus = selectedStatus.isEmpty || plan["status"] == selectedStatus;
      bool matchesPriority = selectedPriority.isEmpty || plan["priority"] == selectedPriority;
      bool matchesQuarter = selectedQuarter.isEmpty || plan["target_quarter"] == selectedQuarter;
      
      return matchesSearch && matchesCategory && matchesStatus && matchesPriority && matchesQuarter;
    }).toList();
  }

  Widget _buildDashboardTab() {
    final int totalPlans = procurementPlans.length;
    final int approved = procurementPlans.where((p) => p["status"] == "approved").length;
    final int pending = procurementPlans.where((p) => p["status"] == "pending").length;
    final int inProgress = procurementPlans.where((p) => p["status"] == "in_progress").length;
    final double totalBudget = procurementPlans.fold(0.0, (sum, plan) => sum + (plan["budget_allocated"] as int).toDouble());

    return Column(
      spacing: spMd,
      children: [
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
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
                  Row(
                    children: [
                      Icon(Icons.assignment, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Total Plans",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "$totalPlans",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
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
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Approved",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "$approved",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
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
                  Row(
                    children: [
                      Icon(Icons.pending, color: warningColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "$pending",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),
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
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: successColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Total Budget",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${totalBudget.currency}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                "Search & Filter",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "Search procurement plans...",
                value: searchQuery,
                hint: "Search by item name, vendor, or ID",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
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
              SizedBox(height: spMd),
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
                      label: "Quarter",
                      items: quarterOptions,
                      value: selectedQuarter,
                      onChanged: (value, label) {
                        selectedQuarter = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
              Row(
                children: [
                  Text(
                    "Recent Procurement Plans",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "New Plan",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: spMd),
              ...filteredPlans.take(5).map((plan) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getStatusColor("${plan["status"]}"),
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
                                  "${plan["id"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${plan["status"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    _getStatusLabel("${plan["status"]}"),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor("${plan["status"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${plan["item_name"]}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${plan["vendor"]} • \$${((plan["estimated_cost"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewPlanTab() {
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
            "New Procurement Plan",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Item Name",
            value: itemName,
            hint: "Enter item or service name",
            validator: Validator.required,
            onChanged: (value) {
              itemName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions.where((item) => item["value"] != "").toList(),
                  value: category,
                  onChanged: (value, label) {
                    category = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityOptions.where((item) => item["value"] != "").toList(),
                  value: priority,
                  onChanged: (value, label) {
                    priority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Detailed description of the item or service",
            validator: Validator.required,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Preferred Vendor",
            value: vendor,
            hint: "Enter vendor or supplier name",
            onChanged: (value) {
              vendor = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Estimated Cost (\$)",
                  value: estimatedCost,
                  hint: "Enter estimated total cost",
                  onChanged: (value) {
                    estimatedCost = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Quantity",
                  value: quantity,
                  hint: "Enter quantity needed",
                  onChanged: (value) {
                    quantity = value;
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
                  label: "Target Quarter",
                  items: quarterOptions.where((item) => item["value"] != "").toList(),
                  value: targetQuarter,
                  onChanged: (value, label) {
                    targetQuarter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Requested By",
                  value: requestedBy,
                  hint: "Enter requester name",
                  validator: Validator.required,
                  onChanged: (value) {
                    requestedBy = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Business Justification",
            value: justification,
            hint: "Explain why this procurement is necessary",
            validator: Validator.required,
            onChanged: (value) {
              justification = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  onPressed: () {
                    itemName = "";
                    category = "";
                    description = "";
                    vendor = "";
                    estimatedCost = "";
                    quantity = "";
                    targetQuarter = "";
                    requestedBy = "";
                    justification = "";
                    priority = "";
                    setState(() {
                      currentTab = 0;
                    });
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Submit Plan",
                  onPressed: () {
                    if (itemName.isNotEmpty && description.isNotEmpty && justification.isNotEmpty) {
                      ss("Procurement plan submitted successfully");
                      itemName = "";
                      category = "";
                      description = "";
                      vendor = "";
                      estimatedCost = "";
                      quantity = "";
                      targetQuarter = "";
                      requestedBy = "";
                      justification = "";
                      priority = "";
                      setState(() {
                        currentTab = 0;
                      });
                    } else {
                      se("Please fill in all required fields");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlansTab() {
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
          Text(
            "All Procurement Plans",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...filteredPlans.map((plan) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${plan["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          _getStatusLabel("${plan["status"]}"),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor("${plan["status"]}"),
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getPriorityColor("${plan["priority"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${plan["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getPriorityColor("${plan["priority"]}"),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${plan["target_quarter"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${plan["id"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${plan["item_name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${plan["description"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.business, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${plan["vendor"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "\$${((plan["estimated_cost"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.inventory, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${plan["quantity"]} ${plan["unit"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${plan["requested_by"]} (${plan["department"]})",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (plan["approval_date"] != null) ...[
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 16, color: successColor),
                        SizedBox(width: 4),
                        Text(
                          "Approved: ${plan["approval_date"]} by ${plan["approved_by"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (plan["expected_delivery"] != null) ...[
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "Expected Delivery: ${plan["expected_delivery"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBudgetTab() {
    final double totalBudget = procurementPlans.fold(0.0, (sum, plan) => sum + (plan["budget_allocated"] as int).toDouble());
    final double approvedBudget = procurementPlans
        .where((plan) => plan["status"] == "approved")
        .fold(0.0, (sum, plan) => sum + (plan["budget_allocated"] as int).toDouble());
    final double pendingBudget = procurementPlans
        .where((plan) => plan["status"] == "pending" || plan["status"] == "under_review")
        .fold(0.0, (sum, plan) => sum + (plan["budget_allocated"] as int).toDouble());

    return Column(
      spacing: spMd,
      children: [
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
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
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Total Budget",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${totalBudget.currency}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
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
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Approved Budget",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${approvedBudget.currency}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
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
                  Row(
                    children: [
                      Icon(Icons.pending, color: warningColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Pending Budget",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${pendingBudget.currency}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                "Budget Breakdown by Category",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...categoryOptions.where((cat) => cat["value"] != "").map((category) {
                final categoryPlans = procurementPlans.where((plan) => plan["category"] == category["value"]).toList();
                final categoryBudget = categoryPlans.fold(0.0, (sum, plan) => sum + (plan["budget_allocated"] as int).toDouble());
                
                if (categoryBudget > 0) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.category, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${category["label"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${categoryPlans.length} items",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${categoryBudget.currency}",
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
                return Container();
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Procurement Planning",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "New Plan", icon: Icon(Icons.add_circle)),
        Tab(text: "All Plans", icon: Icon(Icons.assignment)),
        Tab(text: "Budget", icon: Icon(Icons.account_balance_wallet)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildDashboardTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildNewPlanTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildPlansTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildBudgetTab(),
        ),
      ],
    );
  }
}
