import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaTenantScreeningView extends StatefulWidget {
  const ReaTenantScreeningView({super.key});

  @override
  State<ReaTenantScreeningView> createState() => _ReaTenantScreeningViewState();
}

class _ReaTenantScreeningViewState extends State<ReaTenantScreeningView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedProperty = "All";
  String sortBy = "Latest";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Pending Review", "value": "Pending"},
    {"label": "Under Verification", "value": "Verification"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "Withdrawn", "value": "Withdrawn"},
  ];

  List<Map<String, dynamic>> propertyOptions = [
    {"label": "All Properties", "value": "All"},
    {"label": "Skyline Apartments", "value": "Skyline"},
    {"label": "Garden View Condos", "value": "Garden"},
    {"label": "Downtown Lofts", "value": "Downtown"},
    {"label": "Riverside Towers", "value": "Riverside"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Latest Applications", "value": "Latest"},
    {"label": "Oldest Applications", "value": "Oldest"},
    {"label": "By Score (High to Low)", "value": "Score_High"},
    {"label": "By Score (Low to High)", "value": "Score_Low"},
    {"label": "By Property", "value": "Property"},
  ];

  List<Map<String, dynamic>> screeningApplications = [
    {
      "id": "APP001",
      "applicantName": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1-555-0123",
      "property": "Skyline Apartments",
      "unit": "Unit 4B",
      "applicationDate": "2024-01-15",
      "status": "Approved",
      "creditScore": 785,
      "monthlyIncome": 8500.0,
      "employmentStatus": "Full-time",
      "employer": "Tech Solutions Inc.",
      "yearsEmployed": 3.5,
      "previousRental": true,
      "petOwner": false,
      "emergencyContact": "Mike Johnson",
      "emergencyPhone": "+1-555-0124",
      "documents": ["ID Copy", "Pay Stubs", "Bank Statements", "Employment Letter"],
      "verificationStatus": "Complete",
      "backgroundCheck": "Clear",
      "referenceCheck": "Positive",
      "rentToIncomeRatio": 0.24,
      "score": 92,
      "notes": "Excellent credit history and stable employment. Highly recommended.",
      "profileImage": "https://picsum.photos/100/100?random=1&keyword=woman",
    },
    {
      "id": "APP002",
      "applicantName": "Michael Chen",
      "email": "michael.chen@email.com",
      "phone": "+1-555-0234",
      "property": "Garden View Condos",
      "unit": "Unit 2A",
      "applicationDate": "2024-01-14",
      "status": "Pending",
      "creditScore": 720,
      "monthlyIncome": 6200.0,
      "employmentStatus": "Full-time",
      "employer": "Marketing Agency LLC",
      "yearsEmployed": 2.0,
      "previousRental": true,
      "petOwner": true,
      "emergencyContact": "Lisa Chen",
      "emergencyPhone": "+1-555-0235",
      "documents": ["ID Copy", "Pay Stubs", "Bank Statements"],
      "verificationStatus": "In Progress",
      "backgroundCheck": "Pending",
      "referenceCheck": "Pending",
      "rentToIncomeRatio": 0.29,
      "score": 78,
      "notes": "Good credit score, awaiting employment verification.",
      "profileImage": "https://picsum.photos/100/100?random=2&keyword=man",
    },
    {
      "id": "APP003",
      "applicantName": "Emily Rodriguez",
      "email": "emily.rodriguez@email.com",
      "phone": "+1-555-0345",
      "property": "Downtown Lofts",
      "unit": "Loft 12",
      "applicationDate": "2024-01-13",
      "status": "Verification",
      "creditScore": 690,
      "monthlyIncome": 5800.0,
      "employmentStatus": "Contract",
      "employer": "Design Studio Pro",
      "yearsEmployed": 1.5,
      "previousRental": false,
      "petOwner": false,
      "emergencyContact": "Carlos Rodriguez",
      "emergencyPhone": "+1-555-0346",
      "documents": ["ID Copy", "Contract Agreement", "Bank Statements"],
      "verificationStatus": "In Progress",
      "backgroundCheck": "Clear",
      "referenceCheck": "In Progress",
      "rentToIncomeRatio": 0.31,
      "score": 74,
      "notes": "First-time renter, contract employment needs verification.",
      "profileImage": "https://picsum.photos/100/100?random=3&keyword=woman",
    },
    {
      "id": "APP004",
      "applicantName": "David Kim",
      "email": "david.kim@email.com",
      "phone": "+1-555-0456",
      "property": "Riverside Towers",
      "unit": "Unit 8C",
      "applicationDate": "2024-01-12",
      "status": "Rejected",
      "creditScore": 580,
      "monthlyIncome": 4200.0,
      "employmentStatus": "Part-time",
      "employer": "Retail Store Chain",
      "yearsEmployed": 0.8,
      "previousRental": true,
      "petOwner": true,
      "emergencyContact": "Susan Kim",
      "emergencyPhone": "+1-555-0457",
      "documents": ["ID Copy", "Pay Stubs"],
      "verificationStatus": "Complete",
      "backgroundCheck": "Issues Found",
      "referenceCheck": "Negative",
      "rentToIncomeRatio": 0.43,
      "score": 45,
      "notes": "Credit score below threshold, high rent-to-income ratio.",
      "profileImage": "https://picsum.photos/100/100?random=4&keyword=man",
    },
    {
      "id": "APP005",
      "applicantName": "Jessica Wong",
      "email": "jessica.wong@email.com",
      "phone": "+1-555-0567",
      "property": "Skyline Apartments",
      "unit": "Unit 7A",
      "applicationDate": "2024-01-11",
      "status": "Withdrawn",
      "creditScore": 750,
      "monthlyIncome": 7200.0,
      "employmentStatus": "Full-time",
      "employer": "Financial Services Corp",
      "yearsEmployed": 4.0,
      "previousRental": true,
      "petOwner": false,
      "emergencyContact": "Robert Wong",
      "emergencyPhone": "+1-555-0568",
      "documents": ["ID Copy", "Pay Stubs", "Bank Statements"],
      "verificationStatus": "Complete",
      "backgroundCheck": "Clear",
      "referenceCheck": "Positive",
      "rentToIncomeRatio": 0.25,
      "score": 88,
      "notes": "Applicant found alternative housing arrangement.",
      "profileImage": "https://picsum.photos/100/100?random=5&keyword=woman",
    },
  ];

  List<Map<String, dynamic>> get filteredApplications {
    List<Map<String, dynamic>> filtered = List.from(screeningApplications);

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((app) {
        final name = (app["applicantName"] as String).toLowerCase();
        final email = (app["email"] as String).toLowerCase();
        final property = (app["property"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        return name.contains(query) || email.contains(query) || property.contains(query);
      }).toList();
    }

    if (selectedStatus != "All") {
      filtered = filtered.where((app) => app["status"] == selectedStatus).toList();
    }

    if (selectedProperty != "All") {
      filtered = filtered.where((app) => (app["property"] as String).contains(selectedProperty)).toList();
    }

    // Sort applications
    switch (sortBy) {
      case "Latest":
        filtered.sort((a, b) => DateTime.parse(b["applicationDate"]).compareTo(DateTime.parse(a["applicationDate"])));
        break;
      case "Oldest":
        filtered.sort((a, b) => DateTime.parse(a["applicationDate"]).compareTo(DateTime.parse(b["applicationDate"])));
        break;
      case "Score_High":
        filtered.sort((a, b) => (b["score"] as int).compareTo(a["score"] as int));
        break;
      case "Score_Low":
        filtered.sort((a, b) => (a["score"] as int).compareTo(b["score"] as int));
        break;
      case "Property":
        filtered.sort((a, b) => (a["property"] as String).compareTo(b["property"] as String));
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Rejected":
        return dangerColor;
      case "Pending":
        return warningColor;
      case "Verification":
        return infoColor;
      case "Withdrawn":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Approved":
        return Icons.check_circle;
      case "Rejected":
        return Icons.cancel;
      case "Pending":
        return Icons.schedule;
      case "Verification":
        return Icons.verified_user;
      case "Withdrawn":
        return Icons.remove_circle;
      default:
        return Icons.help;
    }
  }

  void _viewApplicationDetails(Map<String, dynamic> application) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          padding: EdgeInsets.all(spLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      image: DecorationImage(
                        image: NetworkImage("${application["profileImage"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${application["applicantName"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${application["email"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(application["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(application["status"]),
                          size: 16,
                          color: _getStatusColor(application["status"]),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${application["status"]}",
                          style: TextStyle(
                            color: _getStatusColor(application["status"]),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spLg),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailSection("Property Information", [
                        _buildDetailRow("Property", "${application["property"]}"),
                        _buildDetailRow("Unit", "${application["unit"]}"),
                        _buildDetailRow("Application Date", "${DateTime.parse(application["applicationDate"]).dMMMy}"),
                      ]),
                      SizedBox(height: spLg),
                      _buildDetailSection("Financial Information", [
                        _buildDetailRow("Monthly Income", "\$${(application["monthlyIncome"] as double).currency}"),
                        _buildDetailRow("Credit Score", "${application["creditScore"]}"),
                        _buildDetailRow("Rent-to-Income Ratio", "${((application["rentToIncomeRatio"] as double) * 100).toStringAsFixed(1)}%"),
                        _buildDetailRow("Overall Score", "${application["score"]}/100"),
                      ]),
                      SizedBox(height: spLg),
                      _buildDetailSection("Employment Information", [
                        _buildDetailRow("Status", "${application["employmentStatus"]}"),
                        _buildDetailRow("Employer", "${application["employer"]}"),
                        _buildDetailRow("Years Employed", "${application["yearsEmployed"]} years"),
                      ]),
                      SizedBox(height: spLg),
                      _buildDetailSection("Personal Information", [
                        _buildDetailRow("Phone", "${application["phone"]}"),
                        _buildDetailRow("Previous Rental", application["previousRental"] ? "Yes" : "No"),
                        _buildDetailRow("Pet Owner", application["petOwner"] ? "Yes" : "No"),
                        _buildDetailRow("Emergency Contact", "${application["emergencyContact"]}"),
                        _buildDetailRow("Emergency Phone", "${application["emergencyPhone"]}"),
                      ]),
                      SizedBox(height: spLg),
                      _buildDetailSection("Verification Status", [
                        _buildDetailRow("Documents", "${application["verificationStatus"]}"),
                        _buildDetailRow("Background Check", "${application["backgroundCheck"]}"),
                        _buildDetailRow("Reference Check", "${application["referenceCheck"]}"),
                      ]),
                      if ((application["documents"] as List).isNotEmpty) ...[
                        SizedBox(height: spLg),
                        _buildDetailSection("Submitted Documents", [
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (application["documents"] as List).map((doc) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$doc",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ]),
                      ],
                      if ((application["notes"] as String).isNotEmpty) ...[
                        SizedBox(height: spLg),
                        _buildDetailSection("Notes", [
                          Text(
                            "${application["notes"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ]),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: spLg),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Close",
                      size: bs.sm,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  if (application["status"] == "Pending") ...[
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Approve",
                        size: bs.sm,
                        onPressed: () => _updateApplicationStatus(application, "Approved"),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Reject",
                        size: bs.sm,
                        onPressed: () => _updateApplicationStatus(application, "Rejected"),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateApplicationStatus(Map<String, dynamic> application, String newStatus) async {
    Navigator.pop(context);
    
    bool isConfirmed = await confirm("Are you sure you want to $newStatus this application?");
    if (isConfirmed) {
      setState(() {
        application["status"] = newStatus;
      });
      
      if (newStatus == "Approved") {
        ss("Application approved successfully");
      } else {
        si("Application status updated to $newStatus");
      }
    }
  }

  void _addNewApplication() {
    // Navigate to new application form
    si("Navigate to New Application Form");
  }

  void _exportApplications() {
    si("Exporting applications data...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tenant Screening"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportApplications,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewApplication,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter Applications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Search Applications",
                    value: searchQuery,
                    hint: "Search by name, email, or property",
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
                          label: "Property",
                          items: propertyOptions,
                          value: selectedProperty,
                          onChanged: (value, label) {
                            selectedProperty = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.pending_actions,
                          size: 32,
                          color: warningColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${screeningApplications.where((app) => app["status"] == "Pending").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 32,
                          color: successColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${screeningApplications.where((app) => app["status"] == "Approved").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Approved",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.verified_user,
                          size: 32,
                          color: infoColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${screeningApplications.where((app) => app["status"] == "Verification").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Verifying",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Applications List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Applications (${filteredApplications.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Showing ${filteredApplications.length} of ${screeningApplications.length}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredApplications.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final application = filteredApplications[index];
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusMd),
                                image: DecorationImage(
                                  image: NetworkImage("${application["profileImage"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${application["applicantName"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(application["status"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${application["status"]}",
                                          style: TextStyle(
                                            color: _getStatusColor(application["status"]),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${application["property"]} - ${application["unit"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Score: ${application["score"]}/100",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.monetization_on,
                                        size: 16,
                                        color: successColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "\$${(application["monthlyIncome"] as double).currency}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${DateTime.parse(application["applicationDate"]).dMMMy}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.visibility,
                              size: bs.sm,
                              onPressed: () => _viewApplicationDetails(application),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Bulk Approve",
                          icon: Icons.done_all,
                          size: bs.sm,
                          onPressed: () {
                            si("Bulk approve feature");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Send Reminder",
                          icon: Icons.email,
                          size: bs.sm,
                          onPressed: () {
                            si("Send reminder emails");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          icon: Icons.assessment,
                          size: bs.sm,
                          onPressed: () {
                            si("Generate screening report");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Settings",
                          icon: Icons.settings,
                          size: bs.sm,
                          onPressed: () {
                            si("Open screening settings");
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
      ),
    );
  }
}
