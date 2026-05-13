import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaClaimsManagementView extends StatefulWidget {
  const AmaClaimsManagementView({super.key});

  @override
  State<AmaClaimsManagementView> createState() => _AmaClaimsManagementViewState();
}

class _AmaClaimsManagementViewState extends State<AmaClaimsManagementView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedClaimType = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Claims", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Submitted", "value": "submitted"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Paid", "value": "paid"},
  ];

  List<Map<String, dynamic>> claimTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Weather Damage", "value": "weather"},
    {"label": "Pest Damage", "value": "pest"},
    {"label": "Disease", "value": "disease"},
    {"label": "Fire", "value": "fire"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> claimsList = [
    {
      "claimId": "CLM2024001",
      "policyNumber": "POL001",
      "cropType": "Corn",
      "claimType": "weather",
      "cause": "Drought",
      "submissionDate": "2024-07-15",
      "assessmentDate": "2024-07-20",
      "status": "approved",
      "claimAmount": 12000.0,
      "approvedAmount": 10800.0,
      "acres": 25,
      "description": "Severe drought conditions resulted in 40% crop loss",
      "adjuster": "John Smith",
      "documents": ["field_photos.pdf", "yield_reports.pdf", "weather_data.pdf"],
      "paymentDate": "2024-08-01",
    },
    {
      "claimId": "CLM2024002",
      "policyNumber": "POL002",
      "cropType": "Wheat",
      "claimType": "weather",
      "cause": "Hail",
      "submissionDate": "2024-06-10",
      "assessmentDate": "2024-06-15",
      "status": "under_review",
      "claimAmount": 8500.0,
      "approvedAmount": 0.0,
      "acres": 15,
      "description": "Hail storm caused significant damage to wheat crop",
      "adjuster": "Sarah Johnson",
      "documents": ["hail_damage_photos.pdf", "meteorological_report.pdf"],
      "paymentDate": "",
    },
    {
      "claimId": "CLM2024003",
      "policyNumber": "POL003",
      "cropType": "Soybeans",
      "claimType": "pest",
      "cause": "Aphid Infestation",
      "submissionDate": "2024-08-05",
      "assessmentDate": "",
      "status": "submitted",
      "claimAmount": 6500.0,
      "approvedAmount": 0.0,
      "acres": 20,
      "description": "Severe aphid infestation led to 30% yield reduction",
      "adjuster": "",
      "documents": ["pest_inspection_report.pdf", "treatment_records.pdf"],
      "paymentDate": "",
    },
    {
      "claimId": "CLM2024004",
      "policyNumber": "POL001",
      "cropType": "Rice",
      "claimType": "disease",
      "cause": "Blast Disease",
      "submissionDate": "2024-05-20",
      "assessmentDate": "2024-05-25",
      "status": "rejected",
      "claimAmount": 9500.0,
      "approvedAmount": 0.0,
      "acres": 18,
      "description": "Rice blast disease outbreak",
      "adjuster": "Michael Davis",
      "documents": ["disease_analysis.pdf", "treatment_history.pdf"],
      "paymentDate": "",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "date": "2024-08-15",
      "activity": "Claim CLM2024001 payment processed",
      "type": "payment",
      "amount": 10800.0,
    },
    {
      "date": "2024-08-10",
      "activity": "New document uploaded for CLM2024002",
      "type": "document",
      "amount": 0.0,
    },
    {
      "date": "2024-08-05",
      "activity": "Claim CLM2024003 submitted for review",
      "type": "submission",
      "amount": 6500.0,
    },
    {
      "date": "2024-08-01",
      "activity": "Field assessment completed for CLM2024002",
      "type": "assessment",
      "amount": 0.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Claims Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "All Claims", icon: Icon(Icons.list)),
        Tab(text: "Active Claims", icon: Icon(Icons.pending_actions)),
        Tab(text: "New Claim", icon: Icon(Icons.add_circle)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildAllClaimsTab(),
        _buildActiveClaimsTab(),
        _buildNewClaimTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildAllClaimsTab() {
    List<Map<String, dynamic>> filteredClaims = claimsList.where((claim) {
      bool statusMatch = selectedStatus == "all" || claim["status"] == selectedStatus;
      bool typeMatch = selectedClaimType == "all" || claim["claimType"] == selectedClaimType;
      bool searchMatch = searchQuery.isEmpty || 
          claim["claimId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          claim["cropType"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return statusMatch && typeMatch && searchMatch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  "Total Claims",
                  "${claimsList.length}",
                  primaryColor,
                  Icons.assignment,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Approved",
                  "${claimsList.where((c) => c["status"] == "approved" || c["status"] == "paid").length}",
                  successColor,
                  Icons.check_circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Total Paid",
                  "\$${claimsList.where((c) => c["status"] == "paid").fold(0.0, (sum, c) => sum + (c["approvedAmount"] as double)).toStringAsFixed(0)}",
                  infoColor,
                  Icons.payment,
                ),
              ),
            ],
          ),

          // Filters
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
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search Claims",
                        value: searchQuery,
                        hint: "Search by ID, crop type...",
                        onChanged: (value) {
                          searchQuery = value;
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
                        label: "Claim Type",
                        items: claimTypeOptions,
                        value: selectedClaimType,
                        onChanged: (value, label) {
                          selectedClaimType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Claims List
          ...filteredClaims.map((claim) {
            Color statusColor = _getStatusColor(claim["status"]);
            return Container(
              padding: EdgeInsets.all(spSm),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Claim #${claim["claimId"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${claim["cropType"]} - ${claim["cause"]}",
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
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${claim["status"]}".replaceAll("_", " ").toUpperCase(),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${claim["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Submission Date:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${claim["submissionDate"]}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Claim Amount:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "\$${(claim["claimAmount"] as double).toStringAsFixed(0)}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        if (claim["approvedAmount"] > 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Approved Amount:", style: TextStyle(color: disabledBoldColor)),
                              Text(
                                "\$${(claim["approvedAmount"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Affected Acres:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${claim["acres"]} acres",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            _showClaimDetails(claim);
                          },
                        ),
                      ),
                      if (claim["status"] == "draft" || claim["status"] == "submitted") ...[
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Update",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to update claim
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildActiveClaimsTab() {
    List<Map<String, dynamic>> activeClaims = claimsList.where((claim) => 
        claim["status"] != "paid" && claim["status"] != "rejected").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Recent Activities
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...recentActivities.take(5).map((activity) {
                  IconData activityIcon;
                  Color activityColor;
                  
                  switch (activity["type"]) {
                    case "payment":
                      activityIcon = Icons.payment;
                      activityColor = successColor;
                      break;
                    case "document":
                      activityIcon = Icons.description;
                      activityColor = infoColor;
                      break;
                    case "submission":
                      activityIcon = Icons.send;
                      activityColor = warningColor;
                      break;
                    case "assessment":
                      activityIcon = Icons.assignment;
                      activityColor = primaryColor;
                      break;
                    default:
                      activityIcon = Icons.info;
                      activityColor = disabledBoldColor;
                  }

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: activityColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          activityIcon,
                          color: activityColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["activity"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${activity["date"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (activity["amount"] > 0)
                          Text(
                            "\$${(activity["amount"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: activityColor,
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Active Claims
          ...activeClaims.map((claim) {
            Color statusColor = _getStatusColor(claim["status"]);
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: statusColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Claim #${claim["claimId"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${claim["status"]}".replaceAll("_", " ").toUpperCase(),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildClaimProgressIndicator(claim["status"]),
                  Text(
                    "${claim["cropType"]} - ${claim["cause"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount: \$${(claim["claimAmount"] as double).toStringAsFixed(0)}"),
                      QButton(
                        label: "Track Progress",
                        size: bs.sm,
                        onPressed: () {
                          _showClaimDetails(claim);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildNewClaimTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "File a new insurance claim by providing details about the damage or loss to your crops.",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
          ),

          // Claim Type Selection
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Select Claim Type",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QCategoryPicker(
                  items: [
                    {"label": "Weather Damage", "value": "weather"},
                    {"label": "Pest Damage", "value": "pest"},
                    {"label": "Disease", "value": "disease"},
                    {"label": "Fire", "value": "fire"},
                    {"label": "Other", "value": "other"},
                  ],
                  value: "weather",
                  onChanged: (index, label, value, item) {},
                ),
              ],
            ),
          ),

          // Quick File Options
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Start Full Claim",
                        icon: Icons.assignment,
                        onPressed: () {
                          // Navigate to full claim form
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Emergency Report",
                        icon: Icons.emergency,
                        onPressed: () {
                          // Navigate to emergency claim
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Required Documents Checklist
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Required Documents",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildDocumentItem("Field damage photos", true),
                _buildDocumentItem("Weather reports (if applicable)", false),
                _buildDocumentItem("Yield records", false),
                _buildDocumentItem("Treatment records", false),
                _buildDocumentItem("Professional assessment", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    double totalClaimsValue = claimsList.fold(0.0, (sum, claim) => sum + (claim["claimAmount"] as double));
    double totalPaidValue = claimsList.where((c) => c["status"] == "paid").fold(0.0, (sum, claim) => sum + (claim["approvedAmount"] as double));
    double approvalRate = claimsList.where((c) => c["status"] == "approved" || c["status"] == "paid").length / claimsList.length * 100;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Key Metrics
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  "Total Claims Value",
                  "\$${totalClaimsValue.toStringAsFixed(0)}",
                  primaryColor,
                  Icons.attach_money,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Total Paid",
                  "\$${totalPaidValue.toStringAsFixed(0)}",
                  successColor,
                  Icons.payment,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  "Approval Rate",
                  "${approvalRate.toStringAsFixed(1)}%",
                  infoColor,
                  Icons.check_circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Avg. Claim Size",
                  "\$${(totalClaimsValue / claimsList.length).toStringAsFixed(0)}",
                  warningColor,
                  Icons.calculate,
                ),
              ),
            ],
          ),

          // Claims by Type Chart Placeholder
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Claims Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Text(
                      "Claims distribution chart will be displayed here",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String title, bool isRequired) {
    return Row(
      children: [
        Icon(
          isRequired ? Icons.warning : Icons.check_circle_outline,
          color: isRequired ? warningColor : successColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
        ),
        if (isRequired)
          Text(
            "Required",
            style: TextStyle(
              color: warningColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildClaimProgressIndicator(String status) {
    List<String> steps = ["submitted", "under_review", "approved", "paid"];
    int currentStep = steps.indexOf(status);
    if (currentStep == -1) currentStep = 0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: steps.asMap().entries.map((entry) {
          int index = entry.key;
          bool isActive = index <= currentStep;
          bool isCurrent = index == currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isActive ? successColor : disabledColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCurrent ? successColor : disabledColor,
                      width: isCurrent ? 2 : 1,
                    ),
                  ),
                  child: isActive
                      ? Icon(Icons.check, size: 12, color: Colors.white)
                      : null,
                ),
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.symmetric(horizontal: spXs),
                      color: isActive ? successColor : disabledColor,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "draft":
        return disabledBoldColor;
      case "submitted":
        return infoColor;
      case "under_review":
        return warningColor;
      case "approved":
        return successColor;
      case "rejected":
        return dangerColor;
      case "paid":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showClaimDetails(Map<String, dynamic> claim) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Claim #${claim["claimId"]}"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text("Crop: ${claim["cropType"]}"),
                Text("Cause: ${claim["cause"]}"),
                Text("Status: ${claim["status"]}"),
                Text("Amount: \$${(claim["claimAmount"] as double).toStringAsFixed(0)}"),
                if (claim["adjuster"].isNotEmpty)
                  Text("Adjuster: ${claim["adjuster"]}"),
                Text("Description: ${claim["description"]}"),
                if ((claim["documents"] as List).isNotEmpty) ...[
                  Text("Documents:"),
                  ...(claim["documents"] as List<String>).map((doc) => 
                    Text("• $doc", style: TextStyle(fontSize: 12))),
                ],
              ],
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
