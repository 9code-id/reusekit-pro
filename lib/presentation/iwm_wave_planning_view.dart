import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmWavePlanningView extends StatefulWidget {
  const IwmWavePlanningView({super.key});

  @override
  State<IwmWavePlanningView> createState() => _IwmWavePlanningViewState();
}

class _IwmWavePlanningViewState extends State<IwmWavePlanningView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedPriority = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Planning", "value": "planning"},
    {"label": "Ready", "value": "ready"},
    {"label": "Released", "value": "released"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];
  
  List<Map<String, dynamic>> waveStats = [
    {
      "title": "Active Waves",
      "value": 8,
      "subtitle": "Currently Running",
      "icon": Icons.waves,
      "color": primaryColor
    },
    {
      "title": "Orders Planned",
      "value": 347,
      "subtitle": "Today",
      "icon": Icons.assignment,
      "color": successColor
    },
    {
      "title": "Avg Wave Size",
      "value": 43,
      "subtitle": "Orders per Wave",
      "icon": Icons.analytics,
      "color": warningColor
    },
    {
      "title": "Efficiency",
      "value": "94%",
      "subtitle": "Wave Completion",
      "icon": Icons.trending_up,
      "color": infoColor
    },
  ];
  
  List<Map<String, dynamic>> waves = [
    {
      "id": "WAVE-2024-001",
      "name": "Morning Priority Batch",
      "status": "In Progress",
      "priority": "High",
      "ordersCount": 45,
      "itemsCount": 287,
      "estimatedTime": "3.5 hours",
      "actualTime": "2.2 hours",
      "progress": 0.75,
      "zone": "Zone A, B",
      "plannedAt": "2024-01-15 06:00",
      "releasedAt": "2024-01-15 08:00",
      "startedAt": "2024-01-15 08:15",
      "dueAt": "2024-01-15 12:00",
      "pickLists": 8,
      "completedPickLists": 6,
      "assignedPickers": ["John Smith", "Sarah Wilson", "Mike Chen"],
      "criteria": {
        "orderType": "Express",
        "priority": "High",
        "zone": "A, B",
        "cutoffTime": "07:00"
      }
    },
    {
      "id": "WAVE-2024-002",
      "name": "Standard Morning Wave",
      "status": "Ready",
      "priority": "Medium",
      "ordersCount": 68,
      "itemsCount": 432,
      "estimatedTime": "4.2 hours",
      "actualTime": null,
      "progress": 0.0,
      "zone": "Zone C, D",
      "plannedAt": "2024-01-15 07:30",
      "releasedAt": null,
      "startedAt": null,
      "dueAt": "2024-01-15 14:00",
      "pickLists": 12,
      "completedPickLists": 0,
      "assignedPickers": ["Lisa Davis", "Tom Wilson", "Anna Johnson"],
      "criteria": {
        "orderType": "Standard",
        "priority": "Medium",
        "zone": "C, D",
        "cutoffTime": "09:00"
      }
    },
    {
      "id": "WAVE-2024-003",
      "name": "Afternoon Bulk Orders",
      "status": "Planning",
      "priority": "Low",
      "ordersCount": 92,
      "itemsCount": 578,
      "estimatedTime": "5.8 hours",
      "actualTime": null,
      "progress": 0.0,
      "zone": "All Zones",
      "plannedAt": "2024-01-15 10:00",
      "releasedAt": null,
      "startedAt": null,
      "dueAt": "2024-01-15 18:00",
      "pickLists": 15,
      "completedPickLists": 0,
      "assignedPickers": [],
      "criteria": {
        "orderType": "Bulk",
        "priority": "Low",
        "zone": "All",
        "cutoffTime": "12:00"
      }
    },
    {
      "id": "WAVE-2024-004",
      "name": "Express Delivery Wave",
      "status": "Completed",
      "priority": "High",
      "ordersCount": 23,
      "itemsCount": 156,
      "estimatedTime": "2.0 hours",
      "actualTime": "1.8 hours",
      "progress": 1.0,
      "zone": "Zone A",
      "plannedAt": "2024-01-15 05:30",
      "releasedAt": "2024-01-15 07:00",
      "startedAt": "2024-01-15 07:15",
      "completedAt": "2024-01-15 09:03",
      "dueAt": "2024-01-15 10:00",
      "pickLists": 4,
      "completedPickLists": 4,
      "assignedPickers": ["John Smith", "Mike Chen"],
      "criteria": {
        "orderType": "Express",
        "priority": "High",
        "zone": "A",
        "cutoffTime": "06:30"
      }
    },
  ];
  
  List<Map<String, dynamic>> waveTemplates = [
    {
      "name": "Express Morning",
      "description": "High priority orders for morning delivery",
      "criteria": {
        "priority": "High",
        "orderType": "Express",
        "zone": "A, B",
        "maxOrders": 50,
        "cutoffTime": "07:00"
      }
    },
    {
      "name": "Standard Batch",
      "description": "Regular orders with standard processing",
      "criteria": {
        "priority": "Medium",
        "orderType": "Standard",
        "zone": "All",
        "maxOrders": 80,
        "cutoffTime": "09:00"
      }
    },
    {
      "name": "Bulk Processing",
      "description": "Large volume orders for bulk processing",
      "criteria": {
        "priority": "Low",
        "orderType": "Bulk",
        "zone": "All",
        "maxOrders": 100,
        "cutoffTime": "12:00"
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Wave Planning",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Waves", icon: Icon(Icons.waves)),
        Tab(text: "Planning", icon: Icon(Icons.schedule)),
        Tab(text: "Templates", icon: Icon(Icons.library_books)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildWavesTab(),
        _buildPlanningTab(),
        _buildTemplatesTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickActions(),
          _buildWaveStats(),
          _buildWaveTimeline(),
          _buildTodaysWaves(),
        ],
      ),
    );
  }

  Widget _buildWavesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWaveFilters(),
          _buildWavesList(),
        ],
      ),
    );
  }

  Widget _buildPlanningTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWavePlanner(),
          _buildPendingOrders(),
          _buildPlanningResults(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTemplateControls(),
          _buildTemplatesList(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
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
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Create Wave",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Auto Plan",
                  icon: Icons.auto_awesome,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWaveStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Wave Statistics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: waveStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaveTimeline() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Wave Timeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timeline,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Wave Timeline Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysWaves() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Waves",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...waves.take(3).map((wave) => _buildTodayWaveItem(wave)),
        ],
      ),
    );
  }

  Widget _buildTodayWaveItem(Map<String, dynamic> wave) {
    Color statusColor = _getStatusColor(wave["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${wave["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${wave["ordersCount"]} orders • ${wave["zone"]}",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${wave["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                  ),
                ),
              ),
              Text(
                "Due: ${wave["dueAt"].toString().substring(11, 16)}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWaveFilters() {
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
                  label: "Search waves...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
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
                  label: "Priority",
                  items: priorityOptions,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
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

  Widget _buildWavesList() {
    return Column(
      spacing: spSm,
      children: waves.map((wave) => _buildWaveCard(wave)).toList(),
    );
  }

  Widget _buildWaveCard(Map<String, dynamic> wave) {
    Color statusColor = _getStatusColor(wave["status"]);
    Color priorityColor = _getPriorityColor(wave["priority"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${wave["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${wave["name"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${wave["priority"]}",
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${wave["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
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
                      "Orders: ${wave["ordersCount"]} • Items: ${wave["itemsCount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Zone: ${wave["zone"]} • Pick Lists: ${wave["completedPickLists"]}/${wave["pickLists"]}",
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
                    "Est: ${wave["estimatedTime"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (wave["actualTime"] != null)
                    Text(
                      "Actual: ${wave["actualTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
          if ((wave["progress"] as double) > 0 && (wave["progress"] as double) < 1)
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${((wave["progress"] as double) * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: wave["progress"] as double,
                  backgroundColor: disabledOutlineBorderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          Row(
            children: [
              Text(
                "Due: ${wave["dueAt"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  _showWaveDetails(wave);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWavePlanner() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Wave Planner",
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
                  label: "Wave Name",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "High", "value": "high"},
                    {"label": "Medium", "value": "medium"},
                    {"label": "Low", "value": "low"},
                  ],
                  value: "medium",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Max Orders",
                  value: "50",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Zone Filter",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Plan Wave",
                  icon: Icons.schedule,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Auto Plan",
                  icon: Icons.auto_awesome,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPendingOrders() {
    List<Map<String, dynamic>> pendingOrders = [
      {"id": "ORD-001", "customer": "ABC Corp", "items": 8, "priority": "High", "zone": "A"},
      {"id": "ORD-002", "customer": "XYZ Ltd", "items": 12, "priority": "Medium", "zone": "B"},
      {"id": "ORD-003", "customer": "Tech Inc", "items": 5, "priority": "High", "zone": "A"},
      {"id": "ORD-004", "customer": "Global Co", "items": 15, "priority": "Low", "zone": "C"},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pending Orders (${pendingOrders.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...pendingOrders.map((order) => _buildPendingOrderItem(order)),
        ],
      ),
    );
  }

  Widget _buildPendingOrderItem(Map<String, dynamic> order) {
    Color priorityColor = _getPriorityColor(order["priority"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
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
                  "${order["id"]} - ${order["customer"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Items: ${order["items"]} • Zone: ${order["zone"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: priorityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${order["priority"]}",
              style: TextStyle(
                color: priorityColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanningResults() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Planning Results",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spLg),
            child: Center(
              child: Text(
                "Plan a wave to see results",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateControls() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Create Template",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesList() {
    return Column(
      spacing: spSm,
      children: waveTemplates.map((template) => _buildTemplateCard(template)).toList(),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    Map<String, dynamic> criteria = template["criteria"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Use Template",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Criteria:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Priority: ${criteria["priority"]} • Type: ${criteria["orderType"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Zone: ${criteria["zone"]} • Max Orders: ${criteria["maxOrders"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Cutoff Time: ${criteria["cutoffTime"]}",
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

  void _showWaveDetails(Map<String, dynamic> wave) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${wave["id"]} Details"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Wave Information:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text("Name: ${wave["name"]}"),
              Text("Status: ${wave["status"]}"),
              Text("Priority: ${wave["priority"]}"),
              Text("Orders: ${wave["ordersCount"]}"),
              Text("Items: ${wave["itemsCount"]}"),
              Text("Zone: ${wave["zone"]}"),
              SizedBox(height: spSm),
              Text(
                "Assigned Pickers:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...(wave["assignedPickers"] as List<String>).map((picker) => Text("• $picker")),
              SizedBox(height: spSm),
              Text(
                "Timeline:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text("Planned: ${wave["plannedAt"]}"),
              if (wave["releasedAt"] != null) Text("Released: ${wave["releasedAt"]}"),
              if (wave["startedAt"] != null) Text("Started: ${wave["startedAt"]}"),
              if (wave["completedAt"] != null) Text("Completed: ${wave["completedAt"]}"),
              Text("Due: ${wave["dueAt"]}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return primaryColor;
      case 'ready':
      case 'released':
        return warningColor;
      case 'planning':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
