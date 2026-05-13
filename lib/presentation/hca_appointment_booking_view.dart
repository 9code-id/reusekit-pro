import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaAppointmentBookingView extends StatefulWidget {
  const HcaAppointmentBookingView({super.key});

  @override
  State<HcaAppointmentBookingView> createState() => _HcaAppointmentBookingViewState();
}

class _HcaAppointmentBookingViewState extends State<HcaAppointmentBookingView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  
  // Step 1: Appointment Type
  String selectedAppointmentType = "";
  String selectedSpecialty = "";
  String selectedUrgency = "";
  
  // Step 2: Doctor Selection
  String selectedDoctor = "";
  
  // Step 3: Date & Time
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);
  
  // Step 4: Patient Information
  String patientName = "Sarah Johnson";
  String patientPhone = "+1 (555) 123-4567";
  String patientEmail = "sarah.johnson@email.com";
  String reasonForVisit = "";
  String symptoms = "";
  String medications = "";
  String allergies = "Penicillin, Shellfish";
  String insurance = "Blue Cross Blue Shield";
  String insuranceNumber = "BCBS-12345678";
  bool isNewPatient = false;
  bool hasReferral = false;
  String referralDoctor = "";
  
  final List<Map<String, dynamic>> appointmentTypes = [
    {
      "label": "Consultation",
      "value": "consultation",
      "description": "Initial consultation or follow-up",
      "duration": "30 min",
      "icon": Icons.medical_services,
      "color": primaryColor,
    },
    {
      "label": "Check-up",
      "value": "checkup",
      "description": "Routine health check-up",
      "duration": "45 min",
      "icon": Icons.health_and_safety,
      "color": successColor,
    },
    {
      "label": "Procedure",
      "value": "procedure",
      "description": "Medical procedure or minor surgery",
      "duration": "60-120 min",
      "icon": Icons.healing,
      "color": warningColor,
    },
    {
      "label": "Lab Work",
      "value": "lab",
      "description": "Blood test, imaging, or diagnostic tests",
      "duration": "15-30 min",
      "icon": Icons.science,
      "color": infoColor,
    },
    {
      "label": "Emergency",
      "value": "emergency",
      "description": "Urgent medical attention needed",
      "duration": "Variable",
      "icon": Icons.emergency,
      "color": dangerColor,
    },
  ];

  final List<Map<String, dynamic>> specialties = [
    {"label": "General Medicine", "value": "general"},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Dermatology", "value": "dermatology"},
    {"label": "Orthopedics", "value": "orthopedics"},
    {"label": "Pediatrics", "value": "pediatrics"},
    {"label": "Psychiatry", "value": "psychiatry"},
    {"label": "Radiology", "value": "radiology"},
    {"label": "Surgery", "value": "surgery"},
  ];

  final List<Map<String, dynamic>> urgencyLevels = [
    {"label": "Routine", "value": "routine", "color": successColor},
    {"label": "Urgent", "value": "urgent", "color": warningColor},
    {"label": "Emergency", "value": "emergency", "color": dangerColor},
  ];

  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. Michael Chen",
      "specialty": "Cardiology",
      "rating": 4.8,
      "experience": "15+ years",
      "image": "https://picsum.photos/80/80?random=1&keyword=doctor",
      "availability": ["Monday", "Wednesday", "Friday"],
      "nextAvailable": "Dec 28, 2024",
    },
    {
      "name": "Dr. Lisa Park",
      "specialty": "Dermatology",
      "rating": 4.9,
      "experience": "12+ years",
      "image": "https://picsum.photos/80/80?random=2&keyword=doctor",
      "availability": ["Tuesday", "Thursday", "Saturday"],
      "nextAvailable": "Jan 5, 2025",
    },
    {
      "name": "Dr. James Wilson",
      "specialty": "General Medicine",
      "rating": 4.7,
      "experience": "20+ years",
      "image": "https://picsum.photos/80/80?random=3&keyword=doctor",
      "availability": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
      "nextAvailable": "Dec 26, 2024",
    },
    {
      "name": "Dr. Sarah Martinez",
      "specialty": "Pediatrics",
      "rating": 4.9,
      "experience": "10+ years",
      "image": "https://picsum.photos/80/80?random=4&keyword=doctor",
      "availability": ["Monday", "Wednesday", "Friday"],
      "nextAvailable": "Jan 8, 2025",
    },
  ];

  final List<String> timeSlots = [
    "9:00 AM", "9:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM",
    "2:00 PM", "2:30 PM", "3:00 PM", "3:30 PM", "4:00 PM", "4:30 PM"
  ];

  void nextStep() {
    if (currentStep < 3) {
      currentStep++;
      setState(() {});
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void bookAppointment() {
    if (formKey.currentState!.validate()) {
      showLoading();
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Appointment booked successfully!");
        back();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "Step ${currentStep + 1}/4",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Progress Indicator
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: List.generate(4, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(
                        right: index < 3 ? spXs : 0,
                      ),
                      decoration: BoxDecoration(
                        color: index <= currentStep ? primaryColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Step Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (currentStep == 0) _buildStep1(),
                    if (currentStep == 1) _buildStep2(),
                    if (currentStep == 2) _buildStep3(),
                    if (currentStep == 3) _buildStep4(),
                  ],
                ),
              ),
            ),

            // Navigation Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        size: bs.md,
                        onPressed: previousStep,
                      ),
                    ),
                  
                  if (currentStep > 0)
                    SizedBox(width: spSm),
                  
                  Expanded(
                    child: QButton(
                      label: currentStep == 3 ? "Book Appointment" : "Next",
                      size: bs.md,
                      onPressed: currentStep == 3 ? bookAppointment : nextStep,
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

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Appointment Type",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Select the type of appointment you need",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),

        SizedBox(height: spLg),

        // Appointment Types
        Column(
          children: appointmentTypes.map((type) {
            bool isSelected = selectedAppointmentType == type["value"];
            return GestureDetector(
              onTap: () {
                selectedAppointmentType = type["value"];
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (type["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        type["icon"] as IconData,
                        color: type["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${type["label"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${type["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (type["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${type["duration"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: type["color"] as Color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
          }).toList(),
        ),

        SizedBox(height: spLg),

        // Specialty Selection
        QDropdownField(
          label: "Medical Specialty",
          items: specialties,
          value: selectedSpecialty,
          validator: Validator.required,
          onChanged: (value, label) {
            selectedSpecialty = value;
            setState(() {});
          },
        ),

        SizedBox(height: spSm),

        // Urgency Level
        QDropdownField(
          label: "Urgency Level",
          items: urgencyLevels,
          value: selectedUrgency,
          validator: Validator.required,
          onChanged: (value, label) {
            selectedUrgency = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Doctor",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Choose from our experienced healthcare professionals",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),

        SizedBox(height: spLg),

        Column(
          children: doctors.map((doctor) {
            bool isSelected = selectedDoctor == doctor["name"];
            return GestureDetector(
              onTap: () {
                selectedDoctor = doctor["name"];
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Image.network(
                          "${doctor["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${doctor["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${doctor["specialty"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    size: 14,
                                    color: index < (doctor["rating"] as double).floor() 
                                        ? warningColor 
                                        : disabledColor,
                                  );
                                }),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${doctor["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${doctor["experience"]} experience",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Next: ${doctor["nextAvailable"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Date & Time",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Choose your preferred appointment date and time",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),

        SizedBox(height: spLg),

        // Date Picker
        QDatePicker(
          label: "Appointment Date",
          value: selectedDate,
          validator: Validator.required,
          onChanged: (value) {
            selectedDate = value;
            setState(() {});
          },
        ),

        SizedBox(height: spSm),

        // Time Picker
        QTimePicker(
          label: "Appointment Time",
          value: selectedTime,
          onChanged: (value) {
            selectedTime = value!;
            setState(() {});
          },
        ),

        SizedBox(height: spLg),

        // Available Time Slots
        Text(
          "Available Time Slots",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),

        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: timeSlots.map((time) {
            bool isSelected = selectedTime.kkmm == time;
            return GestureDetector(
              onTap: () {
                selectedTime = time.timeOfDay;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? primaryColor : disabledBoldColor,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        SizedBox(height: spLg),

        // Appointment Summary
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: primaryColor.withAlpha(30),
              width: 1,
            ),
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
              SizedBox(height: spXs),
              Text(
                "Doctor: $selectedDoctor",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "Date: ${selectedDate.dMMMy}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "Time: ${selectedTime.kkmm}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "Type: $selectedAppointmentType",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Patient Information",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Please provide or confirm your information",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),

        SizedBox(height: spLg),

        // Personal Information
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        QTextField(
          label: "Full Name",
          value: patientName,
          validator: Validator.required,
          onChanged: (value) {
            patientName = value;
            setState(() {});
          },
        ),

        QTextField(
          label: "Phone Number",
          value: patientPhone,
          validator: Validator.required,
          onChanged: (value) {
            patientPhone = value;
            setState(() {});
          },
        ),

        QTextField(
          label: "Email Address",
          value: patientEmail,
          validator: Validator.email,
          onChanged: (value) {
            patientEmail = value;
            setState(() {});
          },
        ),

        SizedBox(height: spLg),

        // Medical Information
        Text(
          "Medical Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        QMemoField(
          label: "Reason for Visit",
          value: reasonForVisit,
          hint: "Briefly describe the reason for your appointment",
          validator: Validator.required,
          onChanged: (value) {
            reasonForVisit = value;
            setState(() {});
          },
        ),

        QMemoField(
          label: "Current Symptoms",
          value: symptoms,
          hint: "List any symptoms you are experiencing",
          onChanged: (value) {
            symptoms = value;
            setState(() {});
          },
        ),

        QMemoField(
          label: "Current Medications",
          value: medications,
          hint: "List all medications you are currently taking",
          onChanged: (value) {
            medications = value;
            setState(() {});
          },
        ),

        QTextField(
          label: "Known Allergies",
          value: allergies,
          hint: "List any known allergies",
          onChanged: (value) {
            allergies = value;
            setState(() {});
          },
        ),

        SizedBox(height: spLg),

        // Insurance Information
        Text(
          "Insurance Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        QTextField(
          label: "Insurance Provider",
          value: insurance,
          validator: Validator.required,
          onChanged: (value) {
            insurance = value;
            setState(() {});
          },
        ),

        QTextField(
          label: "Insurance Number",
          value: insuranceNumber,
          validator: Validator.required,
          onChanged: (value) {
            insuranceNumber = value;
            setState(() {});
          },
        ),

        SizedBox(height: spLg),

        // Additional Information
        Text(
          "Additional Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        QSwitch(
          label: "New Patient",
          items: [
            {
              "label": "I am a new patient to this practice",
              "value": true,
              "checked": isNewPatient,
            }
          ],
          value: [if (isNewPatient) {"label": "I am a new patient to this practice", "value": true, "checked": true}],
          onChanged: (values, ids) {
            isNewPatient = values.isNotEmpty;
            setState(() {});
          },
        ),

        QSwitch(
          label: "Referral",
          items: [
            {
              "label": "I have a referral from another doctor",
              "value": true,
              "checked": hasReferral,
            }
          ],
          value: [if (hasReferral) {"label": "I have a referral from another doctor", "value": true, "checked": true}],
          onChanged: (values, ids) {
            hasReferral = values.isNotEmpty;
            setState(() {});
          },
        ),

        if (hasReferral) ...[
          QTextField(
            label: "Referring Doctor",
            value: referralDoctor,
            hint: "Name of the doctor who referred you",
            validator: hasReferral ? Validator.required : null,
            onChanged: (value) {
              referralDoctor = value;
              setState(() {});
            },
          ),
        ],

        SizedBox(height: spLg),

        // Final Summary
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor.withAlpha(20),
                primaryColor.withAlpha(5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Appointment Summary",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text("Doctor: $selectedDoctor", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
              Text("Date: ${selectedDate.dMMMy}", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
              Text("Time: ${selectedTime.kkmm}", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
              Text("Type: $selectedAppointmentType", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
              Text("Patient: $patientName", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
              Text("Reason: $reasonForVisit", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
            ],
          ),
        ),
      ],
    );
  }
}
