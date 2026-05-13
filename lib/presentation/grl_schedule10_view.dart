import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSchedule10View extends StatefulWidget {
  @override
  State<GrlSchedule10View> createState() => _GrlSchedule10ViewState();
}

class _GrlSchedule10ViewState extends State<GrlSchedule10View> {
  String selectedTimeSlot = "9:00 AM";
  String selectedDuration = "1 hour";
  String resourceId = "ROOM001";
  String bookingTitle = "";
  String bookingDescription = "";
  String selectedDate = DateTime.now().toString();
  String selectedPurpose = "Meeting";
  String attendeesList = "";
  bool needsEquipment = false;
  bool needsCatering = false;
  String specialRequests = "";

  final formKey = GlobalKey<FormState>();

  Map<String, dynamic> resourceDetails = {
    "id": "ROOM001",
    "name": "Conference Room A",
    "type": "Meeting Room",
    "capacity": 12,
    "location": "Floor 3, Building A",
    "amenities": ["Projector", "Whiteboard", "Video Conference", "Coffee Machine"],
    "hourlyRate": 50.0,
    "image": "https://placehold.co/400x250?text=Conference+Room+A",
    "availability": [
      {"time": "8:00 AM", "available": true},
      {"time": "9:00 AM", "available": true},
      {"time": "10:00 AM", "available": false},
      {"time": "11:00 AM", "available": false},
      {"time": "12:00 PM", "available": true},
      {"time": "1:00 PM", "available": true},
      {"time": "2:00 PM", "available": true},
      {"time": "3:00 PM", "available": false},
      {"time": "4:00 PM", "available": true},
      {"time": "5:00 PM", "available": true},
    ]
  };

  List<Map<String, dynamic>> timeSlots = [
    {"label": "8:00 AM", "value": "8:00 AM"},
    {"label": "9:00 AM", "value": "9:00 AM"},
    {"label": "10:00 AM", "value": "10:00 AM"},
    {"label": "11:00 AM", "value": "11:00 AM"},
    {"label": "12:00 PM", "value": "12:00 PM"},
    {"label": "1:00 PM", "value": "1:00 PM"},
    {"label": "2:00 PM", "value": "2:00 PM"},
    {"label": "3:00 PM", "value": "3:00 PM"},
    {"label": "4:00 PM", "value": "4:00 PM"},
    {"label": "5:00 PM", "value": "5:00 PM"},
  ];

  List<Map<String, dynamic>> durationOptions = [
    {"label": "30 minutes", "value": "30 minutes"},
    {"label": "1 hour", "value": "1 hour"},
    {"label": "1.5 hours", "value": "1.5 hours"},
    {"label": "2 hours", "value": "2 hours"},
    {"label": "3 hours", "value": "3 hours"},
    {"label": "4 hours", "value": "4 hours"},
  ];

