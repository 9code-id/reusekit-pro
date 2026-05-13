import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaLoanStatusView extends StatefulWidget {
  const ReaLoanStatusView({super.key});

  @override
  State<ReaLoanStatusView> createState() => _ReaLoanStatusViewState();
}

class _ReaLoanStatusViewState extends State<ReaLoanStatusView> {
  String selectedFilter = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Applications", "value": "All"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Under Review", "value": "Under Review"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> loanApplications = [
    {
      "id": "LA-2024-001",
      "propertyAddress": "123 Oak Street, Beverly Hills, CA",
      "loanAmount": 850000,
      "loanType": "Conventional",
      "lender": "First National Bank",
      "status": "Under Review",
      "currentStep": 3,
      "totalSteps": 6,
      "applicationDate": "2024-01-15",
      "expectedClosing": "2024-03-15",
      "daysRemaining": 45,
      "interestRate": 3.75,
      "monthlyPayment": 3934,
      "documents": [
        {"name": "Pre-approval Letter", "status": "Completed", "date": "2024-01-16"},
        {"name": "Income Verification", "status": "Completed", "date": "2024-01-20"},
        {"name": "Property Appraisal", "status": "In Progress", "date": ""},
        {"name": "Home Inspection", "status": "Pending", "date": ""},
        {"name": "Title Search", "status": "Pending", "date": ""},
        {"name": "Final Approval", "status": "Pending", "date": ""}
      ],
      "loanOfficer": {
        "name": "Sarah Johnson",
        "phone": "(555) 123-4567",
        "email": "sarah.johnson@firstnational.com"
      },
      "nextAction": "Schedule property appraisal",
      "priority": "Medium"
    },
    {
      "id": "LA-2024-002",
      "propertyAddress": "456 Pine Avenue, Santa Monica, CA",
      "loanAmount": 1250000,
      "loanType": "Jumbo",
      "lender": "Premier Mortgage Corp",
      "status": "Approved",
      "currentStep": 6,
      "totalSteps": 6,
      "applicationDate": "2024-02-01",
      "expectedClosing": "2024-03-25",
      "daysRemaining": 55,
      "interestRate": 3.95,
      "monthlyPayment": 5919,
      "documents": [
        {"name": "Pre-approval Letter", "status": "Completed", "date": "2024-02-02"},
        {"name": "Income Verification", "status": "Completed", "date": "2024-02-05"},
        {"name": "Property Appraisal", "status": "Completed", "date": "2024-02-15"},
        {"name": "Home Inspection", "status": "Completed", "date": "2024-02-18"},
        {"name": "Title Search", "status": "Completed", "date": "2024-02-22"},
        {"name": "Final Approval", "status": "Completed", "date": "2024-02-25"}
      ],
      "loanOfficer": {
        "name": "Michael Chen",
        "phone": "(555) 234-5678",
        "email": "michael.chen@premiermortgage.com"
      },
      "nextAction": "Prepare for closing",
      "priority": "High"
    },
    {
      "id": "LA-2024-003",
      "propertyAddress": "789 Maple Drive, Pasadena, CA",
      "loanAmount": 450000,
      "loanType": "FHA",
      "lender": "Community Credit Union",
      "status": "In Progress",
      "currentStep": 2,
      "totalSteps": 6,
      "applicationDate": "2024-02-10",
      "expectedClosing": "2024-04-10",
      "daysRemaining": 70,
      "interestRate": 4.15,
      "monthlyPayment": 2177,
      "documents": [
        {"name": "Pre-approval Letter", "status": "Completed", "date": "2024-02-11"},
        {"name": "Income Verification", "status": "In Progress", "date": ""},
        {"name": "Property Appraisal", "status": "Pending", "date": ""},
        {"name": "Home Inspection", "status": "Pending", "date": ""},
        {"name": "Title Search", "status": "Pending", "date": ""},
        {"name": "Final Approval", "status": "Pending", "date": ""}
      ],
      "loanOfficer": {
        "name": "Lisa Wang",
        "phone": "(555) 345-6789",
        "email": "lisa.wang@communitycu.com"
      },
      "nextAction": "Submit additional income documents",
      "priority": "Medium"
    },
    {
      "id": "LA-2023-045",
      "propertyAddress": "321 Cedar Lane, Burbank, CA",
      "loanAmount": 675000,
      "loanType": "VA",
      "lender": "Veterans First Lending",
      "status": "Closed",
      "currentStep": 6,
      "totalSteps": 6,
      "applicationDate": "2023-11-15",
      "expectedClosing": "2024-01-15",
      "daysRemaining": 0,
      "interestRate": 3.65,
      "monthlyPayment": 3086,
      "documents": [
        {"name": "Pre-approval Letter", "status": "Completed", "date": "2023-11-16"},
        {"name": "Income Verification", "status": "Completed", "date": "2023-11-20"},
        {"name": "Property Appraisal", "status": "Completed", "date": "2023-12-05"},
        {"name": "Home Inspection", "status": "Completed", "date": "2023-12-08"},
        {"name": "Title Search", "status": "Completed", "date": "2023-12-15"},
        {"name": "Final Approval", "status": "Completed", "date": "2024-01-10"}
      ],
      "loanOfficer": {
        "name": "Robert Martinez",
        "phone": "(555) 456-7890",
        "email": "robert.martinez@veteransfirst.com"
      },
      "nextAction": "Loan completed successfully",
      "priority": "Low"
    }
  ];

