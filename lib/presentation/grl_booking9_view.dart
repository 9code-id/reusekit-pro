import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBooking9View extends StatefulWidget {
  @override
  State<GrlBooking9View> createState() => _GrlBooking9ViewState();
}

class _GrlBooking9ViewState extends State<GrlBooking9View> {
  String selectedClass = "";
  String selectedDate = DateTime.now().toString();
  String selectedTime = "";
  String studentName = "";
  String studentEmail = "";
  String studentPhone = "";
  String experienceLevel = "";
  String goals = "";
  String healthConditions = "";
  List<String> selectedEquipment = [];

  List<Map<String, dynamic>> fitnessClasses = [
    {
      "name": "High-Intensity Interval Training",
      "instructor": "Sarah Johnson",
      "duration": "45 min",
      "difficulty": "Advanced",
      "price": 25.0,
      "maxParticipants": 12,
      "image": "https://picsum.photos/120/80?random=1&keyword=fitness",
      "description": "High-energy workout combining cardio and strength training",
      "benefits": ["Burns calories", "Builds strength", "Improves endurance"]
    },
    {
      "name": "Yoga Flow",
      "instructor": "Maria Garcia",
      "duration": "60 min",
      "difficulty": "Beginner",
      "price": 20.0,
      "maxParticipants": 15,
      "image": "https://picsum.photos/120/80?random=2&keyword=yoga",
      "description": "Gentle yoga sequences for flexibility and relaxation",
      "benefits": ["Increases flexibility", "Reduces stress", "Improves balance"]
    },
    {
      "name": "Strength Training",
      "instructor": "Mike Chen",
      "duration": "50 min",
      "difficulty": "Intermediate",
      "price": 30.0,
      "maxParticipants": 8,
      "image": "https://picsum.photos/120/80?random=3&keyword=strength",
      "description": "Weight lifting and resistance training for muscle building",
      "benefits": ["Builds muscle", "Increases metabolism", "Improves bone density"]
    },
    {
      "name": "Pilates Core",
      "instructor": "Emma Wilson",
      "duration": "45 min",
      "difficulty": "Intermediate",
      "price": 22.0,
      "maxParticipants": 10,
      "image": "https://picsum.photos/120/80?random=4&keyword=pilates",
      "description": "Core-focused exercises for stability and posture",
      "benefits": ["Strengthens core", "Improves posture", "Enhances flexibility"]
    },
  ];

  List<String> timeSlots = [
    "06:00", "07:00", "08:00", "09:00", "10:00", "11:00",
    "14:00", "15:00", "16:00", "17:00", "18:00", "19:00"
  ];

  List<Map<String, dynamic>> experienceLevels = [
    {"label": "Beginner", "value": "beginner"},
    {"label": "Intermediate", "value": "intermediate"},
    {"label": "Advanced", "value": "advanced"},
    {"label": "Expert", "value": "expert"},
  ];

  List<Map<String, dynamic>> equipmentOptions = [
    {"name": "Yoga Mat", "price": 5.0, "description": "Non-slip yoga mat rental"},
    {"name": "Water Bottle", "price": 3.0, "description": "Reusable water bottle"},
    {"name": "Towel", "price": 2.0, "description": "Workout towel rental"},
    {"name": "Resistance Bands", "price": 8.0, "description": "Set of resistance bands"},
    {"name": "Locker", "price": 4.0, "description": "Secure locker rental"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Fitness Class"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildClassSelection(),
            _buildScheduleSelection(),
            _buildParticipantDetails(),
            _buildEquipmentRental(),
            _buildBookingSummary(),
            _buildBookButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildClassSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.fitness_center,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Select Fitness Class",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...fitnessClasses.map((fitnessClass) {
            final isSelected = selectedClass == fitnessClass["name"];
            return GestureDetector(
              onTap: () {
                selectedClass = fitnessClass["name"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${fitnessClass["image"]}",
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${fitnessClass["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                ],
                              ),
                              Text(
                                "with ${fitnessClass["instructor"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor(fitnessClass["difficulty"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${fitnessClass["difficulty"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getDifficultyColor(fitnessClass["difficulty"]),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${fitnessClass["duration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${(fitnessClass["price"] as double).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${fitnessClass["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      children: (fitnessClass["benefits"] as List<String>)
                          .map((benefit) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  benefit,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: successColor,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return successColor;
      case 'intermediate':
        return warningColor;
      case 'advanced':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildScheduleSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Select Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDatePicker(
            label: "Class Date",
            value: DateTime.parse(selectedDate),
            onChanged: (value) {
              selectedDate = value.toString();
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Text(
            "Available Time Slots",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: timeSlots.map((time) {
              final isSelected = selectedTime == time;
              return GestureDetector(
                onTap: () {
                  selectedTime = time;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : disabledBoldColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Participant Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Participant Name",
            value: studentName,
            hint: "Full name of participant",
            onChanged: (value) {
              studentName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email Address",
            value: studentEmail,
            hint: "Email for booking confirmation",
            onChanged: (value) {
              studentEmail = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: studentPhone,
            hint: "Contact number",
            onChanged: (value) {
              studentPhone = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Experience Level",
            items: experienceLevels,
            value: experienceLevel,
            onChanged: (value, label) {
              experienceLevel = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Fitness Goals",
            value: goals,
            hint: "What are your fitness goals?",
            onChanged: (value) {
              goals = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Health Conditions",
            value: healthConditions,
            hint: "Any injuries or health conditions we should know about?",
            onChanged: (value) {
              healthConditions = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentRental() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.sports_gymnastics,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Equipment Rental",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Optional equipment rental for your class",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          ...equipmentOptions.map((equipment) {
            final isSelected = selectedEquipment.contains(equipment["name"]);
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  selectedEquipment.remove(equipment["name"]);
                } else {
                  selectedEquipment.add(equipment["name"]);
                }
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spXs),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.grey[400]!,
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${equipment["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${equipment["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "+\$${(equipment["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBookingSummary() {
    if (selectedClass.isEmpty) return Container();
    
    final selectedClassData = fitnessClasses.firstWhere(
      (fitnessClass) => fitnessClass["name"] == selectedClass,
    );
    
    double totalPrice = selectedClassData["price"] as double;
    
    for (String equipmentName in selectedEquipment) {
      final equipment = equipmentOptions.firstWhere(
        (e) => e["name"] == equipmentName,
      );
      totalPrice += equipment["price"] as double;
    }
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Booking Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildSummaryRow("Class", selectedClass),
          _buildSummaryRow("Instructor", selectedClassData["instructor"]),
          _buildSummaryRow("Date", DateTime.parse(selectedDate).dMMMy),
          _buildSummaryRow("Time", selectedTime),
          _buildSummaryRow("Duration", "${selectedClassData["duration"]}"),
          if (selectedEquipment.isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              "Equipment Rental:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            ...selectedEquipment.map((equipmentName) {
              final equipment = equipmentOptions.firstWhere(
                (e) => e["name"] == equipmentName,
              );
              return Padding(
                padding: EdgeInsets.only(left: spSm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "• $equipmentName",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "+\$${(equipment["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
          Divider(color: primaryColor.withAlpha(50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Book Fitness Class",
        size: bs.md,
        onPressed: () {
          ss("Fitness class booked successfully!");
        },
      ),
    );
  }
}