  List<Map<String, dynamic>> purposeOptions = [
    {"label": "Meeting", "value": "Meeting"},
    {"label": "Presentation", "value": "Presentation"},
    {"label": "Training", "value": "Training"},
    {"label": "Workshop", "value": "Workshop"},
    {"label": "Interview", "value": "Interview"},
    {"label": "Conference Call", "value": "Conference Call"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Resource"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () => _viewAvailability(),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildResourceOverview(),
              _buildBookingDetails(),
              _buildDateTimeSelection(),
              _buildAttendeeInfo(),
              _buildAdditionalServices(),
              _buildCostBreakdown(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResourceOverview() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusLg),
              ),
              image: DecorationImage(
                image: NetworkImage("${resourceDetails["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(100),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radiusLg),
                ),
              ),
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${resourceDetails["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "\$${((resourceDetails["hourlyRate"] as double).toDouble()).currency}/hr",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Up to ${resourceDetails["capacity"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "${resourceDetails["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${resourceDetails["id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${resourceDetails["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                QHorizontalScroll(
                  children: (resourceDetails["amenities"] as List).map((amenity) => Container(
                    margin: EdgeInsets.only(right: spXs),
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$amenity",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Booking Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Booking Title",
            value: bookingTitle,
            hint: "Enter a title for your booking",
            validator: Validator.required,
            onChanged: (value) {
              bookingTitle = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: bookingDescription,
            hint: "Describe the purpose of your booking",
            onChanged: (value) {
              bookingDescription = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Purpose",
            items: purposeOptions,
            value: selectedPurpose,
            onChanged: (value, label) {
              selectedPurpose = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Date & Time",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDatePicker(
            label: "Booking Date",
            value: DateTime.parse(selectedDate),
            validator: Validator.required,
            onChanged: (value) {
              selectedDate = value.toString();
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Start Time",
                  items: timeSlots,
                  value: selectedTimeSlot,
                  onChanged: (value, label) {
                    selectedTimeSlot = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "End time: ${_calculateEndTime()}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildAvailabilityGrid(),
        ],
      ),
    );
  }

  Widget _buildAvailabilityGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Today's Availability",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: (resourceDetails["availability"] as List).map((slot) => 
            GestureDetector(
              onTap: slot["available"] as bool 
                ? () {
                    selectedTimeSlot = slot["time"] as String;
                    setState(() {});
                  }
                : null,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: selectedTimeSlot == slot["time"]
                    ? primaryColor
                    : slot["available"] as bool
                      ? successColor.withAlpha(30)
                      : dangerColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: selectedTimeSlot == slot["time"]
                    ? Border.all(color: primaryColor, width: 2)
                    : null,
                ),
                child: Text(
                  "${slot["time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: selectedTimeSlot == slot["time"]
                      ? Colors.white
                      : slot["available"] as bool
                        ? successColor
                        : dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ).toList(),
        ),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: successColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: spXs),
            Text(
              "Available",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(width: spSm),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: dangerColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: spXs),
            Text(
              "Booked",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAttendeeInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Attendees",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Attendee List",
            value: attendeesList,
            hint: "Enter email addresses separated by commas",
            onChanged: (value) {
              attendeesList = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Icon(
                Icons.people,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                _getAttendeeCount(),
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (_getAttendeeCountNumber() > (resourceDetails["capacity"] as int))
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Exceeds capacity",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalServices() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Additional Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Equipment Rental",
                      "value": true,
                      "checked": needsEquipment,
                    }
                  ],
                  value: [
                    if (needsEquipment) {"label": "Equipment Rental", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    needsEquipment = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Catering Service",
                      "value": true,
                      "checked": needsCatering,
                    }
                  ],
                  value: [
                    if (needsCatering) {"label": "Catering Service", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    needsCatering = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Special Requests",
            value: specialRequests,
            hint: "Any special requirements or requests",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown() {
    double baseRate = resourceDetails["hourlyRate"] as double;
    double duration = _getDurationInHours();
    double subtotal = baseRate * duration;
    double equipmentCost = needsEquipment ? 25.0 : 0.0;
    double cateringCost = needsCatering ? 15.0 * _getAttendeeCountNumber() : 0.0;
    double total = subtotal + equipmentCost + cateringCost;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Cost Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Text(
                "Room rental (${duration}h)",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${subtotal.currency}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (needsEquipment)
            Row(
              children: [
                Text(
                  "Equipment rental",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${equipmentCost.currency}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          if (needsCatering)
            Row(
              children: [
                Text(
                  "Catering (${_getAttendeeCountNumber()} people)",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${cateringCost.currency}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          Container(
            height: 1,
            color: disabledColor,
          ),
          Row(
            children: [
              Text(
                "Total Cost",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${total.currency}",
                style: TextStyle(
                  fontSize: fsH6,
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

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Confirm Booking",
            size: bs.md,
            onPressed: () => _confirmBooking(),
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save as Draft",
            size: bs.md,
            onPressed: () => _saveDraft(),
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Cancel",
            size: bs.md,
            onPressed: () => _cancelBooking(),
          ),
        ),
      ],
    );
  }

  String _calculateEndTime() {
    try {
      DateTime startTime = DateTime.parse("2024-01-01 ${_convertTo24Hour(selectedTimeSlot)}:00");
      double durationHours = _getDurationInHours();
      DateTime endTime = startTime.add(Duration(minutes: (durationHours * 60).round()));
      
      return _convertTo12Hour("${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}");
    } catch (e) {
      return "Invalid time";
    }
  }

  double _getDurationInHours() {
    switch (selectedDuration) {
      case "30 minutes":
        return 0.5;
      case "1 hour":
        return 1.0;
      case "1.5 hours":
        return 1.5;
      case "2 hours":
        return 2.0;
      case "3 hours":
        return 3.0;
      case "4 hours":
        return 4.0;
      default:
        return 1.0;
    }
  }

  String _convertTo24Hour(String time12h) {
    bool isPM = time12h.contains("PM");
    String timeNumber = time12h.replaceAll(RegExp(r'[AP]M'), '').trim();
    List<String> parts = timeNumber.split(':');
    int hour = int.parse(parts[0]);
    
    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;
    
    return "${hour.toString().padLeft(2, '0')}:00";
  }

  String _convertTo12Hour(String time24h) {
    List<String> parts = time24h.split(':');
    int hour = int.parse(parts[0]);
    String minute = parts[1];
    
    if (hour == 0) return "12:$minute AM";
    if (hour < 12) return "$hour:$minute AM";
    if (hour == 12) return "12:$minute PM";
    return "${hour - 12}:$minute PM";
  }

  String _getAttendeeCount() {
    if (attendeesList.trim().isEmpty) {
      return "No attendees added";
    }
    
    List<String> emails = attendeesList.split(',').where((email) => email.trim().isNotEmpty).toList();
    return "${emails.length} ${emails.length == 1 ? 'attendee' : 'attendees'}";
  }

  int _getAttendeeCountNumber() {
    if (attendeesList.trim().isEmpty) return 0;
    return attendeesList.split(',').where((email) => email.trim().isNotEmpty).length;
  }

  void _viewAvailability() {
    // Show availability calendar
    //navigateTo('')
  }

  void _confirmBooking() async {
    if (formKey.currentState!.validate()) {
      if (_getAttendeeCountNumber() > (resourceDetails["capacity"] as int)) {
        se("Number of attendees exceeds room capacity");
        return;
      }

      bool isConfirmed = await confirm("Are you sure you want to confirm this booking?");
      if (isConfirmed) {
        showLoading();
        
        // Simulate API call
        await Future.delayed(Duration(seconds: 2));
        
        hideLoading();
        ss("Booking confirmed successfully!");
        
        // Navigate back to schedule
        back();
      }
    }
  }

  void _saveDraft() async {
    showLoading();
    
    // Simulate saving draft
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    si("Booking saved as draft");
    
    // Navigate back to schedule
    back();
  }

  void _cancelBooking() async {
    if (bookingTitle.isNotEmpty || bookingDescription.isNotEmpty) {
      bool isConfirmed = await confirm("Are you sure you want to discard this booking?");
      if (isConfirmed) {
        back();
      }
    } else {
      back();
    }
  }
}
