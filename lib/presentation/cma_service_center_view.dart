import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaServiceCenterView extends StatefulWidget {
  const CmaServiceCenterView({super.key});

  @override
  State<CmaServiceCenterView> createState() => _CmaServiceCenterViewState();
}

class _CmaServiceCenterViewState extends State<CmaServiceCenterView> {
  int currentTab = 0;
  String selectedServiceType = "All Services";
  String selectedUrgency = "All";
  String selectedStatus = "All";
  String selectedCenter = "All Centers";

  List<Map<String, dynamic>> serviceData = [
    {
      "id": "SRV-2024-001",
      "vehicleId": "CFL-001",
      "vehicleMake": "Ford",
      "vehicleModel": "Transit 350",
      "serviceCenter": "Premium Auto Service",
      "serviceType": "Regular Maintenance",
      "description": "Oil change, filter replacement, 30-point inspection",
      "scheduledDate": "2024-06-20",
      "estimatedTime": "2 hours",
      "status": "Scheduled",
      "priority": "Normal",
      "cost": 185.0,
      "technician": "Mike Johnson",
      "serviceAdvisor": "Sarah Wilson",
      "address": "1500 Service Dr, Detroit, MI",
      "phone": "(313) 555-0101",
      "mileage": 45000,
      "nextService": "2024-09-20",
      "warranty": "Active"
    },
    {
      "id": "SRV-2024-002",
      "vehicleId": "CFL-015",
      "vehicleMake": "Chevrolet",
      "vehicleModel": "Express 2500",
      "serviceCenter": "Fleet Service Solutions",
      "serviceType": "Brake Repair",
      "description": "Replace brake pads and rotors, brake fluid flush",
      "scheduledDate": "2024-06-18",
      "estimatedTime": "4 hours",
      "status": "In Progress",
      "priority": "High",
      "cost": 650.0,
      "technician": "David Chen",
      "serviceAdvisor": "Lisa Rodriguez",
      "address": "2250 Industrial Blvd, Warren, MI",
      "phone": "(586) 555-0202",
      "mileage": 62000,
      "nextService": "2024-12-18",
      "warranty": "Active"
    },
    {
      "id": "SRV-2024-003",
      "vehicleId": "CFL-008",
      "vehicleMake": "Ram",
      "vehicleModel": "ProMaster 3500",
      "serviceCenter": "Commercial Vehicle Center",
      "serviceType": "Engine Repair",
      "description": "Engine diagnostic, timing belt replacement",
      "scheduledDate": "2024-06-15",
      "estimatedTime": "6 hours",
      "status": "Completed",
      "priority": "Critical",
      "cost": 1200.0,
      "technician": "Robert Martinez",
      "serviceAdvisor": "Jennifer Wang",
      "address": "850 Repair Ave, Troy, MI",
      "phone": "(248) 555-0303",
      "mileage": 78000,
      "nextService": "2024-08-15",
      "warranty": "Expired"
    },
    {
      "id": "SRV-2024-004",
      "vehicleId": "CFL-022",
      "vehicleMake": "Mercedes-Benz",
      "vehicleModel": "Sprinter 2500",
      "serviceCenter": "Luxury Commercial Service",
      "serviceType": "Transmission Service",
      "description": "Transmission fluid change, filter replacement",
      "scheduledDate": "2024-06-25",
      "estimatedTime": "3 hours",
      "status": "Scheduled",
      "priority": "Normal",
      "cost": 420.0,
      "technician": "Carlos Rivera",
      "serviceAdvisor": "Amanda Thompson",
      "address": "1750 Luxury Lane, Birmingham, MI",
      "phone": "(248) 555-0404",
      "mileage": 35000,
      "nextService": "2024-12-25",
      "warranty": "Active"
    },
    {
      "id": "SRV-2024-005",
      "vehicleId": "CFL-031",
      "vehicleMake": "Isuzu",
      "vehicleModel": "NPR-HD",
      "serviceCenter": "Heavy Duty Service Center",
      "serviceType": "Tire Replacement",
      "description": "Replace all 6 tires, wheel alignment",
      "scheduledDate": "2024-06-22",
      "estimatedTime": "3 hours",
      "status": "Waiting for Parts",
      "priority": "High",
      "cost": 1800.0,
      "technician": "Tony Garcia",
      "serviceAdvisor": "Michelle Lee",
      "address": "3400 Heavy Equipment Rd, Pontiac, MI",
      "phone": "(248) 555-0505",
      "mileage": 95000,
      "nextService": "2025-06-22",
      "warranty": "Active"
    },
    {
      "id": "SRV-2024-006",
      "vehicleId": "CFL-040",
      "vehicleMake": "Ford",
      "vehicleModel": "F-550",
      "serviceCenter": "Premium Auto Service",
      "serviceType": "A/C Repair",
      "description": "A/C system diagnostic, compressor replacement",
      "scheduledDate": "2024-06-19",
      "estimatedTime": "5 hours",
      "status": "Completed",
      "priority": "Normal",
      "cost": 850.0,
      "technician": "Mark Davis",
      "serviceAdvisor": "Sarah Wilson",
      "address": "1500 Service Dr, Detroit, MI",
      "phone": "(313) 555-0101",
      "mileage": 52000,
      "nextService": "2024-12-19",
      "warranty": "Active"
    }
  ];

