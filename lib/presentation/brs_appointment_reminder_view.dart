import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsAppointmentReminderView extends StatefulWidget {
  const BrsAppointmentReminderView({super.key});

  @override
  State<BrsAppointmentReminderView> createState() => _BrsAppointmentReminderViewState();
}

class _BrsAppointmentReminderViewState extends State<BrsAppointmentReminderView> {
  List<Map<String, dynamic>> upcomingAppointments = [
    {
      "id": "1",
      "barberName": "Mike Thompson",
      "barberImage": "https://picsum.photos/200/200?random=1&keyword=barber",
      "service": "Premium Haircut & Beard Trim",
      "date": "2024-01-16",
      "time": "10:00",
      "duration": 45,
      "price": 35.0,
      "shop": "Elite Cuts Barbershop",
      "address": "123 Main Street, Downtown",
      "reminderSet": true,
      "reminderTime": "1_hour",
      "status": "confirmed",
    },
    {
      "id": "2",
      "barberName": "Sarah Wilson",
      "barberImage": "https://picsum.photos/200/200?random=2&keyword=barber",
      "service": "Hair Wash & Styling",
      "date": "2024-01-18",
      "time": "14:30",
      "duration": 30,
      "price": 25.0,
      "shop": "Modern Style Studio",
      "address": "456 Oak Avenue, Midtown",
      "reminderSet": false,
      "reminderTime": "",
      "status": "pending",
    },
    {
      "id": "3",
      "barberName": "David Chen",
      "barberImage": "https://picsum.photos/200/200?random=3&keyword=barber",
      "service": "Luxury Shave Experience",
      "date": "2024-01-20",
      "time": "16:00",
      "duration": 60,
      "price": 45.0,
      "shop": "Classic Gentleman's Club",
      "address": "789 Pine Street, Uptown",
      "reminderSet": true,
      "reminderTime": "2_hour",
      "status": "confirmed",
    },
  ];

  List<Map<String, dynamic>> reminderOptions = [
    {"label": "15 minutes before", "value": "15_min"},
    {"label": "30 minutes before", "value": "30_min"},
    {"label": "1 hour before", "value": "1_hour"},
    {"label": "2 hours before", "value": "2_hour"},
    {"label": "1 day before", "value": "1_day"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Reminders"),
        actions: [
          QButton(
            icon: Icons.add_alert,
            size: bs.sm,
            onPressed: () {
              _setGlobalReminder();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReminderSummary(),
            _buildSectionHeader("Upcoming Appointments"),
            ...upcomingAppointments.map((appointment) => _buildAppointmentCard(appointment)),
            _buildGlobalReminderSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderSummary() {
    int totalAppointments = upcomingAppointments.length;
    int appointmentsWithReminders = upcomingAppointments.where((a) => a["reminderSet"] as bool).length;
    int pendingReminders = upcomingAppointments.where((a) => a["status"] == "pending").length;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(153)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reminder Overview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Stay on top of your appointments",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(204),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  "Total",
                  "$totalAppointments",
                  Icons.calendar_today,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  "With Reminders",
                  "$appointmentsWithReminders",
                  Icons.alarm_on,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  "Pending",
                  "$pendingReminders",
                  Icons.pending,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(204),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fsH6,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    bool reminderSet = appointment["reminderSet"] as bool;
    String status = appointment["status"] as String;
    
    Color statusColor = status == "confirmed" 
        ? successColor 
        : status == "pending" 
        ? warningColor 
        : infoColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: reminderSet ? successColor.withAlpha(102) : disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${appointment["barberImage"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${appointment["barberName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${appointment["service"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: disabledColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${DateTime.parse(appointment["date"] as String).dMMMy} at ${appointment["time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (reminderSet)
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.notifications_active,
                      color: successColor,
                      size: 16,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(25),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${appointment["shop"]} - ${appointment["address"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${appointment["duration"]} min",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          Text(
                            "\$${(appointment["price"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (reminderSet) ...[
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.alarm,
                          size: 14,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Reminder: ${_getReminderLabel(appointment["reminderTime"] as String)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: reminderSet ? "Update Reminder" : "Set Reminder",
                        size: bs.sm,
                        onPressed: () {
                          _showReminderOptions(appointment);
                        },
                      ),
                    ),
                    if (reminderSet) ...[
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.notifications_off,
                        size: bs.sm,
                        onPressed: () {
                          _removeReminder(appointment["id"] as String);
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlobalReminderSettings() {
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
          _buildSectionHeader("Global Settings"),
          Text(
            "Apply reminder settings to all future appointments",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Set All Reminders",
                  size: bs.sm,
                  onPressed: () {
                    _setAllReminders();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Remove All",
                  size: bs.sm,
                  onPressed: () {
                    _removeAllReminders();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getReminderLabel(String reminderTime) {
    switch (reminderTime) {
      case "15_min":
        return "15 minutes before";
      case "30_min":
        return "30 minutes before";
      case "1_hour":
        return "1 hour before";
      case "2_hour":
        return "2 hours before";
      case "1_day":
        return "1 day before";
      default:
        return "No reminder";
    }
  }

  void _showReminderOptions(Map<String, dynamic> appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Set Reminder",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "Choose when you want to be reminded about your appointment with ${appointment["barberName"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: ListView.builder(
                itemCount: reminderOptions.length,
                itemBuilder: (context, index) {
                  final option = reminderOptions[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(radiusSm),
                        onTap: () {
                          _setReminder(appointment["id"] as String, option["value"] as String);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: disabledOutlineBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${option["label"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setReminder(String appointmentId, String reminderTime) {
    for (var appointment in upcomingAppointments) {
      if (appointment["id"] == appointmentId) {
        appointment["reminderSet"] = true;
        appointment["reminderTime"] = reminderTime;
        break;
      }
    }
    setState(() {});
    ss("Reminder set for ${_getReminderLabel(reminderTime)}");
  }

  void _removeReminder(String appointmentId) {
    for (var appointment in upcomingAppointments) {
      if (appointment["id"] == appointmentId) {
        appointment["reminderSet"] = false;
        appointment["reminderTime"] = "";
        break;
      }
    }
    setState(() {});
    ss("Reminder removed");
  }

  void _setGlobalReminder() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: reminderOptions.map((option) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: spSm),
              child: QButton(
                label: "Set all to ${option["label"]}",
                size: bs.sm,
                onPressed: () {
                  _setAllReminders(option["value"] as String);
                  Navigator.pop(context);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _setAllReminders([String? reminderTime]) {
    String defaultTime = reminderTime ?? "1_hour";
    for (var appointment in upcomingAppointments) {
      appointment["reminderSet"] = true;
      appointment["reminderTime"] = defaultTime;
    }
    setState(() {});
    ss("All reminders set to ${_getReminderLabel(defaultTime)}");
  }

  void _removeAllReminders() {
    for (var appointment in upcomingAppointments) {
      appointment["reminderSet"] = false;
      appointment["reminderTime"] = "";
    }
    setState(() {});
    ss("All reminders removed");
  }
}
