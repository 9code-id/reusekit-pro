import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaLicenseManagementView extends StatefulWidget {
  const FmaLicenseManagementView({super.key});

  @override
  State<FmaLicenseManagementView> createState() => _FmaLicenseManagementViewState();
}

class _FmaLicenseManagementViewState extends State<FmaLicenseManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  String licenseType = "";
  String issuingAuthority = "";
  String licenseNumber = "";
  String applicantName = "";
  String contactEmail = "";
  String phoneNumber = "";
  String businessAddress = "";
  String purpose = "";
  String issueDate = "";
  String expiryDate = "";
  String notes = "";

  List<Map<String, dynamic>> licenses = [
    {
      "id": "LIC001",
      "type": "Restaurant License",
      "number": "RL-2024-001543",
      "authority": "City Health Department",
      "status": "Active",
      "issue_date": "2024-01-15",
      "expiry_date": "2025-01-15",
      "days_until_expiry": 45,
      "business_name": "Gourmet Kitchen",
      "license_holder": "John Smith",
      "fee_paid": 250.00,
      "renewal_required": false,
      "violations": 0,
      "last_inspection": "2024-11-20",
      "conditions": ["No outdoor seating without permit", "Kitchen must maintain 40°F or below"],
    },
    {
      "id": "LIC002",
      "type": "Liquor License",
      "number": "LL-2024-008976",
      "authority": "State Alcohol Board",
      "status": "Expiring Soon",
      "issue_date": "2024-02-01",
      "expiry_date": "2025-02-01",
      "days_until_expiry": 20,
      "business_name": "Gourmet Kitchen",
      "license_holder": "John Smith",
      "fee_paid": 1500.00,
      "renewal_required": true,
      "violations": 1,
      "last_inspection": "2024-12-01",
      "conditions": ["No service to minors", "No off-premises consumption", "Hours: 11AM-2AM"],
    },
    {
      "id": "LIC003",
      "type": "Food Handler Permit",
      "number": "FH-2024-012456",
      "authority": "County Health Services",
      "status": "Active",
      "issue_date": "2024-03-10",
      "expiry_date": "2025-03-10",
      "days_until_expiry": 85,
      "business_name": "Gourmet Kitchen",
      "license_holder": "Sarah Johnson",
      "fee_paid": 45.00,
      "renewal_required": false,
      "violations": 0,
      "last_inspection": "2024-10-15",
      "conditions": ["Valid for food preparation only", "Must display prominently"],
    },
    {
      "id": "LIC004",
      "type": "Business License",
      "number": "BL-2024-789012",
      "authority": "City Business Office",
      "status": "Expired",
      "issue_date": "2023-06-01",
      "expiry_date": "2024-06-01",
      "days_until_expiry": -180,
      "business_name": "Gourmet Kitchen",
      "license_holder": "John Smith",
      "fee_paid": 150.00,
      "renewal_required": true,
      "violations": 0,
      "last_inspection": "2024-05-15",
      "conditions": ["Must operate within zoned area", "No changes without permit"],
    },
    {
      "id": "LIC005",
      "type": "Fire Safety Permit",
      "number": "FS-2024-445566",
      "authority": "Fire Marshal Office",
      "status": "Active",
      "issue_date": "2024-08-15",
      "expiry_date": "2025-08-15",
      "days_until_expiry": 250,
      "business_name": "Gourmet Kitchen",
      "license_holder": "Mike Davis",
      "fee_paid": 75.00,
      "renewal_required": false,
      "violations": 0,
      "last_inspection": "2024-11-30",
      "conditions": ["Fire suppression system required", "Monthly inspections mandatory"],
    },
    {
      "id": "LIC006",
      "type": "Music Performance License",
      "number": "MP-2024-332211",
      "authority": "Entertainment Commission",
      "status": "Pending Renewal",
      "issue_date": "2024-05-20",
      "expiry_date": "2025-05-20",
      "days_until_expiry": 150,
      "business_name": "Gourmet Kitchen",
      "license_holder": "Entertainment Manager",
      "fee_paid": 200.00,
      "renewal_required": true,
      "violations": 0,
      "last_inspection": "2024-11-10",
      "conditions": ["Live music only on weekends", "Sound levels not to exceed 75dB"],
    },
  ];

  List<Map<String, dynamic>> renewalReminders = [
    {
      "license_id": "LIC002",
      "license_type": "Liquor License",
      "days_remaining": 20,
      "priority": "High",
      "action_required": "Submit renewal application",
      "fee": 1500.00,
      "documents_needed": ["Application Form", "Insurance Certificate", "Floor Plan"],
    },
    {
      "license_id": "LIC004",
      "license_type": "Business License",
      "days_remaining": -180,
      "priority": "Critical",
      "action_required": "Immediate renewal required",
      "fee": 150.00,
      "documents_needed": ["Business Registration", "Tax Certificate"],
    },
    {
      "license_id": "LIC006",
      "license_type": "Music Performance License",
      "days_remaining": 150,
      "priority": "Medium",
      "action_required": "Prepare renewal documents",
      "fee": 200.00,
      "documents_needed": ["Performance Schedule", "Noise Control Plan"],
    },
  ];

  List<Map<String, dynamic>> licenseCategories = [
    {
      "category": "Operating Licenses",
      "count": 3,
      "active": 2,
      "expired": 1,
      "expiring_soon": 0,
      "total_fees": 550.00,
    },
    {
      "category": "Safety Permits",
      "count": 2,
      "active": 2,
      "expired": 0,
      "expiring_soon": 0,
      "total_fees": 120.00,
    },
    {
      "category": "Special Permits",
      "count": 1,
      "active": 0,
      "expired": 0,
      "expiring_soon": 1,
      "total_fees": 200.00,
    },
  ];

  List<Map<String, dynamic>> get filteredLicenses {
    return licenses.where((license) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${license["type"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${license["number"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${license["license_holder"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" || license["status"] == selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // License Summary Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.verified, color: Colors.white, size: 32),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Licenses",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${licenses.length}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Active",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "${licenses.where((l) => l["status"] == "Active").length}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: [
              _buildStatCard("Active", "${licenses.where((l) => l["status"] == "Active").length}", Icons.check_circle, successColor),
              _buildStatCard("Expiring Soon", "${licenses.where((l) => l["status"] == "Expiring Soon").length}", Icons.schedule, warningColor),
              _buildStatCard("Expired", "${licenses.where((l) => l["status"] == "Expired").length}", Icons.error, dangerColor),
              _buildStatCard("Renewals Due", "${renewalReminders.length}", Icons.refresh, infoColor),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Renewal Reminders
          Text(
            "Renewal Reminders",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: renewalReminders.map((reminder) {
              Color priorityColor = reminder["priority"] == "Critical" ? dangerColor :
                                   reminder["priority"] == "High" ? warningColor : infoColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: priorityColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.notifications,
                        color: priorityColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${reminder["license_type"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${reminder["action_required"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "Fee: \$${(reminder["fee"] as double).currency}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: priorityColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        (reminder["days_remaining"] as int) > 0 ? "${reminder["days_remaining"]} days" : "Overdue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // License Categories
          Text(
            "License Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: licenseCategories.map((category) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                        Expanded(
                          child: Text(
                            "${category["category"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${(category["total_fees"] as double).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        _buildCategoryCount("Total", category["count"], primaryColor),
                        SizedBox(width: spSm),
                        _buildCategoryCount("Active", category["active"], successColor),
                        SizedBox(width: spSm),
                        _buildCategoryCount("Expired", category["expired"], dangerColor),
                        SizedBox(width: spSm),
                        _buildCategoryCount("Expiring", category["expiring_soon"], warningColor),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLicensesTab() {
    return Column(
      children: [
        // Search and Filter
        Container(
          padding: EdgeInsets.all(spMd),
          color: Colors.white,
          child: Column(
            children: [
              QTextField(
                label: "Search licenses...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QCategoryPicker(
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Active", "value": "Active"},
                  {"label": "Expiring Soon", "value": "Expiring Soon"},
                  {"label": "Expired", "value": "Expired"},
                  {"label": "Pending Renewal", "value": "Pending Renewal"},
                ],
                value: selectedFilter,
                onChanged: (index, label, value, item) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        // License List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: filteredLicenses.length,
            itemBuilder: (context, index) {
              final license = filteredLicenses[index];
              Color statusColor = license["status"] == "Active" ? successColor :
                                 license["status"] == "Expired" ? dangerColor :
                                 license["status"] == "Expiring Soon" ? warningColor : infoColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.verified,
                      color: statusColor,
                    ),
                  ),
                  title: Text(
                    "${license["type"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${license["number"]} • ${license["authority"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${license["status"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          if ((license["days_until_expiry"] as int) > 0)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: disabledBoldColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${license["days_until_expiry"]} days left",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildLicenseInfo("License Holder", "${license["license_holder"]}", Icons.person),
                              ),
                              Expanded(
                                child: _buildLicenseInfo("Fee Paid", "\$${(license["fee_paid"] as double).currency}", Icons.payment),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: _buildLicenseInfo("Issue Date", "${license["issue_date"]}", Icons.calendar_today),
                              ),
                              Expanded(
                                child: _buildLicenseInfo("Expiry Date", "${license["expiry_date"]}", Icons.event),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: _buildLicenseInfo("Violations", "${license["violations"]}", Icons.warning),
                              ),
                              Expanded(
                                child: _buildLicenseInfo("Last Inspection", "${license["last_inspection"]}", Icons.search),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Text(
                            "License Conditions:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (license["conditions"] as List).map((condition) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.check_circle, size: 12, color: primaryColor),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "$condition",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          
                          if (license["renewal_required"] == true) ...[
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Renew License",
                                size: bs.sm,
                                onPressed: () {
                                  ss("License renewal process initiated");
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRenewalsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Renewal Management",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: renewalReminders.map((renewal) {
              Color priorityColor = renewal["priority"] == "Critical" ? dangerColor :
                                   renewal["priority"] == "High" ? warningColor : infoColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: priorityColor,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.refresh,
                      color: priorityColor,
                    ),
                  ),
                  title: Text(
                    "${renewal["license_type"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${renewal["action_required"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: priorityColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${renewal["priority"]} Priority",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "\$${(renewal["fee"] as double).currency}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Required Documents:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Column(
                            children: (renewal["documents_needed"] as List).map((doc) {
                              return Container(
                                margin: EdgeInsets.only(bottom: spXs),
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.description, size: 16, color: primaryColor),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "$doc",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.check_circle_outline, size: 16, color: successColor),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Start Renewal Process",
                              size: bs.sm,
                              onPressed: () {
                                ss("Renewal process started for ${renewal["license_type"]}");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNewLicenseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Apply for New License",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          QDropdownField(
            label: "License Type",
            items: [
              {"label": "Restaurant License", "value": "Restaurant License"},
              {"label": "Liquor License", "value": "Liquor License"},
              {"label": "Food Handler Permit", "value": "Food Handler Permit"},
              {"label": "Business License", "value": "Business License"},
              {"label": "Fire Safety Permit", "value": "Fire Safety Permit"},
              {"label": "Music Performance License", "value": "Music Performance License"},
              {"label": "Outdoor Seating Permit", "value": "Outdoor Seating Permit"},
            ],
            value: licenseType,
            onChanged: (value, label) {
              licenseType = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Issuing Authority",
            value: issuingAuthority,
            onChanged: (value) {
              issuingAuthority = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "License Number (if renewal)",
            value: licenseNumber,
            onChanged: (value) {
              licenseNumber = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Applicant Name",
            value: applicantName,
            onChanged: (value) {
              applicantName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Contact Email",
            value: contactEmail,
            onChanged: (value) {
              contactEmail = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Phone Number",
            value: phoneNumber,
            onChanged: (value) {
              phoneNumber = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Business Address",
            value: businessAddress,
            onChanged: (value) {
              businessAddress = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Purpose/Description",
            value: purpose,
            onChanged: (value) {
              purpose = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Preferred Issue Date",
            value: issueDate,
            onChanged: (value) {
              issueDate = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Requested Expiry Date",
            value: expiryDate,
            onChanged: (value) {
              expiryDate = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Additional Notes",
            value: notes,
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Submit License Application",
              size: bs.md,
              onPressed: () {
                ss("License application submitted successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseInfo(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 2),
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

  Widget _buildCategoryCount(String label, dynamic count, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        "$label: $count",
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "License Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Licenses", icon: Icon(Icons.verified)),
        Tab(text: "Renewals", icon: Icon(Icons.refresh)),
        Tab(text: "Apply", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildLicensesTab(),
        _buildRenewalsTab(),
        _buildNewLicenseTab(),
      ],
    );
  }
}