  List<Map<String, dynamic>> serviceCenters = [
    {
      "name": "Premium Auto Service",
      "address": "1500 Service Dr, Detroit, MI",
      "phone": "(313) 555-0101",
      "rating": 4.8,
      "reviewCount": 156,
      "specialties": ["Commercial Vehicles", "Fleet Service", "Preventive Maintenance"],
      "certifications": ["ASE Certified", "Ford Certified", "Fleet Specialist"],
      "isOpen": true,
      "hours": "7:00 AM - 6:00 PM",
      "services": ["Maintenance", "Repairs", "Diagnostics", "Towing"],
      "waitTime": "2-3 days"
    },
    {
      "name": "Fleet Service Solutions",
      "address": "2250 Industrial Blvd, Warren, MI",
      "phone": "(586) 555-0202",
      "rating": 4.6,
      "reviewCount": 89,
      "specialties": ["Heavy Duty Repairs", "Engine Overhaul", "Transmission"],
      "certifications": ["ASE Master", "Commercial Vehicle Certified"],
      "isOpen": true,
      "hours": "6:00 AM - 8:00 PM",
      "services": ["Emergency Repairs", "Mobile Service", "Parts Supply"],
      "waitTime": "1-2 days"
    },
    {
      "name": "Commercial Vehicle Center",
      "address": "850 Repair Ave, Troy, MI",
      "phone": "(248) 555-0303",
      "rating": 4.7,
      "reviewCount": 203,
      "specialties": ["Body Work", "Paint Service", "Collision Repair"],
      "certifications": ["I-CAR Certified", "Insurance Approved"],
      "isOpen": false,
      "hours": "Closed - Opens 8:00 AM",
      "services": ["Body Repair", "Paint", "Insurance Claims"],
      "waitTime": "3-5 days"
    }
  ];

  List<Map<String, dynamic>> serviceTypeItems = [
    {"label": "All Services", "value": "All Services"},
    {"label": "Regular Maintenance", "value": "Regular Maintenance"},
    {"label": "Brake Repair", "value": "Brake Repair"},
    {"label": "Engine Repair", "value": "Engine Repair"},
    {"label": "Transmission Service", "value": "Transmission Service"},
    {"label": "Tire Replacement", "value": "Tire Replacement"},
    {"label": "A/C Repair", "value": "A/C Repair"},
  ];

