import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaLoyaltyProgramView extends StatefulWidget {
  const RmaLoyaltyProgramView({super.key});

  @override
  State<RmaLoyaltyProgramView> createState() => _RmaLoyaltyProgramViewState();
}

class _RmaLoyaltyProgramViewState extends State<RmaLoyaltyProgramView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedTier = "All";
  String selectedStatus = "All";
  String selectedProgram = "All";
  DateTime? fromDate;
  DateTime? toDate;
  bool showFilters = false;

  List<Map<String, dynamic>> loyaltyMembers = [
    {
      "id": "LP001",
      "name": "Emily Johnson",
      "email": "emily.johnson@email.com",
      "phone": "+1 555-0123",
      "tier": "Platinum",
      "points": 12500,
      "totalSpent": 5800.0,
      "visits": 42,
      "lastVisit": "2024-01-15",
      "joinDate": "2023-06-15",
      "status": "Active",
      "program": "VIP Rewards",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "rewards": [
        {"name": "Free Coffee", "points": 500, "redeemed": 8},
        {"name": "10% Discount", "points": 1000, "redeemed": 3},
      ],
    },
    {
      "id": "LP002",
      "name": "Michael Chen",
      "email": "michael.chen@email.com",
      "phone": "+1 555-0124",
      "tier": "Gold",
      "points": 8750,
      "totalSpent": 3200.0,
      "visits": 28,
      "lastVisit": "2024-01-14",
      "joinDate": "2023-08-22",
      "status": "Active",
      "program": "Standard",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "rewards": [
        {"name": "Free Pastry", "points": 300, "redeemed": 12},
        {"name": "5% Discount", "points": 750, "redeemed": 5},
      ],
    },
    {
      "id": "LP003",
      "name": "Sarah Williams",
      "email": "sarah.williams@email.com",
      "phone": "+1 555-0125",
      "tier": "Silver",
      "points": 4200,
      "totalSpent": 1850.0,
      "visits": 18,
      "lastVisit": "2024-01-12",
      "joinDate": "2023-10-10",
      "status": "Active",
      "program": "Standard",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "rewards": [
        {"name": "Free Size Upgrade", "points": 200, "redeemed": 6},
      ],
    },
    {
      "id": "LP004",
      "name": "David Rodriguez",
      "email": "david.rodriguez@email.com",
      "phone": "+1 555-0126",
      "tier": "Bronze",
      "points": 1800,
      "totalSpent": 920.0,
      "visits": 12,
      "lastVisit": "2024-01-10",
      "joinDate": "2023-11-05",
      "status": "Inactive",
      "program": "Basic",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "rewards": [
        {"name": "Welcome Bonus", "points": 100, "redeemed": 1},
      ],
    },
  ];

  List<Map<String, dynamic>> loyaltyPrograms = [
    {
      "id": "PROG001",
      "name": "VIP Rewards",
      "description": "Premium loyalty program for high-value customers",
      "type": "Tiered",
      "members": 156,
      "pointsRatio": "1 point per \$1 spent",
      "status": "Active",
      "created": "2023-01-15",
      "tiers": [
        {"name": "Bronze", "minSpent": 0, "multiplier": 1.0, "benefits": "Basic rewards"},
        {"name": "Silver", "minSpent": 500, "multiplier": 1.2, "benefits": "5% bonus points"},
        {"name": "Gold", "minSpent": 1500, "multiplier": 1.5, "benefits": "10% bonus points"},
        {"name": "Platinum", "minSpent": 3000, "multiplier": 2.0, "benefits": "Double points"},
      ],
    },
    {
      "id": "PROG002",
      "name": "Standard",
      "description": "Basic loyalty program for regular customers",
      "type": "Points-based",
      "members": 324,
      "pointsRatio": "1 point per \$2 spent",
      "status": "Active",
      "created": "2023-02-01",
      "tiers": [
        {"name": "Member", "minSpent": 0, "multiplier": 1.0, "benefits": "Standard rewards"},
      ],
    },
    {
      "id": "PROG003",
      "name": "Basic",
      "description": "Entry-level loyalty program",
      "type": "Punch Card",
      "members": 98,
      "pointsRatio": "1 point per visit",
      "status": "Active",
      "created": "2023-03-10",
      "tiers": [
        {"name": "Basic", "minSpent": 0, "multiplier": 1.0, "benefits": "Visit rewards"},
      ],
    },
  ];

  List<Map<String, dynamic>> rewards = [
    {
      "id": "REW001",
      "name": "Free Coffee",
      "description": "Any size coffee of your choice",
      "points": 500,
      "category": "Beverage",
      "validity": 30,
      "status": "Active",
      "redemptions": 245,
      "image": "https://picsum.photos/80/80?random=10&keyword=coffee",
    },
    {
      "id": "REW002",
      "name": "10% Discount",
      "description": "10% off on total bill",
      "points": 1000,
      "category": "Discount",
      "validity": 15,
      "status": "Active",
      "redemptions": 156,
      "image": "https://picsum.photos/80/80?random=11&keyword=discount",
    },
    {
      "id": "REW003",
      "name": "Free Pastry",
      "description": "Any pastry from our selection",
      "points": 300,
      "category": "Food",
      "validity": 7,
      "status": "Active",
      "redemptions": 189,
      "image": "https://picsum.photos/80/80?random=12&keyword=pastry",
    },
    {
      "id": "REW004",
      "name": "Birthday Special",
      "description": "Free birthday cake slice",
      "points": 0,
      "category": "Special",
      "validity": 365,
      "status": "Active",
      "redemptions": 67,
      "image": "https://picsum.photos/80/80?random=13&keyword=cake",
    },
  ];

  List<Map<String, dynamic>> tierBenefits = [
    {
      "tier": "Bronze",
      "color": 0xFFCD7F32,
      "minSpent": 0,
      "pointMultiplier": 1.0,
      "benefits": [
        "Earn 1 point per \$1 spent",
        "Birthday reward",
        "Welcome bonus",
      ],
    },
    {
      "tier": "Silver",
      "color": 0xFFC0C0C0,
      "minSpent": 500,
      "pointMultiplier": 1.2,
      "benefits": [
        "20% bonus points",
        "Free size upgrade",
        "Priority support",
        "Quarterly bonus rewards",
      ],
    },
    {
      "tier": "Gold",
      "color": 0xFFFFD700,
      "minSpent": 1500,
      "pointMultiplier": 1.5,
      "benefits": [
        "50% bonus points",
        "Free delivery",
        "Early access to new products",
        "Monthly bonus rewards",
        "VIP customer service",
      ],
    },
    {
      "tier": "Platinum",
      "color": 0xFF71797E,
      "minSpent": 3000,
      "pointMultiplier": 2.0,
      "benefits": [
        "Double points on all purchases",
        "Complimentary premium items",
        "Personal account manager",
        "Exclusive events access",
        "Weekly bonus rewards",
        "Priority reservations",
      ],
    },
  ];

  void _showMemberDetails(Map<String, dynamic> member) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${member["avatar"]}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${member["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${member["tier"]} Member",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoSection("Contact Information", [
                        {"label": "Email", "value": member["email"]},
                        {"label": "Phone", "value": member["phone"]},
                        {"label": "Member ID", "value": member["id"]},
                      ]),
                      SizedBox(height: spMd),
                      _buildInfoSection("Loyalty Stats", [
                        {"label": "Current Points", "value": "${(member["points"] as int).toString()} pts"},
                        {"label": "Total Spent", "value": "\$${((member["totalSpent"] as double)).currency}"},
                        {"label": "Total Visits", "value": "${member["visits"]} visits"},
                        {"label": "Join Date", "value": DateTime.parse("${member["joinDate"]}").dMMMy},
                        {"label": "Last Visit", "value": DateTime.parse("${member["lastVisit"]}").dMMMy},
                      ]),
                      SizedBox(height: spMd),
                      Text(
                        "Redeemed Rewards",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...(member["rewards"] as List).map((reward) => Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${reward["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${(reward["points"] as int)} points",
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
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Redeemed ${reward["redeemed"]}x",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Map<String, String>> items) {
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
        ...items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: spXs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  "${item["label"]}:",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${item["value"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  void _showProgramDetails(Map<String, dynamic> program) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${program["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${program["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoSection("Program Details", [
                        {"label": "Type", "value": program["type"]},
                        {"label": "Members", "value": "${program["members"]} members"},
                        {"label": "Points Ratio", "value": program["pointsRatio"]},
                        {"label": "Status", "value": program["status"]},
                        {"label": "Created", "value": DateTime.parse("${program["created"]}").dMMMy},
                      ]),
                      SizedBox(height: spMd),
                      Text(
                        "Tier Structure",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...(program["tiers"] as List).map((tier) => Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${tier["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${(tier["multiplier"] as double).toStringAsFixed(1)}x points",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Min. spend: \$${(tier["minSpent"] as int)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${tier["benefits"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRewardDetails(Map<String, dynamic> reward) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${reward["image"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${reward["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${reward["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Divider(),
              SizedBox(height: spMd),
              _buildInfoSection("Reward Details", [
                {"label": "Points Required", "value": "${reward["points"]} points"},
                {"label": "Category", "value": reward["category"]},
                {"label": "Validity", "value": "${reward["validity"]} days"},
                {"label": "Status", "value": reward["status"]},
                {"label": "Total Redemptions", "value": "${reward["redemptions"]} times"},
              ]),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Edit Reward",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.of(context).pop();
                        ss("Editing reward functionality would be implemented here");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Deactivate",
                      size: bs.sm,
                      color: dangerColor,
                      onPressed: () async {
                        bool isConfirmed = await confirm("Are you sure you want to deactivate this reward?");
                        if (isConfirmed) {
                          Navigator.of(context).pop();
                          ss("Reward deactivated successfully");
                        }
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

  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, String selectedValue, Function(String) onSelected) {
    bool isSelected = selectedValue == value;
    return GestureDetector(
      onTap: () => onSelected(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : disabledBoldColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildMembersTab() {
    List<Map<String, dynamic>> filteredMembers = loyaltyMembers.where((member) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${member["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${member["email"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${member["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesTier = selectedTier == "All" || member["tier"] == selectedTier;
      bool matchesStatus = selectedStatus == "All" || member["status"] == selectedStatus;
      bool matchesProgram = selectedProgram == "All" || member["program"] == selectedProgram;
      
      return matchesSearch && matchesTier && matchesStatus && matchesProgram;
    }).toList();

    return Column(
      children: [
        // Stats Cards
        ResponsiveGridView(
          padding: EdgeInsets.all(spMd),
          minItemWidth: 160,
          children: [
            _buildStatsCard("Total Members", "578", Icons.people, primaryColor),
            _buildStatsCard("Active Members", "523", Icons.person_add, successColor),
            _buildStatsCard("Points Issued", "1.2M", Icons.stars, warningColor),
            _buildStatsCard("Rewards Redeemed", "2.3K", Icons.redeem, infoColor),
          ],
        ),
        
        // Search and Filters
        Container(
          padding: EdgeInsets.symmetric(horizontal: spMd),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search members...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: showFilters ? Icons.filter_list_off : Icons.filter_list,
                    size: bs.sm,
                    onPressed: () {
                      showFilters = !showFilters;
                      setState(() {});
                    },
                  ),
                ],
              ),
              if (showFilters) ...[
                SizedBox(height: spMd),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tier",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip("All", "All", selectedTier, (value) {
                            selectedTier = value;
                            setState(() {});
                          }),
                          SizedBox(width: spSm),
                          _buildFilterChip("Bronze", "Bronze", selectedTier, (value) {
                            selectedTier = value;
                            setState(() {});
                          }),
                          SizedBox(width: spSm),
                          _buildFilterChip("Silver", "Silver", selectedTier, (value) {
                            selectedTier = value;
                            setState(() {});
                          }),
                          SizedBox(width: spSm),
                          _buildFilterChip("Gold", "Gold", selectedTier, (value) {
                            selectedTier = value;
                            setState(() {});
                          }),
                          SizedBox(width: spSm),
                          _buildFilterChip("Platinum", "Platinum", selectedTier, (value) {
                            selectedTier = value;
                            setState(() {});
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Status",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        _buildFilterChip("All", "All", selectedStatus, (value) {
                          selectedStatus = value;
                          setState(() {});
                        }),
                        SizedBox(width: spSm),
                        _buildFilterChip("Active", "Active", selectedStatus, (value) {
                          selectedStatus = value;
                          setState(() {});
                        }),
                        SizedBox(width: spSm),
                        _buildFilterChip("Inactive", "Inactive", selectedStatus, (value) {
                          selectedStatus = value;
                          setState(() {});
                        }),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Members List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: filteredMembers.length,
            itemBuilder: (context, index) {
              final member = filteredMembers[index];
              Color tierColor;
              switch (member["tier"]) {
                case "Platinum":
                  tierColor = Color(0xFF71797E);
                  break;
                case "Gold":
                  tierColor = Color(0xFFFFD700);
                  break;
                case "Silver":
                  tierColor = Color(0xFFC0C0C0);
                  break;
                default:
                  tierColor = Color(0xFFCD7F32);
              }
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${member["avatar"]}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
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
                                      "${member["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: tierColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${member["tier"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: tierColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${member["email"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${member["id"]} • ${member["program"]}",
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
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${(member["points"] as int).toString()}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Points",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "\$${((member["totalSpent"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Total Spent",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${member["visits"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Visits",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.visibility,
                          size: bs.sm,
                          onPressed: () => _showMemberDetails(member),
                        ),
                      ],
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

  Widget _buildProgramsTab() {
    return Column(
      children: [
        // Stats Cards
        ResponsiveGridView(
          padding: EdgeInsets.all(spMd),
          minItemWidth: 180,
          children: [
            _buildStatsCard("Active Programs", "3", Icons.card_membership, primaryColor),
            _buildStatsCard("Total Enrolled", "578", Icons.people, successColor),
            _buildStatsCard("Avg. Points/Member", "6.2K", Icons.trending_up, warningColor),
          ],
        ),
        
        // Programs List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: loyaltyPrograms.length,
            itemBuilder: (context, index) {
              final program = loyaltyPrograms[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
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
                                "${program["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${program["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${program["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Divider(),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Type",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${program["type"]}",
                                style: TextStyle(
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
                                "Members",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${program["members"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.visibility,
                          size: bs.sm,
                          onPressed: () => _showProgramDetails(program),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Points Ratio: ${program["pointsRatio"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
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

  Widget _buildRewardsTab() {
    return Column(
      children: [
        // Stats Cards
        ResponsiveGridView(
          padding: EdgeInsets.all(spMd),
          minItemWidth: 160,
          children: [
            _buildStatsCard("Active Rewards", "12", Icons.redeem, primaryColor),
            _buildStatsCard("Total Redemptions", "2.3K", Icons.shopping_cart, successColor),
            _buildStatsCard("Avg. Points", "625", Icons.stars, warningColor),
            _buildStatsCard("Popular Reward", "Free Coffee", Icons.local_cafe, infoColor),
          ],
        ),
        
        // Rewards Grid
        Expanded(
          child: ResponsiveGridView(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            minItemWidth: 200,
            children: rewards.map((reward) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${reward["image"]}",
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${reward["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${reward["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(reward["points"] as int)} points",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${reward["redemptions"]} redeemed",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.visibility,
                        size: bs.sm,
                        onPressed: () => _showRewardDetails(reward),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTiersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tier Benefits & Requirements",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Our loyalty program offers four tiers with increasing benefits based on annual spending.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spLg),
          ...tierBenefits.map((tier) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border.all(
                color: Color(tier["color"] as int).withAlpha(50),
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Color(tier["color"] as int),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Text(
                        "${tier["tier"]} Tier",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Color(tier["color"] as int).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${(tier["pointMultiplier"] as double).toStringAsFixed(1)}x Points",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(tier["color"] as int),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Minimum Spend",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${(tier["minSpent"] as int)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
                            "Point Multiplier",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(tier["pointMultiplier"] as double).toStringAsFixed(1)}x",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "Benefits",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...(tier["benefits"] as List<String>).map((benefit) => Padding(
                  padding: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          benefit,
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Loyalty Program",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Members", icon: Icon(Icons.people)),
        Tab(text: "Programs", icon: Icon(Icons.card_membership)),
        Tab(text: "Rewards", icon: Icon(Icons.redeem)),
        Tab(text: "Tiers", icon: Icon(Icons.military_tech)),
      ],
      tabChildren: [
        _buildMembersTab(),
        _buildProgramsTab(),
        _buildRewardsTab(),
        _buildTiersTab(),
      ],
    );
  }
}
