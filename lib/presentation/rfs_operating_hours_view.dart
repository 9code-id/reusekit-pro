import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsOperatingHoursView extends StatefulWidget {
  const RfsOperatingHoursView({super.key});

  @override
  State<RfsOperatingHoursView> createState() => _RfsOperatingHoursViewState();
}

class _RfsOperatingHoursViewState extends State<RfsOperatingHoursView> {
  bool loading = false;
  
  Map<String, Map<String, dynamic>> operatingHours = {
    "Monday": {"isOpen": true, "openTime": "09:00", "closeTime": "22:00"},
    "Tuesday": {"isOpen": true, "openTime": "09:00", "closeTime": "22:00"},
    "Wednesday": {"isOpen": true, "openTime": "09:00", "closeTime": "22:00"},
    "Thursday": {"isOpen": true, "openTime": "09:00", "closeTime": "22:00"},
    "Friday": {"isOpen": true, "openTime": "09:00", "closeTime": "23:00"},
    "Saturday": {"isOpen": true, "openTime": "10:00", "closeTime": "23:00"},
    "Sunday": {"isOpen": true, "openTime": "10:00", "closeTime": "21:00"},
  };
  
  List<String> weekdays = [
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
  ];

  void _handleComplete() async {
    loading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Restaurant setup completed successfully!");
    // Navigate to dashboard
    //navigateTo(RfsDashboardView());
  }

  void _copyHours(String fromDay) {
    Map<String, dynamic> sourceHours = operatingHours[fromDay]!;
    
    for (String day in weekdays) {
      if (day != fromDay) {
        operatingHours[day] = Map.from(sourceHours);
      }
    }
    setState(() {});
    ss("Hours copied to all days");
  }

  void _setAllDaysClosed() {
    for (String day in weekdays) {
      operatingHours[day]!["isOpen"] = false;
    }
    setState(() {});
  }

  void _setAllDaysOpen() {
    for (String day in weekdays) {
      operatingHours[day]!["isOpen"] = true;
    }
    setState(() {});
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildStepItem("1", "Restaurant", false, true),
          Expanded(child: Container(height: 2, color: successColor)),
          _buildStepItem("2", "Location", false, true),
          Expanded(child: Container(height: 2, color: successColor)),
          _buildStepItem("3", "Business", false, true),
          Expanded(child: Container(height: 2, color: successColor)),
          _buildStepItem("4", "Hours", true, false),
        ],
      ),
    );
  }

  Widget _buildStepItem(String number, String label, bool isActive, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : (isCompleted ? successColor : disabledColor),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    number,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? primaryColor : disabledBoldColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildDaySchedule(String day) {
    Map<String, dynamic> dayData = operatingHours[day]!;
    bool isOpen = dayData["isOpen"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isOpen ? successColor : dangerColor,
          ),
        ),
      ),
      child: Column(
        children: [
          // Day header
          Row(
            children: [
              Expanded(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QSwitch(
                items: [
                  {
                    "label": "Open",
                    "value": "open",
                    "checked": isOpen,
                  }
                ],
                value: [
                  if (isOpen)
                    {
                      "label": "Open",
                      "value": "open",
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  operatingHours[day]!["isOpen"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(width: spSm),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: disabledBoldColor),
                onSelected: (value) {
                  if (value == "copy") {
                    _copyHours(day);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "copy",
                    child: Text("Copy to all days"),
                  ),
                ],
              ),
            ],
          ),
          
          // Time selection (only if open)
          if (isOpen) ...[
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Opening Time",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      QTimePicker(
                        label: "Open",
                        value: dayData["openTime"].timeOfDay,
                        onChanged: (value) {
                          operatingHours[day]!["openTime"] = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Closing Time",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      QTimePicker(
                        label: "Close",
                        value: dayData["closeTime"].timeOfDay,
                        onChanged: (value) {
                          operatingHours[day]!["closeTime"] = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ] else ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Closed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: dangerColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int openDays = operatingHours.values.where((day) => day["isOpen"]).length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Operating Hours"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step Indicator
            _buildStepIndicator(),
            
            SizedBox(height: spLg),
            
            // Header
            Text(
              "Set your operating hours",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "When is your restaurant open for business?",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Quick Actions
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Open All Days",
                          size: bs.sm,
                          onPressed: _setAllDaysOpen,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _setAllDaysClosed,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(spSm),
                            side: BorderSide(color: dangerColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                          ),
                          child: Text(
                            "Close All Days",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Open $openDays days per week",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Weekly Schedule
            Text(
              "Weekly Schedule",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Days list
            ...weekdays.map((day) => _buildDaySchedule(day)),
            
            SizedBox(height: spLg),
            
            // Complete Setup Button
            Container(
              width: double.infinity,
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : QButton(
                      label: "Complete Setup",
                      size: bs.md,
                      onPressed: _handleComplete,
                    ),
            ),
            
            SizedBox(height: spMd),
            
            // Back Button
            Center(
              child: GestureDetector(
                onTap: () {
                  back();
                },
                child: Text(
                  "Go Back",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Completion Notice
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: successColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "You're almost done! After completing this step, you'll have access to your restaurant dashboard.",
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
        ),
      ),
    );
  }
}