  List<Map<String, dynamic>> urgencyItems = [
    {"label": "All", "value": "All"},
    {"label": "Normal", "value": "Normal"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Waiting for Parts", "value": "Waiting for Parts"},
  ];

  List<Map<String, dynamic>> centerItems = [
    {"label": "All Centers", "value": "All Centers"},
    {"label": "Premium Auto Service", "value": "Premium Auto Service"},
    {"label": "Fleet Service Solutions", "value": "Fleet Service Solutions"},
    {"label": "Commercial Vehicle Center", "value": "Commercial Vehicle Center"},
  ];

  List<Map<String, dynamic>> get filteredServices {
    return serviceData.where((service) {
      if (selectedServiceType != "All Services" && service["serviceType"] != selectedServiceType) return false;
      if (selectedUrgency != "All" && service["priority"] != selectedUrgency) return false;
      if (selectedStatus != "All" && service["status"] != selectedStatus) return false;
      if (selectedCenter != "All Centers" && service["serviceCenter"] != selectedCenter) return false;
      return true;
    }).toList();
  }

  Widget _buildOverviewTab() {
    final totalServices = filteredServices.length;
    final activeServices = filteredServices.where((s) => s["status"] == "In Progress" || s["status"] == "Scheduled").length;
    final totalCost = filteredServices.fold(0.0, (sum, service) => sum + (service["cost"] as double));
    final completedServices = filteredServices.where((s) => s["status"] == "Completed").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Service Type",
                  items: serviceTypeItems,
                  value: selectedServiceType,
                  onChanged: (value, label) {
                    selectedServiceType = value;
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

          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatCard("Total Services", "$totalServices", Icons.build, primaryColor),
              _buildStatCard("Active Services", "$activeServices", Icons.pending, warningColor),
              _buildStatCard("Total Cost", "\$${totalCost.currency}", Icons.attach_money, dangerColor),
              _buildStatCard("Completed", "$completedServices", Icons.check_circle, successColor),
            ],
          ),

          // Service Status Distribution
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
                Text(
                  "Service Status Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildStatusChart(),
              ],
            ),
          ),

          // Recent Services
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
                Text(
                  "Recent Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...filteredServices.take(3).map((service) => _buildServiceItem(service)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchedulingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Service Centers
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
                Row(
                  children: [
                    Text(
                      "Available Service Centers",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Schedule Service",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {
                        ss("Opening service scheduling");
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...serviceCenters.map((center) => _buildServiceCenterCard(center)),
              ],
            ),
          ),

          // Quick Schedule Form
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
                Text(
                  "Quick Schedule Service",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildQuickScheduleForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: urgencyItems,
                  value: selectedUrgency,
                  onChanged: (value, label) {
                    selectedUrgency = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Service Center",
                  items: centerItems,
                  value: selectedCenter,
                  onChanged: (value, label) {
                    selectedCenter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Service Tracking List
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
                Text(
                  "Service Tracking",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...filteredServices.map((service) => _buildDetailedServiceItem(service)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Service Analytics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Average Cost", "\$677", "per service", infoColor),
              _buildAnalyticsCard("Avg Completion Time", "3.5 hours", "per service", successColor),
              _buildAnalyticsCard("Most Common Service", "Regular Maintenance", "35% of all", warningColor),
              _buildAnalyticsCard("Customer Satisfaction", "4.7/5", "average rating", primaryColor),
            ],
          ),

          // Service Trends
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
                Text(
                  "Service Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildServiceTrendChart(),
              ],
            ),
          ),

          // Service Performance
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
                Row(
                  children: [
                    Text(
                      "Service Center Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Export Report",
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        ss("Service report exported successfully");
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildPerformanceList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, String subtitle, Color color) {
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
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChart() {
    final scheduled = filteredServices.where((s) => s["status"] == "Scheduled").length;
    final inProgress = filteredServices.where((s) => s["status"] == "In Progress").length;
    final completed = filteredServices.where((s) => s["status"] == "Completed").length;
    final waiting = filteredServices.where((s) => s["status"] == "Waiting for Parts").length;
    
    return Column(
      children: [
        _buildChartBar("Scheduled", scheduled, infoColor),
        _buildChartBar("In Progress", inProgress, warningColor),
        _buildChartBar("Completed", completed, successColor),
        _buildChartBar("Waiting for Parts", waiting, dangerColor),
      ],
    );
  }

  Widget _buildChartBar(String label, int value, Color color) {
    final maxValue = filteredServices.length;
    final percentage = maxValue > 0 ? (value / maxValue) : 0.0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Text("$value", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildServiceItem(Map<String, dynamic> service) {
    Color statusColor = service["status"] == "Completed" ? successColor :
                       service["status"] == "In Progress" ? warningColor :
                       service["status"] == "Scheduled" ? infoColor : dangerColor;
                       
    Color priorityColor = service["priority"] == "Critical" ? dangerColor :
                         service["priority"] == "High" ? warningColor : successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(width: 4, color: statusColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${service["id"]} - ${service["vehicleId"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${service["serviceType"]} • ${service["scheduledDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${service["serviceCenter"]}",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${service["priority"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${(service["cost"] as double).currency}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCenterCard(Map<String, dynamic> center) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border(
          left: BorderSide(
            width: 4,
            color: center["isOpen"] ? successColor : disabledBoldColor,
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
                  "${center["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "${center["rating"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  Text(
                    " (${center["reviewCount"]})",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${center["address"]}",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${center["phone"]}",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: spMd),
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Wait: ${center["waitTime"]}",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (center["specialties"] as List).map((specialty) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(100)),
                ),
                child: Text(
                  "$specialty",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Schedule Here",
                  icon: Icons.schedule,
                  size: bs.sm,
                  onPressed: () {
                    ss("Scheduling service at ${center["name"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  ss("Calling ${center["name"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickScheduleForm() {
    return Column(
      children: [
        QDropdownField(
          label: "Vehicle",
          items: [
            {"label": "CFL-001 - Ford Transit 350", "value": "CFL-001"},
            {"label": "CFL-015 - Chevrolet Express 2500", "value": "CFL-015"},
            {"label": "CFL-008 - Ram ProMaster 3500", "value": "CFL-008"},
          ],
          value: "CFL-001",
          onChanged: (value, label) {},
        ),
        SizedBox(height: spMd),
        QDropdownField(
          label: "Service Type",
          items: serviceTypeItems.where((item) => item["value"] != "All Services").toList(),
          value: "Regular Maintenance",
          onChanged: (value, label) {},
        ),
        SizedBox(height: spMd),
        QDropdownField(
          label: "Preferred Center",
          items: centerItems.where((item) => item["value"] != "All Centers").toList(),
          value: "Premium Auto Service",
          onChanged: (value, label) {},
        ),
        SizedBox(height: spMd),
        QDatePicker(
          label: "Preferred Date",
          value: DateTime.now().add(Duration(days: 3)),
          onChanged: (value) {},
        ),
        SizedBox(height: spMd),
        QMemoField(
          label: "Service Description",
          value: "",
          hint: "Describe the issue or required service...",
          onChanged: (value) {},
        ),
        SizedBox(height: spMd),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Schedule Service",
            icon: Icons.check,
            size: bs.md,
            onPressed: () {
              ss("Service scheduled successfully");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedServiceItem(Map<String, dynamic> service) {
    Color statusColor = service["status"] == "Completed" ? successColor :
                       service["status"] == "In Progress" ? warningColor :
                       service["status"] == "Scheduled" ? infoColor : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(width: 4, color: statusColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${service["id"]} - ${service["vehicleId"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${service["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
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
                    Text("Vehicle: ${service["vehicleMake"]} ${service["vehicleModel"]}", style: TextStyle(fontSize: 14)),
                    Text("Service: ${service["serviceType"]}", style: TextStyle(fontSize: 14)),
                    Text("Date: ${service["scheduledDate"]}", style: TextStyle(fontSize: 14)),
                    Text("Center: ${service["serviceCenter"]}", style: TextStyle(fontSize: 14)),
                    Text("Technician: ${service["technician"]}", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Cost: \$${(service["cost"] as double).currency}", 
                       style: TextStyle(fontWeight: FontWeight.bold, color: dangerColor)),
                  Text("Est. Time: ${service["estimatedTime"]}", style: TextStyle(fontSize: 14)),
                  Text("Mileage: ${service["mileage"]}", style: TextStyle(fontSize: 14)),
                  Text("Warranty: ${service["warranty"]}", style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${service["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceTrendChart() {
    return Container(
      height: 200,
      child: Center(
        child: Text(
          "Service trend visualization would be displayed here",
          style: TextStyle(color: disabledBoldColor),
        ),
      ),
    );
  }

  Widget _buildPerformanceList() {
    final performanceData = [
      {"center": "Premium Auto Service", "completed": 45, "avgTime": "2.8 hours", "satisfaction": 4.8},
      {"center": "Fleet Service Solutions", "completed": 32, "avgTime": "3.2 hours", "satisfaction": 4.6},
      {"center": "Commercial Vehicle Center", "completed": 28, "avgTime": "4.1 hours", "satisfaction": 4.7},
    ];

    return Column(
      children: performanceData.map((data) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
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
                      "${data["center"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Completed: ${data["completed"]} services",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${data["avgTime"]}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 14),
                      Text(
                        " ${data["satisfaction"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.bold,
                        ),
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Service Center",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Scheduling", icon: Icon(Icons.schedule)),
        Tab(text: "Tracking", icon: Icon(Icons.track_changes)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSchedulingTab(),
        _buildTrackingTab(),
        _buildReportsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
