import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaAppointmentBookingView extends StatefulWidget {
  const CmaAppointmentBookingView({super.key});

  @override
  State<CmaAppointmentBookingView> createState() => _CmaAppointmentBookingViewState();
}

class _CmaAppointmentBookingViewState extends State<CmaAppointmentBookingView> {
  int currentStep = 0;
  String selectedService = "";
  String selectedLocation = "";
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);
  String vehicleInfo = "";
  String customerNotes = "";
  String customerName = "";
  String customerPhone = "";
  String customerEmail = "";

  List<Map<String, dynamic>> services = [
    {
      "id": "oil_change",
      "name": "Oil Change",
      "duration": "30 min",
      "price": 49.99,
      "description": "Standard oil change with filter replacement",
      "icon": Icons.oil_barrel,
    },
    {
      "id": "brake_service",
      "name": "Brake Service",
      "duration": "2 hours",
      "price": 189.99,
      "description": "Complete brake inspection and pad replacement",
      "icon": Icons.settings,
    },
    {
      "id": "tire_rotation",
      "name": "Tire Rotation",
      "duration": "45 min",
      "price": 39.99,
      "description": "Tire rotation and pressure check",
      "icon": Icons.tire_repair,
    },
    {
      "id": "diagnostic",
      "name": "Diagnostic Check",
      "duration": "1 hour",
      "price": 99.99,
      "description": "Complete vehicle diagnostic scan",
      "icon": Icons.computer,
    },
    {
      "id": "tune_up",
      "name": "Tune-Up",
      "duration": "3 hours",
      "price": 299.99,
      "description": "Complete engine tune-up service",
      "icon": Icons.build,
    },
    {
      "id": "ac_service",
      "name": "A/C Service",
      "duration": "1.5 hours",
      "price": 129.99,
      "description": "Air conditioning system service and recharge",
      "icon": Icons.ac_unit,
    },
  ];

  List<Map<String, dynamic>> locations = [
    {
      "id": "downtown",
      "name": "Downtown Service Center",
      "address": "123 Main St, Downtown",
      "phone": "(555) 123-4567",
      "hours": "Mon-Fri: 7AM-6PM, Sat: 8AM-4PM",
      "rating": 4.8,
      "image": "https://picsum.photos/300/200?random=1&keyword=garage",
    },
    {
      "id": "north",
      "name": "North Side Auto Care",
      "address": "456 North Ave, Northside",
      "phone": "(555) 234-5678",
      "hours": "Mon-Fri: 8AM-7PM, Sat: 9AM-5PM",
      "rating": 4.6,
      "image": "https://picsum.photos/300/200?random=2&keyword=workshop",
    },
    {
      "id": "south",
      "name": "South End Garage",
      "address": "789 South Blvd, Southend",
      "phone": "(555) 345-6789",
      "hours": "Mon-Sat: 7AM-6PM",
      "rating": 4.7,
      "image": "https://picsum.photos/300/200?random=3&keyword=mechanic",
    },
  ];

  List<TimeOfDay> availableSlots = [
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 30),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 13, minute: 30),
    TimeOfDay(hour: 15, minute: 0),
    TimeOfDay(hour: 16, minute: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment"),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: List.generate(4, (index) {
                bool isActive = index <= currentStep;
                bool isCompleted = index < currentStep;
                
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isActive ? primaryColor : disabledColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? Icon(Icons.check, color: Colors.white, size: 16)
                              : Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      if (index < 3)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: index < currentStep ? primaryColor : disabledColor,
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),

          // Step Content
          Expanded(
            child: _buildStepContent(),
          ),

          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Back",
                      size: bs.md,
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: currentStep == 3 ? "Book Appointment" : "Next",
                    size: bs.md,
                    onPressed: _canProceed() ? () {
                      if (currentStep == 3) {
                        _bookAppointment();
                      } else {
                        currentStep++;
                        setState(() {});
                      }
                    } : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildServiceSelection();
      case 1:
        return _buildLocationSelection();
      case 2:
        return _buildDateTimeSelection();
      case 3:
        return _buildCustomerInfo();
      default:
        return Container();
    }
  }

  Widget _buildServiceSelection() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Service",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Choose the service you need for your vehicle",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          ...services.map((service) {
            bool isSelected = selectedService == service["id"];
            
            return GestureDetector(
              onTap: () {
                selectedService = service["id"] as String;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(30) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        service["icon"] as IconData,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${service["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${service["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${service["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${(service["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
          }),
        ],
      ),
    );
  }

  Widget _buildLocationSelection() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Location",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Choose your preferred service location",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          ...locations.map((location) {
            bool isSelected = selectedLocation == location["id"];
            
            return GestureDetector(
              onTap: () {
                selectedLocation = location["id"] as String;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(30) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${location["image"]}",
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${location["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${location["rating"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
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
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${location["address"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${location["phone"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${location["hours"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelection() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Date & Time",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Choose your preferred appointment date and time",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
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
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Date",
                  style: TextStyle(
                    fontSize: 16,
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

          // Time Selection
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available Time Slots",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: availableSlots.map((time) {
                    bool isSelected = selectedTime == time;
                    String timeString = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                    
                    return GestureDetector(
                      onTap: () {
                        selectedTime = time;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Text(
                          timeString,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Vehicle Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vehicle Information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Vehicle Details",
                  value: vehicleInfo,
                  hint: "e.g., 2020 Honda Civic, License: ABC123",
                  onChanged: (value) {
                    vehicleInfo = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Additional Notes",
                  value: customerNotes,
                  hint: "Any specific concerns or requests",
                  onChanged: (value) {
                    customerNotes = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Please provide your contact details",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Full Name",
                  value: customerName,
                  hint: "Enter your full name",
                  onChanged: (value) {
                    customerName = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Phone Number",
                  value: customerPhone,
                  hint: "(555) 123-4567",
                  onChanged: (value) {
                    customerPhone = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Email Address",
                  value: customerEmail,
                  hint: "your.email@example.com",
                  onChanged: (value) {
                    customerEmail = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Appointment Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Appointment Summary",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (selectedService.isNotEmpty) ...[
                  Row(
                    children: [
                      Text("Service: ", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("${services.firstWhere((s) => s["id"] == selectedService)["name"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Price: ", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("\$${(services.firstWhere((s) => s["id"] == selectedService)["price"] as double).toStringAsFixed(2)}"),
                    ],
                  ),
                ],
                if (selectedLocation.isNotEmpty)
                  Row(
                    children: [
                      Text("Location: ", style: TextStyle(fontWeight: FontWeight.w600)),
                      Expanded(
                        child: Text("${locations.firstWhere((l) => l["id"] == selectedLocation)["name"]}"),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Text("Date: ", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                  ],
                ),
                Row(
                  children: [
                    Text("Time: ", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}"),
                  ],
                ),
                if (vehicleInfo.isNotEmpty)
                  Row(
                    children: [
                      Text("Vehicle: ", style: TextStyle(fontWeight: FontWeight.w600)),
                      Expanded(child: Text(vehicleInfo)),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedService.isNotEmpty;
      case 1:
        return selectedLocation.isNotEmpty;
      case 2:
        return vehicleInfo.isNotEmpty;
      case 3:
        return customerName.isNotEmpty && customerPhone.isNotEmpty && customerEmail.isNotEmpty;
      default:
        return false;
    }
  }

  void _bookAppointment() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Appointment booked successfully!");
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: successColor),
            SizedBox(width: spSm),
            Text("Booking Confirmed"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your appointment has been successfully booked!"),
            SizedBox(height: spSm),
            Text(
              "Confirmation Number: #APT${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text("You will receive a confirmation email shortly."),
          ],
        ),
        actions: [
          QButton(
            label: "Done",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              // Reset form
              currentStep = 0;
              selectedService = "";
              selectedLocation = "";
              vehicleInfo = "";
              customerNotes = "";
              customerName = "";
              customerPhone = "";
              customerEmail = "";
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
