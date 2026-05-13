import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBookingCalendarView extends StatefulWidget {
  const BrsBookingCalendarView({super.key});

  @override
  State<BrsBookingCalendarView> createState() => _BrsBookingCalendarViewState();
}

class _BrsBookingCalendarViewState extends State<BrsBookingCalendarView> {
  DateTime selectedDate = DateTime.now();
  String selectedTimeSlot = "";
  String selectedBarber = "";
  List<String> selectedServices = [];
  
  final Map<String, dynamic> selectedBarberData = {
    "id": "1",
    "name": "Michael Rodriguez",
    "image": "https://picsum.photos/200/200?random=1&keyword=barber",
    "rating": 4.8,
    "specialty": "Classic Cuts & Beard Styling",
  };

  final List<Map<String, dynamic>> availableBarbers = [
    {
      "id": "1",
      "name": "Michael Rodriguez",
      "image": "https://picsum.photos/60/60?random=1&keyword=barber",
      "specialty": "Classic Cuts",
    },
    {
      "id": "2",
      "name": "James Thompson",
      "image": "https://picsum.photos/60/60?random=2&keyword=hairdresser",
      "specialty": "Modern Styles",
    },
    {
      "id": "3",
      "name": "David Chen",
      "image": "https://picsum.photos/60/60?random=3&keyword=stylist",
      "specialty": "Traditional Shaves",
    },
  ];

  final List<Map<String, dynamic>> services = [
    {
      "id": "1",
      "name": "Classic Haircut",
      "price": 35.0,
      "duration": 45,
      "description": "Traditional haircut with styling",
    },
    {
      "id": "2",
      "name": "Beard Trim",
      "price": 20.0,
      "duration": 30,
      "description": "Precise beard shaping",
    },
    {
      "id": "3",
      "name": "Hot Towel Shave",
      "price": 45.0,
      "duration": 60,
      "description": "Luxurious traditional shave",
    },
    {
      "id": "4",
      "name": "Hair Wash & Style",
      "price": 25.0,
      "duration": 30,
      "description": "Deep cleanse with styling",
    },
  ];

  final List<String> timeSlots = [
    "9:00 AM", "9:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM",
    "12:00 PM", "12:30 PM", "1:00 PM", "1:30 PM", "2:00 PM", "2:30 PM",
    "3:00 PM", "3:30 PM", "4:00 PM", "4:30 PM", "5:00 PM", "5:30 PM",
    "6:00 PM", "6:30 PM"
  ];

  final List<String> busySlots = ["10:30 AM", "2:00 PM", "4:30 PM"];

  double get totalPrice {
    return selectedServices.fold(0.0, (sum, serviceId) {
      final service = services.firstWhere((s) => s["id"] == serviceId);
      return sum + (service["price"] as double);
    });
  }

  int get totalDuration {
    return selectedServices.fold(0, (sum, serviceId) {
      final service = services.firstWhere((s) => s["id"] == serviceId);
      return sum + (service["duration"] as int);
    });
  }

  bool isSlotAvailable(String slot) {
    return !busySlots.contains(slot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment"),
        actions: [
          QButton(
            icon: Icons.calendar_today,
            size: bs.sm,
            onPressed: () {
              si("Opening calendar view...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Progress Indicator
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      _buildProgressStep(1, "Services", selectedServices.isNotEmpty),
                      Expanded(child: Container(height: 2, color: disabledColor)),
                      _buildProgressStep(2, "Barber", selectedBarber.isNotEmpty),
                      Expanded(child: Container(height: 2, color: disabledColor)),
                      _buildProgressStep(3, "Date & Time", selectedTimeSlot.isNotEmpty),
                    ],
                  ),
                ],
              ),
            ),

            // Service Selection
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
                    "Select Services",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...services.map((service) {
                    final isSelected = selectedServices.contains(service["id"]);
                    return GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          selectedServices.remove(service["id"]);
                        } else {
                          selectedServices.add(service["id"]);
                        }
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primaryColor.withAlpha(20) 
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected ? Icons.check_circle : Icons.circle,
                              color: isSelected ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${service["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? primaryColor : disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(service["price"] as double).toStringAsFixed(0)}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${service["description"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "${service["duration"]} min",
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
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Barber Selection
            if (selectedServices.isNotEmpty) ...[
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
                      "Choose Your Barber",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QHorizontalScroll(
                      children: availableBarbers.map((barber) {
                        final isSelected = selectedBarber == barber["id"];
                        return GestureDetector(
                          onTap: () {
                            selectedBarber = barber["id"];
                            setState(() {});
                          },
                          child: Container(
                            width: 120,
                            margin: EdgeInsets.only(right: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? primaryColor.withAlpha(20) 
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected 
                                    ? primaryColor 
                                    : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${barber["image"]}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${barber["name"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${barber["specialty"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    if (selectedBarber.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Barber selected successfully!",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],

            // Date Selection
            if (selectedBarber.isNotEmpty) ...[
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
                        selectedTimeSlot = ""; // Reset time slot when date changes
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Time Selection
            if (selectedBarber.isNotEmpty) ...[
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
                      "Date: ${selectedDate.dMMMy}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: timeSlots.map((slot) {
                        final isAvailable = isSlotAvailable(slot);
                        final isSelected = selectedTimeSlot == slot;
                        
                        return GestureDetector(
                          onTap: isAvailable ? () {
                            selectedTimeSlot = slot;
                            setState(() {});
                          } : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spMd,
                              vertical: spSm,
                            ),
                            decoration: BoxDecoration(
                              color: !isAvailable 
                                  ? disabledColor.withAlpha(20)
                                  : isSelected 
                                      ? primaryColor 
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: !isAvailable 
                                    ? disabledColor
                                    : isSelected 
                                        ? primaryColor 
                                        : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              slot,
                              style: TextStyle(
                                color: !isAvailable 
                                    ? disabledBoldColor
                                    : isSelected 
                                        ? Colors.white 
                                        : primaryColor,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            // Booking Summary
            if (selectedServices.isNotEmpty && selectedBarber.isNotEmpty && selectedTimeSlot.isNotEmpty) ...[
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
                      "Booking Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date & Time",
                                style: TextStyle(color: disabledBoldColor),
                              ),
                              Text(
                                "${selectedDate.dMMMy} at $selectedTimeSlot",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Barber",
                                style: TextStyle(color: disabledBoldColor),
                              ),
                              Text(
                                selectedBarberData["name"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Services",
                                style: TextStyle(color: disabledBoldColor),
                              ),
                              Text(
                                "${selectedServices.length} service${selectedServices.length != 1 ? 's' : ''}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Duration",
                                style: TextStyle(color: disabledBoldColor),
                              ),
                              Text(
                                "$totalDuration minutes",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 1,
                            color: disabledOutlineBorderColor,
                            margin: EdgeInsets.symmetric(vertical: spXs),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Price",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${totalPrice.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Continue to Payment",
                        size: bs.md,
                        onPressed: () {
                          ss("Proceeding to payment...");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Additional Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
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
                      SizedBox(width: spSm),
                      Text(
                        "Booking Information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Please arrive 10 minutes before your appointment\n• Cancellations must be made at least 24 hours in advance\n• A deposit of 20% may be required for certain services",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                      height: 1.4,
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

  Widget _buildProgressStep(int step, String label, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isCompleted ? successColor : disabledColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                : Text(
                    "$step",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            color: isCompleted ? successColor : disabledBoldColor,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
