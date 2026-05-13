import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmMeetingSchedulerView extends StatefulWidget {
  const EcmMeetingSchedulerView({super.key});

  @override
  State<EcmMeetingSchedulerView> createState() => _EcmMeetingSchedulerViewState();
}

class _EcmMeetingSchedulerViewState extends State<EcmMeetingSchedulerView> {
  String meetingTitle = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedDuration = "30";
  String meetingType = "In-Person";
  String location = "";
  String description = "";
  String selectedAttendees = "";
  bool sendReminder = true;
  String reminderTime = "15";

  List<Map<String, dynamic>> durationOptions = [
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "45 minutes", "value": "45"},
    {"label": "1 hour", "value": "60"},
    {"label": "1.5 hours", "value": "90"},
    {"label": "2 hours", "value": "120"},
  ];

  List<Map<String, dynamic>> meetingTypeOptions = [
    {"label": "In-Person", "value": "In-Person"},
    {"label": "Virtual", "value": "Virtual"},
    {"label": "Hybrid", "value": "Hybrid"},
  ];

  List<Map<String, dynamic>> reminderOptions = [
    {"label": "5 minutes before", "value": "5"},
    {"label": "15 minutes before", "value": "15"},
    {"label": "30 minutes before", "value": "30"},
    {"label": "1 hour before", "value": "60"},
  ];

  List<Map<String, dynamic>> upcomingMeetings = [
    {
      "title": "Project Kickoff Meeting",
      "date": "2024-01-15",
      "time": "09:00",
      "duration": "60",
      "type": "Virtual",
      "attendees": 8,
      "status": "Confirmed"
    },
    {
      "title": "Weekly Team Standup",
      "date": "2024-01-16",
      "time": "10:30",
      "duration": "30",
      "type": "In-Person",
      "attendees": 12,
      "status": "Pending"
    },
    {
      "title": "Client Presentation",
      "date": "2024-01-17",
      "time": "14:00",
      "duration": "90",
      "type": "Hybrid",
      "attendees": 6,
      "status": "Confirmed"
    },
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meeting Scheduler"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Schedule New Meeting",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Create and manage your meetings efficiently",
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
              ),

              QTextField(
                label: "Meeting Title",
                value: meetingTitle,
                hint: "Enter meeting title",
                validator: Validator.required,
                onChanged: (value) {
                  meetingTitle = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "Meeting Date",
                      value: selectedDate,
                      onChanged: (value) {
                        selectedDate = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTimePicker(
                      label: "Meeting Time",
                      value: selectedTime,
                      onChanged: (value) {
                        selectedTime = value!;
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
                      label: "Duration",
                      items: durationOptions,
                      value: selectedDuration,
                      onChanged: (value, label) {
                        selectedDuration = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Meeting Type",
                      items: meetingTypeOptions,
                      value: meetingType,
                      onChanged: (value, label) {
                        meetingType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QTextField(
                label: "Location / Meeting Link",
                value: location,
                hint: meetingType == "Virtual" ? "Enter meeting link" : "Enter location",
                validator: Validator.required,
                onChanged: (value) {
                  location = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Meeting Description",
                value: description,
                hint: "Add meeting agenda and details",
                onChanged: (value) {
                  description = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Attendees",
                value: selectedAttendees,
                hint: "Add attendee emails separated by commas",
                onChanged: (value) {
                  selectedAttendees = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Send Reminder",
                          "value": true,
                          "checked": sendReminder,
                        }
                      ],
                      value: [
                        if (sendReminder)
                          {
                            "label": "Send Reminder",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        sendReminder = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                  if (sendReminder) ...[
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Reminder Time",
                        items: reminderOptions,
                        value: reminderTime,
                        onChanged: (value, label) {
                          reminderTime = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ],
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Schedule Meeting",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ss("Meeting scheduled successfully!");
                    }
                  },
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
                        Text(
                          "Upcoming Meetings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...List.generate(upcomingMeetings.length, (index) {
                      final meeting = upcomingMeetings[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${meeting["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
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
                                    color: meeting["status"] == "Confirmed"
                                        ? successColor.withAlpha(20)
                                        : warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${meeting["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: meeting["status"] == "Confirmed"
                                          ? successColor
                                          : warningColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${DateTime.parse(meeting["date"]).dMMMy} • ${meeting["time"]} • ${meeting["duration"]}min",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  meeting["type"] == "Virtual"
                                      ? Icons.videocam
                                      : meeting["type"] == "Hybrid"
                                          ? Icons.merge_type
                                          : Icons.location_on,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${meeting["type"]} • ${meeting["attendees"]} attendees",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
