import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCustomerGroupsView extends StatefulWidget {
  const PosCustomerGroupsView({super.key});

  @override
  State<PosCustomerGroupsView> createState() => _PosCustomerGroupsViewState();
}

class _PosCustomerGroupsViewState extends State<PosCustomerGroupsView> {
  String searchQuery = "";
  String selectedGroup = "";
  String groupName = "";
  String groupDescription = "";
  String discountPercentage = "";
  String minimumSpend = "";
  bool isActive = true;

  List<Map<String, dynamic>> customerGroups = [
    {
      "id": "1",
      "name": "VIP Customers",
      "description": "High-value customers with exclusive benefits",
      "memberCount": 125,
      "discountPercentage": 15,
      "minimumSpend": 500,
      "totalSpent": 75000,
      "averageOrderValue": 245,
      "isActive": true,
      "color": Colors.purple,
      "created": "2024-01-15",
      "lastUpdated": "2024-06-10",
    },
    {
      "id": "2",
      "name": "Regular Customers",
      "description": "Standard customers with basic benefits",
      "memberCount": 450,
      "discountPercentage": 5,
      "minimumSpend": 100,
      "totalSpent": 125000,
      "averageOrderValue": 95,
      "isActive": true,
      "color": Colors.blue,
      "created": "2024-02-01",
      "lastUpdated": "2024-06-15",
    },
    {
      "id": "3",
      "name": "Students",
      "description": "Student discount program",
      "memberCount": 89,
      "discountPercentage": 10,
      "minimumSpend": 50,
      "totalSpent": 15000,
      "averageOrderValue": 65,
      "isActive": true,
      "color": Colors.green,
      "created": "2024-03-01",
      "lastUpdated": "2024-06-12",
    },
    {
      "id": "4",
      "name": "Seniors",
      "description": "Senior citizen discount program",
      "memberCount": 67,
      "discountPercentage": 12,
      "minimumSpend": 75,
      "totalSpent": 12500,
      "averageOrderValue": 85,
      "isActive": false,
      "color": Colors.orange,
      "created": "2024-01-20",
      "lastUpdated": "2024-05-30",
    },
  ];

