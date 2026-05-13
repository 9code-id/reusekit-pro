import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsSubscriberManagementView extends StatefulWidget {
  const DmsSubscriberManagementView({super.key});

  @override
  State<DmsSubscriberManagementView> createState() => _DmsSubscriberManagementViewState();
}

class _DmsSubscriberManagementViewState extends State<DmsSubscriberManagementView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedList = "all";
  String selectedSegment = "all";
  String bulkAction = "";
  bool selectAll = false;
  List<String> selectedSubscribers = [];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Subscribers", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Unsubscribed", "value": "unsubscribed"},
    {"label": "Bounced", "value": "bounced"},
    {"label": "Pending", "value": "pending"}
  ];

  List<Map<String, dynamic>> listOptions = [
    {"label": "All Lists", "value": "all"},
    {"label": "Newsletter (15.8K)", "value": "newsletter"},
    {"label": "VIP Customers (5.2K)", "value": "vip"},
    {"label": "Product Updates (12.1K)", "value": "products"},
    {"label": "Promotions (8.9K)", "value": "promotions"}
  ];

  List<Map<String, dynamic>> segmentOptions = [
    {"label": "All Segments", "value": "all"},
    {"label": "High Engagement", "value": "high_engagement"},
    {"label": "Recent Subscribers", "value": "recent"},
    {"label": "VIP Customers", "value": "vip"},
    {"label": "Inactive Users", "value": "inactive"}
  ];

  List<Map<String, dynamic>> bulkActionOptions = [
    {"label": "Select Action", "value": ""},
    {"label": "Add to List", "value": "add_list"},
    {"label": "Remove from List", "value": "remove_list"},
    {"label": "Export Selected", "value": "export"},
    {"label": "Delete Selected", "value": "delete"}
  ];

  List<Map<String, dynamic>> subscribers = [
    {
      "id": "sub1",
      "email": "sarah.johnson@email.com",
      "firstName": "Sarah",
      "lastName": "Johnson",
      "status": "Active",
      "subscribeDate": "2024-05-15",
      "lastActivity": "2024-06-18",
      "lists": ["Newsletter", "VIP Customers"],
      "segments": ["High Engagement", "VIP Customers"],
      "engagementScore": 95,
      "totalOpens": 45,
      "totalClicks": 23,
      "location": "New York, US",
      "source": "Website"
    },
    {
      "id": "sub2",
      "email": "mike.chen@email.com",
      "firstName": "Mike",
      "lastName": "Chen",
      "status": "Active",
      "subscribeDate": "2024-06-01",
      "lastActivity": "2024-06-17",
      "lists": ["Newsletter", "Product Updates"],
      "segments": ["Recent Subscribers", "High Engagement"],
      "engagementScore": 88,
      "totalOpens": 28,
      "totalClicks": 15,
      "location": "California, US",
      "source": "Social Media"
    },
    {
      "id": "sub3",
      "email": "emma.davis@email.com",
      "firstName": "Emma",
      "lastName": "Davis",
      "status": "Active",
      "subscribeDate": "2024-04-20",
      "lastActivity": "2024-06-16",
      "lists": ["Newsletter", "Promotions"],
      "segments": ["High Engagement"],
      "engagementScore": 92,
      "totalOpens": 52,
      "totalClicks": 31,
      "location": "London, UK",
      "source": "Google Ads"
    },
    {
      "id": "sub4",
      "email": "alex.wilson@email.com",
      "firstName": "Alex",
      "lastName": "Wilson",
      "status": "Unsubscribed",
      "subscribeDate": "2024-03-10",
      "lastActivity": "2024-05-22",
      "lists": ["Newsletter"],
      "segments": ["Inactive Users"],
      "engagementScore": 32,
      "totalOpens": 8,
      "totalClicks": 2,
      "location": "Toronto, CA",
      "source": "Website"
    },
    {
      "id": "sub5",
      "email": "lisa.brown@email.com",
      "firstName": "Lisa",
      "lastName": "Brown",
      "status": "Bounced",
      "subscribeDate": "2024-05-08",
      "lastActivity": "2024-05-08",
      "lists": ["Newsletter"],
      "segments": [],
      "engagementScore": 0,
      "totalOpens": 0,
      "totalClicks": 0,
      "location": "Unknown",
      "source": "Import"
    },
    {
      "id": "sub6",
      "email": "james.garcia@email.com",
      "firstName": "James",
      "lastName": "Garcia",
      "status": "Pending",
      "subscribeDate": "2024-06-18",
      "lastActivity": "2024-06-18",
      "lists": ["Newsletter"],
      "segments": ["Recent Subscribers"],
      "engagementScore": 0,
      "totalOpens": 0,
      "totalClicks": 0,
      "location": "Madrid, ES",
      "source": "Website"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscriber Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              _showAddSubscriber();
            },
          ),
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {
              ss("Opening import wizard");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildFiltersAndSearch(),
            _buildBulkActions(),
            _buildSubscribersList(),
            _buildSubscriberInsights(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.people,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subscriber Management",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Manage your email subscribers and segments",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
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
                child: _buildMetricCard("Total Subscribers", "28.4K", Icons.people),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Active", "24.1K", Icons.check_circle),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Growth Rate", "+8.2%", Icons.trending_up),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withAlpha(204),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.search,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Search & Filter Subscribers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Search Subscribers",
            value: searchQuery,
            hint: "Search by email, name, or location",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
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
                  label: "List",
                  items: listOptions,
                  value: selectedList,
                  onChanged: (value, label) {
                    selectedList = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Segment",
            items: segmentOptions,
            value: selectedSegment,
            onChanged: (value, label) {
              selectedSegment = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.checklist,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Bulk Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Select All Visible",
                      "value": true,
                      "checked": selectAll,
                    }
                  ],
                  value: [
                    if (selectAll)
                      {
                        "label": "Select All Visible",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    selectAll = values.isNotEmpty;
                    if (selectAll) {
                      selectedSubscribers = _getFilteredSubscribers().map((s) => s["id"] as String).toList();
                    } else {
                      selectedSubscribers.clear();
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (selectedSubscribers.isNotEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Action (${selectedSubscribers.length} selected)",
                    items: bulkActionOptions,
                    value: bulkAction,
                    onChanged: (value, label) {
                      bulkAction = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Execute",
                  size: bs.md,
                  onPressed: () {
                    if (bulkAction.isNotEmpty) {
                      _executeBulkAction();
                    } else {
                      se("Please select an action");
                    }
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubscribersList() {
    List<Map<String, dynamic>> filteredSubscribers = _getFilteredSubscribers();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.list,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Subscribers (${filteredSubscribers.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...filteredSubscribers.map((subscriber) {
            bool isSelected = selectedSubscribers.contains(subscriber["id"]);
            
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(26) : Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isSelected 
                      ? primaryColor 
                      : _getStatusColor(subscriber["status"]),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _toggleSubscriberSelection(subscriber["id"]);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${subscriber["firstName"]} ${subscriber["lastName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${subscriber["email"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${subscriber["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "•",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Source: ${subscriber["source"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(subscriber["status"]),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${subscriber["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSubscriberMetric(
                          "Engagement", 
                          "${subscriber["engagementScore"]}/100"
                        ),
                      ),
                      Expanded(
                        child: _buildSubscriberMetric(
                          "Opens", 
                          "${subscriber["totalOpens"]}"
                        ),
                      ),
                      Expanded(
                        child: _buildSubscriberMetric(
                          "Clicks", 
                          "${subscriber["totalClicks"]}"
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSubscriberMetric(
                          "Subscribed", 
                          "${subscriber["subscribeDate"]}"
                        ),
                      ),
                      Expanded(
                        child: _buildSubscriberMetric(
                          "Last Activity", 
                          "${subscriber["lastActivity"]}"
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  if ((subscriber["lists"] as List).isNotEmpty) ...[
                    Text(
                      "Lists: ${(subscriber["lists"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                  if ((subscriber["segments"] as List).isNotEmpty) ...[
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (subscriber["segments"] as List).map((segment) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$segment",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Profile",
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening profile for ${subscriber["firstName"]} ${subscriber["lastName"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Edit",
                          size: bs.sm,
                          onPressed: () {
                            _showEditSubscriber(subscriber);
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          _showSubscriberOptions(subscriber);
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

  Widget _buildSubscriberMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriberInsights() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.insights,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Subscriber Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildInsightCard(
                "Top Source",
                "Website",
                "45% of subscribers",
                Icons.web,
                successColor,
              ),
              _buildInsightCard(
                "Avg. Engagement",
                "78/100",
                "Above industry average",
                Icons.trending_up,
                infoColor,
              ),
              _buildInsightCard(
                "Growth This Month",
                "+1.2K",
                "15% increase",
                Icons.person_add,
                warningColor,
              ),
              _buildInsightCard(
                "Churn Rate",
                "2.1%",
                "Below industry average",
                Icons.person_remove,
                primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String value, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(51),
          width: 1,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredSubscribers() {
    return subscribers.where((subscriber) {
      bool matchesSearch = searchQuery.isEmpty || 
          subscriber["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${subscriber["firstName"]} ${subscriber["lastName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          subscriber["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || 
          subscriber["status"].toString().toLowerCase() == selectedStatus.toLowerCase();
      
      bool matchesList = selectedList == "all" || 
          (subscriber["lists"] as List).any((list) => list.toString().toLowerCase().contains(selectedList.toLowerCase()));
      
      bool matchesSegment = selectedSegment == "all" || 
          (subscriber["segments"] as List).any((segment) => segment.toString().toLowerCase().contains(selectedSegment.toLowerCase()));
      
      return matchesSearch && matchesStatus && matchesList && matchesSegment;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "unsubscribed":
        return dangerColor;
      case "bounced":
        return warningColor;
      case "pending":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  void _toggleSubscriberSelection(String subscriberId) {
    if (selectedSubscribers.contains(subscriberId)) {
      selectedSubscribers.remove(subscriberId);
    } else {
      selectedSubscribers.add(subscriberId);
    }
    selectAll = selectedSubscribers.length == _getFilteredSubscribers().length;
    setState(() {});
  }

  void _executeBulkAction() {
    String actionName = bulkActionOptions.firstWhere((action) => action["value"] == bulkAction)["label"];
    ss("Executed '$actionName' on ${selectedSubscribers.length} subscribers");
    selectedSubscribers.clear();
    selectAll = false;
    bulkAction = "";
    setState(() {});
  }

  void _showAddSubscriber() {
    ss("Opening add subscriber form");
  }

  void _showEditSubscriber(Map<String, dynamic> subscriber) {
    si("Editing ${subscriber["firstName"]} ${subscriber["lastName"]}");
  }

  void _showSubscriberOptions(Map<String, dynamic> subscriber) {
    si("Options for ${subscriber["firstName"]} ${subscriber["lastName"]}");
  }
}
