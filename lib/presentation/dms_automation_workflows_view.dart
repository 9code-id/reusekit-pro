import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsAutomationWorkflowsView extends StatefulWidget {
  const DmsAutomationWorkflowsView({super.key});

  @override
  State<DmsAutomationWorkflowsView> createState() => _DmsAutomationWorkflowsViewState();
}

class _DmsAutomationWorkflowsViewState extends State<DmsAutomationWorkflowsView> {
  String selectedTab = "all";
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  bool isCreatingWorkflow = false;
  String workflowName = "";
  String workflowDescription = "";
  String triggerType = "subscription";
  String actionType = "send_email";
  String delayValue = "1";
  String delayUnit = "hours";

  List<Map<String, dynamic>> workflows = [
    {
      "id": "wf_001",
      "name": "Welcome Series",
      "description": "3-email welcome sequence for new subscribers",
      "type": "onboarding",
      "status": "active",
      "trigger": "New subscription",
      "emails_sent": 2847,
      "opens": 2142,
      "clicks": 896,
      "conversions": 234,
      "open_rate": 75.2,
      "click_rate": 31.5,
      "conversion_rate": 8.2,
      "created_date": "2024-01-15",
      "last_run": "2024-03-18",
      "subscribers": 2847,
      "steps": 3,
      "color": "#4CAF50"
    },
    {
      "id": "wf_002",
      "name": "Cart Abandonment",
      "description": "Recover abandoned carts with targeted emails",
      "type": "behavioral",
      "status": "active",
      "trigger": "Cart abandonment",
      "emails_sent": 1534,
      "opens": 897,
      "clicks": 324,
      "conversions": 156,
      "open_rate": 58.5,
      "click_rate": 21.1,
      "conversion_rate": 10.2,
      "created_date": "2024-02-01",
      "last_run": "2024-03-18",
      "subscribers": 1534,
      "steps": 2,
      "color": "#FF9800"
    },
    {
      "id": "wf_003",
      "name": "Re-engagement Campaign",
      "description": "Win back inactive subscribers",
      "type": "engagement",
      "status": "active",
      "trigger": "No engagement for 30 days",
      "emails_sent": 892,
      "opens": 267,
      "clicks": 89,
      "conversions": 23,
      "open_rate": 29.9,
      "click_rate": 10.0,
      "conversion_rate": 2.6,
      "created_date": "2024-01-20",
      "last_run": "2024-03-17",
      "subscribers": 892,
      "steps": 4,
      "color": "#9C27B0"
    },
    {
      "id": "wf_004",
      "name": "Birthday Campaign",
      "description": "Special birthday offers and wishes",
      "type": "event",
      "status": "active",
      "trigger": "Customer birthday",
      "emails_sent": 245,
      "opens": 201,
      "clicks": 87,
      "conversions": 34,
      "open_rate": 82.0,
      "click_rate": 35.5,
      "conversion_rate": 13.9,
      "created_date": "2024-02-14",
      "last_run": "2024-03-18",
      "subscribers": 245,
      "steps": 1,
      "color": "#E91E63"
    },
    {
      "id": "wf_005",
      "name": "Product Education",
      "description": "Educate customers about product features",
      "type": "educational",
      "status": "paused",
      "trigger": "First purchase",
      "emails_sent": 567,
      "opens": 423,
      "clicks": 178,
      "conversions": 67,
      "open_rate": 74.6,
      "click_rate": 31.4,
      "conversion_rate": 11.8,
      "created_date": "2024-01-30",
      "last_run": "2024-03-15",
      "subscribers": 567,
      "steps": 5,
      "color": "#2196F3"
    }
  ];

  List<Map<String, dynamic>> triggerTypes = [
    {"label": "New Subscription", "value": "subscription"},
    {"label": "Cart Abandonment", "value": "cart_abandonment"},
    {"label": "Purchase Made", "value": "purchase"},
    {"label": "No Engagement", "value": "no_engagement"},
    {"label": "Birthday", "value": "birthday"},
    {"label": "Custom Event", "value": "custom_event"},
  ];

  List<Map<String, dynamic>> actionTypes = [
    {"label": "Send Email", "value": "send_email"},
    {"label": "Add Tag", "value": "add_tag"},
    {"label": "Remove Tag", "value": "remove_tag"},
    {"label": "Update Field", "value": "update_field"},
    {"label": "Send SMS", "value": "send_sms"},
    {"label": "Wait", "value": "wait"},
  ];

