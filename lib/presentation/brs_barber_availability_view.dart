import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBarberAvailabilityView extends StatefulWidget {
  const BrsBarberAvailabilityView({super.key});

  @override
  State<BrsBarberAvailabilityView> createState() => _BrsBarberAvailabilityViewState();
}

class _BrsBarberAvailabilityViewState extends State<BrsBarberAvailabilityView> {
  bool isAvailable = true;
  String selectedTimeZone = "Asia/Jakarta";
  
  List<Map<String, dynamic>> weekDays = [
    {
      "day": "Monday",
      "short": "Mon",
      "isActive": true,
      "startTime": "09:00",
      "endTime": "18:00",
      "breakStart": "12:00",
      "breakEnd": "13:00",
    },
    {
      "day": "Tuesday", 
      "short": "Tue",
      "isActive": true,
      "startTime": "09:00",
      "endTime": "18:00",
      "breakStart": "12:00",
      "breakEnd": "13:00",
    },
    {
      "day": "Wednesday",
      "short": "Wed", 
      "isActive": true,
      "startTime": "09:00",
      "endTime": "18:00",
      "breakStart": "12:00",
      "breakEnd": "13:00",
    },
    {
      "day": "Thursday",
      "short": "Thu",
      "isActive": true,
      "startTime": "09:00",
      "endTime": "18:00",
      "breakStart": "12:00",
      "breakEnd": "13:00",
    },
    {
      "day": "Friday",
      "short": "Fri",
      "isActive": true,
      "startTime": "09:00",
      "endTime": "18:00",
      "breakStart": "12:00",
      "breakEnd": "13:00",
    },
    {
      "day": "Saturday",
      "short": "Sat",
      "isActive": true,
      "startTime": "10:00",
      "endTime": "17:00",
      "breakStart": "12:30",
      "breakEnd": "13:30",
    },
    {
      "day": "Sunday",
      "short": "Sun",
      "isActive": false,
      "startTime": "10:00",
      "endTime": "16:00",
      "breakStart": "12:00",
      "breakEnd": "13:00",
    },
  ];

  List<Map<String, dynamic>> timeZones = [
    {"label": "Asia/Jakarta (GMT+7)", "value": "Asia/Jakarta"},
    {"label": "Asia/Singapore (GMT+8)", "value": "Asia/Singapore"},
    {"label": "UTC (GMT+0)", "value": "UTC"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Availability Settings"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              ss("Availability settings saved successfully");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Availability Status
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
                  Text(
                    "Current Status",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isAvailable ? successColor : dangerColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: Text(
                          isAvailable ? "Available for bookings" : "Currently unavailable",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: isAvailable ? successColor : dangerColor,
                          ),
                        ),
                      ),
                      
                      Switch(
                        value: isAvailable,
                        onChanged: (value) {
                          isAvailable = value;
                          setState(() {});
                        },
                        activeColor: successColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Time Zone
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
                  Text(
                    "Time Zone",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Select Time Zone",
                    items: timeZones,
                    value: selectedTimeZone,
                    onChanged: (value, label) {
                      selectedTimeZone = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Weekly Schedule
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weekly Schedule",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      QButton(
                        label: "Apply to All",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Column(
                    children: List.generate(weekDays.length, (index) {
                      final day = weekDays[index];
                      return _buildDaySchedule(day, index);
                    }),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Quick Actions
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
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Set Standard Hours",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: QButton(
                          label: "Copy Monday",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Enable All Days",
                          size: bs.sm,
                          onPressed: () {
                            for (var day in weekDays) {
                              day["isActive"] = true;
                            }
                            setState(() {});
                          },
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: QButton(
                          label: "Weekend Only",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySchedule(Map<String, dynamic> day, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (day["isActive"] as bool) ? Colors.white : disabledColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: disabledOutlineBorderColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Day Name
              SizedBox(
                width: 80,
                child: Text(
                  "${day["day"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: (day["isActive"] as bool) ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
              
              // Status Switch
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      (day["isActive"] as bool) ? "Active" : "Closed",
                      style: TextStyle(
                        fontSize: 14,
                        color: (day["isActive"] as bool) ? successColor : dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    Switch(
                      value: day["isActive"] as bool,
                      onChanged: (value) {
                        weekDays[index]["isActive"] = value;
                        setState(() {});
                      },
                      activeColor: successColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (day["isActive"] as bool) ...[
            SizedBox(height: spSm),
            
            // Working Hours
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start Time",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${day["startTime"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(width: spSm),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End Time",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${day["endTime"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Break Time
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Break Start",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${day["breakStart"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(width: spSm),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Break End",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${day["breakEnd"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
