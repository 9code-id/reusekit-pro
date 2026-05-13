import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaTenantScreeningView extends StatefulWidget {
  const RmaTenantScreeningView({super.key});

  @override
  State<RmaTenantScreeningView> createState() => _RmaTenantScreeningViewState();
}

class _RmaTenantScreeningViewState extends State<RmaTenantScreeningView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedScore = "";

  List<Map<String, dynamic>> screenings = [
    {
      "id": "SCR001",
      "applicantName": "Emily Johnson",
      "email": "emily.johnson@email.com",
      "phone": "(555) 123-4567",
      "property": "Sunset Villa #101",
      "applicationDate": "2025-06-18",
      "status": "Completed",
      "overallScore": 85,
      "creditScore": 720,
      "monthlyIncome": 7500.0,
      "employmentStatus": "Full-time",
      "employer": "Tech Solutions Inc.",
      "employmentYears": 3,
      "previousRental": "Yes",
      "evictionHistory": "None",
      "criminalBackground": "Clear",
      "references": 3,
      "recommendation": "Approve",
      "image": "https://picsum.photos/60/60?random=901&keyword=person",
      "riskLevel": "Low",
      "documents": ["ID", "Pay Stubs", "Bank Statements"],
    },
    {
      "id": "SCR002",
      "applicantName": "Michael Brown",
      "email": "michael.brown@email.com",
      "phone": "(555) 234-5678",
      "property": "Ocean View #205",
      "applicationDate": "2025-06-17",
      "status": "In Review",
      "overallScore": 0,
      "creditScore": 650,
      "monthlyIncome": 5200.0,
      "employmentStatus": "Full-time",
      "employer": "Marketing Group LLC",
      "employmentYears": 1,
      "previousRental": "Yes",
      "evictionHistory": "None",
      "criminalBackground": "Pending",
      "references": 2,
      "recommendation": "Pending",
      "image": "https://picsum.photos/60/60?random=902&keyword=person",
      "riskLevel": "Medium",
      "documents": ["ID", "Pay Stubs"],
    },
    {
      "id": "SCR003",
      "applicantName": "Jessica Miller",
      "email": "jessica.miller@email.com",
      "phone": "(555) 345-6789",
      "property": "Garden Court #12",
      "applicationDate": "2025-06-16",
      "status": "Flagged",
      "overallScore": 45,
      "creditScore": 580,
      "monthlyIncome": 4800.0,
      "employmentStatus": "Part-time",
      "employer": "Retail Store Chain",
      "employmentYears": 0.5,
      "previousRental": "No",
      "evictionHistory": "1 Previous",
      "criminalBackground": "Minor Offense",
      "references": 1,
      "recommendation": "Reject",
      "image": "https://picsum.photos/60/60?random=903&keyword=person",
      "riskLevel": "High",
      "documents": ["ID"],
    },
    {
      "id": "SCR004",
      "applicantName": "Robert Taylor",
      "email": "robert.taylor@email.com",
      "phone": "(555) 456-7890",
      "property": "Metro Heights #304",
      "applicationDate": "2025-06-19",
      "status": "Pending Documents",
      "overallScore": 0,
      "creditScore": 0,
      "monthlyIncome": 6200.0,
      "employmentStatus": "Self-employed",
      "employer": "Freelance Consultant",
      "employmentYears": 5,
      "previousRental": "Yes",
      "evictionHistory": "None",
      "criminalBackground": "Pending",
      "references": 4,
      "recommendation": "Pending",
      "image": "https://picsum.photos/60/60?random=904&keyword=person",
      "riskLevel": "Medium",
      "documents": ["ID", "Tax Returns"],
    },
    {
      "id": "SCR005",
      "applicantName": "Amanda White",
      "email": "amanda.white@email.com",
      "phone": "(555) 567-8901",
      "property": "Riverside Loft #8",
      "applicationDate": "2025-06-15",
      "status": "Completed",
      "overallScore": 92,
      "creditScore": 780,
      "monthlyIncome": 8900.0,
      "employmentStatus": "Full-time",
      "employer": "Financial Services Corp",
      "employmentYears": 7,
      "previousRental": "Yes",
      "evictionHistory": "None",
      "criminalBackground": "Clear",
      "references": 4,
      "recommendation": "Strongly Approve",
      "image": "https://picsum.photos/60/60?random=905&keyword=person",
      "riskLevel": "Low",
      "documents": ["ID", "Pay Stubs", "Bank Statements", "References"],
    },
  ];

  List<Map<String, dynamic>> criteria = [
    {
      "category": "Credit Score",
      "weight": 30,
      "minRequirement": 650,
      "description": "Minimum credit score for approval",
      "icon": Icons.account_balance,
      "color": primaryColor,
    },
    {
      "category": "Income Verification",
      "weight": 25,
      "minRequirement": "3x Rent",
      "description": "Monthly income must be 3 times the rent",
      "icon": Icons.attach_money,
      "color": successColor,
    },
    {
      "category": "Employment History",
      "weight": 20,
      "minRequirement": "1 Year",
      "description": "Stable employment for minimum 1 year",
      "icon": Icons.work,
      "color": infoColor,
    },
    {
      "category": "Rental History",
      "weight": 15,
      "minRequirement": "Clean",
      "description": "No evictions or negative rental history",
      "icon": Icons.home,
      "color": warningColor,
    },
    {
      "category": "Background Check",
      "weight": 10,
      "minRequirement": "Clean",
      "description": "Clear criminal background check",
      "icon": Icons.security,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> analytics = [
    {
      "title": "Total Applications",
      "value": 42,
      "change": 18,
      "color": primaryColor,
      "icon": Icons.people,
    },
    {
      "title": "Approved",
      "value": 28,
      "change": 15,
      "color": successColor,
      "icon": Icons.check_circle,
    },
    {
      "title": "Rejected",
      "value": 8,
      "change": -10,
      "color": dangerColor,
      "icon": Icons.cancel,
    },
    {
      "title": "Average Score",
      "value": 74,
      "change": 8,
      "color": infoColor,
      "icon": Icons.grade,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Completed", "value": "Completed"},
    {"label": "In Review", "value": "In Review"},
    {"label": "Flagged", "value": "Flagged"},
    {"label": "Pending Documents", "value": "Pending Documents"},
  ];

  List<Map<String, dynamic>> scoreOptions = [
    {"label": "All Scores", "value": ""},
    {"label": "90+ (Excellent)", "value": "90+"},
    {"label": "70-89 (Good)", "value": "70-89"},
    {"label": "50-69 (Fair)", "value": "50-69"},
    {"label": "Below 50 (Poor)", "value": "Below 50"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return successColor;
      case 'In Review':
        return warningColor;
      case 'Flagged':
        return dangerColor;
      case 'Pending Documents':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRiskColor(String risk) {
    switch (risk) {
      case 'Low':
        return successColor;
      case 'Medium':
        return warningColor;
      case 'High':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRecommendationColor(String recommendation) {
    switch (recommendation) {
      case 'Strongly Approve':
      case 'Approve':
        return successColor;
      case 'Reject':
        return dangerColor;
      default:
        return warningColor;
    }
  }

  List<Map<String, dynamic>> _getFilteredScreenings() {
    return screenings.where((screening) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${screening["applicantName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${screening["email"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${screening["property"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || screening["status"] == selectedStatus;
      
      bool matchesScore = selectedScore.isEmpty || _checkScoreRange(screening["overallScore"] as int, selectedScore);
      
      return matchesSearch && matchesStatus && matchesScore;
    }).toList();
  }

  bool _checkScoreRange(int score, String range) {
    switch (range) {
      case "90+":
        return score >= 90;
      case "70-89":
        return score >= 70 && score < 90;
      case "50-69":
        return score >= 50 && score < 70;
      case "Below 50":
        return score < 50 && score > 0;
      default:
        return true;
    }
  }

  Widget _buildScreeningsTab() {
    final filteredScreenings = _getFilteredScreenings();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search applications...",
                  value: searchQuery,
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
                onPressed: () {},
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Filter Dropdowns
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
                  label: "Score Range",
                  items: scoreOptions,
                  value: selectedScore,
                  onChanged: (value, label) {
                    selectedScore = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Screenings Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: filteredScreenings.map((screening) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getRiskColor("${screening["riskLevel"]}"),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Applicant Header
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              "${screening["image"]}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${screening["applicantName"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${screening["email"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${screening["phone"]}",
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
                      
                      SizedBox(height: spSm),
                      
                      // Property and Date
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${screening["property"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Applied: ${screening["applicationDate"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Status and Score
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${screening["status"]}").withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${screening["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${screening["status"]}"),
                              ),
                            ),
                          ),
                          
                          Spacer(),
                          
                          if (screening["overallScore"] > 0)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: (screening["overallScore"] as int) >= 80 
                                    ? successColor.withAlpha(50)
                                    : (screening["overallScore"] as int) >= 60 
                                        ? warningColor.withAlpha(50)
                                        : dangerColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, size: 10, color: (screening["overallScore"] as int) >= 80 
                                      ? successColor
                                      : (screening["overallScore"] as int) >= 60 
                                          ? warningColor
                                          : dangerColor),
                                  SizedBox(width: 2),
                                  Text(
                                    "${screening["overallScore"]}/100",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: (screening["overallScore"] as int) >= 80 
                                          ? successColor
                                          : (screening["overallScore"] as int) >= 60 
                                              ? warningColor
                                              : dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Key Information
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.account_balance, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Credit: ${screening["creditScore"] > 0 ? screening["creditScore"] : "Pending"}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${((screening["monthlyIncome"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Icon(Icons.work, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${screening["employer"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${screening["employmentYears"]} years",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${screening["references"]} refs",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Risk Assessment
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getRiskColor("${screening["riskLevel"]}").withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${screening["riskLevel"]} Risk",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getRiskColor("${screening["riskLevel"]}"),
                              ),
                            ),
                          ),
                          
                          if (screening["recommendation"] != "Pending") ...[
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getRecommendationColor("${screening["recommendation"]}").withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${screening["recommendation"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getRecommendationColor("${screening["recommendation"]}"),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Documents Status
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: (screening["documents"] as List).map((doc) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$doc",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Action Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: screening["status"] == "Completed" ? "View Report" : "Continue Review",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCriteriaTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                "Screening Criteria",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Edit Criteria",
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "Customize your tenant screening requirements and scoring weights",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Criteria Cards
          Column(
            spacing: spSm,
            children: criteria.map((criterion) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (criterion["color"] as Color).withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        criterion["icon"] as IconData,
                        size: 24,
                        color: criterion["color"] as Color,
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
                                "${criterion["category"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (criterion["color"] as Color).withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${criterion["weight"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: criterion["color"] as Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "${criterion["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Text(
                                "Minimum: ",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${criterion["minRequirement"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Quick Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
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
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Bulk Screen",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Export Report",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Import Applications",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Reset Criteria",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: analytics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            size: 20,
                            color: metric["color"] as Color,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (metric["change"] as int) >= 0 ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(metric["change"] as int) >= 0 ? '+' : ''}${metric["change"]}%",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: (metric["change"] as int) >= 0 ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "${metric["value"]}${metric["title"] == "Average Score" ? "/100" : ""}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Screening Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Screening Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Approval Rate",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "66.7% (28/42)",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Average Processing Time",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "2.3 days",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Rejection Reason",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "Low Credit Score",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Document Completion",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "89% complete rate",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Tenant Screening",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Applications", icon: Icon(Icons.people)),
        Tab(text: "Criteria", icon: Icon(Icons.rule)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildScreeningsTab(),
        _buildCriteriaTab(),
        _buildAnalyticsTab(),
      ],
    );
  }
}
