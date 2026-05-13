import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaRescheduleAppointmentView extends StatefulWidget {
  const MhaRescheduleAppointmentView({super.key});

  @override
  State<MhaRescheduleAppointmentView> createState() => _MhaRescheduleAppointmentViewState();
}

class _MhaRescheduleAppointmentViewState extends State<MhaRescheduleAppointmentView> {
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  String selectedTime = "";
  String rescheduleReason = "";
  
  final Map<String, dynamic> currentAppointment = {
    "id": "APT001",
    "doctor": {
      "name": "Dr. Sarah Johnson",
      "specialty": "Cardiologist",
      "image": "https://picsum.photos/300/300?random=1&keyword=doctor",
      "hospital": "City General Hospital",
    },
    "currentDate": "2024-01-15",
    "currentTime": "10:30",
    "fee": 150.0,
  };
  
  final List<String> rescheduleReasons = [
    "Schedule conflict",
    "Medical emergency",
    "Personal reasons",
    "Work commitment",
    "Travel plans",
    "Other",
  ];
  
  final List<Map<String, dynamic>> availableSlots = [
    {"date": "2024-01-16", "time": "09:00", "available": true},
    {"date": "2024-01-16", "time": "10:30", "available": false},
    {"date": "2024-01-16", "time": "14:00", "available": true},
    {"date": "2024-01-16", "time": "15:30", "available": true},
    {"date": "2024-01-17", "time": "09:30", "available": true},
    {"date": "2024-01-17", "time": "11:00", "available": true},
    {"date": "2024-01-17", "time": "13:30", "available": false},
    {"date": "2024-01-17", "time": "16:00", "available": true},
    {"date": "2024-01-18", "time": "08:30", "available": true},
    {"date": "2024-01-18", "time": "10:00", "available": true},
    {"date": "2024-01-18", "time": "14:30", "available": true},
  ];

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
            _buildCurrentAppointmentCard(),
            
            SizedBox(height: spMd),
            
            // Reschedule Reason
            _buildRescheduleReasonSection(),
            
            SizedBox(height: spMd),
            
            // New Date Selection
            _buildDateSelectionSection(),
            
            SizedBox(height: spMd),
            
            // Available Time Slots
            _buildTimeSlotSection(),
            
            SizedBox(height: spMd),
            
            // Reschedule Policy
            _buildReschedulePolicyCard(),
            
            SizedBox(height: spXl),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }
  
  Widget _buildCurrentAppointmentCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: Border(
          left: BorderSide(
            width: 4,
            color: warningColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Current Appointment",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${currentAppointment["doctor"]["image"]}",
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
                      "${currentAppointment["doctor"]["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${currentAppointment["doctor"]["specialty"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${currentAppointment["doctor"]["hospital"]}",
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
          
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        DateTime.parse(currentAppointment["currentDate"]).dMMMy,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${currentAppointment["currentTime"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fee",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(currentAppointment["fee"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRescheduleReasonSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reason for Rescheduling",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QDropdownField(
            label: "Select Reason",
            items: rescheduleReasons.map((reason) => {
              "label": reason,
              "value": reason,
            }).toList(),
            value: rescheduleReason,
            onChanged: (value, label) {
              rescheduleReason = value;
              setState(() {});
            },
          ),
          
          if (rescheduleReason == "Other") ...[
            SizedBox(height: spMd),
            QMemoField(
              label: "Please specify",
              value: "",
              hint: "Please provide the reason for rescheduling",
              onChanged: (value) {
                // Handle custom reason
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildDateSelectionSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select New Date",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QDatePicker(
            label: "New Appointment Date",
            value: selectedDate,
            onChanged: (value) {
              selectedDate = value;
              selectedTime = ""; // Reset time selection when date changes
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Please select a date at least 24 hours in advance",
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
    );
  }
  
  Widget _buildTimeSlotSection() {
    // Filter slots for selected date
    final slotsForDate = availableSlots.where((slot) => 
      DateTime.parse(slot["date"]).day == selectedDate.day &&
      DateTime.parse(slot["date"]).month == selectedDate.month &&
      DateTime.parse(slot["date"]).year == selectedDate.year
    ).toList();
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Time Slots",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          if (slotsForDate.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(Icons.event_busy, color: disabledBoldColor, size: 48),
                  SizedBox(height: spMd),
                  Text(
                    "No available slots",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Please select a different date",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Text(
              "Select a time slot for ${selectedDate.dMMMy}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: slotsForDate.map((slot) {
                final isAvailable = slot["available"] as bool;
                final time = slot["time"] as String;
                final isSelected = selectedTime == time;
                
                return GestureDetector(
                  onTap: isAvailable ? () {
                    selectedTime = time;
                    setState(() {});
                  } : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? primaryColor 
                          : isAvailable 
                              ? primaryColor.withAlpha(20) 
                              : disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected 
                            ? primaryColor 
                            : isAvailable 
                                ? primaryColor 
                                : disabledColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected 
                            ? Colors.white 
                            : isAvailable 
                                ? primaryColor 
                                : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Legend
            Row(
              children: [
                _buildLegendItem(primaryColor, "Available"),
                SizedBox(width: spMd),
                _buildLegendItem(disabledColor, "Booked"),
                SizedBox(width: spMd),
                _buildLegendItem(primaryColor, "Selected", selected: true),
              ],
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildLegendItem(Color color, String label, {bool selected = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: selected ? color : color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: color, width: 1),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildReschedulePolicyCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.policy, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Reschedule Policy",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          _buildPolicyItem("Free rescheduling up to 24 hours before appointment"),
          _buildPolicyItem("Rescheduling within 24 hours may incur a \$25 fee"),
          _buildPolicyItem("No-show appointments are subject to full charge"),
          _buildPolicyItem("Maximum 2 reschedules allowed per appointment"),
          _buildPolicyItem("Appointment confirmation will be sent via SMS and email"),
        ],
      ),
    );
  }
  
  Widget _buildPolicyItem(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: warningColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBottomActions() {
    final canReschedule = rescheduleReason.isNotEmpty && selectedTime.isNotEmpty;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Summary
          if (canReschedule) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Appointment Details",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${selectedDate.dMMMy} at $selectedTime",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Reason: $rescheduleReason",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
          ],
          
          // Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.md,
                  color: disabledColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              
              SizedBox(width: spSm),
              
              Expanded(
                flex: 2,
                child: QButton(
                  label: "Confirm Reschedule",
                  size: bs.md,
                  onPressed: canReschedule ? () async {
                    // Show loading
                    showLoading();
                    
                    // Simulate API call
                    await Future.delayed(Duration(seconds: 2));
                    
                    hideLoading();
                    
                    // Show success message
                    ss("Appointment rescheduled successfully!");
                    
                    // Navigate back or to confirmation
                    Navigator.pop(context);
                    // navigateTo(AppointmentConfirmationView)
                  } : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
