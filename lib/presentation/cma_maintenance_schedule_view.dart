import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaMaintenanceScheduleView extends StatefulWidget {
  const CmaMaintenanceScheduleView({super.key});

  @override
  State<CmaMaintenanceScheduleView> createState() => _CmaMaintenanceScheduleViewState();
}

class _CmaMaintenanceScheduleViewState extends State<CmaMaintenanceScheduleView> {
  List<Map<String, dynamic>> maintenanceSchedule = [
    {
      "id": 1,
      "service_type": "Oil Change",
      "due_date": "2024-07-15",
      "due_mileage": 85000,
      "current_mileage": 82340,
      "status": "Overdue",
      "priority": "High",
      "estimated_cost": 45.00,
      "description": "Regular oil and filter change",
      "last_service": "2024-04-15",
      "interval_months": 3,
      "interval_miles": 3000,
    },
    {
      "id": 2,
      "service_type": "Tire Rotation",
      "due_date": "2024-08-20",
      "due_mileage": 86000,
      "current_mileage": 82340,
      "status": "Due Soon",
      "priority": "Medium",
      "estimated_cost": 35.00,
      "description": "Rotate tires for even wear",
      "last_service": "2024-02-20",
      "interval_months": 6,
      "interval_miles": 6000,
    },
    {
      "id": 3,
      "service_type": "Brake Inspection",
      "due_date": "2024-09-10",
      "due_mileage": 88000,
      "current_mileage": 82340,
      "status": "Upcoming",
      "priority": "High",
      "estimated_cost": 150.00,
      "description": "Check brake pads and fluid",
      "last_service": "2024-03-10",
      "interval_months": 6,
      "interval_miles": 6000,
    },
    {
      "id": 4,
      "service_type": "Air Filter Replacement",
      "due_date": "2024-10-05",
      "due_mileage": 90000,
      "current_mileage": 82340,
      "status": "Scheduled",
      "priority": "Low",
      "estimated_cost": 25.00,
      "description": "Replace engine air filter",
      "last_service": "2024-01-05",
      "interval_months": 12,
      "interval_miles": 12000,
    },
    {
      "id": 5,
      "service_type": "Transmission Service",
      "due_date": "2024-12-15",
      "due_mileage": 95000,
      "current_mileage": 82340,
      "status": "Upcoming",
      "priority": "High",
      "estimated_cost": 285.00,
      "description": "Transmission fluid and filter change",
      "last_service": "2022-12-15",
      "interval_months": 24,
      "interval_miles": 30000,
    },
  ];

  List<Map<String, dynamic>> upcomingServices = [
    {
      "date": "2024-07-20",
      "time": "09:00",
      "service": "Oil Change",
      "shop": "Quick Lube Express",
      "address": "123 Main St, Downtown",
      "phone": "(555) 123-4567",
      "estimated_duration": "30 minutes",
      "cost": 45.00,
    },
    {
      "date": "2024-08-25",
      "time": "14:30",
      "service": "Tire Rotation & Balance",
      "shop": "Tire Center Pro",
      "address": "456 Oak Ave, Midtown",
      "phone": "(555) 987-6543",
      "estimated_duration": "1 hour",
      "cost": 65.00,
    },
  ];

  int selectedTab = 0;
  String filterStatus = "All";

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All", "value": "All"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Due Soon", "value": "Due Soon"},
    {"label": "Upcoming", "value": "Upcoming"},
    {"label": "Scheduled", "value": "Scheduled"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Maintenance Schedule",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "Calendar", icon: Icon(Icons.calendar_month)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildScheduleTab(),
        _buildCalendarTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildScheduleTab() {
    List<Map<String, dynamic>> filteredSchedule = filterStatus == "All" 
        ? maintenanceSchedule 
        : maintenanceSchedule.where((item) => item["status"] == filterStatus).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: statusFilters,
                  value: filterStatus,
                  onChanged: (value, label) {
                    filterStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add Service",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _showAddServiceDialog();
                },
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.speed, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current Mileage",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "82,340 miles",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Update",
                  size: bs.sm,
                  onPressed: () {
                    _showUpdateMileageDialog();
                  },
                ),
              ],
            ),
          ),

          ...filteredSchedule.map((service) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getStatusColor(service["status"]),
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
                        "${service["service_type"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(service["status"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${service["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Text(
                  "${service["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Due Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(service["due_date"]).dMMMy}",
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
                            "Due Mileage",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(service["due_mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
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
                            "Est. Cost",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(service["estimated_cost"] as double).currency}",
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
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Schedule Now",
                        size: bs.sm,
                        onPressed: () {
                          _scheduleService(service);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        _showServiceOptions(service);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Upcoming Appointments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...upcomingServices.map((appointment) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: successColor,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.event,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${DateTime.parse(appointment["date"]).dMMMy} at ${appointment["time"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Text(
                  "${appointment["service"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      Icons.store,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${appointment["shop"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${appointment["address"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${appointment["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Duration",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${appointment["estimated_duration"]}",
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
                            "Cost",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(appointment["cost"] as double).currency}",
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
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Reschedule",
                        size: bs.sm,
                        onPressed: () {
                          _rescheduleAppointment(appointment);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () {
                        _cancelAppointment(appointment);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Service History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Maintenance Statistics",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "15",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Services Done",
                            textAlign: TextAlign.center,
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
                            "\$1,245",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Spent",
                            textAlign: TextAlign.center,
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
                            "3",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Overdue Items",
                            textAlign: TextAlign.center,
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
              ],
            ),
          ),

          Text(
            "Recent Services",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Container(
            child: Text(
              "Service history will be displayed here after completing maintenance appointments.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Overdue":
        return dangerColor;
      case "Due Soon":
        return warningColor;
      case "Upcoming":
        return infoColor;
      case "Scheduled":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showAddServiceDialog() {
    si("Add new maintenance service feature coming soon");
  }

  void _showUpdateMileageDialog() {
    si("Update current mileage feature coming soon");
  }

  void _scheduleService(Map<String, dynamic> service) {
    si("Scheduling ${service["service_type"]} service");
  }

  void _showServiceOptions(Map<String, dynamic> service) {
    si("Service options for ${service["service_type"]}");
  }

  void _rescheduleAppointment(Map<String, dynamic> appointment) {
    si("Rescheduling appointment for ${appointment["service"]}");
  }

  void _cancelAppointment(Map<String, dynamic> appointment) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this appointment?");
    if (isConfirmed) {
      ss("Appointment cancelled successfully");
    }
  }
}
