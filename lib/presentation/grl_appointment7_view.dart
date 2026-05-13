import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAppointment7View extends StatefulWidget {
  @override
  State<GrlAppointment7View> createState() => _GrlAppointment7ViewState();
}

class _GrlAppointment7ViewState extends State<GrlAppointment7View> {
  String selectedDate = "";
  String selectedTime = "";
  String reasonForReschedule = "";
  bool isUrgent = false;

  Map<String, dynamic> currentAppointment = {
    "id": "APT-2024-001",
    "doctor": "Dr. Sarah Johnson",
    "specialty": "Cardiologist",
    "date": "2024-01-15",
    "time": "09:00",
    "location": "Room 301, Medical Center",
    "type": "consultation",
    "fee": 150.0,
    "doctorImage": "https://picsum.photos/80/80?random=1&keyword=doctor",
  };

  List<String> availableDates = [
    "2024-01-20", "2024-01-21", "2024-01-22", "2024-01-23",
    "2024-01-24", "2024-01-25", "2024-01-26", "2024-01-27",
  ];

  List<String> timeSlots = [
    "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
    "14:00", "14:30", "15:00", "15:30", "16:00", "16:30",
    "17:00", "17:30",
  ];

  List<String> busySlots = ["10:30", "15:00", "16:30"];

  List<Map<String, dynamic>> rescheduleReasons = [
    {
      "label": "Personal Emergency",
      "value": "emergency",
    },
    {
      "label": "Work Conflict",
      "value": "work",
    },
    {
      "label": "Health Issues",
      "value": "health",
    },
    {
      "label": "Transportation Issues",
      "value": "transport",
    },
    {
      "label": "Other",
      "value": "other",
    },
  ];

  void _rescheduleAppointment() async {
    if (selectedDate.isEmpty || selectedTime.isEmpty) {
      se("Please select both date and time");
      return;
    }

    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    ss("Appointment rescheduled successfully!");
    back();
  }

  bool _isTimeSlotBusy(String time) {
    return busySlots.contains(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reschedule Appointment"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Appointment Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Appointment",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          image: DecorationImage(
                            image: NetworkImage("${currentAppointment["doctorImage"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentAppointment["doctor"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${currentAppointment["specialty"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Current: ${DateTime.parse("${currentAppointment["date"]}").dMMMy} at ${currentAppointment["time"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
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

            SizedBox(height: spLg),

            // Reason for Reschedule
            QDropdownField(
              label: "Reason for Rescheduling",
              items: rescheduleReasons,
              value: reasonForReschedule,
              onChanged: (value, label) {
                reasonForReschedule = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Priority Toggle
            QSwitch(
              items: [
                {
                  "label": "Mark as Urgent",
                  "value": true,
                  "checked": isUrgent,
                }
              ],
              value: [
                if (isUrgent)
                  {
                    "label": "Mark as Urgent",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  isUrgent = values.isNotEmpty;
                });
              },
            ),

            if (isUrgent) ...[
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: dangerColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.priority_high,
                      color: dangerColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Urgent rescheduling requests will be processed immediately. Additional fees may apply.",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: spLg),

            // New Date Selection
            Text(
              "Select New Date",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(spMd),
                itemCount: availableDates.length,
                itemBuilder: (context, index) {
                  final date = availableDates[index];
                  final dateTime = DateTime.parse(date);
                  bool isSelected = selectedDate == date;

                  return GestureDetector(
                    onTap: () {
                      selectedDate = date;
                      selectedTime = ""; // Reset time selection
                      setState(() {});
                    },
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${dateTime.day}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : primaryColor,
                            ),
                          ),
                          Text(
                            ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][dateTime.weekday % 7],
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                          Text(
                            ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][dateTime.month - 1],
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (selectedDate.isNotEmpty) ...[
              SizedBox(height: spLg),

              // Time Selection
              Text(
                "Available Time Slots",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Text(
                "Selected Date: ${DateTime.parse(selectedDate).dMMMy}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    // Morning Slots
                    Row(
                      children: [
                        Icon(
                          Icons.wb_sunny,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Morning",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),

                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: timeSlots.where((time) => 
                        int.parse(time.split(':')[0]) < 12
                      ).map((time) {
                        bool isSelected = selectedTime == time;
                        bool isBusy = _isTimeSlotBusy(time);

                        return GestureDetector(
                          onTap: isBusy ? null : () {
                            selectedTime = time;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spMd,
                              vertical: spSm,
                            ),
                            decoration: BoxDecoration(
                              color: isBusy 
                                  ? disabledColor.withAlpha(20)
                                  : isSelected 
                                      ? primaryColor 
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isBusy 
                                    ? disabledColor
                                    : isSelected 
                                        ? primaryColor 
                                        : disabledOutlineBorderColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              time,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isBusy 
                                    ? disabledColor
                                    : isSelected 
                                        ? Colors.white 
                                        : primaryColor,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: spLg),

                    // Afternoon Slots
                    Row(
                      children: [
                        Icon(
                          Icons.wb_cloudy,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Afternoon",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),

                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: timeSlots.where((time) => 
                        int.parse(time.split(':')[0]) >= 12
                      ).map((time) {
                        bool isSelected = selectedTime == time;
                        bool isBusy = _isTimeSlotBusy(time);

                        return GestureDetector(
                          onTap: isBusy ? null : () {
                            selectedTime = time;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spMd,
                              vertical: spSm,
                            ),
                            decoration: BoxDecoration(
                              color: isBusy 
                                  ? disabledColor.withAlpha(20)
                                  : isSelected 
                                      ? primaryColor 
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isBusy 
                                    ? disabledColor
                                    : isSelected 
                                        ? primaryColor 
                                        : disabledOutlineBorderColor,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  time,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isBusy 
                                        ? disabledColor
                                        : isSelected 
                                            ? Colors.white 
                                            : primaryColor,
                                  ),
                                ),
                                if (isBusy) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.block,
                                    size: 16,
                                    color: disabledColor,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: spMd),

                    // Legend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: disabledColor),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Not Available",
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
            ],

            SizedBox(height: spLg),

            // Summary
            if (selectedDate.isNotEmpty && selectedTime.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: successColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Appointment Schedule",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          DateTime.parse(selectedDate).dMMMy,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.access_time,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          selectedTime,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spLg),
            ],

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.md,
                    onPressed: () {
                      back();
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Confirm Reschedule",
                    size: bs.md,
                    onPressed: _rescheduleAppointment,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Note
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Rescheduling is free if done 24 hours before the appointment. A cancellation fee may apply for last-minute changes.",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