  List<Map<String, dynamic>> groupMembers = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 555-0123",
      "groupId": "1",
      "joinDate": "2024-01-20",
      "totalSpent": 1250,
      "orderCount": 15,
      "lastOrder": "2024-06-18",
      "lifetimeValue": 2500,
    },
    {
      "id": "2",
      "name": "Mike Chen", 
      "email": "mike.chen@email.com",
      "phone": "+1 555-0124",
      "groupId": "1",
      "joinDate": "2024-02-15",
      "totalSpent": 890,
      "orderCount": 8,
      "lastOrder": "2024-06-17",
      "lifetimeValue": 1800,
    },
    {
      "id": "3",
      "name": "Emma Davis",
      "email": "emma.davis@email.com", 
      "phone": "+1 555-0125",
      "groupId": "2",
      "joinDate": "2024-03-10",
      "totalSpent": 450,
      "orderCount": 6,
      "lastOrder": "2024-06-16",
      "lifetimeValue": 650,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Groups"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _showCreateGroupDialog,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildGroupsOverview(),
            _buildGroupsList(),
            _buildTopPerformingGroups(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search groups...",
          value: searchQuery,
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        QDropdownField(
          label: "Filter by Status",
          items: [
            {"label": "All Groups", "value": ""},
            {"label": "Active", "value": "active"},
            {"label": "Inactive", "value": "inactive"},
          ],
          value: selectedGroup,
          onChanged: (value, label) {
            selectedGroup = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildGroupsOverview() {
    int totalMembers = customerGroups.fold(0, (sum, group) => sum + (group["memberCount"] as int));
    double totalRevenue = customerGroups.fold(0.0, (sum, group) => sum + (group["totalSpent"] as int).toDouble());
    int activeGroups = customerGroups.where((group) => group["isActive"] == true).length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.groups,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$totalMembers",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Total Members",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.attach_money,
                color: successColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "\$${(totalRevenue / 1000).toStringAsFixed(1)}K",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Total Revenue",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle,
                color: infoColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$activeGroups",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Active Groups",
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

  Widget _buildGroupsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Customer Groups",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...customerGroups.map((group) => _buildGroupCard(group)),
      ],
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: group["color"] as Color,
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
                  children: [
                    Text(
                      "${group["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${group["description"]}",
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
                  color: group["isActive"] ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  group["isActive"] ? "Active" : "Inactive",
                  style: TextStyle(
                    fontSize: 12,
                    color: group["isActive"] ? successColor : dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showGroupOptionsDialog(group),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${group["memberCount"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Members",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${group["discountPercentage"]}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${group["averageOrderValue"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Avg Order",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${((group["totalSpent"] as int) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Revenue",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Members",
              size: bs.sm,
              onPressed: () => _showGroupMembersDialog(group),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformingGroups() {
    var sortedGroups = List<Map<String, dynamic>>.from(customerGroups);
    sortedGroups.sort((a, b) => (b["totalSpent"] as int).compareTo(a["totalSpent"] as int));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Top Performing Groups",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              ...sortedGroups.take(3).map((group) => _buildPerformanceItem(group, sortedGroups.indexOf(group) + 1)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceItem(Map<String, dynamic> group, int rank) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: rank == 1 ? Colors.amber : rank == 2 ? Colors.grey : Colors.brown,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Center(
            child: Text(
              "$rank",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${group["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "${group["memberCount"]} members • ${group["discountPercentage"]}% discount",
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
          children: [
            Text(
              "\$${((group["totalSpent"] as int) / 1000).toStringAsFixed(1)}K",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            Text(
              "Revenue",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showCreateGroupDialog() {
    groupName = "";
    groupDescription = "";
    discountPercentage = "";
    minimumSpend = "";
    isActive = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Customer Group"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Group Name",
              value: groupName,
              onChanged: (value) {
                groupName = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Description",
              value: groupDescription,
              onChanged: (value) {
                groupDescription = value;
                setState(() {});
              },
            ),
            QNumberField(
              label: "Discount Percentage (%)",
              value: discountPercentage,
              onChanged: (value) {
                discountPercentage = value;
                setState(() {});
              },
            ),
            QNumberField(
              label: "Minimum Spend (\$)",
              value: minimumSpend,
              onChanged: (value) {
                minimumSpend = value;
                setState(() {});
              },
            ),
            QSwitch(
              items: [
                {
                  "label": "Group Active",
                  "value": true,
                  "checked": isActive,
                }
              ],
              value: [
                if (isActive)
                  {
                    "label": "Group Active",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                isActive = values.isNotEmpty;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create Group",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Customer group created successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showGroupOptionsDialog(Map<String, dynamic> group) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${group["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Members: ${group["memberCount"]}"),
            Text("Discount: ${group["discountPercentage"]}%"),
            Text("Min Spend: \$${group["minimumSpend"]}"),
            Text("Total Revenue: \$${group["totalSpent"]}"),
            Text("Status: ${group["isActive"] ? "Active" : "Inactive"}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              QButton(
                label: "Edit",
                size: bs.sm,
                onPressed: () {
                  Navigator.pop(context);
                  si("Opening group edit dialog");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Members",
                size: bs.sm,
                onPressed: () {
                  Navigator.pop(context);
                  _showGroupMembersDialog(group);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showGroupMembersDialog(Map<String, dynamic> group) {
    var members = groupMembers.where((member) => member["groupId"] == group["id"]).toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${group["name"]} Members"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (members.isEmpty)
                Text("No members in this group yet.")
              else
                ...members.map((member) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${member["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${member["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${member["totalSpent"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Add Member",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              si("Opening add member dialog");
            },
          ),
        ],
      ),
    );
  }
}
