import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsTimeSlotView extends StatefulWidget {
  const BrsTimeSlotView({super.key});

  @override
  State<BrsTimeSlotView> createState() => _BrsTimeSlotViewState();
}

class _BrsTimeSlotViewState extends State<BrsTimeSlotView> {
  DateTime selectedDate = DateTime.now();
  String selectedBarber = "John Smith";
  String selectedTimeSlot = "";

  List<Map<String, dynamic>> barbers = [
    {
      "id": "1",
      "name": "John Smith",
      "speciality": "Classic Cuts & Styling",
      "rating": 4.8,
      "avatar": "https://picsum.photos/80/80?random=1&keyword=barber",
      "experience": "8 years"
    },
    {
      "id": "2",
      "name": "Mike Johnson",
      "speciality": "Modern Cuts & Beard",
      "rating": 4.7,
      "avatar": "https://picsum.photos/80/80?random=2&keyword=barber",
      "experience": "6 years"
    },
    {
      "id": "3",
      "name": "David Wilson",
      "speciality": "Hair Treatment & Color",
      "rating": 4.9,
      "avatar": "https://picsum.photos/80/80?random=3&keyword=barber",
      "experience": "10 years"
    },
  ];

  Map<String, List<Map<String, dynamic>>> timeSlots = {
    "John Smith": [
      {"time": "09:00", "available": true},
      {"time": "10:00", "available": true},
      {"time": "11:00", "available": false},
      {"time": "14:00", "available": true},
      {"time": "15:00", "available": true},
      {"time": "16:00", "available": false},
    ],
    "Mike Johnson": [
      {"time": "09:30", "available": true},
      {"time": "10:30", "available": false},
      {"time": "11:30", "available": true},
      {"time": "14:30", "available": true},
      {"time": "15:30", "available": false},
      {"time": "16:30", "available": true},
    ],
    "David Wilson": [
      {"time": "10:00", "available": false},
      {"time": "11:00", "available": true},
      {"time": "12:00", "available": true},
      {"time": "15:00", "available": false},
      {"time": "16:00", "available": true},
      {"time": "17:00", "available": true},
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentSlots = timeSlots[selectedBarber] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Time Slot"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Date Selection
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Select Date",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDatePicker(
                    label: "Appointment Date",
                    value: selectedDate,
                    onChanged: (value) {
                      selectedDate = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Barber Selection
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Select Barber",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...barbers.map((barber) {
                    bool isSelected = selectedBarber == barber["name"];
                    
                    return GestureDetector(
                      onTap: () {
                        selectedBarber = "${barber["name"]}";
                        selectedTimeSlot = "";
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage("${barber["avatar"]}"),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${barber["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${barber["speciality"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${barber["rating"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${barber["experience"]} experience",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Time Slots
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Available Time Slots",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "For $selectedBarber on ${selectedDate.dMMMy}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  if (currentSlots.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          Text(
                            "No available slots",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Please select another barber or date",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: currentSlots.map((slot) {
                        bool isSelected = selectedTimeSlot == slot["time"];
                        bool isAvailable = slot["available"] as bool;
                        
                        return GestureDetector(
                          onTap: isAvailable ? () {
                            selectedTimeSlot = "${slot["time"]}";
                            setState(() {});
                          } : null,
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? primaryColor 
                                  : isAvailable 
                                      ? Colors.white 
                                      : disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected 
                                    ? primaryColor 
                                    : isAvailable 
                                        ? disabledOutlineBorderColor 
                                        : disabledColor,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: isSelected 
                                      ? Colors.white 
                                      : isAvailable 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                  size: 24,
                                ),
                                Text(
                                  "${slot["time"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected 
                                        ? Colors.white 
                                        : isAvailable 
                                            ? primaryColor 
                                            : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  isAvailable ? "Available" : "Booked",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected 
                                        ? Colors.white 
                                        : isAvailable 
                                            ? successColor 
                                            : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),

            // Continue Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue to Booking",
                size: bs.md,
                onPressed: selectedTimeSlot.isNotEmpty ? () {
                  ss("Selected: $selectedBarber at $selectedTimeSlot");
                } : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
