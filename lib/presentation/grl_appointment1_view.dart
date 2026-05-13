import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAppointment1View extends StatefulWidget {
  @override
  State<GrlAppointment1View> createState() => _GrlAppointment1ViewState();
}

class _GrlAppointment1ViewState extends State<GrlAppointment1View> {
  int selectedTab = 0;
  String selectedFilter = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> appointments = [
    {
      "id": "APT001",
      "patientName": "Sarah Johnson",
      "doctorName": "Dr. Michael Chen",
      "specialty": "Cardiology",
      "date": "2024-01-15",
      "time": "09:00",
      "duration": "30 min",
      "type": "Check-up",
      "status": "confirmed",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "notes": "Regular cardiac check-up and blood pressure monitoring"
    },
    {
      "id": "APT002",
      "patientName": "David Wilson",
      "doctorName": "Dr. Emily Rodriguez",
      "specialty": "Dermatology",
      "date": "2024-01-15",
      "time": "10:30",
      "duration": "45 min",
      "type": "Consultation",
      "status": "pending",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "notes": "Skin condition evaluation and treatment plan"
    },
    {
      "id": "APT003",
      "patientName": "Maria Garcia",
      "doctorName": "Dr. James Kim",
      "specialty": "Orthopedics",
      "date": "2024-01-15",
      "time": "14:00",
      "duration": "60 min",
      "type": "Follow-up",
      "status": "completed",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "notes": "Post-surgery follow-up and recovery assessment"
    },
    {
      "id": "APT004",
      "patientName": "Robert Thompson",
      "doctorName": "Dr. Lisa Wang",
      "specialty": "Neurology",
      "date": "2024-01-16",
      "time": "11:15",
      "duration": "45 min",
      "type": "Consultation",
      "status": "cancelled",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "notes": "Neurological assessment for headache symptoms"
    },
    {
      "id": "APT005",
      "patientName": "Jennifer Lee",
      "doctorName": "Dr. Ahmed Hassan",
      "specialty": "Pediatrics",
      "date": "2024-01-16",
      "time": "15:30",
      "duration": "30 min",
      "type": "Vaccination",
      "status": "confirmed",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=person",
      "notes": "Routine childhood vaccination schedule"
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "Tomorrow", "value": "tomorrow"},
    {"label": "This Week", "value": "week"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments"),
        actions: [
          GestureDetector(
            onTap: () {
              // Navigate to add appointment
            },
            child: Icon(
              Icons.add,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          _buildTabBar(),
          Expanded(
            child: _buildAppointmentsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search appointments...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {
                  // Show filter options
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.tune,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    List<String> tabs = ["All", "Pending", "Confirmed", "Completed"];
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAppointmentsList() {
    List<Map<String, dynamic>> filteredAppointments = _getFilteredAppointments();
    
    if (filteredAppointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Icon(
              Icons.calendar_month,
              size: 64,
              color: disabledColor,
            ),
            Text(
              "No appointments found",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filters",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = filteredAppointments[index];
        return _buildAppointmentCard(appointment);
      },
    );
  }

  List<Map<String, dynamic>> _getFilteredAppointments() {
    List<Map<String, dynamic>> filtered = appointments;
    
    // Filter by tab
    if (selectedTab != 0) {
      String status = ["", "pending", "confirmed", "completed"][selectedTab];
      filtered = filtered.where((apt) => apt["status"] == status).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((apt) =>
          apt["patientName"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          apt["doctorName"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          apt["specialty"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    Color statusColor = _getStatusColor(appointment["status"]);
    IconData statusIcon = _getStatusIcon(appointment["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${appointment["avatar"]}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${appointment["patientName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${appointment["doctorName"]} • ${appointment["specialty"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            statusIcon,
                            size: 12,
                            color: statusColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${appointment["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showAppointmentActions(appointment);
                },
                child: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey[300]),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  Icons.calendar_today,
                  "Date",
                  DateTime.parse(appointment["date"]).dMMMy,
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  Icons.access_time,
                  "Time",
                  "${appointment["time"]}",
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  Icons.schedule,
                  "Duration",
                  "${appointment["duration"]}",
                ),
              ),
            ],
          ),
          if (appointment["notes"] != null && appointment["notes"].isNotEmpty) ...[
            SizedBox(height: spXs),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.note,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${appointment["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to appointment details
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (appointment["status"] == "pending")
                Expanded(
                  child: QButton(
                    label: "Confirm",
                    size: bs.sm,
                    color: successColor,
                    onPressed: () {
                      _confirmAppointment(appointment);
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: primaryColor,
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'completed':
        return infoColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'confirmed':
        return Icons.check_circle;
      case 'pending':
        return Icons.schedule;
      case 'completed':
        return Icons.task_alt;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  void _showAppointmentActions(Map<String, dynamic> appointment) {
    // Show action sheet with options like reschedule, cancel, etc.
    ss("Appointment actions menu");
  }

  void _confirmAppointment(Map<String, dynamic> appointment) {
    // Update appointment status to confirmed
    int index = appointments.indexWhere((apt) => apt["id"] == appointment["id"]);
    if (index != -1) {
      appointments[index]["status"] = "confirmed";
      setState(() {});
      ss("Appointment confirmed successfully");
    }
  }
}
