import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSubsidiesView extends StatefulWidget {
  const AmaSubsidiesView({super.key});

  @override
  State<AmaSubsidiesView> createState() => _AmaSubsidiesViewState();
}

class _AmaSubsidiesViewState extends State<AmaSubsidiesView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String applicationStatus = "";
  bool showFilters = false;

  List<Map<String, dynamic>> subsidyPrograms = [
    {
      "id": "SUB001",
      "name": "Tractor Purchase Subsidy",
      "category": "Equipment",
      "amount": 50000,
      "maxAmount": 100000,
      "eligibility": "Small farmers with <5 hectares",
      "deadline": "2025-08-15",
      "status": "Active",
      "applicants": 245,
      "approved": 67,
      "description": "Government subsidy for purchasing agricultural tractors and related equipment",
      "requirements": ["Land ownership certificate", "Income proof", "Agricultural registration"],
      "coverage": 75,
      "icon": Icons.agriculture,
      "priority": "High"
    },
    {
      "id": "SUB002", 
      "name": "Seed Development Grant",
      "category": "Seeds",
      "amount": 15000,
      "maxAmount": 25000,
      "eligibility": "Certified seed producers",
      "deadline": "2025-07-30",
      "status": "Active",
      "applicants": 189,
      "approved": 134,
      "description": "Financial support for high-quality seed production and distribution",
      "requirements": ["Seed certification", "Production capacity proof", "Quality standards compliance"],
      "coverage": 60,
      "icon": Icons.grass,
      "priority": "Medium"
    },
    {
      "id": "SUB003",
      "name": "Irrigation System Support",
      "category": "Infrastructure", 
      "amount": 75000,
      "maxAmount": 150000,
      "eligibility": "Farmers with water rights",
      "deadline": "2025-09-20",
      "status": "Active",
      "applicants": 312,
      "approved": 89,
      "description": "Subsidy for installing modern irrigation systems and water management",
      "requirements": ["Water rights certificate", "Land survey", "Technical feasibility study"],
      "coverage": 80,
      "icon": Icons.water_drop,
      "priority": "High"
    },
    {
      "id": "SUB004",
      "name": "Organic Certification Aid",
      "category": "Certification",
      "amount": 8000,
      "maxAmount": 12000,
      "eligibility": "Organic farming practitioners",
      "deadline": "2025-06-30",
      "status": "Closing Soon",
      "applicants": 156,
      "approved": 98,
      "description": "Financial assistance for obtaining organic farming certification",
      "requirements": ["Organic farming practice proof", "Soil test reports", "Crop history"],
      "coverage": 65,
      "icon": Icons.eco,
      "priority": "Medium"
    },
    {
      "id": "SUB005",
      "name": "Young Farmer Initiative",
      "category": "Youth",
      "amount": 35000,
      "maxAmount": 60000,
      "eligibility": "Farmers under 35 years",
      "deadline": "2025-10-15",
      "status": "New",
      "applicants": 78,
      "approved": 23,
      "description": "Special funding program to encourage young people in agriculture",
      "requirements": ["Age verification", "Agricultural education certificate", "Business plan"],
      "coverage": 70,
      "icon": Icons.people,
      "priority": "High"
    },
    {
      "id": "SUB006",
      "name": "Crop Insurance Subsidy",
      "category": "Insurance",
      "amount": 5000,
      "maxAmount": 10000,
      "eligibility": "All registered farmers",
      "deadline": "2025-12-31",
      "status": "Active",
      "applicants": 567,
      "approved": 445,
      "description": "Government support for agricultural crop insurance premiums",
      "requirements": ["Farmer registration", "Crop details", "Previous year harvest data"],
      "coverage": 50,
      "icon": Icons.security,
      "priority": "Low"
    }
  ];

  List<Map<String, dynamic>> myApplications = [
    {
      "id": "APP001",
      "subsidyName": "Tractor Purchase Subsidy",
      "appliedDate": "2025-05-15",
      "status": "Under Review",
      "amount": 45000,
      "progress": 60,
      "nextStep": "Document verification",
      "officer": "John Smith",
      "estimatedDecision": "2025-07-01"
    },
    {
      "id": "APP002",
      "subsidyName": "Seed Development Grant", 
      "appliedDate": "2025-04-20",
      "status": "Approved",
      "amount": 12000,
      "progress": 100,
      "nextStep": "Fund disbursement",
      "officer": "Sarah Johnson",
      "estimatedDecision": "2025-06-15"
    },
    {
      "id": "APP003",
      "subsidyName": "Irrigation System Support",
      "appliedDate": "2025-06-01",
      "status": "Pending Documents",
      "amount": 68000,
      "progress": 25,
      "nextStep": "Submit water rights certificate",
      "officer": "Michael Brown",
      "estimatedDecision": "2025-08-10"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Equipment", "value": "Equipment"},
    {"label": "Seeds", "value": "Seeds"},
    {"label": "Infrastructure", "value": "Infrastructure"},
    {"label": "Certification", "value": "Certification"},
    {"label": "Youth", "value": "Youth"},
    {"label": "Insurance", "value": "Insurance"}
  ];

  List<Map<String, dynamic>> get filteredSubsidies {
    return subsidyPrograms.where((subsidy) {
      bool matchesSearch = subsidy["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          subsidy["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || subsidy["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Agricultural Subsidies",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Available", icon: Icon(Icons.list)),
        Tab(text: "My Applications", icon: Icon(Icons.folder)),
        Tab(text: "Guidelines", icon: Icon(Icons.info)),
      ],
      tabChildren: [
        _buildAvailableTab(),
        _buildMyApplicationsTab(),
        _buildGuidelinesTab(),
      ],
    );
  }

  Widget _buildAvailableTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildSubsidyStats(),
          _buildSubsidyList(),
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
                label: "Search subsidies...",
                value: searchQuery,
                hint: "Search by name or description",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: showFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
              size: bs.sm,
              onPressed: () {
                showFilters = !showFilters;
                setState(() {});
              },
            ),
          ],
        ),
        if (showFilters) ...[
          QDropdownField(
            label: "Category",
            items: categories,
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ],
    );
  }

  Widget _buildSubsidyStats() {
    int totalPrograms = subsidyPrograms.length;
    int activePrograms = subsidyPrograms.where((s) => s["status"] == "Active").length;
    double totalFunding = subsidyPrograms.fold(0.0, (sum, s) => sum + (s["maxAmount"] as int).toDouble());

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Programs", totalPrograms.toString(), Icons.list_alt, primaryColor),
        _buildStatCard("Active Programs", activePrograms.toString(), Icons.check_circle, successColor),
        _buildStatCard("Total Funding", "\$${(totalFunding / 1000).toStringAsFixed(0)}K", Icons.monetization_on, warningColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Live",
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
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

  Widget _buildSubsidyList() {
    return Column(
      spacing: spSm,
      children: filteredSubsidies.map((subsidy) => _buildSubsidyCard(subsidy)).toList(),
    );
  }

  Widget _buildSubsidyCard(Map<String, dynamic> subsidy) {
    Color statusColor = subsidy["status"] == "Active" 
        ? successColor 
        : subsidy["status"] == "New" 
            ? infoColor 
            : warningColor;

    return Container(
      padding: EdgeInsets.all(spMd),
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
            children: [
              Icon(
                subsidy["icon"] as IconData,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${subsidy["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${subsidy["category"]} • ${subsidy["id"]}",
                      style: TextStyle(
                        fontSize: 12,
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
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${subsidy["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${subsidy["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildInfoItem("Amount", "\$${((subsidy["amount"] as int).toDouble()).currency}", Icons.attach_money),
              _buildInfoItem("Max Amount", "\$${((subsidy["maxAmount"] as int).toDouble()).currency}", Icons.trending_up),
              _buildInfoItem("Coverage", "${subsidy["coverage"]}%", Icons.pie_chart),
              _buildInfoItem("Deadline", "${DateTime.parse("${subsidy["deadline"]}").dMMMy}", Icons.schedule),
            ],
          ),
          Row(
            children: [
              Text(
                "Eligibility: ${subsidy["eligibility"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Spacer(),
              Text(
                "${subsidy["approved"]}/${subsidy["applicants"]} approved",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Apply Now",
              size: bs.sm,
              onPressed: () {
                ss("Application started for ${subsidy["name"]}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: disabledBoldColor, size: 16),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMyApplicationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildApplicationStats(),
          _buildApplicationsList(),
        ],
      ),
    );
  }

  Widget _buildApplicationStats() {
    int totalApps = myApplications.length;
    int approved = myApplications.where((app) => app["status"] == "Approved").length;
    int pending = myApplications.where((app) => app["status"] == "Under Review").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildApplicationStatCard("Total Applications", totalApps.toString(), Icons.folder, primaryColor),
        _buildApplicationStatCard("Approved", approved.toString(), Icons.check_circle, successColor),
        _buildApplicationStatCard("Under Review", pending.toString(), Icons.pending, warningColor),
      ],
    );
  }

  Widget _buildApplicationStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildApplicationsList() {
    return Column(
      spacing: spSm,
      children: myApplications.map((application) => _buildApplicationCard(application)).toList(),
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> application) {
    Color statusColor = application["status"] == "Approved"
        ? successColor
        : application["status"] == "Under Review"
            ? warningColor
            : dangerColor;

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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${application["subsidyName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Applied: ${DateTime.parse("${application["appliedDate"]}").dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
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
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${application["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${application["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: (application["progress"] as int) / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAppInfoItem("Amount", "\$${((application["amount"] as int).toDouble()).currency}", Icons.monetization_on),
              _buildAppInfoItem("Officer", "${application["officer"]}", Icons.person),
              _buildAppInfoItem("Next Step", "${application["nextStep"]}", Icons.arrow_forward),
              _buildAppInfoItem("Decision By", "${DateTime.parse("${application["estimatedDecision"]}").dMMMy}", Icons.event),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("Viewing details for ${application["id"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () {
                  si("Contacting officer ${application["officer"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 16),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuidelinesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildGuidelineSection(
            "Eligibility Requirements",
            Icons.checklist,
            [
              "Must be a registered farmer or agricultural business",
              "Valid agricultural land ownership or lease agreement",
              "Proof of income and financial statements",
              "No outstanding government loans or subsidies",
              "Compliance with environmental regulations",
            ],
          ),
          _buildGuidelineSection(
            "Application Process",
            Icons.assignment,
            [
              "Complete online application form with all required details",
              "Upload supporting documents (land papers, income proof, etc.)",
              "Submit application before the deadline",
              "Wait for initial review and verification",
              "Provide additional documents if requested",
              "Attend interview if required",
            ],
          ),
          _buildGuidelineSection(
            "Required Documents",
            Icons.folder_open,
            [
              "Land ownership certificate or lease agreement",
              "Government-issued ID and photo",
              "Income tax returns for last 2 years",
              "Bank statements for last 6 months",
              "Agricultural registration certificate",
              "Crop insurance documents (if applicable)",
            ],
          ),
          _buildGuidelineSection(
            "Important Notes",
            Icons.info,
            [
              "Applications are processed on first-come, first-served basis",
              "Incomplete applications will be rejected",
              "False information may result in permanent disqualification",
              "Approved funds must be used for stated purposes only",
              "Regular audits and inspections may be conducted",
              "Misuse of funds may result in legal action",
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelineSection(String title, IconData icon, List<String> items) {
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
            children: [
              Icon(icon, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(left: spLg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
