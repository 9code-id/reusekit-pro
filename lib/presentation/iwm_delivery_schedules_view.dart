import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmDeliverySchedulesView extends StatefulWidget {
  const IwmDeliverySchedulesView({super.key});

  @override
  State<IwmDeliverySchedulesView> createState() => _IwmDeliverySchedulesViewState();
}

class _IwmDeliverySchedulesViewState extends State<IwmDeliverySchedulesView> {
  int selectedTab = 0;
  String selectedPriority = "all";
  String selectedStatus = "all";
  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Urgent", "value": "urgent"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Delayed", "value": "delayed"},
  ];

  List<Map<String, dynamic>> scheduleStats = [
    {
      "title": "Today's Deliveries",
      "value": 45,
      "subtitle": "32 completed",
      "icon": Icons.today,
      "color": primaryColor
    },
    {
      "title": "On Time Rate",
      "value": 94.5,
      "subtitle": "This week",
      "icon": Icons.schedule,
      "color": successColor
    },
    {
      "title": "Delayed",
      "value": 7,
      "subtitle": "Need attention",
      "icon": Icons.warning,
      "color": dangerColor
    },
    {
      "title": "Avg Delivery Time",
      "value": 2.3,
      "subtitle": "Days",
      "icon": Icons.timer,
      "color": infoColor
    },
  ];

  List<Map<String, dynamic>> deliverySchedules = [
    {
      "id": "DS-2024-001",
      "orderId": "ORD-789012",
      "customer": "John Smith",
      "address": "123 Main St, New York, NY 10001",
      "phone": "+1 (555) 123-4567",
      "scheduledDate": "2024-01-22",
      "scheduledTime": "09:00 - 12:00",
      "priority": "High",
      "status": "Scheduled",
      "carrier": "FedEx",
      "trackingNumber": "1234567890123456",
      "deliveryInstructions": "Leave at front door if no answer",
      "packageCount": 2,
      "weight": 5.5,
      "value": 299.99,
      "deliveryType": "Standard",
      "attempts": 0,
      "lastAttempt": "",
      "driver": "Mike Johnson",
      "route": "Route A-1"
    },
    {
      "id": "DS-2024-002",
      "orderId": "ORD-789013",
      "customer": "Sarah Johnson",
      "address": "456 Oak Ave, Los Angeles, CA 90210",
      "phone": "+1 (555) 987-6543",
      "scheduledDate": "2024-01-22",
      "scheduledTime": "14:00 - 17:00",
      "priority": "Medium",
      "status": "In Progress",
      "carrier": "UPS",
      "trackingNumber": "1Z999AA1234567890",
      "deliveryInstructions": "Ring doorbell, signature required",
      "packageCount": 1,
      "weight": 2.8,
      "value": 149.99,
      "deliveryType": "Express",
      "attempts": 1,
      "lastAttempt": "2024-01-21 15:30",
      "driver": "Lisa Davis",
      "route": "Route B-2"
    },
    {
      "id": "DS-2024-003",
      "orderId": "ORD-789014",
      "customer": "Mike Chen",
      "address": "789 Pine St, Chicago, IL 60601",
      "phone": "+1 (555) 456-7890",
      "scheduledDate": "2024-01-21",
      "scheduledTime": "10:00 - 13:00",
      "priority": "Urgent",
      "status": "Delayed",
      "carrier": "DHL",
      "trackingNumber": "DHL123456789",
      "deliveryInstructions": "Business address, deliver to reception",
      "packageCount": 3,
      "weight": 8.2,
      "value": 450.00,
      "deliveryType": "Same Day",
      "attempts": 2,
      "lastAttempt": "2024-01-21 16:45",
      "driver": "Tom Wilson",
      "route": "Route C-3"
    },
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"time": "08:00 - 12:00", "available": 5, "booked": 12},
    {"time": "12:00 - 16:00", "available": 8, "booked": 15},
    {"time": "16:00 - 20:00", "available": 3, "booked": 10},
  ];

  List<Map<String, dynamic>> deliveryRoutes = [
    {
      "route": "Route A-1",
      "driver": "Mike Johnson",
      "vehicle": "Van #101",
      "deliveries": 8,
      "completed": 5,
      "status": "Active",
      "estimatedCompletion": "16:30"
    },
    {
      "route": "Route B-2",
      "driver": "Lisa Davis",
      "vehicle": "Truck #205",
      "deliveries": 12,
      "completed": 9,
      "status": "Active",
      "estimatedCompletion": "18:15"
    },
    {
      "route": "Route C-3",
      "driver": "Tom Wilson",
      "vehicle": "Van #103",
      "deliveries": 6,
      "completed": 6,
      "status": "Completed",
      "estimatedCompletion": "Completed"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Delivery Schedules",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Schedules", icon: Icon(Icons.schedule)),
        Tab(text: "Routes", icon: Icon(Icons.route)),
        Tab(text: "Calendar", icon: Icon(Icons.calendar_today)),
      ],
      tabChildren: [
        _buildSchedulesTab(),
        _buildRoutesTab(),
        _buildCalendarTab(),
      ],
    );
  }

  Widget _buildSchedulesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFiltersAndSearch(),
          _buildScheduleStats(),
          _buildSchedulesList(),
        ],
      ),
    );
  }

  Widget _buildRoutesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRouteHeader(),
          _buildRoutesList(),
        ],
      ),
    );
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendarView(),
          _buildTimeSlots(),
        ],
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
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
                child: QDropdownField(
                  label: "Priority",
                  items: priorityItems,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
          QDatePicker(
            label: "Delivery Date",
            value: selectedDate,
            onChanged: (value) {
              selectedDate = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Delivery Statistics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: scheduleStats.map((stat) => _buildStatCard(stat)).toList(),
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
            stat["title"] == "On Time Rate" || stat["title"] == "Avg Delivery Time"
                ? "${stat["value"]}"
                : "${stat["value"]}",
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

  Widget _buildSchedulesList() {
    return Column(
      spacing: spSm,
      children: deliverySchedules.map((schedule) => _buildScheduleCard(schedule)).toList(),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule) {
    Color statusColor = _getStatusColor(schedule["status"]);
    Color priorityColor = _getPriorityColor(schedule["priority"]);
    
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
                      "${schedule["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Order: ${schedule["orderId"]}",
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
                      "${schedule["priority"]}",
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
                      "${schedule["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${schedule["customer"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${schedule["address"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${schedule["scheduledDate"]} • ${schedule["scheduledTime"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Packages: ${schedule["packageCount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Value: \$${(schedule["value"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
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
                      "Driver: ${schedule["driver"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Route: ${schedule["route"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Manage",
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _showScheduleDetails(schedule),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Text(
            "Delivery Routes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          QButton(
            label: "Optimize Routes",
            icon: Icons.route,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildRoutesList() {
    return Column(
      spacing: spSm,
      children: deliveryRoutes.map((route) => _buildRouteCard(route)).toList(),
    );
  }

  Widget _buildRouteCard(Map<String, dynamic> route) {
    Color statusColor = route["status"] == "Completed" ? successColor : infoColor;
    double progress = (route["completed"] as int) / (route["deliveries"] as int);
    
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${route["route"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Driver: ${route["driver"]} • ${route["vehicle"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${route["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
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
                      "${route["completed"]}/${route["deliveries"]} deliveries",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledOutlineBorderColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "ETA: ${route["estimatedCompletion"]}",
                style: TextStyle(
                  color: disabledColor,
                  fontSize: 12,
                ),
              ),
              Spacer(),
              QButton(
                label: "Track",
                icon: Icons.my_location,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
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
            "Delivery Calendar",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 300,
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
                    Icons.calendar_today,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Calendar View",
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

  Widget _buildTimeSlots() {
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
            "Available Time Slots",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...timeSlots.map((slot) => _buildTimeSlotCard(slot)),
        ],
      ),
    );
  }

  Widget _buildTimeSlotCard(Map<String, dynamic> slot) {
    int total = (slot["available"] as int) + (slot["booked"] as int);
    double availability = (slot["available"] as int) / total;
    
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
            child: Text(
              "${slot["time"]}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${slot["available"]} available",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${slot["booked"]} booked",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: disabledOutlineBorderColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 1 - availability,
              child: Container(
                decoration: BoxDecoration(
                  color: availability > 0.3 ? successColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showScheduleDetails(Map<String, dynamic> schedule) {
    // Show detailed schedule management dialog
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return infoColor;
      case 'scheduled':
        return warningColor;
      case 'delayed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
