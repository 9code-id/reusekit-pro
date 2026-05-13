import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmAppointmentCalendarView extends StatefulWidget {
  const FsmAppointmentCalendarView({super.key});

  @override
  State<FsmAppointmentCalendarView> createState() => _FsmAppointmentCalendarViewState();
}

class _FsmAppointmentCalendarViewState extends State<FsmAppointmentCalendarView> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  
  List<Map<String, dynamic>> appointments = [
    {
      "id": "1",
      "title": "Annual HVAC Maintenance",
      "client": "TechCorp Office Building",
      "technician": "John Smith",
      "date": DateTime.now(),
      "startTime": "09:00",
      "endTime": "12:00",
      "status": "Confirmed",
      "type": "Maintenance",
      "priority": "High",
      "duration": 3,
      "notes": "Annual system checkup and filter replacement",
      "clientPhone": "+1 555-0123",
      "location": "123 Business District, Floor 15"
    },
    {
      "id": "2",
      "title": "Emergency Plumbing Repair",
      "client": "Green Valley Apartments",
      "technician": "Mike Davis", 
      "date": DateTime.now(),
      "startTime": "14:00",
      "endTime": "16:30",
      "status": "In Progress",
      "type": "Emergency",
      "priority": "Critical",
      "duration": 2.5,
      "notes": "Burst pipe in basement, water damage control",
      "clientPhone": "+1 555-0124",
      "location": "456 Residential Ave, Building C"
    },
    {
      "id": "3",
      "title": "Electrical System Installation",
      "client": "New Factory Complex",
      "technician": "Sarah Johnson",
      "date": DateTime.now().add(Duration(days: 1)),
      "startTime": "08:00",
      "endTime": "17:00",
      "status": "Scheduled",
      "type": "Installation",
      "priority": "High",
      "duration": 8,
      "notes": "Complete electrical setup for manufacturing floor",
      "clientPhone": "+1 555-0125",
      "location": "789 Industrial Zone, Sector A"
    },
    {
      "id": "4",
      "title": "Security System Check",
      "client": "Downtown Mall",
      "technician": "Emma Wilson",
      "date": DateTime.now().add(Duration(days: 2)),
      "startTime": "10:00",
      "endTime": "13:00",
      "status": "Scheduled",
      "type": "Inspection",
      "priority": "Medium",
      "duration": 3,
      "notes": "Monthly security system audit and testing",
      "clientPhone": "+1 555-0126",
      "location": "321 Shopping District, Main Entrance"
    },
    {
      "id": "5",
      "title": "Routine Maintenance",
      "client": "Hospital West Wing",
      "technician": "John Smith",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "startTime": "07:00",
      "endTime": "11:00",
      "status": "Completed",
      "type": "Maintenance",
      "priority": "High",
      "duration": 4,
      "notes": "Critical infrastructure maintenance completed",
      "clientPhone": "+1 555-0127",
      "location": "555 Medical Center Dr, West Wing"
    }
  ];

  bool showAppointmentForm = false;
  Map<String, dynamic>? selectedAppointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              selectedAppointment = null;
              showAppointmentForm = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCalendarHeader(),
            _buildCalendarGrid(),
            _buildAppointmentsList(),
            if (showAppointmentForm) _buildAppointmentForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              focusedDate = DateTime(focusedDate.year, focusedDate.month - 1);
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(Icons.chevron_left, color: primaryColor),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${_getMonthName(focusedDate.month)} ${focusedDate.year}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${_getAppointmentCountForMonth()} appointments this month",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              focusedDate = DateTime(focusedDate.year, focusedDate.month + 1);
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(Icons.chevron_right, color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Weekday headers
          Row(
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) => 
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ),
            ).toList(),
          ),
          // Calendar days
          ..._buildCalendarWeeks(),
        ],
      ),
    );
  }

  List<Widget> _buildCalendarWeeks() {
    List<Widget> weeks = [];
    DateTime firstDayOfMonth = DateTime(focusedDate.year, focusedDate.month, 1);
    DateTime lastDayOfMonth = DateTime(focusedDate.year, focusedDate.month + 1, 0);
    
    int startingDayOfWeek = firstDayOfMonth.weekday % 7;
    DateTime startDate = firstDayOfMonth.subtract(Duration(days: startingDayOfWeek));
    
    for (int week = 0; week < 6; week++) {
      List<Widget> days = [];
      for (int day = 0; day < 7; day++) {
        DateTime currentDate = startDate.add(Duration(days: week * 7 + day));
        days.add(_buildCalendarDay(currentDate, currentDate.month == focusedDate.month));
      }
      weeks.add(Row(children: days));
      
      if (weeks.length >= 5 && 
          startDate.add(Duration(days: (week + 1) * 7)).month != focusedDate.month) {
        break;
      }
    }
    
    return weeks;
  }

  Widget _buildCalendarDay(DateTime date, bool isCurrentMonth) {
    bool isSelected = date.day == selectedDate.day && 
                     date.month == selectedDate.month && 
                     date.year == selectedDate.year;
    bool isToday = date.day == DateTime.now().day && 
                   date.month == DateTime.now().month && 
                   date.year == DateTime.now().year;
    
    List<Map<String, dynamic>> dayAppointments = appointments.where((apt) {
      DateTime aptDate = apt["date"] as DateTime;
      return aptDate.day == date.day && 
             aptDate.month == date.month && 
             aptDate.year == date.year;
    }).toList();

    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedDate = date;
          setState(() {});
        },
        child: Container(
          height: 50,
          margin: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : 
                   isToday ? primaryColor.withAlpha(20) : Colors.transparent,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  "${date.day}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white :
                           isToday ? primaryColor :
                           isCurrentMonth ? primaryColor : disabledColor,
                  ),
                ),
              ),
              if (dayAppointments.isNotEmpty)
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : 
                             dayAppointments.any((apt) => apt["priority"] == "Critical") ? dangerColor :
                             dayAppointments.any((apt) => apt["priority"] == "High") ? warningColor : successColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentsList() {
    List<Map<String, dynamic>> dayAppointments = appointments.where((apt) {
      DateTime aptDate = apt["date"] as DateTime;
      return aptDate.day == selectedDate.day && 
             aptDate.month == selectedDate.month && 
             aptDate.year == selectedDate.year;
    }).toList();

    dayAppointments.sort((a, b) => a["startTime"].compareTo(b["startTime"]));

    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Appointments for ${selectedDate.dMMMy}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (dayAppointments.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(Icons.event_available, size: 48, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No appointments scheduled",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              spacing: spSm,
              children: dayAppointments.map((appointment) => 
                _buildAppointmentCard(appointment)).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    Color statusColor = appointment["status"] == "Completed" ? successColor :
                       appointment["status"] == "In Progress" ? infoColor :
                       appointment["status"] == "Confirmed" ? warningColor : disabledBoldColor;

    Color priorityColor = appointment["priority"] == "Critical" ? dangerColor :
                         appointment["priority"] == "High" ? warningColor :
                         appointment["priority"] == "Medium" ? infoColor : successColor;

    return GestureDetector(
      onTap: () {
        selectedAppointment = appointment;
        showAppointmentForm = true;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border(
            left: BorderSide(
              width: 4,
              color: priorityColor,
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
                    spacing: spXs,
                    children: [
                      Text(
                        "${appointment["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Client: ${appointment["client"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Technician: ${appointment["technician"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: spXs,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${appointment["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${appointment["priority"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: priorityColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${appointment["startTime"]} - ${appointment["endTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                Icon(Icons.timer, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${appointment["duration"]}h",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${appointment["type"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentForm() {
    bool isEditing = selectedAppointment != null;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                isEditing ? "Edit Appointment" : "New Appointment",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (isEditing)
                GestureDetector(
                  onTap: () async {
                    bool isConfirmed = await confirm("Are you sure you want to delete this appointment?");
                    if (isConfirmed) {
                      ss("Appointment deleted successfully");
                      showAppointmentForm = false;
                      selectedAppointment = null;
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    child: Icon(Icons.delete, color: dangerColor),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  showAppointmentForm = false;
                  selectedAppointment = null;
                  setState(() {});
                },
                child: Icon(Icons.close, color: disabledBoldColor),
              ),
            ],
          ),
          QTextField(
            label: "Appointment Title",
            value: isEditing ? "${selectedAppointment!["title"]}" : "",
            onChanged: (value) {},
          ),
          QTextField(
            label: "Client Name",
            value: isEditing ? "${selectedAppointment!["client"]}" : "",
            onChanged: (value) {},
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Technician",
                  items: [
                    {"label": "John Smith", "value": "John Smith"},
                    {"label": "Mike Davis", "value": "Mike Davis"},
                    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
                    {"label": "Emma Wilson", "value": "Emma Wilson"},
                  ],
                  value: isEditing ? "${selectedAppointment!["technician"]}" : "",
                  onChanged: (value, label) {},
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "Critical", "value": "Critical"},
                    {"label": "High", "value": "High"},
                    {"label": "Medium", "value": "Medium"},
                    {"label": "Low", "value": "Low"},
                  ],
                  value: isEditing ? "${selectedAppointment!["priority"]}" : "",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Appointment Date",
                  value: isEditing ? selectedAppointment!["date"] as DateTime : selectedDate,
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: [
                    {"label": "Installation", "value": "Installation"},
                    {"label": "Maintenance", "value": "Maintenance"},
                    {"label": "Repair", "value": "Repair"},
                    {"label": "Emergency", "value": "Emergency"},
                    {"label": "Inspection", "value": "Inspection"},
                  ],
                  value: isEditing ? "${selectedAppointment!["type"]}" : "",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTimePicker(
                  label: "Start Time",
                  value: isEditing ? "${selectedAppointment!["startTime"]}".timeOfDay : TimeOfDay.now(),
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                child: QTimePicker(
                  label: "End Time",
                  value: isEditing ? "${selectedAppointment!["endTime"]}".timeOfDay : TimeOfDay.now(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          QTextField(
            label: "Location",
            value: isEditing ? "${selectedAppointment!["location"]}" : "",
            onChanged: (value) {},
          ),
          QTextField(
            label: "Client Phone",
            value: isEditing ? "${selectedAppointment!["clientPhone"]}" : "",
            onChanged: (value) {},
          ),
          QMemoField(
            label: "Notes",
            value: isEditing ? "${selectedAppointment!["notes"]}" : "",
            onChanged: (value) {},
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    showAppointmentForm = false;
                    selectedAppointment = null;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: isEditing ? "Update" : "Create",
                  size: bs.sm,
                  onPressed: () {
                    ss(isEditing ? "Appointment updated successfully" : "Appointment created successfully");
                    showAppointmentForm = false;
                    selectedAppointment = null;
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

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  int _getAppointmentCountForMonth() {
    return appointments.where((apt) {
      DateTime aptDate = apt["date"] as DateTime;
      return aptDate.month == focusedDate.month && aptDate.year == focusedDate.year;
    }).length;
  }
}
