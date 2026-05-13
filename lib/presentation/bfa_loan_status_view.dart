import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaLoanStatusView extends StatefulWidget {
  const BfaLoanStatusView({super.key});

  @override
  State<BfaLoanStatusView> createState() => _BfaLoanStatusViewState();
}

class _BfaLoanStatusViewState extends State<BfaLoanStatusView> {
  int selectedTab = 0;
  String searchQuery = "";
  
  final List<Map<String, dynamic>> loanApplications = [
    {
      "applicationId": "LN2024001234",
      "loanType": "Personal Loan",
      "amount": 500000,
      "appliedDate": "2024-01-15",
      "status": "Approved",
      "statusColor": "success",
      "nextAction": "Accept Offer",
      "tenure": "36 months",
      "interestRate": 10.5,
      "emi": 16134,
      "processingFee": 2500,
      "remarks": "Congratulations! Your loan has been approved. Please accept the offer to proceed.",
      "timeline": [
        {"step": "Application Submitted", "date": "2024-01-15", "status": "completed"},
        {"step": "Document Verification", "date": "2024-01-16", "status": "completed"},
        {"step": "Credit Check", "date": "2024-01-17", "status": "completed"},
        {"step": "Approval", "date": "2024-01-18", "status": "completed"},
        {"step": "Offer Acceptance", "date": "Pending", "status": "pending"},
        {"step": "Disbursement", "date": "Pending", "status": "pending"},
      ]
    },
    {
      "applicationId": "LN2024001189",
      "loanType": "Home Loan",
      "amount": 2500000,
      "appliedDate": "2024-01-10",
      "status": "Under Review",
      "statusColor": "warning",
      "nextAction": "Submit Property Documents",
      "tenure": "240 months",
      "interestRate": 8.75,
      "emi": 23456,
      "processingFee": 12500,
      "remarks": "Your application is under review. Please submit property valuation documents.",
      "timeline": [
        {"step": "Application Submitted", "date": "2024-01-10", "status": "completed"},
        {"step": "Document Verification", "date": "2024-01-11", "status": "completed"},
        {"step": "Credit Check", "date": "2024-01-12", "status": "completed"},
        {"step": "Property Verification", "date": "In Progress", "status": "current"},
        {"step": "Final Approval", "date": "Pending", "status": "pending"},
        {"step": "Disbursement", "date": "Pending", "status": "pending"},
      ]
    },
    {
      "applicationId": "LN2024000987",
      "loanType": "Car Loan",
      "amount": 800000,
      "appliedDate": "2023-12-28",
      "status": "Disbursed",
      "statusColor": "success",
      "nextAction": "Download Agreement",
      "tenure": "60 months",
      "interestRate": 9.25,
      "emi": 16842,
      "processingFee": 4000,
      "remarks": "Loan amount has been successfully disbursed to your account.",
      "timeline": [
        {"step": "Application Submitted", "date": "2023-12-28", "status": "completed"},
        {"step": "Document Verification", "date": "2023-12-29", "status": "completed"},
        {"step": "Credit Check", "date": "2023-12-30", "status": "completed"},
        {"step": "Approval", "date": "2024-01-02", "status": "completed"},
        {"step": "Agreement Signing", "date": "2024-01-03", "status": "completed"},
        {"step": "Disbursement", "date": "2024-01-05", "status": "completed"},
      ]
    },
    {
      "applicationId": "LN2024000756",
      "loanType": "Education Loan",
      "amount": 1200000,
      "appliedDate": "2023-12-20",
      "status": "Rejected",
      "statusColor": "danger",
      "nextAction": "Re-apply",
      "tenure": "120 months",
      "interestRate": 0,
      "emi": 0,
      "processingFee": 0,
      "remarks": "Application rejected due to insufficient income documentation. You may re-apply with complete documents.",
      "timeline": [
        {"step": "Application Submitted", "date": "2023-12-20", "status": "completed"},
        {"step": "Document Verification", "date": "2023-12-21", "status": "completed"},
        {"step": "Credit Check", "date": "2023-12-22", "status": "completed"},
        {"step": "Rejection", "date": "2023-12-23", "status": "rejected"},
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredApplications {
    if (searchQuery.isEmpty) {
      if (selectedTab == 0) return loanApplications;
      if (selectedTab == 1) return loanApplications.where((app) => 
          app["status"] == "Under Review" || app["status"] == "Approved").toList();
      if (selectedTab == 2) return loanApplications.where((app) => 
          app["status"] == "Disbursed").toList();
      if (selectedTab == 3) return loanApplications.where((app) => 
          app["status"] == "Rejected").toList();
    }
    
    return loanApplications.where((app) => 
        "${app["applicationId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${app["loanType"]}".toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  Color _getStatusColor(String statusColor) {
    switch (statusColor) {
      case "success": return successColor;
      case "warning": return warningColor;
      case "danger": return dangerColor;
      default: return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh loan status
              ss("Loan status refreshed");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: QTextField(
                          label: "Search by Application ID or Loan Type",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {
                        // Trigger search
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Status Filter Tabs
                QCategoryPicker(
                  items: [
                    {"label": "All", "value": 0},
                    {"label": "Active", "value": 1},
                    {"label": "Disbursed", "value": 2},
                    {"label": "Rejected", "value": 3},
                  ],
                  value: selectedTab,
                  onChanged: (index, label, value, item) {
                    selectedTab = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Application List
          Expanded(
            child: filteredApplications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredApplications.length,
                    itemBuilder: (context, index) {
                      final application = filteredApplications[index];
                      return _buildApplicationCard(application);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to new loan application
          // ss('Next page'));
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> application) {
    final statusColor = _getStatusColor(application["statusColor"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${application["applicationId"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${application["loanType"]}",
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
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${application["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Loan Details
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem(
                        "Amount",
                        "₹${(application["amount"] as int).toDouble().currency}",
                        Icons.account_balance_wallet,
                      ),
                    ),
                    Expanded(
                      child: _buildDetailItem(
                        "Applied Date",
                        "${application["appliedDate"]}",
                        Icons.calendar_today,
                      ),
                    ),
                  ],
                ),
                
                if (application["status"] != "Rejected") ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          "Tenure",
                          "${application["tenure"]}",
                          Icons.schedule,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          "Interest Rate",
                          "${application["interestRate"]}% p.a.",
                          Icons.percent,
                        ),
                      ),
                    ],
                  ),
                ],
                
                SizedBox(height: spMd),
                
                // Remarks
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${application["remarks"]}",
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Timeline",
                    color: disabledBoldColor,
                    size: bs.sm,
                    onPressed: () {
                      _showTimelineDialog(application);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "${application["nextAction"]}",
                    size: bs.sm,
                    onPressed: () {
                      _handleNextAction(application);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 10,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Loan Applications Found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "You haven't applied for any loans yet or no applications match your search criteria.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Apply for Loan",
              size: bs.md,
              onPressed: () {
                // Navigate to loan application
                // ss('Next page'));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTimelineDialog(Map<String, dynamic> application) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Container(
          padding: EdgeInsets.all(spMd),
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Application Timeline",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              Text(
                "${application["applicationId"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              
              // Timeline
              Container(
                constraints: BoxConstraints(maxHeight: 400),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      (application["timeline"] as List).length,
                      (index) {
                        final step = (application["timeline"] as List)[index];
                        final isLast = index == (application["timeline"] as List).length - 1;
                        
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: _getTimelineColor(step["status"]),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _getTimelineIcon(step["status"]),
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                                if (!isLast)
                                  Container(
                                    width: 2,
                                    height: 40,
                                    color: disabledOutlineBorderColor,
                                  ),
                              ],
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: spMd),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${step["step"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${step["date"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTimelineColor(String status) {
    switch (status) {
      case "completed": return successColor;
      case "current": return warningColor;
      case "rejected": return dangerColor;
      default: return disabledColor;
    }
  }

  IconData _getTimelineIcon(String status) {
    switch (status) {
      case "completed": return Icons.check;
      case "current": return Icons.schedule;
      case "rejected": return Icons.close;
      default: return Icons.circle;
    }
  }

  void _handleNextAction(Map<String, dynamic> application) {
    final action = application["nextAction"];
    
    switch (action) {
      case "Accept Offer":
        _showAcceptOfferDialog(application);
        break;
      case "Submit Property Documents":
        ss("Please visit the nearest branch to submit property documents");
        break;
      case "Download Agreement":
        ss("Loan agreement downloaded successfully");
        break;
      case "Re-apply":
        // Navigate to loan application
        // ss('Next page'));
        break;
      default:
        si("Action: $action");
    }
  }

  void _showAcceptOfferDialog(Map<String, dynamic> application) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Loan Offer Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    _buildOfferDetail("Loan Amount", "₹${(application["amount"] as int).toDouble().currency}"),
                    _buildOfferDetail("Interest Rate", "${application["interestRate"]}% p.a."),
                    _buildOfferDetail("Tenure", "${application["tenure"]}"),
                    _buildOfferDetail("Monthly EMI", "₹${(application["emi"] as int).toDouble().currency}"),
                    _buildOfferDetail("Processing Fee", "₹${(application["processingFee"] as int).toDouble().currency}"),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Decline",
                      color: disabledBoldColor,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        sw("Loan offer declined");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Accept",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Loan offer accepted! Disbursement will be processed within 2-3 business days.");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfferDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
