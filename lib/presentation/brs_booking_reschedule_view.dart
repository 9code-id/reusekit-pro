import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBookingRescheduleView extends StatefulWidget {
  const BrsBookingRescheduleView({super.key});

  @override
  State<BrsBookingRescheduleView> createState() => _BrsBookingRescheduleViewState();
}

class _BrsBookingRescheduleViewState extends State<BrsBookingRescheduleView> {
  String selectedDate = DateTime.now().add(Duration(days: 1)).toString();
  String selectedTime = "10:00";
  String rescheduleReason = "";
  bool loading = false;

  List<Map<String, dynamic>> timeSlots = [
    {"time": "09:00", "available": true},
    {"time": "09:30", "available": false},
    {"time": "10:00", "available": true},
    {"time": "10:30", "available": true},
    {"time": "11:00", "available": false},
    {"time": "11:30", "available": true},
    {"time": "14:00", "available": true},
    {"time": "14:30", "available": true},
    {"time": "15:00", "available": true},
    {"time": "15:30", "available": false},
    {"time": "16:00", "available": true},
    {"time": "16:30", "available": true},
  ];

  List<Map<String, dynamic>> rescheduleReasons = [
    {"label": "Emergency", "value": "emergency"},
    {"label": "Work Conflict", "value": "work_conflict"},
    {"label": "Personal Reason", "value": "personal"},
    {"label": "Travel", "value": "travel"},
    {"label": "Health Issue", "value": "health"},
    {"label": "Other", "value": "other"},
  ];

  Map<String, dynamic> currentBooking = {
    "id": "BK001",
    "barber_name": "John Smith",
    "barber_image": "https://picsum.photos/120/120?random=101&keyword=barber",
    "service": "Premium Haircut + Beard Trim",
    "date": "2024-12-15",
    "time": "14:00",
    "duration": "45 minutes",
    "price": 35.0,
    "shop_name": "Elite Barber Shop",
    "address": "123 Main Street, Downtown",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reschedule Appointment"),
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                _buildCurrentBookingCard(),
                _buildDateSelection(),
                _buildTimeSlotSelection(),
                _buildRescheduleReasonSection(),
                _buildPolicyInfo(),
                _buildRescheduleButton(),
              ],
            ),
          ),
    );
  }

  Widget _buildCurrentBookingCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: warningColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Current Appointment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${currentBooking["barber_image"]}",
                  width: 60,
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
                    Text(
                      "${currentBooking["barber_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${currentBooking["service"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${DateTime.parse(currentBooking["date"]).dMMMy} at ${currentBooking["time"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "\$${(currentBooking["price"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection() {
    return Container(
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
            "Select New Date",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDatePicker(
            label: 'New Appointment Date',
            value: DateTime.parse(selectedDate),
            onChanged: (value) {
              selectedDate = value.toString();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotSelection() {
    return Container(
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
            "Select New Time",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Available time slots for ${DateTime.parse(selectedDate).dMMMy}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: timeSlots.map((slot) {
              bool isSelected = selectedTime == slot["time"];
              bool isAvailable = slot["available"] as bool;
              
              return GestureDetector(
                onTap: isAvailable ? () {
                  selectedTime = slot["time"];
                  setState(() {});
                } : null,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: !isAvailable 
                      ? disabledColor 
                      : isSelected 
                        ? primaryColor 
                        : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: !isAvailable 
                        ? disabledOutlineBorderColor
                        : isSelected 
                          ? primaryColor 
                          : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Text(
                    "${slot["time"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: !isAvailable 
                        ? disabledBoldColor
                        : isSelected 
                          ? Colors.white 
                          : primaryColor,
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

  Widget _buildRescheduleReasonSection() {
    return Container(
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
            "Reason for Rescheduling",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Reason",
            items: rescheduleReasons,
            value: rescheduleReason,
            onChanged: (value, label) {
              rescheduleReason = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Additional Notes (Optional)",
            value: "",
            hint: "Provide any additional details...",
            onChanged: (value) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: infoColor.withAlpha(50),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Reschedule Policy",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Text(
            "• Free rescheduling up to 2 hours before appointment\n• You can reschedule up to 3 times per booking\n• Same-day rescheduling may incur additional charges\n• Cancellation after rescheduling follows standard policy",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRescheduleButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Confirm Reschedule",
            size: bs.md,
            onPressed: _rescheduleAppointment,
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Cancel",
            size: bs.md,
            color: disabledBoldColor,
            onPressed: () => back(),
          ),
        ),
      ],
    );
  }

  void _rescheduleAppointment() async {
    if (rescheduleReason.isEmpty) {
      se("Please select a reason for rescheduling");
      return;
    }

    bool isConfirmed = await confirm("Are you sure you want to reschedule this appointment?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Appointment rescheduled successfully!");
    await Future.delayed(Duration(milliseconds: 500));
    back();
  }
}
