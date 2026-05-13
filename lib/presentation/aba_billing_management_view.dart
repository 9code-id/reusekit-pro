import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaBillingManagementView extends StatefulWidget {
  const AbaBillingManagementView({super.key});

  @override
  State<AbaBillingManagementView> createState() => _AbaBillingManagementViewState();
}

class _AbaBillingManagementViewState extends State<AbaBillingManagementView> {
  String searchQuery = "";
  String selectedPeriod = "current_month";
  String selectedStatus = "all";
  int currentTab = 0;

  List<Map<String, dynamic>> billingRecords = [
    {
      "id": "BILL-2025-001",
      "client_name": "Smith Family",
      "patient_name": "Alex Smith",
      "billing_period": "January 2025",
      "service_date": "2025-01-15",
      "hours_billed": 20,
      "rate_per_hour": 120.00,
      "subtotal": 2400.00,
      "insurance_claim": "BC12345",
      "insurance_payment": 1920.00,
      "copay_amount": 480.00,
      "status": "paid",
      "payment_date": "2025-01-20",
      "service_type": "Direct ABA Therapy",
      "therapist": "Dr. Sarah Johnson",
      "authorization_code": "AUTH-2025-001"
    },
    {
      "id": "BILL-2025-002",
      "client_name": "Martinez Family",
      "patient_name": "Sofia Martinez",
      "billing_period": "January 2025",
      "service_date": "2025-01-18",
      "hours_billed": 15,
      "rate_per_hour": 125.00,
      "subtotal": 1875.00,
      "insurance_claim": "BC12346",
      "insurance_payment": 1500.00,
      "copay_amount": 375.00,
      "status": "pending",
      "payment_date": null,
      "service_type": "Behavioral Assessment",
      "therapist": "Dr. Michael Chen",
      "authorization_code": "AUTH-2025-002"
    },
    {
      "id": "BILL-2025-003",
      "client_name": "Thompson Family",
      "patient_name": "Emma Thompson",
      "billing_period": "January 2025",
      "service_date": "2025-01-12",
      "hours_billed": 25,
      "rate_per_hour": 110.00,
      "subtotal": 2750.00,
      "insurance_claim": "BC12347",
      "insurance_payment": 0.00,
      "copay_amount": 2750.00,
      "status": "rejected",
      "payment_date": null,
      "service_type": "Intensive ABA Therapy",
      "therapist": "Dr. Lisa Rodriguez",
      "authorization_code": "AUTH-2025-003"
    },
    {
      "id": "BILL-2025-004",
      "client_name": "Davis Family",
      "patient_name": "Jordan Davis",
      "billing_period": "January 2025",
      "service_date": "2025-01-22",
      "hours_billed": 18,
      "rate_per_hour": 115.00,
      "subtotal": 2070.00,
      "insurance_claim": "BC12348",
      "insurance_payment": 1656.00,
      "copay_amount": 414.00,
      "status": "processing",
      "payment_date": null,
      "service_type": "Social Skills Training",
      "therapist": "Dr. Amanda Wilson",
      "authorization_code": "AUTH-2025-004"
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Paid", "value": "paid"},
    {"label": "Pending", "value": "pending"},
    {"label": "Processing", "value": "processing"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Month", "value": "current_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "This Year", "value": "this_year"},
    {"label": "All Time", "value": "all_time"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return successColor;
      case 'pending':
        return warningColor;
      case 'processing':
        return infoColor;
      case 'rejected':
        return dangerColor;
      case 'overdue':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'paid':
        return 'Paid';
      case 'pending':
        return 'Pending';
      case 'processing':
        return 'Processing';
      case 'rejected':
        return 'Rejected';
      case 'overdue':
        return 'Overdue';
      default:
        return 'Unknown';
    }
  }

  List<Map<String, dynamic>> get filteredBillingRecords {
    return billingRecords.where((record) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${record["client_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["patient_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["insurance_claim"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || record["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  double get totalBilled {
    return filteredBillingRecords.fold(0.0, (sum, record) => sum + (record["subtotal"] as double));
  }

  double get totalInsurancePayments {
    return filteredBillingRecords.fold(0.0, (sum, record) => sum + (record["insurance_payment"] as double));
  }

  double get totalCopayments {
    return filteredBillingRecords.fold(0.0, (sum, record) => sum + (record["copay_amount"] as double));
  }

  int get pendingClaims {
    return filteredBillingRecords.where((record) => record["status"] == "pending" || record["status"] == "processing").length;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Billing Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Billing Records", icon: Icon(Icons.receipt_long)),
        Tab(text: "Claims Tracking", icon: Icon(Icons.track_changes)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildBillingRecordsTab(),
        _buildClaimsTrackingTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildBillingRecordsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildSummaryCards(),
          _buildBillingRecordsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search billing records...",
                value: searchQuery,
                hint: "Client, patient, billing ID, or claim number",
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
                label: "Period",
                items: periodOptions,
                value: selectedPeriod,
                onChanged: (value, label) {
                  selectedPeriod = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Billed",
          "\$${totalBilled.currency}",
          Icons.receipt,
          primaryColor,
        ),
        _buildSummaryCard(
          "Insurance Payments",
          "\$${totalInsurancePayments.currency}",
          Icons.business,
          successColor,
        ),
        _buildSummaryCard(
          "Copayments",
          "\$${totalCopayments.currency}",
          Icons.payment,
          infoColor,
        ),
        _buildSummaryCard(
          "Pending Claims",
          "$pendingClaims",
          Icons.pending,
          warningColor,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingRecordsList() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Billing Records",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "New Billing",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...filteredBillingRecords.map((record) => _buildBillingRecordCard(record)),
      ],
    );
  }

  Widget _buildBillingRecordCard(Map<String, dynamic> record) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${record["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${record["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${record["client_name"]} - ${record["patient_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${record["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel("${record["status"]}"),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${record["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildRecordDetailCard(
                "Service Details",
                [
                  "Type: ${record["service_type"]}",
                  "Hours: ${record["hours_billed"]}",
                  "Rate: \$${(record["rate_per_hour"] as double).currency}/hr",
                  "Therapist: ${record["therapist"]}",
                ],
                Icons.medical_services,
                primaryColor,
              ),
              _buildRecordDetailCard(
                "Billing Amount",
                [
                  "Subtotal: \$${(record["subtotal"] as double).currency}",
                  "Insurance: \$${(record["insurance_payment"] as double).currency}",
                  "Copay: \$${(record["copay_amount"] as double).currency}",
                  "Period: ${record["billing_period"]}",
                ],
                Icons.attach_money,
                successColor,
              ),
              _buildRecordDetailCard(
                "Claim Information",
                [
                  "Claim: ${record["insurance_claim"]}",
                  "Auth: ${record["authorization_code"]}",
                  "Service Date: ${record["service_date"]}",
                  record["payment_date"] != null ? "Paid: ${record["payment_date"]}" : "Payment: Pending",
                ],
                Icons.description,
                infoColor,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.print,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecordDetailCard(String title, List<String> details, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          ...details.map((detail) => Text(
            detail,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildClaimsTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildClaimsHeader(),
          _buildClaimsStatusOverview(),
          _buildClaimsList(),
        ],
      ),
    );
  }

  Widget _buildClaimsHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.track_changes,
            color: infoColor,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Insurance Claims Tracking",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Monitor and track insurance claim submissions and payments",
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
    );
  }

  Widget _buildClaimsStatusOverview() {
    List<Map<String, dynamic>> claimsStatus = [
      {"status": "Submitted", "count": 15, "amount": 18750.00, "color": infoColor},
      {"status": "Processing", "count": 8, "amount": 9600.00, "color": warningColor},
      {"status": "Approved", "count": 22, "amount": 26400.00, "color": successColor},
      {"status": "Rejected", "count": 3, "amount": 3600.00, "color": dangerColor},
    ];

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
            "Claims Status Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: claimsStatus.map((status) => _buildClaimsStatusCard(status)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimsStatusCard(Map<String, dynamic> status) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: (status["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (status["color"] as Color).withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${status["status"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: status["color"] as Color,
                ),
              ),
              Icon(
                Icons.description,
                color: status["color"] as Color,
                size: 20,
              ),
            ],
          ),
          Text(
            "${status["count"]} Claims",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "\$${(status["amount"] as double).currency}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: status["color"] as Color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimsList() {
    List<Map<String, dynamic>> recentClaims = billingRecords.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Claims",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...recentClaims.map((claim) => _buildClaimCard(claim)),
      ],
    );
  }

  Widget _buildClaimCard(Map<String, dynamic> claim) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: _getStatusColor("${claim["status"]}").withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.description,
              color: _getStatusColor("${claim["status"]}"),
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${claim["insurance_claim"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${claim["client_name"]} - ${claim["patient_name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Amount: \$${(claim["subtotal"] as double).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
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
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${claim["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel("${claim["status"]}"),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${claim["status"]}"),
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildReportsHeader(),
          _buildRevenueReports(),
          _buildInsuranceReports(),
          _buildCustomReports(),
        ],
      ),
    );
  }

  Widget _buildReportsHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.analytics,
            color: successColor,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Billing Reports & Analytics",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Comprehensive billing and revenue analysis reports",
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
    );
  }

  Widget _buildRevenueReports() {
    List<Map<String, dynamic>> revenueMetrics = [
      {
        "title": "Monthly Revenue",
        "value": "\$45,720",
        "change": "+12.5%",
        "icon": Icons.trending_up,
        "color": successColor
      },
      {
        "title": "Average Billing",
        "value": "\$2,286",
        "change": "+8.2%",
        "icon": Icons.receipt,
        "color": infoColor
      },
      {
        "title": "Collection Rate",
        "value": "94.2%",
        "change": "+2.1%",
        "icon": Icons.percent,
        "color": primaryColor
      },
      {
        "title": "Outstanding Amount",
        "value": "\$8,450",
        "change": "-15.3%",
        "icon": Icons.warning,
        "color": warningColor
      },
    ];

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
            "Revenue Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: revenueMetrics.map((metric) => _buildRevenueMetricCard(metric)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueMetricCard(Map<String, dynamic> metric) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: (metric["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (metric["color"] as Color).withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                metric["icon"] as IconData,
                color: metric["color"] as Color,
                size: 24,
              ),
              Text(
                "${metric["change"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: metric["change"].toString().startsWith('+') ? successColor : dangerColor,
                ),
              ),
            ],
          ),
          Text(
            "${metric["value"]}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: metric["color"] as Color,
            ),
          ),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceReports() {
    List<Map<String, dynamic>> insuranceData = [
      {"provider": "Blue Cross Blue Shield", "claims": 15, "amount": 18750.00, "approval_rate": 92},
      {"provider": "Aetna", "claims": 8, "amount": 9600.00, "approval_rate": 88},
      {"provider": "Cigna", "claims": 12, "amount": 14400.00, "approval_rate": 95},
      {"provider": "UnitedHealth", "claims": 6, "amount": 7200.00, "approval_rate": 83},
    ];

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
            "Insurance Provider Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: insuranceData.map((data) => _buildInsuranceProviderCard(data)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceProviderCard(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${data["provider"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${data["claims"]} claims • \$${(data["amount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${data["approval_rate"]}% approval",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: successColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomReports() {
    List<Map<String, dynamic>> reportOptions = [
      {
        "title": "Aging Report",
        "description": "Outstanding balances by age",
        "icon": Icons.schedule,
        "color": warningColor
      },
      {
        "title": "Service Analysis",
        "description": "Revenue breakdown by service type",
        "icon": Icons.pie_chart,
        "color": infoColor
      },
      {
        "title": "Therapist Productivity",
        "description": "Billing performance by therapist",
        "icon": Icons.person,
        "color": successColor
      },
      {
        "title": "Denial Analysis",
        "description": "Insurance claim rejections and reasons",
        "icon": Icons.error,
        "color": dangerColor
      },
    ];

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
            "Custom Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: reportOptions.map((report) => _buildCustomReportCard(report)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomReportCard(Map<String, dynamic> report) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                report["icon"] as IconData,
                color: report["color"] as Color,
                size: 24,
              ),
              QButton(
                icon: Icons.play_arrow,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Text(
            "${report["title"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${report["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
