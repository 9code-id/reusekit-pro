import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaTaxFilingView extends StatefulWidget {
  const BfaTaxFilingView({super.key});

  @override
  State<BfaTaxFilingView> createState() => _BfaTaxFilingViewState();
}

class _BfaTaxFilingViewState extends State<BfaTaxFilingView> {
  String filingStatus = "In Progress";
  String taxYear = "2024";
  
  List<Map<String, dynamic>> taxYears = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
  ];

  List<Map<String, dynamic>> filingSteps = [
    {
      "step": 1,
      "title": "Gather Documents",
      "description": "Collect all necessary tax documents (W-2, 1099, receipts, etc.)",
      "status": "completed",
      "icon": Icons.folder,
      "documents": ["W-2", "1099-INT", "1099-DIV", "Receipts"],
      "dueDate": "2025-02-15",
    },
    {
      "step": 2,
      "title": "Review Income Sources",
      "description": "Enter all income from employment, investments, and other sources",
      "status": "completed",
      "icon": Icons.attach_money,
      "documents": [],
      "dueDate": "2025-02-20",
    },
    {
      "step": 3,
      "title": "Calculate Deductions",
      "description": "Determine whether to itemize or take standard deduction",
      "status": "in_progress",
      "icon": Icons.calculate,
      "documents": [],
      "dueDate": "2025-02-25",
    },
    {
      "step": 4,
      "title": "Review & File",
      "description": "Double-check all information and submit your tax return",
      "status": "pending",
      "icon": Icons.send,
      "documents": [],
      "dueDate": "2025-04-15",
    },
  ];

  List<Map<String, dynamic>> taxDocuments = [
    {
      "name": "W-2 Form",
      "type": "Income",
      "status": "uploaded",
      "date": "2025-01-15",
      "employer": "ABC Corp",
      "amount": 75000.0,
      "icon": Icons.description,
      "required": true,
    },
    {
      "name": "1099-INT",
      "type": "Interest Income",
      "status": "uploaded",
      "date": "2025-01-20",
      "employer": "Chase Bank",
      "amount": 245.50,
      "icon": Icons.account_balance,
      "required": false,
    },
    {
      "name": "1099-DIV",
      "type": "Dividend Income",
      "status": "uploaded",
      "date": "2025-01-22",
      "employer": "Vanguard",
      "amount": 1150.75,
      "icon": Icons.trending_up,
      "required": false,
    },
    {
      "name": "Mortgage Interest (1098)",
      "type": "Deduction",
      "status": "missing",
      "date": "",
      "employer": "Wells Fargo",
      "amount": 8500.0,
      "icon": Icons.home,
      "required": false,
    },
    {
      "name": "Charitable Donations",
      "type": "Deduction",
      "status": "uploaded",
      "date": "2025-01-10",
      "employer": "Various",
      "amount": 2500.0,
      "icon": Icons.volunteer_activism,
      "required": false,
    },
  ];

  Map<String, dynamic> taxSummary = {
    "totalIncome": 76396.25,
    "adjustedGrossIncome": 70396.25,
    "taxableIncome": 56546.25,
    "federalTax": 8945.50,
    "stateTax": 3519.75,
    "totalTax": 12465.25,
    "withholdings": 13200.00,
    "refundAmount": 734.75,
    "estimatedRefundDate": "2025-03-15",
  };

  List<Map<String, dynamic>> filingOptions = [
    {
      "method": "Self-File Online",
      "description": "Use tax software to prepare and file your return yourself",
      "cost": 0.0,
      "time": "2-4 hours",
      "accuracy": "Good",
      "support": "Online help",
      "icon": Icons.computer,
      "color": successColor,
      "recommended": false,
    },
    {
      "method": "Professional CPA",
      "description": "Have a certified public accountant prepare your return",
      "cost": 350.0,
      "time": "1-2 weeks",
      "accuracy": "Excellent",
      "support": "Full service",
      "icon": Icons.person,
      "color": primaryColor,
      "recommended": true,
    },
    {
      "method": "Tax Preparation Service",
      "description": "Use a national tax preparation chain for assistance",
      "cost": 150.0,
      "time": "Same day",
      "accuracy": "Good",
      "support": "In-person help",
      "icon": Icons.storefront,
      "color": warningColor,
      "recommended": false,
    },
  ];

  int getCompletedSteps() {
    return filingSteps.where((step) => step["status"] == "completed").length;
  }

  int getCurrentStep() {
    for (int i = 0; i < filingSteps.length; i++) {
      if (filingSteps[i]["status"] != "completed") {
        return i + 1;
      }
    }
    return filingSteps.length;
  }

  int getMissingDocuments() {
    return taxDocuments.where((doc) => doc["status"] == "missing").length;
  }

  @override
  Widget build(BuildContext context) {
    int completedSteps = getCompletedSteps();
    int currentStep = getCurrentStep();
    int missingDocs = getMissingDocuments();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Filing"),
        actions: [
          IconButton(
            onPressed: () {
              // Get help
            },
            icon: Icon(Icons.help),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filing Status Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(filingStatus),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getStatusIcon(filingStatus),
                        color: _getStatusColor(filingStatus),
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Tax Year $taxYear Filing Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _getStatusMessage(filingStatus),
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatusCard(
                          "Steps Completed",
                          "$completedSteps/${filingSteps.length}",
                          Icons.checklist,
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatusCard(
                          "Current Step",
                          "Step $currentStep",
                          Icons.timeline,
                          primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (missingDocs > 0) ...[
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            size: 16,
                            color: warningColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "$missingDocs documents still needed",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Filing Progress
            Text(
              "Filing Progress",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              spacing: spSm,
              children: filingSteps.map((step) {
                Color stepColor = _getStepColor(step["status"]);
                IconData stepIcon = _getStepIcon(step["status"]);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: step["status"] == "in_progress" ? Border.all(
                      color: primaryColor.withAlpha(50),
                      width: 2,
                    ) : null,
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: stepColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: step["status"] == "completed"
                                  ? Icon(
                                      Icons.check,
                                      color: stepColor,
                                      size: 20,
                                    )
                                  : Text(
                                      "${step["step"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: stepColor,
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
                                  "${step["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    decoration: step["status"] == "completed" ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                Text(
                                  "${step["description"]}",
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
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: stepColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  _getStepStatusText(step["status"]),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: stepColor,
                                  ),
                                ),
                              ),
                              if (step["status"] != "completed") ...[
                                SizedBox(height: spXxs),
                                Text(
                                  "Due: ${step["dueDate"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      
                      if (step["status"] == "in_progress") ...[
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Continue Step",
                            icon: Icons.arrow_forward,
                            size: bs.sm,
                            onPressed: () {
                              // Continue current step
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),

            // Tax Documents
            Text(
              "Tax Documents",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: taxDocuments.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> doc = entry.value;
                  Color statusColor = _getDocumentStatusColor(doc["status"]);
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index < taxDocuments.length - 1 ? Border(
                        bottom: BorderSide(
                          color: disabledColor,
                          width: 1,
                        ),
                      ) : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            doc["icon"] as IconData,
                            color: statusColor,
                            size: 20,
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
                                      "${doc["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (doc["required"] as bool) ...[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 1,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "Required",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${doc["type"]} • ${doc["employer"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (doc["status"] == "uploaded") ...[
                                Text(
                                  "Uploaded: ${doc["date"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                _getDocumentStatusText(doc["status"]),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ),
                            if ((doc["amount"] as double) > 0) ...[
                              SizedBox(height: spXxs),
                              Text(
                                "\$${(doc["amount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: doc["type"] == "Income" ? successColor : primaryColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Tax Summary
            if (completedSteps >= 2) ...[
              Text(
                "Tax Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

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
                    _buildSummaryRow("Total Income", "\$${(taxSummary["totalIncome"] as double).currency}", false),
                    _buildSummaryRow("Adjusted Gross Income", "\$${(taxSummary["adjustedGrossIncome"] as double).currency}", false),
                    _buildSummaryRow("Taxable Income", "\$${(taxSummary["taxableIncome"] as double).currency}", false),
                    _buildSummaryRow("Federal Tax", "\$${(taxSummary["federalTax"] as double).currency}", false),
                    _buildSummaryRow("State Tax", "\$${(taxSummary["stateTax"] as double).currency}", false),
                    _buildSummaryRow("Total Tax Owed", "\$${(taxSummary["totalTax"] as double).currency}", false),
                    _buildSummaryRow("Tax Withholdings", "\$${(taxSummary["withholdings"] as double).currency}", false),
                    Divider(),
                    _buildSummaryRow("Estimated Refund", "\$${(taxSummary["refundAmount"] as double).currency}", true),
                  ],
                ),
              ),

              if ((taxSummary["refundAmount"] as double) > 0) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: successColor.withAlpha(30),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Expected Refund",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(taxSummary["refundAmount"] as double).currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Expected by: ${taxSummary["estimatedRefundDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],

            // Filing Options
            Text(
              "Filing Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              spacing: spSm,
              children: filingOptions.map((option) {
                bool recommended = option["recommended"] as bool;
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: recommended ? Border.all(
                      color: primaryColor.withAlpha(50),
                      width: 2,
                    ) : null,
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (option["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              option["icon"] as IconData,
                              color: option["color"] as Color,
                              size: 20,
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
                                        "${option["method"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (recommended) ...[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Recommended",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  "${option["description"]}",
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
                      
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "Cost: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  (option["cost"] as double) > 0 ? "\$${(option["cost"] as double).currency}" : "Free",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (option["cost"] as double) > 0 ? dangerColor : successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Time: ${option["time"]} • Accuracy: ${option["accuracy"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Choose This Option",
                          icon: Icons.arrow_forward,
                          size: bs.sm,
                          onPressed: () {
                            // Choose filing option
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Upload Document",
                    icon: Icons.upload_file,
                    size: bs.sm,
                    onPressed: () {
                      // Upload tax document
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Get Help",
                    icon: Icons.support_agent,
                    size: bs.sm,
                    onPressed: () {
                      // Get filing help
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
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
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool highlight) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: highlight ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: highlight ? successColor : primaryColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return primaryColor;
      case "Not Started":
        return disabledBoldColor;
      default:
        return warningColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Completed":
        return Icons.check_circle;
      case "In Progress":
        return Icons.pending;
      case "Not Started":
        return Icons.radio_button_unchecked;
      default:
        return Icons.warning;
    }
  }

  String _getStatusMessage(String status) {
    switch (status) {
      case "Completed":
        return "Your tax return has been successfully filed and accepted.";
      case "In Progress":
        return "Your tax filing is currently in progress. Complete the remaining steps.";
      case "Not Started":
        return "You haven't started your tax filing yet. Begin by gathering documents.";
      default:
        return "Please check your filing status and complete any required actions.";
    }
  }

  Color _getStepColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return primaryColor;
      case "pending":
        return disabledBoldColor;
      default:
        return warningColor;
    }
  }

  IconData _getStepIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "in_progress":
        return Icons.pending;
      case "pending":
        return Icons.radio_button_unchecked;
      default:
        return Icons.warning;
    }
  }

  String _getStepStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }

  Color _getDocumentStatusColor(String status) {
    switch (status) {
      case "uploaded":
        return successColor;
      case "missing":
        return dangerColor;
      case "pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getDocumentStatusText(String status) {
    switch (status) {
      case "uploaded":
        return "Uploaded";
      case "missing":
        return "Missing";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }
}
