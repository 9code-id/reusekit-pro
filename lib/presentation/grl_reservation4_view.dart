import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReservation4View extends StatefulWidget {
  @override
  State<GrlReservation4View> createState() => _GrlReservation4ViewState();
}

class _GrlReservation4ViewState extends State<GrlReservation4View> {
  int currentStep = 2;
  String selectedService = "Premium Consultation";
  String selectedDate = "2024-03-15";
  String selectedTime = "14:30";
  String fullName = "John Doe";
  String email = "john@example.com";
  String phone = "+1234567890";
  String notes = "";
  bool agreeToTerms = false;
  
  List<Map<String, dynamic>> services = [
    {
      "id": "1",
      "name": "Basic Consultation",
      "price": 50.0,
      "duration": "30 mins",
      "description": "Standard consultation session"
    },
    {
      "id": "2", 
      "name": "Premium Consultation",
      "price": 100.0,
      "duration": "60 mins",
      "description": "Extended consultation with detailed analysis"
    },
    {
      "id": "3",
      "name": "Group Session",
      "price": 75.0,
      "duration": "45 mins", 
      "description": "Consultation for multiple participants"
    }
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"time": "09:00", "available": true},
    {"time": "10:30", "available": true},
    {"time": "12:00", "available": false},
    {"time": "14:30", "available": true},
    {"time": "16:00", "available": true},
    {"time": "17:30", "available": false}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                _buildStepIndicator(0, "Service", currentStep >= 0),
                Expanded(child: Container(height: 2, color: currentStep >= 1 ? primaryColor : disabledColor)),
                _buildStepIndicator(1, "Date & Time", currentStep >= 1),
                Expanded(child: Container(height: 2, color: currentStep >= 2 ? primaryColor : disabledColor)),
                _buildStepIndicator(2, "Details", currentStep >= 2),
                Expanded(child: Container(height: 2, color: currentStep >= 3 ? primaryColor : disabledColor)),
                _buildStepIndicator(3, "Confirm", currentStep >= 3),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentStep == 0) _buildServiceSelection(),
                  if (currentStep == 1) _buildDateTimeSelection(),
                  if (currentStep == 2) _buildDetailsForm(),
                  if (currentStep == 3) _buildConfirmation(),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowLg],
            ),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        if (currentStep > 0) {
                          currentStep--;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: currentStep == 3 ? "Book Now" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep < 3) {
                        currentStep++;
                        setState(() {});
                      } else {
                        _bookAppointment();
                      }
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

  Widget _buildStepIndicator(int step, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? primaryColor : disabledColor,
          ),
          child: Center(
            child: Text(
              "${step + 1}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? primaryColor : disabledBoldColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Service",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Choose the service that best fits your needs",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 14,
          ),
        ),
        SizedBox(height: spMd),
        ...services.map((service) {
          bool isSelected = selectedService == service["name"];
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: GestureDetector(
              onTap: () {
                selectedService = service["name"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected ? [shadowSm] : [],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledColor,
                          width: 2,
                        ),
                        color: isSelected ? primaryColor : Colors.transparent,
                      ),
                      child: isSelected
                          ? Icon(Icons.check, color: Colors.white, size: 12)
                          : null,
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
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
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
                              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${service["duration"]}",
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
                    Text(
                      "\$${(service["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDateTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Date & Time",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Choose your preferred appointment date and time",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 14,
          ),
        ),
        SizedBox(height: spMd),
        
        QDatePicker(
          label: "Appointment Date",
          value: DateTime.parse(selectedDate),
          onChanged: (value) {
            selectedDate = value.toString().split(' ')[0];
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        Text(
          "Available Time Slots",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: timeSlots.map((slot) {
            bool isSelected = selectedTime == slot["time"];
            bool isAvailable = slot["available"];
            
            return GestureDetector(
              onTap: isAvailable ? () {
                selectedTime = slot["time"];
                setState(() {});
              } : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: !isAvailable 
                      ? disabledColor
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
                  "${slot["time"]}",
                  style: TextStyle(
                    color: !isAvailable 
                        ? disabledBoldColor
                        : isSelected 
                            ? Colors.white 
                            : primaryColor,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDetailsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Please provide your contact information",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 14,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Full Name",
          value: fullName,
          onChanged: (value) {
            fullName = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Email Address",
          value: email,
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Phone Number",
          value: phone,
          onChanged: (value) {
            phone = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Additional Notes (Optional)",
          value: notes,
          onChanged: (value) {
            notes = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        QSwitch(
          items: [
            {
              "label": "I agree to the terms and conditions",
              "value": true,
              "checked": agreeToTerms,
            }
          ],
          value: [
            if (agreeToTerms)
              {
                "label": "I agree to the terms and conditions",
                "value": true,
                "checked": true
              }
          ],
          onChanged: (values, ids) {
            setState(() {
              agreeToTerms = values.isNotEmpty;
            });
          },
        ),
      ],
    );
  }

  Widget _buildConfirmation() {
    Map<String, dynamic> selectedServiceData = services.firstWhere(
      (service) => service["name"] == selectedService,
    );
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Confirm Booking",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Please review your appointment details",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 14,
          ),
        ),
        SizedBox(height: spMd),
        
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
                "Appointment Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              _buildSummaryRow("Service", selectedService),
              _buildSummaryRow("Date", DateTime.parse(selectedDate).dMMMy),
              _buildSummaryRow("Time", selectedTime),
              _buildSummaryRow("Duration", "${selectedServiceData["duration"]}"),
              _buildSummaryRow("Price", "\$${(selectedServiceData["price"] as double).toStringAsFixed(0)}"),
              
              Divider(height: spMd * 2),
              
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              _buildSummaryRow("Name", fullName),
              _buildSummaryRow("Email", email),
              _buildSummaryRow("Phone", phone),
              
              if (notes.isNotEmpty) ...[
                SizedBox(height: spSm),
                Text(
                  "Notes",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  notes,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "You will receive a confirmation email shortly after booking.",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _bookAppointment() {
    if (!agreeToTerms) {
      se("Please agree to the terms and conditions");
      return;
    }
    
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Appointment booked successfully!");
      // Navigate to success page or back
    });
  }
}