  List<Map<String, dynamic>> get filteredApplications {
    return loanApplications.where((app) {
      bool matchesSearch = "${app["propertyAddress"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${app["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFilter = selectedFilter == "All" || app["status"] == selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search applications...",
            value: searchQuery,
            hint: "Enter loan ID or property address",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Filter by Status",
            items: statusFilters,
            value: selectedFilter,
            onChanged: (value, label) {
              selectedFilter = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOverview() {
    final inProgressCount = loanApplications.where((app) => app["status"] == "In Progress").length;
    final underReviewCount = loanApplications.where((app) => app["status"] == "Under Review").length;
    final approvedCount = loanApplications.where((app) => app["status"] == "Approved").length;
    final closedCount = loanApplications.where((app) => app["status"] == "Closed").length;

    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Loan Status Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatusCard("In Progress", inProgressCount, warningColor, Icons.hourglass_empty),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatusCard("Under Review", underReviewCount, infoColor, Icons.rate_review),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatusCard("Approved", approvedCount, successColor, Icons.check_circle),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatusCard("Closed", closedCount, primaryColor, Icons.home),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
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
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> application) {
    final statusColor = _getStatusColor(application["status"]);
    final progressPercentage = ((application["currentStep"] as int) / (application["totalSteps"] as int) * 100).round();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [statusColor.withAlpha(25), Colors.white],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
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
                            "Loan ID: ${application["id"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${application["propertyAddress"]}",
                            style: TextStyle(
                              fontSize: fsH6,
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
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${application["status"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progress: Step ${application["currentStep"]} of ${application["totalSteps"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "$progressPercentage%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progressPercentage / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                // Loan Details
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailItem("Loan Amount", "\$${((application["loanAmount"] as int) / 1000).toInt()}K"),
                          ),
                          Expanded(
                            child: _buildDetailItem("Loan Type", "${application["loanType"]}"),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailItem("Interest Rate", "${application["interestRate"]}%"),
                          ),
                          Expanded(
                            child: _buildDetailItem("Monthly Payment", "\$${application["monthlyPayment"]}"),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailItem("Lender", "${application["lender"]}"),
                          ),
                          Expanded(
                            child: _buildDetailItem("Expected Closing", "${application["expectedClosing"]}"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Next Action
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(12),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.assignment, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Next Action",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${application["nextAction"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (application["daysRemaining"] > 0) ...[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(application["priority"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${application["daysRemaining"]} days",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Loan Officer Contact
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loan Officer",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${application["loanOfficer"]["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${application["loanOfficer"]["phone"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.phone, color: primaryColor),
                        onPressed: () => _contactLoanOfficer(application),
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        icon: Icons.info,
                        size: bs.sm,
                        onPressed: () => _viewApplicationDetails(application),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Documents",
                        icon: Icons.folder,
                        size: bs.sm,
                        onPressed: () => _viewDocuments(application),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Updates",
                        icon: Icons.notifications,
                        size: bs.sm,
                        onPressed: () => _viewUpdates(application),
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

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return warningColor;
      case "Under Review":
        return infoColor;
      case "Approved":
        return successColor;
      case "Rejected":
        return dangerColor;
      case "Closed":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return infoColor;
    }
  }

  void _contactLoanOfficer(Map<String, dynamic> application) {
    final loanOfficer = application["loanOfficer"];
    si("Calling ${loanOfficer["name"]} at ${loanOfficer["phone"]}");
  }

  void _viewApplicationDetails(Map<String, dynamic> application) {
    // Navigate to detailed application view
    si("Viewing details for ${application["id"]}");
  }

  void _viewDocuments(Map<String, dynamic> application) {
    // Navigate to documents view
    si("Viewing documents for ${application["id"]}");
  }

  void _viewUpdates(Map<String, dynamic> application) {
    // Navigate to updates view
    si("Viewing updates for ${application["id"]}");
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
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildStatusOverview(),
          Expanded(
            child: filteredApplications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No loan applications found",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search or filter criteria",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: spMd),
                    itemCount: filteredApplications.length,
                    itemBuilder: (context, index) {
                      return _buildApplicationCard(filteredApplications[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
