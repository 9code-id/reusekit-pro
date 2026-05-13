import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaBookTutorView extends StatefulWidget {
  const ElaBookTutorView({super.key});

  @override
  State<ElaBookTutorView> createState() => _ElaBookTutorViewState();
}

class _ElaBookTutorViewState extends State<ElaBookTutorView> {
  final formKey = GlobalKey<FormState>();
  
  String selectedDate = "";
  String selectedTime = "";
  String selectedDuration = "60";
  String selectedSubject = "";
  String sessionNotes = "";
  bool isRecurring = false;
  String recurringFrequency = "";
  bool usePaymentMethod = true;

  // Sample tutor data
  Map<String, dynamic> tutor = {
    "id": 1,
    "name": "Dr. Sarah Johnson",
    "title": "Mathematics Professor",
    "profileImage": "https://picsum.photos/60/60?random=1&keyword=teacher",
    "rating": 4.9,
    "reviewCount": 156,
    "hourlyRate": 65,
    "specialties": ["Calculus", "Linear Algebra", "Statistics"],
    "responseTime": "Within 1 hour",
    "isVerified": true,
  };

  List<Map<String, dynamic>> durationOptions = [
    {"label": "30 minutes", "value": "30"},
    {"label": "60 minutes", "value": "60"},
    {"label": "90 minutes", "value": "90"},
    {"label": "120 minutes", "value": "120"},
  ];

  List<Map<String, dynamic>> subjectOptions = [
    {"label": "Select Subject", "value": ""},
    {"label": "Calculus", "value": "calculus"},
    {"label": "Linear Algebra", "value": "linear_algebra"},
    {"label": "Statistics", "value": "statistics"},
    {"label": "Differential Equations", "value": "differential_equations"},
    {"label": "General Mathematics", "value": "general_math"},
  ];

  List<Map<String, dynamic>> recurringOptions = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Bi-weekly", "value": "biweekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  // Available time slots
  Map<String, List<String>> availableSlots = {
    "2024-01-16": ["09:00", "10:00", "14:00", "15:00"],
    "2024-01-17": ["09:00", "11:00", "14:00", "16:00"],
    "2024-01-18": ["10:00", "13:00", "15:00", "16:00"],
    "2024-01-19": ["09:00", "10:00", "14:00", "15:00"],
    "2024-01-20": ["09:00", "11:00", "13:00"],
  };

  List<String> get availableTimesForSelectedDate {
    if (selectedDate.isEmpty) return [];
    return availableSlots[selectedDate] ?? [];
  }

  double get sessionCost {
    if (selectedDuration.isEmpty) return 0;
    double hours = int.parse(selectedDuration) / 60.0;
    return (tutor["hourlyRate"] as int) * hours;
  }

  double get platformFee {
    return sessionCost * 0.05; // 5% platform fee
  }

  double get totalCost {
    return sessionCost + platformFee;
  }

  void _bookSession() async {
    if (formKey.currentState!.validate()) {
      if (selectedDate.isEmpty) {
        se("Please select a date");
        return;
      }
      if (selectedTime.isEmpty) {
        se("Please select a time");
        return;
      }

      showLoading();
      
      // Simulate booking process
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      ss("Session booked successfully!");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Session"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Tutor Info Card
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("${tutor["profileImage"]}"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${tutor["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (tutor["isVerified"] as bool) ...[
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: primaryColor,
                                ),
                              ],
                            ],
                          ),
                          Text(
                            "${tutor["title"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, size: 14, color: warningColor),
                              SizedBox(width: 4),
                              Text(
                                "${tutor["rating"]} (${tutor["reviewCount"]} reviews)",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${tutor["hourlyRate"]}/hr",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${tutor["responseTime"]}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Session Details
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Session Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Subject Selection
                    QDropdownField(
                      label: "Subject",
                      items: subjectOptions,
                      value: selectedSubject,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedSubject = value;
                        setState(() {});
                      },
                    ),

                    // Duration Selection
                    QDropdownField(
                      label: "Session Duration",
                      items: durationOptions,
                      value: selectedDuration,
                      onChanged: (value, label) {
                        selectedDuration = value;
                        setState(() {});
                      },
                    ),

                    // Session Notes
                    QMemoField(
                      label: "Session Notes (Optional)",
                      value: sessionNotes,
                      hint: "Describe what you'd like to focus on during the session...",
                      onChanged: (value) {
                        sessionNotes = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Date Selection
              Container(
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
                      "Select Date",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    QHorizontalScroll(
                      children: availableSlots.keys.map((date) {
                        bool isSelected = selectedDate == date;
                        DateTime dateTime = DateTime.parse(date);
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = date;
                              selectedTime = ""; // Reset time when date changes
                            });
                          },
                          child: Container(
                            width: 80,
                            padding: EdgeInsets.all(spSm),
                            margin: EdgeInsets.only(right: spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"][dateTime.weekday % 7],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : disabledBoldColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${dateTime.day}",
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", 
                                   "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"][dateTime.month - 1],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : disabledBoldColor,
                                    fontSize: 10,
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

              // Time Selection
              if (selectedDate.isNotEmpty)
                Container(
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
                        "Select Time",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      if (availableTimesForSelectedDate.isEmpty)
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info, color: warningColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "No available slots for this date",
                                style: TextStyle(
                                  color: warningColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: availableTimesForSelectedDate.map((time) {
                            bool isSelected = selectedTime == time;
                            
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTime = time;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledColor,
                                  ),
                                ),
                                child: Text(
                                  "$time:00",
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),

              // Recurring Session Options
              Container(
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
                      "Recurring Sessions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Set up recurring sessions",
                          "value": true,
                          "checked": isRecurring,
                        }
                      ],
                      value: [if (isRecurring) {"label": "Set up recurring sessions", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        setState(() {
                          isRecurring = values.isNotEmpty;
                        });
                      },
                    ),
                    
                    if (isRecurring)
                      QCategoryPicker(
                        label: "Frequency",
                        items: recurringOptions,
                        value: recurringFrequency,
                        onChanged: (index, label, value, item) {
                          recurringFrequency = value;
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),

              // Cost Breakdown
              Container(
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
                      "Cost Breakdown",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Text(
                          "Session (${selectedDuration} min)",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${sessionCost.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Text(
                          "Platform fee (5%)",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${platformFee.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    
                    Divider(),
                    
                    Row(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${totalCost.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Payment Method
              Container(
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
                      "Payment Method",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.credit_card, color: primaryColor),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "•••• •••• •••• 1234",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Visa ending in 1234",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Change",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Booking Terms
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Booking Terms",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• Free cancellation up to 24 hours before session\n"
                      "• 50% refund for cancellations within 24 hours\n"
                      "• No refund for no-shows\n"
                      "• Sessions can be rescheduled once for free",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Book Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Book Session - \$${totalCost.toStringAsFixed(2)}",
                  size: bs.md,
                  onPressed: _bookSession,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
