import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCoopManagementView extends StatefulWidget {
  const RmaCoopManagementView({super.key});

  @override
  State<RmaCoopManagementView> createState() => _RmaCoopManagementViewState();
}

class _RmaCoopManagementViewState extends State<RmaCoopManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedBuilding = "";
  String selectedStatus = "";
  String selectedShareClass = "";

  List<Map<String, dynamic>> buildingOptions = [
    {"label": "All Buildings", "value": ""},
    {"label": "North Wing", "value": "north-wing"},
    {"label": "South Wing", "value": "south-wing"},
    {"label": "East Tower", "value": "east-tower"},
    {"label": "West Tower", "value": "west-tower"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Owner Occupied", "value": "owner-occupied"},
    {"label": "Sublet", "value": "sublet"},
    {"label": "For Sale", "value": "for-sale"},
    {"label": "Available", "value": "available"},
    {"label": "Flip Tax Due", "value": "flip-tax-due"},
  ];

  List<Map<String, dynamic>> shareClassOptions = [
    {"label": "All Classes", "value": ""},
    {"label": "Class A", "value": "class-a"},
    {"label": "Class B", "value": "class-b"},
    {"label": "Class C", "value": "class-c"},
    {"label": "Penthouse", "value": "penthouse"},
  ];

  List<Map<String, dynamic>> coopUnits = [
    {
      "id": "coop001",
      "unitNumber": "4B",
      "building": "North Wing",
      "floor": 4,
      "shareClass": "Class B",
      "shares": 1850,
      "status": "Owner Occupied",
      "rooms": "2BR/1BA",
      "sqft": 1100,
      "ownerName": "Michael Chen",
      "ownerContact": "mchen@email.com",
      "maintenanceFee": 890,
      "marketValue": 420000,
      "purchasePrice": 385000,
      "purchaseDate": "2022-03-15",
      "flipTaxPaid": true,
      "subletAllowed": true,
      "image": "https://picsum.photos/300/200?random=1&keyword=apartment",
    },
    {
      "id": "coop002",
      "unitNumber": "12A",
      "building": "East Tower",
      "floor": 12,
      "shareClass": "Class A",
      "shares": 2240,
      "status": "Sublet",
      "rooms": "3BR/2BA",
      "sqft": 1450,
      "ownerName": "Jennifer Smith",
      "ownerContact": "jsmith@email.com",
      "tenantName": "Robert Wilson",
      "subletRent": 3200,
      "maintenanceFee": 1150,
      "marketValue": 580000,
      "purchasePrice": 510000,
      "purchaseDate": "2021-09-22",
      "flipTaxPaid": true,
      "subletAllowed": true,
      "subletApproved": true,
      "image": "https://picsum.photos/300/200?random=2&keyword=coop",
    },
    {
      "id": "coop003",
      "unitNumber": "8C",
      "building": "South Wing",
      "floor": 8,
      "shareClass": "Class C",
      "shares": 1420,
      "status": "For Sale",
      "rooms": "1BR/1BA",
      "sqft": 850,
      "ownerName": "Heritage Properties LLC",
      "ownerContact": "info@heritage.com",
      "askingPrice": 365000,
      "maintenanceFee": 720,
      "marketValue": 355000,
      "purchasePrice": 295000,
      "purchaseDate": "2020-11-08",
      "flipTaxPaid": false,
      "flipTaxAmount": 7300,
      "subletAllowed": false,
      "image": "https://picsum.photos/300/200?random=3&keyword=studio",
    },
    {
      "id": "coop004",
      "unitNumber": "PH2",
      "building": "West Tower",
      "floor": 20,
      "shareClass": "Penthouse",
      "shares": 4680,
      "status": "Owner Occupied",
      "rooms": "4BR/3BA",
      "sqft": 2800,
      "ownerName": "Elizabeth Davis",
      "ownerContact": "edavis@email.com",
      "maintenanceFee": 2150,
      "marketValue": 1250000,
      "purchasePrice": 980000,
      "purchaseDate": "2019-06-30",
      "flipTaxPaid": true,
      "subletAllowed": true,
      "boardMember": true,
      "image": "https://picsum.photos/300/200?random=4&keyword=penthouse",
    },
  ];

  List<Map<String, dynamic>> boardMembers = [
    {
      "name": "Elizabeth Davis",
      "position": "President",
      "unit": "PH2",
      "term": "2024-2026",
      "email": "edavis@email.com",
    },
    {
      "name": "Michael Chen",
      "position": "Vice President",
      "unit": "4B",
      "term": "2024-2026",
      "email": "mchen@email.com",
    },
    {
      "name": "Sarah Thompson",
      "position": "Treasurer",
      "unit": "6A",
      "term": "2023-2025",
      "email": "sthompson@email.com",
    },
    {
      "name": "David Rodriguez",
      "position": "Secretary",
      "unit": "9C",
      "term": "2023-2025",
      "email": "drodriguez@email.com",
    },
  ];

  List<Map<String, dynamic>> boardMeetings = [
    {
      "date": "2025-02-15",
      "time": "19:00",
      "type": "Monthly Board Meeting",
      "location": "Community Room",
      "agenda": ["Budget Review", "Maintenance Updates", "Sublet Applications", "Building Security"],
      "status": "Scheduled",
    },
    {
      "date": "2025-01-18",
      "time": "19:00",
      "type": "Monthly Board Meeting",
      "location": "Community Room",
      "agenda": ["Holiday Schedule", "Elevator Maintenance", "New Applications"],
      "status": "Completed",
      "minutes": "Minutes available",
    },
    {
      "date": "2025-03-20",
      "time": "18:30",
      "type": "Annual Shareholder Meeting",
      "location": "Main Hall",
      "agenda": ["Annual Report", "Budget Approval", "Board Elections", "Building Improvements"],
      "status": "Upcoming",
    },
  ];

  List<Map<String, dynamic>> applications = [
    {
      "id": "app001",
      "type": "Purchase Application",
      "applicantName": "James Wilson",
      "unit": "5A",
      "submittedDate": "2025-01-10",
      "status": "Under Review",
      "documents": ["Financial Statement", "References", "Board Package"],
      "interviewDate": "2025-01-25",
    },
    {
      "id": "app002",
      "type": "Sublet Application",
      "applicantName": "Lisa Chen",
      "unit": "7B",
      "submittedDate": "2025-01-12",
      "status": "Approved",
      "documents": ["Tenant Application", "Financial Verification", "Reference Letters"],
      "approvedDate": "2025-01-20",
    },
    {
      "id": "app003",
      "type": "Alteration Application",
      "applicantName": "Robert Kim",
      "unit": "3C",
      "submittedDate": "2025-01-15",
      "status": "Pending Documents",
      "documents": ["Architectural Plans", "Contractor License", "Insurance Certificate"],
      "missingDocuments": ["Engineer's Report"],
    },
  ];

  List<Map<String, dynamic>> get filteredUnits {
    return coopUnits.where((unit) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${unit["unitNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${unit["ownerName"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesBuilding = selectedBuilding.isEmpty || unit["building"] == buildingOptions.firstWhere((b) => b["value"] == selectedBuilding)["label"];
      bool matchesStatus = selectedStatus.isEmpty || unit["status"] == statusOptions.firstWhere((s) => s["value"] == selectedStatus)["label"];
      bool matchesClass = selectedShareClass.isEmpty || unit["shareClass"] == shareClassOptions.firstWhere((c) => c["value"] == selectedShareClass)["label"];
      
      return matchesSearch && matchesBuilding && matchesStatus && matchesClass;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Co-op Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Shareholders", icon: Icon(Icons.group)),
        Tab(text: "Board", icon: Icon(Icons.account_balance)),
        Tab(text: "Applications", icon: Icon(Icons.assignment)),
      ],
      tabChildren: [
        _buildShareholdersTab(),
        _buildBoardTab(),
        _buildApplicationsTab(),
      ],
    );
  }

  Widget _buildShareholdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildShareholdersOverview(),
          _buildShareholdersList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search Shareholders",
          value: searchQuery,
          hint: "Search by unit number or owner name",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Building",
                items: buildingOptions,
                value: selectedBuilding,
                onChanged: (value, label) {
                  selectedBuilding = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
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
          ],
        ),
        QDropdownField(
          label: "Share Class",
          items: shareClassOptions,
          value: selectedShareClass,
          onChanged: (value, label) {
            selectedShareClass = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildShareholdersOverview() {
    int totalShares = coopUnits.fold(0, (sum, unit) => sum + (unit["shares"] as int));
    double avgMaintenance = coopUnits.fold(0.0, (sum, unit) => sum + (unit["maintenanceFee"] as int)) / coopUnits.length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Total Units", "${coopUnits.length}", Icons.home, primaryColor),
        _buildOverviewCard("Total Shares", "${totalShares}", Icons.pie_chart, successColor),
        _buildOverviewCard("Owner Occupied", "${coopUnits.where((u) => u["status"] == "Owner Occupied").length}", Icons.person_pin, infoColor),
        _buildOverviewCard("Avg Maintenance", "\$${avgMaintenance.toStringAsFixed(0)}", Icons.account_balance_wallet, warningColor),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "LIVE",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: color,
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

  Widget _buildShareholdersList() {
    return Column(
      children: filteredUnits.map((unit) => _buildShareholderCard(unit)).toList(),
    );
  }

  Widget _buildShareholderCard(Map<String, dynamic> unit) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
              image: DecorationImage(
                image: NetworkImage("${unit["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(unit["status"]),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${unit["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Unit ${unit["unitNumber"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${unit["shareClass"]} • ${unit["shares"]} shares",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.business, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${unit["building"]} • Floor ${unit["floor"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    if (unit["boardMember"] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "BOARD",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Owner",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${unit["ownerName"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rooms",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${unit["rooms"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Square Feet",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${unit["sqft"]} sq ft",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Maintenance Fee",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${unit["maintenanceFee"]}/month",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Market Value",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((unit["marketValue"] as int) / 1000).toStringAsFixed(0)}K",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Purchase Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            DateTime.parse("${unit["purchaseDate"]}").dMMMy,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (unit["status"] == "Sublet" && unit["tenantName"] != null)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.person, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Tenant: ${unit["tenantName"]} • \$${unit["subletRent"]}/month",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (unit["status"] == "For Sale")
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.sell, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Asking Price: \$${((unit["askingPrice"] as int) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                        if (unit["flipTaxPaid"] == false) ...[
                          Spacer(),
                          Text(
                            "Flip Tax: \$${unit["flipTaxAmount"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                      decoration: BoxDecoration(
                        color: unit["flipTaxPaid"] == true ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        unit["flipTaxPaid"] == true ? "Flip Tax Paid" : "Flip Tax Due",
                        style: TextStyle(
                          fontSize: 12,
                          color: unit["flipTaxPaid"] == true ? successColor : dangerColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                      decoration: BoxDecoration(
                        color: unit["subletAllowed"] == true ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        unit["subletAllowed"] == true ? "Sublet Allowed" : "No Sublet",
                        style: TextStyle(
                          fontSize: 12,
                          color: unit["subletAllowed"] == true ? primaryColor : disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () => _showShareholderDetails(unit),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.email,
                      size: bs.sm,
                      onPressed: () => _contactShareholder(unit),
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

  Widget _buildBoardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBoardMembers(),
          _buildUpcomingMeetings(),
          _buildMeetingHistory(),
        ],
      ),
    );
  }

  Widget _buildBoardMembers() {
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
          Text(
            "Board of Directors",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...boardMembers.map((member) => _buildBoardMemberCard(member)).toList(),
        ],
      ),
    );
  }

  Widget _buildBoardMemberCard(Map<String, dynamic> member) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${member["name"]}".substring(0, 1),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
                  "${member["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${member["position"]} • Unit ${member["unit"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Term: ${member["term"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.email,
            size: bs.sm,
            onPressed: () => _contactBoardMember(member),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingMeetings() {
    List<Map<String, dynamic>> upcoming = boardMeetings.where((m) => m["status"] == "Scheduled" || m["status"] == "Upcoming").toList();

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
          Text(
            "Upcoming Meetings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...upcoming.map((meeting) => _buildMeetingCard(meeting)).toList(),
        ],
      ),
    );
  }

  Widget _buildMeetingHistory() {
    List<Map<String, dynamic>> completed = boardMeetings.where((m) => m["status"] == "Completed").toList();

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
          Text(
            "Meeting History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...completed.map((meeting) => _buildMeetingCard(meeting)).toList(),
        ],
      ),
    );
  }

  Widget _buildMeetingCard(Map<String, dynamic> meeting) {
    Color statusColor = _getMeetingStatusColor(meeting["status"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${meeting["type"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${meeting["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${DateTime.parse("${meeting["date"]}").dMMMy} at ${meeting["time"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${meeting["location"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Agenda:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          ...((meeting["agenda"] as List).map((item) => Padding(
            padding: EdgeInsets.only(left: spSm),
            child: Text(
              "• $item",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
          ))).toList(),
          if (meeting["minutes"] != null)
            Padding(
              padding: EdgeInsets.only(top: spSm),
              child: Row(
                children: [
                  Icon(Icons.description, size: 16, color: successColor),
                  SizedBox(width: spXs),
                  Text(
                    "${meeting["minutes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildApplicationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildApplicationsOverview(),
          _buildApplicationsList(),
        ],
      ),
    );
  }

  Widget _buildApplicationsOverview() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildApplicationStatCard("Total Applications", "${applications.length}", Icons.assignment, primaryColor),
        _buildApplicationStatCard("Under Review", "${applications.where((a) => a["status"] == "Under Review").length}", Icons.rate_review, warningColor),
        _buildApplicationStatCard("Approved", "${applications.where((a) => a["status"] == "Approved").length}", Icons.check_circle, successColor),
        _buildApplicationStatCard("Pending", "${applications.where((a) => a["status"] == "Pending Documents").length}", Icons.pending, dangerColor),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "2025",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: color,
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

  Widget _buildApplicationsList() {
    return Column(
      children: applications.map((application) => _buildApplicationCard(application)).toList(),
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> application) {
    Color statusColor = _getApplicationStatusColor(application["status"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${application["type"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${application["applicantName"]} • Unit ${application["unit"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${application["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Submitted: ${DateTime.parse("${application["submittedDate"]}").dMMMy}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (application["interviewDate"] != null)
            Row(
              children: [
                Icon(Icons.event, size: 16, color: warningColor),
                SizedBox(width: spXs),
                Text(
                  "Interview: ${DateTime.parse("${application["interviewDate"]}").dMMMy}",
                  style: TextStyle(
                    fontSize: 14,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          if (application["approvedDate"] != null)
            Row(
              children: [
                Icon(Icons.check_circle, size: 16, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "Approved: ${DateTime.parse("${application["approvedDate"]}").dMMMy}",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          SizedBox(height: spSm),
          Text(
            "Documents:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (application["documents"] as List).map((doc) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$doc",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          if (application["missingDocuments"] != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: spSm),
                Text(
                  "Missing Documents:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (application["missingDocuments"] as List).map((doc) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$doc",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Review Application",
                  size: bs.sm,
                  onPressed: () => _reviewApplication(application),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showApplicationOptions(application),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Owner Occupied":
        return successColor;
      case "Sublet":
        return infoColor;
      case "For Sale":
        return warningColor;
      case "Available":
        return primaryColor;
      case "Flip Tax Due":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getMeetingStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return warningColor;
      case "Upcoming":
        return infoColor;
      case "Completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getApplicationStatusColor(String status) {
    switch (status) {
      case "Under Review":
        return warningColor;
      case "Approved":
        return successColor;
      case "Pending Documents":
        return dangerColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showShareholderDetails(Map<String, dynamic> unit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Unit ${unit["unitNumber"]} Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Building: ${unit["building"]}"),
              Text("Floor: ${unit["floor"]}"),
              Text("Share Class: ${unit["shareClass"]}"),
              Text("Shares: ${unit["shares"]}"),
              Text("Status: ${unit["status"]}"),
              Text("Rooms: ${unit["rooms"]}"),
              Text("Square Feet: ${unit["sqft"]} sq ft"),
              Text("Owner: ${unit["ownerName"]}"),
              Text("Contact: ${unit["ownerContact"]}"),
              Text("Maintenance Fee: \$${unit["maintenanceFee"]}/month"),
              Text("Market Value: \$${((unit["marketValue"] as int).toDouble()).currency}"),
              Text("Purchase Price: \$${((unit["purchasePrice"] as int).toDouble()).currency}"),
              Text("Purchase Date: ${DateTime.parse("${unit["purchaseDate"]}").dMMMy}"),
              if (unit["tenantName"] != null)
                Text("Tenant: ${unit["tenantName"]}"),
              if (unit["subletRent"] != null)
                Text("Sublet Rent: \$${unit["subletRent"]}/month"),
              if (unit["askingPrice"] != null)
                Text("Asking Price: \$${((unit["askingPrice"] as int).toDouble()).currency}"),
              Text("Flip Tax Paid: ${unit["flipTaxPaid"] ? 'Yes' : 'No'}"),
              Text("Sublet Allowed: ${unit["subletAllowed"] ? 'Yes' : 'No'}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _contactShareholder(Map<String, dynamic> unit) {
    ss("Contacting ${unit["ownerName"]} at ${unit["ownerContact"]}");
  }

  void _contactBoardMember(Map<String, dynamic> member) {
    ss("Contacting ${member["name"]} at ${member["email"]}");
  }

  void _reviewApplication(Map<String, dynamic> application) {
    ss("Reviewing ${application["type"]} for ${application["applicantName"]}");
  }

  void _showApplicationOptions(Map<String, dynamic> application) {
    ss("More options for application ${application["id"]}");
  }
}
