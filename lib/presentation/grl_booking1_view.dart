import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBooking1View extends StatefulWidget {
  @override
  State<GrlBooking1View> createState() => _GrlBooking1ViewState();
}

class _GrlBooking1ViewState extends State<GrlBooking1View> {
  String selectedService = "";
  String selectedDate = DateTime.now().toIso8601String().substring(0, 10);
  String selectedTime = "09:00";
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  String specialRequests = "";
  bool sendConfirmation = true;
  bool sendReminder = true;
  
  List<Map<String, dynamic>> services = [
    {
      "label": "Haircut & Styling",
      "value": "haircut",
      "price": 35.0,
      "duration": 45,
      "description": "Professional haircut with styling and consultation"
    },
    {
      "label": "Hair Coloring",
      "value": "coloring", 
      "price": 85.0,
      "duration": 120,
      "description": "Full hair coloring service with premium products"
    },
    {
      "label": "Manicure & Pedicure",
      "value": "manicure",
      "price": 55.0,
      "duration": 90,
      "description": "Complete nail care with polish and treatment"
    },
    {
      "label": "Facial Treatment",
      "value": "facial",
      "price": 75.0,
      "duration": 60,
      "description": "Deep cleansing facial with moisturizing treatment"
    },
    {
      "label": "Massage Therapy",
      "value": "massage",
      "price": 95.0,
      "duration": 75,
      "description": "Relaxing full body massage with aromatherapy"
    },
  ];

  List<String> availableTimes = [
    "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
    "12:00", "12:30", "14:00", "14:30", "15:00", "15:30",
    "16:00", "16:30", "17:00", "17:30", "18:00", "18:30",
  ];

  Map<String, dynamic>? get selectedServiceData {
    return services.firstWhere(
      (service) => service["value"] == selectedService,
      orElse: () => {},
    );
  }

  double get totalPrice {
    if (selectedServiceData == null || selectedServiceData!.isEmpty) return 0.0;
    return (selectedServiceData!["price"] as double);
  }

  Future<void> _bookAppointment() async {
    if (selectedService.isEmpty || customerName.isEmpty || customerEmail.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    ss("Appointment booked successfully!");
    
    // Reset form
    selectedService = "";
    customerName = "";
    customerEmail = "";
    customerPhone = "";
    specialRequests = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white, size: 28),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Book Your Appointment",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Choose from our premium services",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (totalPrice > 0) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.white),
                          SizedBox(width: spSm),
                          Text(
                            "Total: \$${totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          if (selectedServiceData != null)
                            Text(
                              "${selectedServiceData!["duration"]} min",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Service Selection
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
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
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Choose a service",
                    items: services.map((service) => {
                      "label": "${service["label"]} - \$${(service["price"] as double).toStringAsFixed(0)}",
                      "value": service["value"],
                    }).toList(),
                    value: selectedService,
                    onChanged: (value, label) {
                      selectedService = value;
                      setState(() {});
                    },
                  ),
                  if (selectedServiceData != null && selectedServiceData!.isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${selectedServiceData!["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 16, color: primaryColor),
                              SizedBox(width: spXs),
                              Text(
                                "${selectedServiceData!["duration"]} minutes",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${(selectedServiceData!["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Date & Time Selection
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
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
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Appointment Date",
                          value: DateTime.parse(selectedDate),
                          onChanged: (value) {
                            selectedDate = value.toIso8601String().substring(0, 10);
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Time Slot",
                          items: availableTimes.map((time) => {
                            "label": time,
                            "value": time,
                          }).toList(),
                          value: selectedTime,
                          onChanged: (value, label) {
                            selectedTime = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Customer Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Full Name",
                    value: customerName,
                    validator: Validator.required,
                    onChanged: (value) {
                      customerName = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Email Address",
                    value: customerEmail,
                    validator: Validator.email,
                    onChanged: (value) {
                      customerEmail = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Phone Number",
                    value: customerPhone,
                    onChanged: (value) {
                      customerPhone = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QMemoField(
                    label: "Special Requests (Optional)",
                    value: specialRequests,
                    hint: "Any specific requirements or preferences...",
                    onChanged: (value) {
                      specialRequests = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Notification Preferences
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notification Preferences",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Send booking confirmation email",
                        "value": true,
                        "checked": sendConfirmation,
                      }
                    ],
                    value: [if (sendConfirmation) {"label": "Send booking confirmation email", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      sendConfirmation = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spXs),
                  QSwitch(
                    items: [
                      {
                        "label": "Send appointment reminder (24h before)",
                        "value": true,
                        "checked": sendReminder,
                      }
                    ],
                    value: [if (sendReminder) {"label": "Send appointment reminder (24h before)", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      sendReminder = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Summary Card
            if (selectedService.isNotEmpty && customerName.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor),
                        SizedBox(width: spSm),
                        Text(
                          "Booking Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Service: ${selectedServiceData!["label"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Date: ${DateTime.parse(selectedDate).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Time: $selectedTime",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Customer: $customerName",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${totalPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "${selectedServiceData!["duration"]} min",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            
            SizedBox(height: spMd),
            
            // Book Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Confirm Booking",
                size: bs.md,
                onPressed: _bookAppointment,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Terms Text
            Text(
              "By booking this appointment, you agree to our terms and conditions. Cancellations must be made at least 24 hours in advance.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
