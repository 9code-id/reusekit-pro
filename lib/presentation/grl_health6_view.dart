import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHealth6View extends StatefulWidget {
  @override
  State<GrlHealth6View> createState() => _GrlHealth6ViewState();
}

class _GrlHealth6ViewState extends State<GrlHealth6View> {
  String patientName = "";
  String patientAge = "";
  String patientGender = "male";
  String appointmentType = "consultation";
  String selectedDate = DateTime.now().add(Duration(days: 1)).toString().split(' ')[0];
  String selectedTime = "09:00";
  String symptoms = "";
  String medicalHistory = "";
  String notes = "";
  bool isUrgent = false;

  List<Map<String, dynamic>> appointmentTypes = [
    {"label": "General Consultation", "value": "consultation"},
    {"label": "Follow-up Visit", "value": "followup"},
    {"label": "Health Checkup", "value": "checkup"},
    {"label": "Specialist Referral", "value": "specialist"},
    {"label": "Emergency", "value": "emergency"},
  ];

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
  ];

  List<String> availableTimes = [
    "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
    "14:00", "14:30", "15:00", "15:30", "16:00", "16:30",
    "17:00", "17:30"
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(200)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Schedule Your Appointment",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Book with our qualified healthcare professionals",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                      size: 48,
                    ),
                  ],
                ),
              ),

              // Quick Info
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Appointments can be booked up to 30 days in advance. Emergency cases will be prioritized.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Patient Information
              Text(
                "Patient Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Full Name",
                value: patientName,
                hint: "Enter patient's full name",
                validator: Validator.required,
                onChanged: (value) {
                  patientName = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Age",
                      value: patientAge,
                      hint: "Enter age",
                      validator: Validator.required,
                      onChanged: (value) {
                        patientAge = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Gender",
                      items: genderOptions,
                      value: patientGender,
                      onChanged: (value, label) {
                        patientGender = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Appointment Details
              Text(
                "Appointment Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Appointment Type",
                items: appointmentTypes,
                value: appointmentType,
                onChanged: (value, label) {
                  appointmentType = value;
                  setState(() {});
                },
              ),

              QDatePicker(
                label: "Preferred Date",
                value: DateTime.parse(selectedDate),
                onChanged: (value) {
                  selectedDate = value.toString().split(' ')[0];
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Preferred Time",
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

              // Priority Setting
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Priority Level",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Mark as Urgent",
                                "value": true,
                                "checked": isUrgent,
                              }
                            ],
                            value: [
                              if (isUrgent)
                                {
                                  "label": "Mark as Urgent",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              isUrgent = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    if (isUrgent)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning, color: Colors.red, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Urgent appointments will be prioritized and may require immediate attention.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Medical Information
              Text(
                "Medical Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QMemoField(
                label: "Current Symptoms",
                value: symptoms,
                hint: "Describe your current symptoms or concerns",
                onChanged: (value) {
                  symptoms = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Medical History",
                value: medicalHistory,
                hint: "List any relevant medical history, allergies, or current medications",
                onChanged: (value) {
                  medicalHistory = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Additional Notes",
                value: notes,
                hint: "Any additional information for the healthcare provider",
                onChanged: (value) {
                  notes = value;
                  setState(() {});
                },
              ),

              // Appointment Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Appointment Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (patientName.isNotEmpty)
                      Row(
                        children: [
                          Icon(Icons.person, color: disabledBoldColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "Patient: $patientName",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        Icon(Icons.medical_services, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Type: ${appointmentTypes.firstWhere((type) => type["value"] == appointmentType)["label"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Date: $selectedDate at $selectedTime",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (isUrgent)
                      Row(
                        children: [
                          Icon(Icons.priority_high, color: Colors.red, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "Priority: URGENT",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Book Appointment",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ss("Appointment booked successfully for $selectedDate at $selectedTime");
                    }
                  },
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save as Draft",
                      size: bs.sm,
                      onPressed: () {
                        si("Appointment details saved as draft");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Call Clinic",
                      size: bs.sm,
                      onPressed: () {
                        si("Connecting to clinic...");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
