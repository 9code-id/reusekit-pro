import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaLeaseAgreementsView extends StatefulWidget {
  const RmaLeaseAgreementsView({super.key});

  @override
  State<RmaLeaseAgreementsView> createState() => _RmaLeaseAgreementsViewState();
}

class _RmaLeaseAgreementsViewState extends State<RmaLeaseAgreementsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> leaseAgreements = [
    {
      "id": "LSE001",
      "tenant": "Sarah Johnson",
      "property": "Downtown Apartment Complex",
      "unit": "Unit 204",
      "lease_type": "Residential",
      "start_date": "2024-01-15",
      "end_date": "2024-12-15",
      "monthly_rent": 2400.0,
      "security_deposit": 2400.0,
      "status": "Active",
      "lease_term": 12,
      "renewal_option": true,
      "pet_allowed": true,
      "utilities_included": ["Water", "Trash"],
      "special_terms": "No smoking policy",
      "signed_date": "2024-01-10",
      "document_url": "lease_001.pdf",
      "days_remaining": 3,
    },
    {
      "id": "LSE002",
      "tenant": "Michael Chen",
      "property": "Riverside Villa Community",
      "unit": "Villa 3",
      "lease_type": "Residential",
      "start_date": "2024-03-01",
      "end_date": "2025-02-28",
      "monthly_rent": 3200.0,
      "security_deposit": 3200.0,
      "status": "Active",
      "lease_term": 12,
      "renewal_option": true,
      "pet_allowed": false,
      "utilities_included": ["Water", "Trash", "Internet"],
      "special_terms": "No pet policy, Landscaping included",
      "signed_date": "2024-02-25",
      "document_url": "lease_002.pdf",
      "days_remaining": 72,
    },
    {
      "id": "LSE003",
      "tenant": "Emily Rodriguez",
      "property": "Garden Heights Condos",
      "unit": "Condo 12B",
      "lease_type": "Residential",
      "start_date": "2024-06-01",
      "end_date": "2025-05-31",
      "monthly_rent": 1800.0,
      "security_deposit": 1800.0,
      "status": "Notice Given",
      "lease_term": 12,
      "renewal_option": false,
      "pet_allowed": true,
      "utilities_included": ["Water"],
      "special_terms": "Pet deposit required",
      "signed_date": "2024-05-28",
      "document_url": "lease_003.pdf",
      "days_remaining": 150,
      "notice_date": "2024-12-01",
    },
    {
      "id": "LSE004",
      "tenant": "David Kim",
      "property": "Downtown Apartment Complex",
      "unit": "Apt 105",
      "lease_type": "Commercial",
      "start_date": "2024-04-01",
      "end_date": "2027-03-31",
      "monthly_rent": 2200.0,
      "security_deposit": 4400.0,
      "status": "Active",
      "lease_term": 36,
      "renewal_option": true,
      "pet_allowed": false,
      "utilities_included": [],
      "special_terms": "Business use only, No modifications without approval",
      "signed_date": "2024-03-28",
      "document_url": "lease_004.pdf",
      "days_remaining": 850,
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Expiring", "value": "Expiring"},
    {"label": "Notice Given", "value": "Notice Given"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All", "value": "All"},
    {"label": "Residential", "value": "Residential"},
    {"label": "Commercial", "value": "Commercial"},
  ];

  List<Map<String, dynamic>> get filteredLeases {
    return leaseAgreements.where((lease) {
      bool matchesSearch = lease["tenant"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          lease["unit"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          lease["property"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || _getLeaseStatus(lease) == selectedStatus;
      bool matchesType = selectedType == "All" || lease["lease_type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  String _getLeaseStatus(Map<String, dynamic> lease) {
    if (lease["status"] == "Notice Given") return "Notice Given";
    
    int daysRemaining = lease["days_remaining"] as int;
    if (daysRemaining <= 0) return "Expired";
    if (daysRemaining <= 30) return "Expiring";
    return "Active";
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Lease Agreements",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Leases", icon: Icon(Icons.description)),
        Tab(text: "Templates", icon: Icon(Icons.file_copy)),
        Tab(text: "Renewals", icon: Icon(Icons.refresh)),
      ],
      tabChildren: [
        _buildLeasesTab(),
        _buildTemplatesTab(),
        _buildRenewalsTab(),
      ],
    );
  }

  Widget _buildLeasesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildLeaseOverview(),
          _buildSearchAndFilters(),
          _buildLeasesList(),
        ],
      ),
    );
  }

  Widget _buildLeaseOverview() {
    int activeLeases = leaseAgreements.where((lease) => _getLeaseStatus(lease) == "Active").length;
    int expiringLeases = leaseAgreements.where((lease) => _getLeaseStatus(lease) == "Expiring").length;
    int noticeGiven = leaseAgreements.where((lease) => lease["status"] == "Notice Given").length;
    double totalRent = leaseAgreements.fold(0.0, (sum, lease) => sum + (lease["monthly_rent"] as num).toDouble());

    return Container(
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
            "Lease Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildOverviewCard("Active Leases", "$activeLeases", Icons.description, successColor),
              _buildOverviewCard("Expiring Soon", "$expiringLeases", Icons.warning, warningColor),
              _buildOverviewCard("Notice Given", "$noticeGiven", Icons.notifications, dangerColor),
              _buildOverviewCard("Total Monthly Rent", "\$${totalRent.currency}", Icons.monetization_on, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
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

  Widget _buildSearchAndFilters() {
    return Container(
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
                  label: "Search Leases",
                  value: searchQuery,
                  hint: "Search by tenant, unit, or property",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
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
                  label: "Type",
                  items: typeItems,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(child: Container()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeasesList() {
    return Column(
      spacing: spSm,
      children: filteredLeases.map((lease) {
        Color statusColor = _getStatusColor(_getLeaseStatus(lease));
        
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
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${lease["tenant"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: lease["lease_type"] == "Residential" ? infoColor.withAlpha(20) : warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${lease["lease_type"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: lease["lease_type"] == "Residential" ? infoColor : warningColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${lease["unit"]} - ${lease["property"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${_getLeaseStatus(lease)}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: spXs,
                    children: [
                      Text(
                        "\$${((lease["monthly_rent"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${lease["days_remaining"]} days left",
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(color: disabledColor),
              Row(
                children: [
                  Expanded(
                    child: _buildLeaseInfo("Start Date", "${lease["start_date"]}", Icons.calendar_today),
                  ),
                  Expanded(
                    child: _buildLeaseInfo("End Date", "${lease["end_date"]}", Icons.event),
                  ),
                  Expanded(
                    child: _buildLeaseInfo("Term", "${lease["lease_term"]} months", Icons.schedule),
                  ),
                  Expanded(
                    child: _buildLeaseInfo("Deposit", "\$${((lease["security_deposit"] as num).toDouble()).currency}", Icons.account_balance),
                  ),
                ],
              ),
              if ((lease["utilities_included"] as List).isNotEmpty || lease["special_terms"] != null)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      if ((lease["utilities_included"] as List).isNotEmpty)
                        Row(
                          children: [
                            Icon(Icons.build, size: 14, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "Utilities: ${(lease["utilities_included"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      if (lease["special_terms"] != null)
                        Row(
                          children: [
                            Icon(Icons.info, size: 14, color: primaryColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${lease["special_terms"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          if (lease["pet_allowed"] == true)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              margin: EdgeInsets.only(right: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Pets Allowed",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ),
                          if (lease["renewal_option"] == true)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Renewal Option",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Signed: ${lease["signed_date"]} • Document: ${lease["document_url"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      QButton(
                        icon: Icons.file_download,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLeaseInfo(String label, String value, IconData icon) {
    return Column(
      spacing: spXs,
      children: [
        Icon(
          icon,
          size: 16,
          color: primaryColor,
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Expiring":
        return warningColor;
      case "Notice Given":
        return dangerColor;
      case "Expired":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTemplateCategories(),
          _buildTemplateList(),
        ],
      ),
    );
  }

  Widget _buildTemplateCategories() {
    List<Map<String, dynamic>> categories = [
      {
        "title": "Residential Lease",
        "description": "Standard residential lease agreement template",
        "icon": Icons.home,
        "color": primaryColor,
        "templates_count": 3,
      },
      {
        "title": "Commercial Lease",
        "description": "Commercial property lease agreement template",
        "icon": Icons.business,
        "color": infoColor,
        "templates_count": 2,
      },
      {
        "title": "Short-term Rental",
        "description": "Vacation and short-term rental agreements",
        "icon": Icons.event,
        "color": warningColor,
        "templates_count": 1,
      },
      {
        "title": "Lease Addendums",
        "description": "Additional terms and amendment templates",
        "icon": Icons.add_circle,
        "color": successColor,
        "templates_count": 4,
      },
    ];

    return Container(
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Lease Template Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Create New",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: categories.map((category) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (category["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: (category["color"] as Color).withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: category["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${category["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: category["color"] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${category["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${category["templates_count"]} templates",
                            style: TextStyle(
                              fontSize: 12,
                              color: category["color"] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        QButton(
                          label: "View",
                          size: bs.sm,
                          onPressed: () {},
                        ),
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

  Widget _buildTemplateList() {
    List<Map<String, dynamic>> templates = [
      {
        "name": "Standard Residential Lease",
        "category": "Residential",
        "description": "12-month residential lease with standard terms",
        "last_used": "2024-12-01",
        "usage_count": 15,
        "file_size": "2.5 MB",
        "created_date": "2024-01-15",
      },
      {
        "name": "Pet-Friendly Residential Lease",
        "category": "Residential",
        "description": "Residential lease allowing pets with additional terms",
        "last_used": "2024-11-28",
        "usage_count": 8,
        "file_size": "2.8 MB",
        "created_date": "2024-02-10",
      },
      {
        "name": "Commercial Office Lease",
        "category": "Commercial",
        "description": "Multi-year commercial lease for office spaces",
        "last_used": "2024-11-15",
        "usage_count": 3,
        "file_size": "3.2 MB",
        "created_date": "2024-03-05",
      },
      {
        "name": "Utilities Addendum",
        "category": "Addendum",
        "description": "Additional terms for utility responsibilities",
        "last_used": "2024-12-05",
        "usage_count": 12,
        "file_size": "0.8 MB",
        "created_date": "2024-01-20",
      },
    ];

    return Container(
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
            "Lease Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...templates.map((template) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.description,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${template["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Used ${template["usage_count"]} times",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Last: ${template["last_used"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${template["file_size"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      QButton(
                        icon: Icons.copy,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      QButton(
                        label: "Use Template",
                        size: bs.sm,
                        onPressed: () {},
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

  Widget _buildRenewalsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRenewalOverview(),
          _buildUpcomingRenewals(),
          _buildRenewalHistory(),
        ],
      ),
    );
  }

  Widget _buildRenewalOverview() {
    List<Map<String, dynamic>> renewalLeases = leaseAgreements.where((lease) => 
      (lease["days_remaining"] as int) <= 90 && lease["renewal_option"] == true).toList();
    
    int eligibleRenewals = renewalLeases.length;
    int urgentRenewals = renewalLeases.where((lease) => (lease["days_remaining"] as int) <= 30).length;
    double renewalValue = renewalLeases.fold(0.0, (sum, lease) => sum + (lease["monthly_rent"] as num).toDouble());

    return Container(
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
            "Renewal Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildRenewalStatCard("Eligible Renewals", "$eligibleRenewals", Icons.refresh, infoColor),
              _buildRenewalStatCard("Urgent (≤30 days)", "$urgentRenewals", Icons.warning, warningColor),
              _buildRenewalStatCard("Monthly Value", "\$${renewalValue.currency}", Icons.monetization_on, successColor),
              _buildRenewalStatCard("Renewal Rate", "85%", Icons.trending_up, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRenewalStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
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

  Widget _buildUpcomingRenewals() {
    List<Map<String, dynamic>> upcomingRenewals = leaseAgreements.where((lease) => 
      (lease["days_remaining"] as int) <= 120 && 
      lease["renewal_option"] == true &&
      lease["status"] != "Notice Given").toList();

    upcomingRenewals.sort((a, b) => (a["days_remaining"] as int).compareTo(b["days_remaining"] as int));

    return Container(
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Upcoming Renewals",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Bulk Actions",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...upcomingRenewals.map((lease) {
            int daysRemaining = lease["days_remaining"] as int;
            Color urgencyColor = daysRemaining <= 30 ? dangerColor :
                               daysRemaining <= 60 ? warningColor : infoColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: urgencyColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: urgencyColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${lease["tenant"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${lease["unit"]} - ${lease["property"]}",
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
                        spacing: spXs,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: urgencyColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$daysRemaining days left",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: urgencyColor,
                              ),
                            ),
                          ),
                          Text(
                            "Expires: ${lease["end_date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildRenewalInfo("Current Rent", "\$${((lease["monthly_rent"] as num).toDouble()).currency}"),
                      ),
                      Expanded(
                        child: _buildRenewalInfo("Lease Term", "${lease["lease_term"]} months"),
                      ),
                      Expanded(
                        child: _buildRenewalInfo("Tenant Rating", "4.5★"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Suggested new rent: \$${(((lease["monthly_rent"] as num) * 1.05).toDouble()).currency} (+5%)",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        spacing: spSm,
                        children: [
                          QButton(
                            icon: Icons.message,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          QButton(
                            label: "Start Renewal",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
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

  Widget _buildRenewalInfo(String label, String value) {
    return Column(
      spacing: spXs,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRenewalHistory() {
    List<Map<String, dynamic>> renewalHistory = [
      {
        "tenant": "John Smith",
        "unit": "Unit 101",
        "property": "Downtown Apartment Complex",
        "renewal_date": "2024-11-15",
        "old_rent": 2300.0,
        "new_rent": 2400.0,
        "term_length": 12,
        "status": "Completed",
      },
      {
        "tenant": "Lisa Wang",
        "unit": "Villa 2",
        "property": "Riverside Villa Community",
        "renewal_date": "2024-10-30",
        "old_rent": 3000.0,
        "new_rent": 3150.0,
        "term_length": 12,
        "status": "Completed",
      },
      {
        "tenant": "Robert Davis",
        "unit": "Condo 8A",
        "property": "Garden Heights Condos",
        "renewal_date": "2024-12-01",
        "old_rent": 1750.0,
        "new_rent": 1750.0,
        "term_length": 12,
        "status": "Declined",
      },
    ];

    return Container(
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Recent Renewal Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...renewalHistory.map((renewal) {
            Color statusColor = renewal["status"] == "Completed" ? successColor : dangerColor;
            double rentIncrease = ((renewal["new_rent"] as num) - (renewal["old_rent"] as num)).toDouble();
            double increasePercent = (rentIncrease / (renewal["old_rent"] as num)) * 100;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      renewal["status"] == "Completed" ? Icons.check_circle : Icons.cancel,
                      color: statusColor,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${renewal["tenant"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${renewal["unit"]} - ${renewal["property"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Renewed: ${renewal["renewal_date"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            if (rentIncrease > 0)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "+\$${rentIncrease.currency} (+${increasePercent.toStringAsFixed(1)}%)",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              )
                            else if (rentIncrease == 0)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Same Rate",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: spXs,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${renewal["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((renewal["new_rent"] as num).toDouble()).currency}/mo",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
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
}
