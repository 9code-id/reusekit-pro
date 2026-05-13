import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaExpenseManagementView extends StatefulWidget {
  const ComaExpenseManagementView({Key? key}) : super(key: key);

  @override
  State<ComaExpenseManagementView> createState() => _ComaExpenseManagementViewState();
}

class _ComaExpenseManagementViewState extends State<ComaExpenseManagementView> {
  String selectedExpenseType = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> expenseTypeFilters = [
    {"label": "All Expenses", "value": "all", "count": 48},
    {"label": "Travel", "value": "travel", "count": 12},
    {"label": "Meals", "value": "meals", "count": 8},
    {"label": "Equipment", "value": "equipment", "count": 15},
    {"label": "Supplies", "value": "supplies", "count": 9},
    {"label": "Training", "value": "training", "count": 4},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Reimbursed", "value": "reimbursed"},
  ];

  List<Map<String, dynamic>> expenses = [
    {
      "id": "EXP-2024-001",
      "employee_name": "Sarah Johnson",
      "employee_id": "EMP-001",
      "project_id": "PRJ-2024-001",
      "project_name": "Metro Downtown Complex",
      "expense_type": "travel",
      "category": "Transportation",
      "description": "Site visit and client meeting transportation",
      "amount": 145.50,
      "currency": "USD",
      "expense_date": "2024-06-17",
      "submission_date": "2024-06-17",
      "approval_status": "pending",
      "approved_by": null,
      "approval_date": null,
      "reimbursement_status": "not_processed",
      "reimbursement_date": null,
      "receipt_attached": true,
      "receipt_url": "https://example.com/receipt001.pdf",
      "mileage": 85.2,
      "rate_per_mile": 0.65,
      "vendor": "Metro Taxi Service",
      "payment_method": "Credit Card",
      "business_purpose": "Client meeting and site inspection",
      "approver": "Michael Chen",
      "notes": "Uber receipts for downtown site visits",
      "tax_deductible": true,
      "billable_to_client": true,
    },
    {
      "id": "EXP-2024-002",
      "employee_name": "Robert Martinez",
      "employee_id": "EMP-002",
      "project_id": "PRJ-2024-002",
      "project_name": "Riverside Office Park",
      "expense_type": "meals",
      "category": "Client Entertainment",
      "description": "Working lunch with project stakeholders",
      "amount": 185.75,
      "currency": "USD",
      "expense_date": "2024-06-16",
      "submission_date": "2024-06-16",
      "approval_status": "approved",
      "approved_by": "Emily Rodriguez",
      "approval_date": "2024-06-16",
      "reimbursement_status": "processed",
      "reimbursement_date": "2024-06-18",
      "receipt_attached": true,
      "receipt_url": "https://example.com/receipt002.pdf",
      "attendees": 4,
      "restaurant": "Downtown Bistro",
      "vendor": "Downtown Bistro",
      "payment_method": "Company Card",
      "business_purpose": "Project milestone celebration and planning",
      "approver": "Emily Rodriguez",
      "notes": "Team lunch after successful phase completion",
      "tax_deductible": true,
      "billable_to_client": false,
    },
    {
      "id": "EXP-2024-003",
      "employee_name": "Jennifer Park",
      "employee_id": "EMP-003",
      "project_id": "PRJ-2024-003",
      "project_name": "Healthcare Facility Expansion",
      "expense_type": "equipment",
      "category": "Safety Equipment",
      "description": "Personal protective equipment for site work",
      "amount": 320.00,
      "currency": "USD",
      "expense_date": "2024-06-15",
      "submission_date": "2024-06-15",
      "approval_status": "approved",
      "approved_by": "David Wilson",
      "approval_date": "2024-06-15",
      "reimbursement_status": "reimbursed",
      "reimbursement_date": "2024-06-17",
      "receipt_attached": true,
      "receipt_url": "https://example.com/receipt003.pdf",
      "equipment_list": ["Hard Hat", "Safety Boots", "High-Vis Vest", "Safety Glasses"],
      "vendor": "Safety Supply Pro",
      "payment_method": "Personal Card",
      "business_purpose": "Required safety equipment for healthcare site",
      "approver": "David Wilson",
      "notes": "Specialized equipment for medical facility requirements",
      "tax_deductible": true,
      "billable_to_client": true,
    },
    {
      "id": "EXP-2024-004",
      "employee_name": "Carlos Rivera",
      "employee_id": "EMP-004",
      "project_id": "PRJ-2024-001",
      "project_name": "Metro Downtown Complex",
      "expense_type": "supplies",
      "category": "Office Supplies",
      "description": "Project documentation and office supplies",
      "amount": 78.25,
      "currency": "USD",
      "expense_date": "2024-06-14",
      "submission_date": "2024-06-14",
      "approval_status": "rejected",
      "approved_by": "Sarah Johnson",
      "approval_date": "2024-06-14",
      "rejection_reason": "Personal items included in expense",
      "reimbursement_status": "not_applicable",
      "reimbursement_date": null,
      "receipt_attached": true,
      "receipt_url": "https://example.com/receipt004.pdf",
      "items": ["Binders", "Printing Paper", "Pens", "Folders"],
      "vendor": "Office Depot",
      "payment_method": "Personal Card",
      "business_purpose": "Project documentation organization",
      "approver": "Sarah Johnson",
      "notes": "Some personal items need to be separated",
      "tax_deductible": false,
      "billable_to_client": false,
    },
    {
      "id": "EXP-2024-005",
      "employee_name": "Maria Gonzalez",
      "employee_id": "EMP-005",
      "project_id": "PRJ-2024-004",
      "project_name": "Residential Tower A",
      "expense_type": "training",
      "category": "Professional Development",
      "description": "Construction safety certification course",
      "amount": 450.00,
      "currency": "USD",
      "expense_date": "2024-06-13",
      "submission_date": "2024-06-13",
      "approval_status": "approved",
      "approved_by": "Thomas Anderson",
      "approval_date": "2024-06-13",
      "reimbursement_status": "processed",
      "reimbursement_date": "2024-06-16",
      "receipt_attached": true,
      "receipt_url": "https://example.com/receipt005.pdf",
      "course_name": "OSHA 30-Hour Construction Safety",
      "training_provider": "Safety Training Institute",
      "vendor": "Safety Training Institute",
      "payment_method": "Company Card",
      "business_purpose": "Required certification for project safety compliance",
      "approver": "Thomas Anderson",
      "notes": "Mandatory certification for team lead position",
      "tax_deductible": true,
      "billable_to_client": false,
    },
    {
      "id": "EXP-2024-006",
      "employee_name": "David Kim",
      "employee_id": "EMP-006",
      "project_id": "PRJ-2024-002",
      "project_name": "Riverside Office Park",
      "expense_type": "travel",
      "category": "Accommodation",
      "description": "Hotel stay for multi-day site inspection",
      "amount": 285.60,
      "currency": "USD",
      "expense_date": "2024-06-12",
      "submission_date": "2024-06-12",
      "approval_status": "approved",
      "approved_by": "Emily Rodriguez",
      "approval_date": "2024-06-12",
      "reimbursement_status": "reimbursed",
      "reimbursement_date": "2024-06-15",
      "receipt_attached": true,
      "receipt_url": "https://example.com/receipt006.pdf",
      "hotel_name": "Riverside Inn",
      "nights": 2,
      "rate_per_night": 142.80,
      "vendor": "Riverside Inn",
      "payment_method": "Personal Card",
      "business_purpose": "Extended site inspection and quality control",
      "approver": "Emily Rodriguez",
      "notes": "Required for detailed foundation inspection",
      "tax_deductible": true,
      "billable_to_client": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addExpense(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showExpenseReports(),
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
                  _buildExpenseOverview(),
                  _buildSearchAndFilter(),
                  _buildExpenseFilters(),
                  _buildExpenseStats(),
                  _buildExpensesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildExpenseOverview() {
    double totalExpenses = expenses.fold(0.0, (sum, e) => sum + (e["amount"] as double));
    double pendingAmount = expenses.where((e) => e["approval_status"] == "pending").fold(0.0, (sum, e) => sum + (e["amount"] as double));
    double approvedAmount = expenses.where((e) => e["approval_status"] == "approved").fold(0.0, (sum, e) => sum + (e["amount"] as double));
    double reimbursedAmount = expenses.where((e) => e["reimbursement_status"] == "reimbursed").fold(0.0, (sum, e) => sum + (e["amount"] as double));

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
                child: Icon(Icons.receipt_long, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Expense Management Overview",
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
              _buildOverviewCard("Total", "\$${(totalExpenses).currency}", Icons.monetization_on, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Pending", "\$${(pendingAmount).currency}", Icons.hourglass_empty, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Approved", "\$${(approvedAmount).currency}", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Reimbursed", "\$${(reimbursedAmount).currency}", Icons.payment, infoColor),
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
                  label: "Search expenses...",
                  value: searchQuery,
                  hint: "Search by description, employee, or vendor",
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
                "Status:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QHorizontalScroll(
                  children: statusFilters.map((status) {
                    bool isSelected = selectedStatus == status["value"];
                    return Container(
                      margin: EdgeInsets.only(right: spSm),
                      child: GestureDetector(
                        onTap: () {
                          selectedStatus = status["value"];
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
                            "${status["label"]}",
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

  Widget _buildExpenseFilters() {
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
            "Filter by Expense Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: expenseTypeFilters.map((filter) {
              bool isSelected = selectedExpenseType == filter["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedExpenseType = filter["value"];
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

  Widget _buildExpenseStats() {
    int pendingCount = expenses.where((e) => e["approval_status"] == "pending").length;
    int approvedCount = expenses.where((e) => e["approval_status"] == "approved").length;
    double avgExpense = expenses.fold(0.0, (sum, e) => sum + (e["amount"] as double)) / expenses.length;

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
            "Expense Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildStatCard("Pending Review", "$pendingCount", Icons.pending_actions),
              SizedBox(width: spSm),
              _buildStatCard("Approved", "$approvedCount", Icons.check_circle),
              SizedBox(width: spSm),
              _buildStatCard("Avg. Amount", "\$${(avgExpense).currency}", Icons.calculate),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
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

  Widget _buildExpensesList() {
    List<Map<String, dynamic>> filteredExpenses = _getFilteredExpenses();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Expense Records (${filteredExpenses.length})",
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
        ...filteredExpenses.map((expense) => _buildExpenseCard(expense)),
      ],
    );
  }

  Widget _buildExpenseCard(Map<String, dynamic> expense) {
    Color statusColor = _getApprovalStatusColor(expense["approval_status"]);
    Color typeColor = _getExpenseTypeColor(expense["expense_type"]);

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
                      "${expense["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${expense["description"]}",
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
                  "${expense["approval_status"]}".toUpperCase(),
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
                  "${expense["expense_type"]}".toUpperCase(),
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
                  "${expense["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Employee: ${expense["employee_name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Project: ${expense["project_name"]}",
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
            child: Row(
              children: [
                Text(
                  "Amount: \$${((expense["amount"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                if (expense["receipt_attached"] == true)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "RECEIPT",
                      style: TextStyle(
                        fontSize: 10,
                        color: successColor,
                        fontWeight: FontWeight.bold,
                      ),
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
                  "Vendor: ${expense["vendor"]}",
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
              Icon(Icons.credit_card, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Payment: ${expense["payment_method"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Date: ${expense["expense_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (expense["approved_by"] != null)
            Row(
              children: [
                Icon(Icons.person_add, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Approved by: ${expense["approved_by"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                if (expense["approval_date"] != null)
                  Text(
                    "on ${expense["approval_date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
              ],
            ),
          if (expense["rejection_reason"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: dangerColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Rejected: ${expense["rejection_reason"]}",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getReimbursementStatusColor(expense["reimbursement_status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${expense["reimbursement_status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getReimbursementStatusColor(expense["reimbursement_status"]),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (expense["billable_to_client"] == true) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "BILLABLE",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              Spacer(),
              Text(
                "Submitted: ${expense["submission_date"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (expense["notes"] != null && (expense["notes"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${expense["notes"]}",
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
                  "Purpose: ${expense["business_purpose"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewExpenseDetails(expense["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editExpense(expense["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showExpenseOptions(expense),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredExpenses() {
    List<Map<String, dynamic>> filtered = expenses;

    if (selectedExpenseType != "all") {
      filtered = filtered.where((e) => e["expense_type"] == selectedExpenseType).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((e) => e["approval_status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((e) =>
          e["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          e["employee_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          e["vendor"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
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

  Color _getExpenseTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'travel':
        return infoColor;
      case 'meals':
        return warningColor;
      case 'equipment':
        return primaryColor;
      case 'supplies':
        return successColor;
      case 'training':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getReimbursementStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'reimbursed':
        return successColor;
      case 'processed':
        return warningColor;
      case 'not_processed':
        return primaryColor;
      case 'not_applicable':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addExpense() {
    ss("Add new expense");
  }

  void _showExpenseReports() {
    ss("Expense reports and analytics");
  }

  void _showAdvancedFilters() {
    ss("Advanced expense filters");
  }

  void _showSortOptions() {
    ss("Expense sort options");
  }

  void _viewExpenseDetails(String expenseId) {
    ss("Viewing expense details $expenseId");
  }

  void _editExpense(String expenseId) {
    ss("Editing expense $expenseId");
  }

  void _showExpenseOptions(Map<String, dynamic> expense) {
    ss("Expense options for ${expense["id"]}");
  }
}
