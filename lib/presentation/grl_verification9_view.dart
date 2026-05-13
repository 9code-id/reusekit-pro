import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVerification9View extends StatefulWidget {
  @override
  State<GrlVerification9View> createState() => _GrlVerification9ViewState();
}

class _GrlVerification9ViewState extends State<GrlVerification9View> {
  String selectedTab = "pending";
  
  List<Map<String, dynamic>> verificationRequests = [
    {
      "id": "VER-001",
      "type": "Identity Verification",
      "status": "pending",
      "submittedDate": "2024-06-20",
      "estimatedCompletion": "2024-06-22",
      "progress": 75,
      "documents": ["Driver's License", "Selfie"],
      "notes": "Documents are being reviewed by our verification team.",
    },
    {
      "id": "VER-002",
      "type": "Business Verification",
      "status": "approved",
      "submittedDate": "2024-06-15",
      "completedDate": "2024-06-18",
      "progress": 100,
      "documents": ["Business License", "Tax Certificate", "Bank Statement"],
      "notes": "All documents verified successfully. Account fully activated.",
    },
    {
      "id": "VER-003",
      "type": "Phone Verification",
      "status": "rejected",
      "submittedDate": "2024-06-12",
      "rejectedDate": "2024-06-13",
      "progress": 0,
      "documents": ["Phone Number Verification"],
      "notes": "Phone number could not be verified. Invalid number provided.",
      "rejectionReason": "Invalid phone number format",
    },
    {
      "id": "VER-004",
      "type": "Address Verification",
      "status": "in_review",
      "submittedDate": "2024-06-19",
      "estimatedCompletion": "2024-06-24",
      "progress": 50,
      "documents": ["Utility Bill", "Bank Statement"],
      "notes": "Documents received. Currently under review.",
    },
    {
      "id": "VER-005",
      "type": "Income Verification",
      "status": "approved",
      "submittedDate": "2024-06-10",
      "completedDate": "2024-06-14",
      "progress": 100,
      "documents": ["Pay Stubs", "Tax Returns"],
      "notes": "Income verification completed successfully.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Status refreshed");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Pending",
                    "${_getFilteredRequests('pending').length + _getFilteredRequests('in_review').length}",
                    warningColor,
                    Icons.hourglass_empty,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: _buildSummaryCard(
                    "Approved",
                    "${_getFilteredRequests('approved').length}",
                    successColor,
                    Icons.check_circle,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: _buildSummaryCard(
                    "Rejected",
                    "${_getFilteredRequests('rejected').length}",
                    dangerColor,
                    Icons.cancel,
                  ),
                ),
              ],
            ),
          ),
          
          // Tab Selector
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "pending";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        color: selectedTab == "pending" ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Pending",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: selectedTab == "pending" ? primaryColor : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "completed";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        color: selectedTab == "completed" ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: selectedTab == "completed" ? primaryColor : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: _getDisplayedRequests().map((request) => _buildVerificationCard(request)).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(NewVerificationView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: color.withAlpha(60),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            count,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCard(Map<String, dynamic> request) {
    Color statusColor = _getStatusColor(request["status"]);
    IconData statusIcon = _getStatusIcon(request["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    statusIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${request["type"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "ID: ${request["id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    _getStatusText(request["status"]),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Bar (if applicable)
                if (request["status"] == "pending" || request["status"] == "in_review") ...[
                  Row(
                    children: [
                      Text(
                        "Progress:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (request["progress"] as int) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "${request["progress"]}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                ],
                
                // Dates
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Submitted: ${request["submittedDate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                if (request["estimatedCompletion"] != null) ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: warningColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Expected: ${request["estimatedCompletion"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
                
                if (request["completedDate"] != null) ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Completed: ${request["completedDate"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
                
                if (request["rejectedDate"] != null) ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.cancel,
                        size: 16,
                        color: dangerColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Rejected: ${request["rejectedDate"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
                
                SizedBox(height: spMd),
                
                // Documents
                Text(
                  "Documents:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: (request["documents"] as List).map((doc) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$doc",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  )).toList(),
                ),
                
                SizedBox(height: spMd),
                
                // Notes
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notes:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${request["notes"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      // Rejection Reason
                      if (request["rejectionReason"] != null) ...[
                        SizedBox(height: spMd),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: dangerColor.withAlpha(60),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error,
                                color: dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Reason: ${request["rejectionReason"]}",
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
                      ],
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Action Buttons
                Row(
                  children: [
                    if (request["status"] == "rejected")
                      Expanded(
                        child: QButton(
                          label: "Resubmit",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(ResubmitVerificationView(requestId: request["id"]));
                          },
                        ),
                      ),
                    if (request["status"] == "pending" || request["status"] == "in_review") ...[
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(VerificationDetailsView(requestId: request["id"]));
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("Are you sure you want to cancel this verification request?");
                            if (isConfirmed) {
                              ss("Verification request canceled");
                            }
                          },
                        ),
                      ),
                    ],
                    if (request["status"] == "approved")
                      Expanded(
                        child: QButton(
                          label: "View Certificate",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(VerificationCertificateView(requestId: request["id"]));
                          },
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

  List<Map<String, dynamic>> _getFilteredRequests(String status) {
    return verificationRequests.where((req) => req["status"] == status).toList();
  }

  List<Map<String, dynamic>> _getDisplayedRequests() {
    if (selectedTab == "pending") {
      return verificationRequests.where((req) => 
        req["status"] == "pending" || req["status"] == "in_review"
      ).toList();
    } else {
      return verificationRequests.where((req) => 
        req["status"] == "approved" || req["status"] == "rejected"
      ).toList();
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
      case "in_review":
        return warningColor;
      case "approved":
        return successColor;
      case "rejected":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "pending":
        return Icons.hourglass_empty;
      case "in_review":
        return Icons.search;
      case "approved":
        return Icons.check_circle;
      case "rejected":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "pending":
        return "PENDING";
      case "in_review":
        return "IN REVIEW";
      case "approved":
        return "APPROVED";
      case "rejected":
        return "REJECTED";
      default:
        return "UNKNOWN";
    }
  }
}
