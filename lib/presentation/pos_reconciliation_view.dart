import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosReconciliationView extends StatefulWidget {
  const PosReconciliationView({super.key});

  @override
  State<PosReconciliationView> createState() => _PosReconciliationViewState();
}

class _PosReconciliationViewState extends State<PosReconciliationView> {
  final formKey = GlobalKey<FormState>();
  
  // Reconciliation data
  List<Map<String, dynamic>> reconciliationItems = [
    {
      "category": "Cash Sales",
      "system_amount": 2850.75,
      "actual_amount": 2850.75,
      "variance": 0.0,
      "status": "balanced",
      "icon": Icons.attach_money,
    },
    {
      "category": "Credit Card",
      "system_amount": 4250.30,
      "actual_amount": 4245.30,
      "variance": -5.0,
      "status": "variance",
      "icon": Icons.credit_card,
    },
    {
      "category": "Gift Cards",
      "system_amount": 325.50,
      "actual_amount": 325.50,
      "variance": 0.0,
      "status": "balanced",
      "icon": Icons.card_giftcard,
    },
    {
      "category": "Returns/Refunds",
      "system_amount": -125.80,
      "actual_amount": -125.80,
      "variance": 0.0,
      "status": "balanced",
      "icon": Icons.assignment_return,
    },
    {
      "category": "Discounts",
      "system_amount": -85.25,
      "actual_amount": -82.50,
      "variance": 2.75,
      "status": "variance",
      "icon": Icons.local_offer,
    },
    {
      "category": "Tips",
      "system_amount": 185.40,
      "actual_amount": 180.00,
      "variance": -5.40,
      "status": "variance",
      "icon": Icons.volunteer_activism,
    },
  ];

  List<Map<String, dynamic>> reconciliationHistory = [
    {
      "date": "2024-06-18",
      "shift": "Evening",
      "total_variance": -2.65,
      "status": "approved",
      "manager": "Sarah Johnson",
      "time": "11:45 PM",
    },
    {
      "date": "2024-06-18",
      "shift": "Afternoon",
      "total_variance": 0.0,
      "status": "balanced",
      "manager": "Mike Wilson",
      "time": "5:30 PM",
    },
    {
      "date": "2024-06-17",
      "shift": "Evening",
      "total_variance": 8.50,
      "status": "reviewed",
      "manager": "Sarah Johnson",
      "time": "11:50 PM",
    },
    {
      "date": "2024-06-17",
      "shift": "Afternoon",
      "total_variance": -3.25,
      "status": "approved",
      "manager": "Mike Wilson",
      "time": "5:25 PM",
    },
  ];

  // Form fields
  String notes = "";
  String managerPassword = "";
  bool isSubmitting = false;

  double get totalSystemAmount => reconciliationItems.fold(0.0, (sum, item) => sum + (item["system_amount"] as double));
  double get totalActualAmount => reconciliationItems.fold(0.0, (sum, item) => sum + (item["actual_amount"] as double));
  double get totalVariance => reconciliationItems.fold(0.0, (sum, item) => sum + (item["variance"] as double));

  void _approveReconciliation() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isSubmitting = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isSubmitting = false;
    });

    ss("Reconciliation approved successfully");
    // Navigate back or to next screen
  }

  void _requestManagerApproval() async {
    bool isConfirmed = await confirm("Request manager approval for this reconciliation?");
    if (!isConfirmed) return;

    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();

    si("Manager approval request sent");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("End of Day Reconciliation"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Show reconciliation history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Summary Card
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.assessment,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Reconciliation Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: disabledOutlineBorderColor,
                      margin: EdgeInsets.symmetric(vertical: spSm),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "System Total:",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${totalSystemAmount.currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Actual Total:",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${totalActualAmount.currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: disabledOutlineBorderColor,
                      margin: EdgeInsets.symmetric(vertical: spSm),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Variance:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: totalVariance == 0 
                              ? successColor.withAlpha(20)
                              : totalVariance.abs() <= 10 
                                ? warningColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${totalVariance >= 0 ? '+' : ''}\$${totalVariance.abs().currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: totalVariance == 0 
                                ? successColor
                                : totalVariance.abs() <= 10 
                                  ? warningColor
                                  : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Reconciliation Items
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Text(
                        "Reconciliation Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    ...reconciliationItems.map((item) => _buildReconciliationItem(item)),
                  ],
                ),
              ),

              // Notes Section
              QMemoField(
                label: "Reconciliation Notes",
                value: notes,
                hint: "Add any notes about variances or issues found...",
                onChanged: (value) {
                  notes = value;
                  setState(() {});
                },
              ),

              // Manager Authorization
              if (totalVariance.abs() > 5.0) ...[
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: warningColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.security,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Manager Authorization Required",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Variance exceeds \$5.00 threshold. Manager approval is required.",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      QTextField(
                        label: "Manager Password",
                        value: managerPassword,
                        obscureText: true,
                        validator: Validator.required,
                        onChanged: (value) {
                          managerPassword = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],

              // Action Buttons
              Row(
                spacing: spSm,
                children: [
                  if (totalVariance.abs() > 5.0)
                    Expanded(
                      child: QButton(
                        label: "Request Approval",
                        icon: Icons.approval,
                        onPressed: _requestManagerApproval,
                      ),
                    ),
                  Expanded(
                    child: QButton(
                      label: isSubmitting ? "Processing..." : "Complete Reconciliation",
                      onPressed: isSubmitting ? null : _approveReconciliation,
                    ),
                  ),
                ],
              ),

              // Recent History
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent Reconciliations",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Show all history
                            },
                            child: Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...reconciliationHistory.take(3).map((history) => _buildHistoryItem(history)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReconciliationItem(Map<String, dynamic> item) {
    Color statusColor = item["status"] == "balanced" ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["category"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "System: \$${(item["system_amount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Actual: \$${(item["actual_amount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(item["variance"] as double) >= 0 ? '+' : ''}\$${(item["variance"] as double).abs().currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> history) {
    Color statusColor;
    IconData statusIcon;
    
    switch (history["status"]) {
      case "balanced":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "approved":
        statusColor = infoColor;
        statusIcon = Icons.verified;
        break;
      case "reviewed":
        statusColor = warningColor;
        statusIcon = Icons.pending;
        break;
      default:
        statusColor = disabledBoldColor;
        statusIcon = Icons.help;
    }
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${history["date"]} - ${history["shift"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${history["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Manager: ${history["manager"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Variance: ${(history["total_variance"] as double) >= 0 ? '+' : ''}\$${(history["total_variance"] as double).abs().currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: (history["total_variance"] as double) == 0 ? successColor : warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
