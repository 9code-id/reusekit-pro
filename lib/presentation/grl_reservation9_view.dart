import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReservation9View extends StatefulWidget {
  @override
  State<GrlReservation9View> createState() => _GrlReservation9ViewState();
}

class _GrlReservation9ViewState extends State<GrlReservation9View> {
  String selectedServiceType = "Consultation";
  String selectedDate = DateTime.now().add(Duration(days: 7)).toString().split(' ')[0];
  String selectedTime = "";
  String patientName = "";
  String patientAge = "";
  String contactNumber = "";
  String email = "";
  String emergencyContact = "";
  String medicalHistory = "";
  String currentMedications = "";
  String allergies = "";
  String reasonForVisit = "";
  bool hasInsurance = false;
  String insuranceProvider = "";
  bool agreesToTerms = false;

  List<Map<String, dynamic>> serviceTypes = [
    {
      "name": "Consultation",
      "duration": "30 mins",
      "price": 120.0,
      "description": "General consultation with healthcare provider"
    },
    {
      "name": "Check-up",
      "duration": "45 mins", 
      "price": 150.0,
      "description": "Comprehensive health check-up and screening"
    },
    {
      "name": "Follow-up",
      "duration": "20 mins",
      "price": 80.0,
      "description": "Follow-up appointment for previous consultation"
    },
    {
      "name": "Specialist",
      "duration": "60 mins",
      "price": 200.0,
      "description": "Specialist consultation for specific conditions"
    }
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"time": "08:00", "available": true},
    {"time": "08:30", "available": true},
    {"time": "09:00", "available": false},
    {"time": "09:30", "available": true},
    {"time": "10:00", "available": true},
    {"time": "10:30", "available": false},
    {"time": "11:00", "available": true},
    {"time": "11:30", "available": true},
    {"time": "14:00", "available": true},
    {"time": "14:30", "available": false},
    {"time": "15:00", "available": true},
    {"time": "15:30", "available": true},
    {"time": "16:00", "available": true},
    {"time": "16:30", "available": true}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Appointment"),
        actions: [
          IconButton(
            icon: Icon(Icons.medical_services),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServiceSelection(),
            SizedBox(height: spMd),
            _buildDateTimeSelection(),
            SizedBox(height: spMd),
            _buildPatientInformation(),
            SizedBox(height: spMd),
            _buildMedicalInformation(),
            SizedBox(height: spMd),
            _buildInsuranceInformation(),
            SizedBox(height: spMd),
            _buildTermsAndConditions(),
            SizedBox(height: spMd),
            _buildAppointmentSummary(),
            SizedBox(height: spMd),
            _buildBookingButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Service Type",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        ...serviceTypes.map((service) {
          bool isSelected = selectedServiceType == service["name"];
          
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: GestureDetector(
              onTap: () {
                selectedServiceType = service["name"];
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
                              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
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
          "Select Appointment Date & Time",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        QDatePicker(
          label: "Appointment Date",
          value: DateTime.parse(selectedDate),
          onChanged: (value) {
            selectedDate = value.toString().split(' ')[0];
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
        SizedBox(height: spSm),
        
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 80,
          children: timeSlots.map((slot) {
            bool isSelected = selectedTime == slot["time"];
            bool isAvailable = slot["available"];
            
            return GestureDetector(
              onTap: isAvailable ? () {
                selectedTime = slot["time"];
                setState(() {});
              } : null,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spXs),
                decoration: BoxDecoration(
                  color: !isAvailable 
                      ? disabledColor.withAlpha(50)
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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildPatientInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Patient Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Full Name",
          value: patientName,
          onChanged: (value) {
            patientName = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Age",
                value: patientAge,
                onChanged: (value) {
                  patientAge = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Contact Number",
                value: contactNumber,
                onChanged: (value) {
                  contactNumber = value;
                  setState(() {});
                },
              ),
            ),
          ],
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
          label: "Emergency Contact",
          value: emergencyContact,
          hint: "Name and phone number",
          onChanged: (value) {
            emergencyContact = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildMedicalInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Medical Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Medical History",
          value: medicalHistory,
          hint: "Previous surgeries, chronic conditions, etc.",
          onChanged: (value) {
            medicalHistory = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Current Medications",
          value: currentMedications,
          hint: "List all medications you are currently taking",
          onChanged: (value) {
            currentMedications = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Allergies",
          value: allergies,
          hint: "Food, medication, or environmental allergies",
          onChanged: (value) {
            allergies = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Reason for Visit",
          value: reasonForVisit,
          hint: "Brief description of symptoms or concerns",
          onChanged: (value) {
            reasonForVisit = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildInsuranceInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Insurance Information",
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
              "label": "I have health insurance",
              "value": true,
              "checked": hasInsurance,
            }
          ],
          value: [
            if (hasInsurance)
              {
                "label": "I have health insurance",
                "value": true,
                "checked": true
              }
          ],
          onChanged: (values, ids) {
            setState(() {
              hasInsurance = values.isNotEmpty;
            });
          },
        ),
        
        if (hasInsurance) ...[
          SizedBox(height: spSm),
          QTextField(
            label: "Insurance Provider",
            value: insuranceProvider,
            hint: "Name of your insurance company",
            onChanged: (value) {
              insuranceProvider = value;
              setState(() {});
            },
          ),
        ],
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Terms & Conditions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
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
                "Important Information:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "• Please arrive 15 minutes before your appointment\n"
                "• Bring a valid ID and insurance card\n"
                "• Cancellation must be made 24 hours in advance\n"
                "• Late arrival may result in rescheduling",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spSm),
        
        QSwitch(
          items: [
            {
              "label": "I agree to the terms and conditions and privacy policy",
              "value": true,
              "checked": agreesToTerms,
            }
          ],
          value: [
            if (agreesToTerms)
              {
                "label": "I agree to the terms and conditions and privacy policy",
                "value": true,
                "checked": true
              }
          ],
          onChanged: (values, ids) {
            setState(() {
              agreesToTerms = values.isNotEmpty;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAppointmentSummary() {
    if (selectedServiceType.isEmpty || selectedTime.isEmpty) {
      return Container();
    }

    Map<String, dynamic> selectedService = serviceTypes.firstWhere(
      (service) => service["name"] == selectedServiceType,
    );

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
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
          
          _buildSummaryRow("Service", selectedServiceType),
          _buildSummaryRow("Date", DateTime.parse(selectedDate).dMMMy),
          _buildSummaryRow("Time", selectedTime),
          _buildSummaryRow("Duration", "${selectedService["duration"]}"),
          _buildSummaryRow("Patient", patientName.isNotEmpty ? patientName : "Not provided"),
          
          Divider(height: spMd * 2),
          
          Row(
            children: [
              Text(
                "Total Fee",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${(selectedService["price"] as double).toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          if (hasInsurance) ...[
            SizedBox(height: spXs),
            Text(
              "Insurance coverage may apply",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
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

  Widget _buildBookingButton() {
    bool canBook = selectedServiceType.isNotEmpty &&
                   selectedTime.isNotEmpty &&
                   patientName.isNotEmpty &&
                   contactNumber.isNotEmpty &&
                   email.isNotEmpty &&
                   agreesToTerms;

    return Container(
      width: double.infinity,
      child: QButton(
        label: "Book Appointment",
        size: bs.md,
        onPressed: canBook ? () {
          _bookAppointment();
        } : null,
      ),
    );
  }

  void _bookAppointment() {
    if (!agreesToTerms) {
      se("Please agree to the terms and conditions");
      return;
    }
    
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      
      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: successColor),
              SizedBox(width: spSm),
              Text("Appointment Booked"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your medical appointment has been successfully booked."),
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Appointment Details:", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("Date: ${DateTime.parse(selectedDate).dMMMy}"),
                    Text("Time: $selectedTime"),
                    Text("Service: $selectedServiceType"),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "A confirmation email will be sent to $email with all the details and preparation instructions.",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                back();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    });
  }
}