  List<Map<String, dynamic>> delayUnits = [
    {"label": "Minutes", "value": "minutes"},
    {"label": "Hours", "value": "hours"},
    {"label": "Days", "value": "days"},
    {"label": "Weeks", "value": "weeks"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Paused", "value": "paused"},
    {"label": "Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Onboarding", "value": "onboarding"},
    {"label": "Behavioral", "value": "behavioral"},
    {"label": "Engagement", "value": "engagement"},
    {"label": "Event", "value": "event"},
    {"label": "Educational", "value": "educational"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Automation Workflows"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              isCreatingWorkflow = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildMetricsCards(),
            _buildFilters(),
            if (isCreatingWorkflow) _buildCreateWorkflowForm(),
            _buildWorkflowsList(),
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
      child: Row(
        children: [
          Icon(
            Icons.autorenew,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Marketing Automation",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Automate your email marketing with intelligent workflows",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsCards() {
    int totalEmailsSent = workflows.fold(0, (sum, w) => sum + (w["emails_sent"] as int));
    double avgOpenRate = workflows.fold(0.0, (sum, w) => sum + (w["open_rate"] as double)) / workflows.length;
    double avgClickRate = workflows.fold(0.0, (sum, w) => sum + (w["click_rate"] as double)) / workflows.length;
    int totalConversions = workflows.fold(0, (sum, w) => sum + (w["conversions"] as int));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildMetricCard(
          "Active Workflows",
          "${workflows.where((w) => w["status"] == "active").length}",
          Icons.play_circle,
          primaryColor,
        ),
        _buildMetricCard(
          "Total Emails Sent",
          "${totalEmailsSent}",
          Icons.send,
          successColor,
        ),
        _buildMetricCard(
          "Avg Open Rate",
          "${avgOpenRate.toStringAsFixed(1)}%",
          Icons.mail,
          infoColor,
        ),
        _buildMetricCard(
          "Total Conversions",
          "${totalConversions}",
          Icons.trending_up,
          warningColor,
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 16,
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
          SizedBox(height: spXs),
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

  Widget _buildFilters() {
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
          Text(
            "Filter Workflows",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search workflows",
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
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  si("Searching workflows...");
                },
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
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateWorkflowForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Create New Workflow",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  isCreatingWorkflow = false;
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Workflow Name",
            value: workflowName,
            hint: "Enter workflow name",
            onChanged: (value) {
              workflowName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: workflowDescription,
            hint: "Describe your workflow purpose",
            onChanged: (value) {
              workflowDescription = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Trigger Type",
                  items: triggerTypes,
                  value: triggerType,
                  onChanged: (value, label) {
                    triggerType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "First Action",
                  items: actionTypes,
                  value: actionType,
                  onChanged: (value, label) {
                    actionType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (actionType == "wait") ...[
            Row(
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Delay",
                    value: delayValue,
                    onChanged: (value) {
                      delayValue = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Unit",
                    items: delayUnits,
                    value: delayUnit,
                    onChanged: (value, label) {
                      delayUnit = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    isCreatingWorkflow = false;
                    workflowName = "";
                    workflowDescription = "";
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create Workflow",
                  size: bs.sm,
                  onPressed: () {
                    if (workflowName.isNotEmpty) {
                      ss("Workflow created successfully!");
                      isCreatingWorkflow = false;
                      workflowName = "";
                      workflowDescription = "";
                      setState(() {});
                    } else {
                      se("Please enter workflow name");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowsList() {
    var filteredWorkflows = workflows.where((workflow) {
      bool matchesSearch = searchQuery.isEmpty ||
          workflow["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          workflow["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "all" || workflow["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || workflow["type"] == selectedType;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "Workflows (${filteredWorkflows.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.refresh,
                  size: bs.sm,
                  color: disabledBoldColor,
                  onPressed: () {
                    si("Refreshing workflows...");
                  },
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredWorkflows.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final workflow = filteredWorkflows[index];
              return _buildWorkflowItem(workflow);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowItem(Map<String, dynamic> workflow) {
    Color statusColor = workflow["status"] == "active" ? successColor : 
                       workflow["status"] == "paused" ? warningColor : disabledBoldColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(int.parse(workflow["color"].replaceAll("#", "0xFF"))),
                  borderRadius: BorderRadius.circular(radiusXs),
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
                          workflow["name"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${workflow["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          color: disabledBoldColor,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      workflow["description"],
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.flash_on,
                          size: 14,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Trigger: ${workflow["trigger"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.layers,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${workflow["steps"]} steps",
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
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildWorkflowStat("Emails Sent", "${workflow["emails_sent"]}", Icons.send),
                    ),
                    Expanded(
                      child: _buildWorkflowStat("Opens", "${workflow["open_rate"]}%", Icons.mail),
                    ),
                    Expanded(
                      child: _buildWorkflowStat("Clicks", "${workflow["click_rate"]}%", Icons.mouse),
                    ),
                    Expanded(
                      child: _buildWorkflowStat("Conversions", "${workflow["conversion_rate"]}%", Icons.trending_up),
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
                  label: "Edit",
                  icon: Icons.edit,
                  size: bs.sm,
                  color: infoColor,
                  onPressed: () {
                    si("Opening workflow editor...");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: workflow["status"] == "active" ? "Pause" : "Activate",
                  icon: workflow["status"] == "active" ? Icons.pause : Icons.play_arrow,
                  size: bs.sm,
                  color: workflow["status"] == "active" ? warningColor : successColor,
                  onPressed: () {
                    String action = workflow["status"] == "active" ? "paused" : "activated";
                    ss("Workflow $action successfully!");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Analytics",
                  icon: Icons.analytics,
                  size: bs.sm,
                  onPressed: () {
                    si("Opening workflow analytics...");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: primaryColor,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
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
}
