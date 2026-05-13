import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaPillScheduleView extends StatefulWidget {
  const MhaPillScheduleView({super.key});

  @override
  State<MhaPillScheduleView> createState() => _MhaPillScheduleViewState();
}

class _MhaPillScheduleViewState extends State<MhaPillScheduleView> {
  int selectedDay = 0;
  String selectedMedication = "";
  String selectedTimeSlot = "morning";
  bool showAddForm = false;

  final List<String> weekDays = [
    "Monday",
    "Tuesday", 
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  final List<Map<String, dynamic>> pillSchedule = [
    {
      "medication": "Aspirin",
      "dosage": "100mg",
      "color": Colors.blue,
      "shape": "round",
      "times": {
        "morning": "08:00",
        "afternoon": null,
        "evening": null,
        "night": null,
      },
      "days": [true, true, true, true, true, true, true], // Mon-Sun
      "taken": {
        "monday": {"morning": true, "afternoon": false, "evening": false, "night": false},
        "tuesday": {"morning": true, "afternoon": false, "evening": false, "night": false},
        "wednesday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "thursday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "friday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "saturday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "sunday": {"morning": false, "afternoon": false, "evening": false, "night": false},
      },
      "notes": "Take with food",
    },
    {
      "medication": "Vitamin D",
      "dosage": "1000 IU",
      "color": Colors.orange,
      "shape": "capsule",
      "times": {
        "morning": "09:00",
        "afternoon": null,
        "evening": null,
        "night": null,
      },
      "days": [true, true, true, true, true, true, true],
      "taken": {
        "monday": {"morning": true, "afternoon": false, "evening": false, "night": false},
        "tuesday": {"morning": true, "afternoon": false, "evening": false, "night": false},
        "wednesday": {"morning": true, "afternoon": false, "evening": false, "night": false},
        "thursday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "friday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "saturday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "sunday": {"morning": false, "afternoon": false, "evening": false, "night": false},
      },
      "notes": "Best with breakfast",
    },
    {
      "medication": "Lisinopril",
      "dosage": "10mg",
      "color": Colors.red,
      "shape": "oval",
      "times": {
        "morning": "08:00",
        "afternoon": null,
        "evening": "20:00",
        "night": null,
      },
      "days": [true, true, true, true, true, true, true],
      "taken": {
        "monday": {"morning": true, "afternoon": false, "evening": true, "night": false},
        "tuesday": {"morning": true, "afternoon": false, "evening": true, "night": false},
        "wednesday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "thursday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "friday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "saturday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "sunday": {"morning": false, "afternoon": false, "evening": false, "night": false},
      },
      "notes": "Monitor blood pressure",
    },
    {
      "medication": "Metformin",
      "dosage": "500mg",
      "color": Colors.green,
      "shape": "round",
      "times": {
        "morning": "07:30",
        "afternoon": null,
        "evening": "19:30",
        "night": null,
      },
      "days": [true, true, true, true, true, true, true],
      "taken": {
        "monday": {"morning": true, "afternoon": false, "evening": true, "night": false},
        "tuesday": {"morning": true, "afternoon": false, "evening": false, "night": false},
        "wednesday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "thursday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "friday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "saturday": {"morning": false, "afternoon": false, "evening": false, "night": false},
        "sunday": {"morning": false, "afternoon": false, "evening": false, "night": false},
      },
      "notes": "Take with meals",
    },
  ];

  final List<Map<String, dynamic>> timeSlots = [
    {
      "label": "Morning",
      "value": "morning",
      "icon": Icons.wb_sunny,
      "color": Colors.orange,
      "defaultTime": "08:00"
    },
    {
      "label": "Afternoon", 
      "value": "afternoon",
      "icon": Icons.wb_cloudy,
      "color": Colors.blue,
      "defaultTime": "14:00"
    },
    {
      "label": "Evening",
      "value": "evening", 
      "icon": Icons.wb_twilight,
      "color": Colors.purple,
      "defaultTime": "19:00"
    },
    {
      "label": "Night",
      "value": "night",
      "icon": Icons.bedtime,
      "color": Colors.indigo,
      "defaultTime": "22:00"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pill Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                showAddForm = true;
              });
            },
          ),
        ],
      ),
      body: showAddForm ? _buildAddPillForm() : _buildScheduleView(),
    );
  }

  Widget _buildScheduleView() {
    return Column(
      children: [
        _buildWeekSelector(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                _buildDayOverview(),
                SizedBox(height: spLg),
                _buildTimeSlotSchedule(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekSelector() {
    return Container(
      height: 60,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: spMd),
        itemCount: weekDays.length,
        itemBuilder: (context, index) {
          final isSelected = selectedDay == index;
          final isToday = index == 2; // Wednesday (current day)
          
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDay = index;
              });
            },
            child: Container(
              width: 80,
              margin: EdgeInsets.symmetric(horizontal: spXs, vertical: spSm),
              decoration: BoxDecoration(
                color: isSelected 
                    ? primaryColor 
                    : isToday 
                        ? primaryColor.withAlpha(20)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isSelected 
                      ? primaryColor
                      : isToday
                          ? primaryColor
                          : Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weekDays[index].substring(0, 3),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected 
                          ? Colors.white
                          : isToday
                              ? primaryColor
                              : disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${15 + index}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected 
                          ? Colors.white
                          : isToday
                              ? primaryColor
                              : primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDayOverview() {
    final currentDay = weekDays[selectedDay].toLowerCase();
    final todayMedications = pillSchedule.where((med) {
      return (med["days"] as List)[selectedDay];
    }).toList();

    int totalDoses = 0;
    int takenDoses = 0;

    for (var med in todayMedications) {
      final taken = med["taken"][currentDay] as Map<String, bool>;
      final times = med["times"] as Map<String, dynamic>;
      
      for (var timeSlot in times.keys) {
        if (times[timeSlot] != null) {
          totalDoses++;
          if (taken[timeSlot] == true) {
            takenDoses++;
          }
        }
      }
    }

    final adherencePercentage = totalDoses > 0 ? ((takenDoses / totalDoses) * 100).round() : 0;

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
            "${weekDays[selectedDay]}, January ${15 + selectedDay}",
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "$takenDoses",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "Taken",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.orange.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.schedule, color: Colors.orange, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "${totalDoses - takenDoses}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        "Remaining",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.trending_up, color: primaryColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "$adherencePercentage%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Adherence",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Daily Schedule",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Add Medication",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                setState(() {
                  showAddForm = true;
                });
              },
            ),
          ],
        ),
        SizedBox(height: spSm),
        ...timeSlots.map((timeSlot) => _buildTimeSlotCard(timeSlot)),
      ],
    );
  }

  Widget _buildTimeSlotCard(Map<String, dynamic> timeSlot) {
    final currentDay = weekDays[selectedDay].toLowerCase();
    final timeSlotKey = timeSlot["value"];
    
    final medicationsForTimeSlot = pillSchedule.where((med) {
      final times = med["times"] as Map<String, dynamic>;
      return times[timeSlotKey] != null && (med["days"] as List)[selectedDay];
    }).toList();

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (timeSlot["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  timeSlot["icon"] as IconData,
                  color: timeSlot["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${timeSlot["label"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (medicationsForTimeSlot.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${medicationsForTimeSlot.length} medication${medicationsForTimeSlot.length > 1 ? 's' : ''}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
            ],
          ),
          if (medicationsForTimeSlot.isEmpty) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: Colors.grey[200]!,
                  style: BorderStyle.solid,
                ),
              ),
              child: Text(
                "No medications scheduled",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ] else ...[
            SizedBox(height: spSm),
            ...medicationsForTimeSlot.map((medication) => 
              _buildMedicationPill(medication, timeSlotKey, currentDay)),
          ],
        ],
      ),
    );
  }

  Widget _buildMedicationPill(Map<String, dynamic> medication, String timeSlot, String currentDay) {
    final times = medication["times"] as Map<String, dynamic>;
    final taken = medication["taken"][currentDay] as Map<String, bool>;
    final isTaken = taken[timeSlot] == true;
    final scheduledTime = times[timeSlot];

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isTaken ? Colors.green.withAlpha(20) : Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isTaken ? Colors.green : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: (medication["color"] as Color).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.medication,
              color: medication["color"] as Color,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${medication["medication"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    decoration: isTaken ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  "${medication["dosage"]} at $scheduledTime",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (isTaken) ...[
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 20,
            ),
          ] else ...[
            QButton(
              label: "Take",
              size: bs.sm,
              onPressed: () {
                _markAsTaken(medication, timeSlot, currentDay);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddPillForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Add Medication to Schedule",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.close,
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    showAddForm = false;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: spLg),
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
                QTextField(
                  label: "Medication Name",
                  value: selectedMedication,
                  hint: "Enter medication name",
                  onChanged: (value) {
                    selectedMedication = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Text(
                  "Select Time Slots",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...timeSlots.map((timeSlot) => _buildTimeSlotSelector(timeSlot)),
                SizedBox(height: spSm),
                Text(
                  "Days of Week",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                _buildDaySelector(),
                SizedBox(height: spLg),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add to Schedule",
                    onPressed: () {
                      setState(() {
                        showAddForm = false;
                      });
                      ss("Medication added to schedule successfully");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotSelector(Map<String, dynamic> timeSlot) {
    final isSelected = selectedTimeSlot == timeSlot["value"];
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTimeSlot = timeSlot["value"];
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              timeSlot["icon"] as IconData,
              color: isSelected ? primaryColor : disabledBoldColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "${timeSlot["label"]} (${timeSlot["defaultTime"]})",
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? primaryColor : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySelector() {
    return Wrap(
      spacing: spSm,
      runSpacing: spSm,
      children: weekDays.asMap().entries.map((entry) {
        final index = entry.key;
        final day = entry.value;
        final isSelected = true; // Default all days selected
        
        return GestureDetector(
          onTap: () {
            // Toggle day selection
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: isSelected ? primaryColor : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Text(
              day.substring(0, 3),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : disabledBoldColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _markAsTaken(Map<String, dynamic> medication, String timeSlot, String currentDay) {
    setState(() {
      final taken = medication["taken"][currentDay] as Map<String, bool>;
      taken[timeSlot] = true;
    });
    ss("Medication marked as taken");
  }
}
