import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmDealListView extends StatefulWidget {
  const CrmDealListView({super.key});

  @override
  State<CrmDealListView> createState() => _CrmDealListViewState();
}

class _CrmDealListViewState extends State<CrmDealListView> {
  String searchQuery = "";
  String selectedStage = "All";
  String selectedOwner = "All";
  String sortBy = "newest";

  List<Map<String, dynamic>> deals = [
    {
      "id": "DEAL001",
      "title": "Enterprise Software License",
      "company": "TechCorp Solutions",
      "value": 85000.0,
      "stage": "Proposal",
      "probability": 75,
      "owner": "Sarah Wilson",
      "closeDate": "2024-01-15",
      "lastActivity": "2024-01-08",
      "priority": "High",
      "tags": ["Enterprise", "Software"],
      "avatar": "https://picsum.photos/50/50?random=1",
    },
    {
      "id": "DEAL002",
      "title": "Digital Marketing Campaign",
      "company": "StartupHub Inc",
      "value": 25000.0,
      "stage": "Negotiation",
      "probability": 90,
      "owner": "Mike Johnson",
      "closeDate": "2024-01-10",
      "lastActivity": "2024-01-09",
      "priority": "High",
      "tags": ["Marketing", "Digital"],
      "avatar": "https://picsum.photos/50/50?random=2",
    },
    {
      "id": "DEAL003",
      "title": "Cloud Infrastructure Setup",
      "company": "Global Finance Ltd",
      "value": 120000.0,
      "stage": "Qualified",
      "probability": 60,
      "owner": "Emily Chen",
      "closeDate": "2024-02-20",
      "lastActivity": "2024-01-07",
      "priority": "Medium",
      "tags": ["Cloud", "Infrastructure"],
      "avatar": "https://picsum.photos/50/50?random=3",
    },
    {
      "id": "DEAL004",
      "title": "Mobile App Development",
      "company": "Retail Masters",
      "value": 65000.0,
      "stage": "Discovery",
      "probability": 40,
      "owner": "David Brown",
      "closeDate": "2024-03-15",
      "lastActivity": "2024-01-06",
      "priority": "Medium",
      "tags": ["Mobile", "Development"],
      "avatar": "https://picsum.photos/50/50?random=4",
    },
    {
      "id": "DEAL005",
      "title": "Data Analytics Platform",
      "company": "Healthcare Innovations",
      "value": 95000.0,
      "stage": "Closed Won",
      "probability": 100,
      "owner": "Lisa Wang",
      "closeDate": "2024-01-05",
      "lastActivity": "2024-01-05",
      "priority": "High",
      "tags": ["Analytics", "Healthcare"],
      "avatar": "https://picsum.photos/50/50?random=5",
    },
  ];

  List<Map<String, dynamic>> stageOptions = [
    {"label": "All Stages", "value": "All"},
    {"label": "Discovery", "value": "Discovery"},
    {"label": "Qualified", "value": "Qualified"},
    {"label": "Proposal", "value": "Proposal"},
    {"label": "Negotiation", "value": "Negotiation"},
    {"label": "Closed Won", "value": "Closed Won"},
    {"label": "Closed Lost", "value": "Closed Lost"},
  ];

  List<Map<String, dynamic>> ownerOptions = [
    {"label": "All Owners", "value": "All"},
    {"label": "Sarah Wilson", "value": "Sarah Wilson"},
    {"label": "Mike Johnson", "value": "Mike Johnson"},
    {"label": "Emily Chen", "value": "Emily Chen"},
    {"label": "David Brown", "value": "David Brown"},
    {"label": "Lisa Wang", "value": "Lisa Wang"},
  ];

  List<Map<String, dynamic>> get filteredDeals {
    return deals.where((deal) {
      bool matchesSearch = deal["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          deal["company"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStage = selectedStage == "All" || deal["stage"] == selectedStage;
      bool matchesOwner = selectedOwner == "All" || deal["owner"] == selectedOwner;
      return matchesSearch && matchesStage && matchesOwner;
    }).toList();
  }

  Color _getStageColor(String stage) {
    switch (stage) {
      case "Discovery":
        return infoColor;
      case "Qualified":
        return warningColor;
      case "Proposal":
        return primaryColor;
      case "Negotiation":
        return successColor;
      case "Closed Won":
        return successColor;
      case "Closed Lost":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deal Pipeline"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo CrmAddDealView
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Cards Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${((deals.fold(0.0, (sum, deal) => sum + (deal["value"] as double))) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Total Value",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredDeals.length}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Active Deals",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${((deals.where((d) => d["probability"] > 70).length / deals.length) * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Win Rate",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search deals...",
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
                  onPressed: () {
                    _showFilterDialog();
                  },
                ),
              ],
            ),

            // Quick Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickFilter("All", selectedStage == "All"),
                  SizedBox(width: spXs),
                  _buildQuickFilter("Discovery", selectedStage == "Discovery"),
                  SizedBox(width: spXs),
                  _buildQuickFilter("Proposal", selectedStage == "Proposal"),
                  SizedBox(width: spXs),
                  _buildQuickFilter("Negotiation", selectedStage == "Negotiation"),
                  SizedBox(width: spXs),
                  _buildQuickFilter("Closed Won", selectedStage == "Closed Won"),
                ],
              ),
            ),

            // Deals List
            ...filteredDeals.map((deal) => _buildDealCard(deal)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        selectedStage = label == "All" ? "All" : label;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
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
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDealCard(Map<String, dynamic> deal) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          // Header Row
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${deal["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${deal["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${deal["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStageColor("${deal["stage"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${deal["stage"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStageColor("${deal["stage"]}"),
                  ),
                ),
              ),
            ],
          ),

          // Value and Probability Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deal Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(deal["value"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Probability",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${deal["probability"]}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (deal["probability"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation(primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Details Row
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${deal["owner"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.calendar_today,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${deal["closeDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${deal["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${deal["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor("${deal["priority"]}"),
                  ),
                ),
              ),
            ],
          ),

          // Tags
          if ((deal["tags"] as List).isNotEmpty)
            Wrap(
              spacing: spXs,
              children: (deal["tags"] as List).map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "$tag",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                    ),
                  ),
                );
              }).toList(),
            ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo CrmDealDetailView
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo CrmAddDealView with edit mode
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showDealActions(deal);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Filter Deals"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: spSm,
                children: [
                  QDropdownField(
                    label: "Stage",
                    items: stageOptions,
                    value: selectedStage,
                    onChanged: (value, label) {
                      selectedStage = value;
                      setDialogState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Owner",
                    items: ownerOptions,
                    value: selectedOwner,
                    onChanged: (value, label) {
                      selectedOwner = value;
                      setDialogState(() {});
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    selectedStage = "All";
                    selectedOwner = "All";
                    setDialogState(() {});
                  },
                  child: Text("Clear"),
                ),
                QButton(
                  label: "Apply",
                  size: bs.sm,
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDealActions(Map<String, dynamic> deal) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "${deal["title"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Deal"),
                onTap: () {
                  Navigator.pop(context);
                  //navigateTo CrmAddDealView with edit mode
                },
              ),
              ListTile(
                leading: Icon(Icons.content_copy),
                title: Text("Clone Deal"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Deal cloned successfully");
                },
              ),
              ListTile(
                leading: Icon(Icons.archive),
                title: Text("Archive Deal"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Deal archived successfully");
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete Deal", style: TextStyle(color: dangerColor)),
                onTap: () async {
                  Navigator.pop(context);
                  bool isConfirmed = await confirm("Are you sure you want to delete this deal?");
                  if (isConfirmed) {
                    ss("Deal deleted successfully");
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
