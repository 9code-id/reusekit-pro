import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForm5View extends StatefulWidget {
  @override
  State<GrlForm5View> createState() => _GrlForm5ViewState();
}

class _GrlForm5ViewState extends State<GrlForm5View> {
  final formKey = GlobalKey<FormState>();
  
  String patientName = "";
  String patientEmail = "";
  String patientPhone = "";
  DateTime dateOfBirth = DateTime.now().subtract(Duration(days: 365 * 30));
  String selectedGender = "";
  String emergencyContact = "";
  String emergencyPhone = "";
  String bloodType = "";
  String allergies = "";
  String currentMedications = "";
  String medicalHistory = "";
  String selectedDoctor = "";
  DateTime appointmentDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay appointmentTime = TimeOfDay(hour: 9, minute: 0);
  String selectedDepartment = "";
  String appointmentReason = "";
  String symptoms = "";
  String insuranceProvider = "";
  String insuranceNumber = "";
  String preferredLanguage = "";
  bool hasInsurance = true;
  bool firstVisit = false;
  bool followUpVisit = false;
  bool urgentCare = false;

  List<Map<String, dynamic>> genderItems = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "not_specified"},
  ];

  List<Map<String, dynamic>> bloodTypeItems = [
    {"label": "A+", "value": "a_positive"},
    {"label": "A-", "value": "a_negative"},
    {"label": "B+", "value": "b_positive"},
    {"label": "B-", "value": "b_negative"},
    {"label": "AB+", "value": "ab_positive"},
    {"label": "AB-", "value": "ab_negative"},
    {"label": "O+", "value": "o_positive"},
    {"label": "O-", "value": "o_negative"},
    {"label": "Unknown", "value": "unknown"},
  ];

  List<Map<String, dynamic>> doctorItems = [
    {"label": "Dr. Sarah Johnson - General Medicine", "value": "dr_johnson"},
    {"label": "Dr. Michael Chen - Cardiology", "value": "dr_chen"},
    {"label": "Dr. Emily Davis - Pediatrics", "value": "dr_davis"},
    {"label": "Dr. Robert Smith - Orthopedics", "value": "dr_smith"},
    {"label": "Dr. Lisa Wang - Dermatology", "value": "dr_wang"},
    {"label": "Dr. James Wilson - Internal Medicine", "value": "dr_wilson"},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "General Medicine", "value": "general"},
    {"label": "Emergency", "value": "emergency"},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Orthopedics", "value": "orthopedics"},
    {"label": "Pediatrics", "value": "pediatrics"},
    {"label": "Dermatology", "value": "dermatology"},
    {"label": "Gynecology", "value": "gynecology"},
    {"label": "Neurology", "value": "neurology"},
  ];

  List<Map<String, dynamic>> languageItems = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Chinese", "value": "zh"},
    {"label": "Japanese", "value": "ja"},
  ];

  Future<void> _bookAppointment() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      ss("Appointment booked successfully!");
      
      //navigateTo AppointmentConfirmationView
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment"),
        actions: [
          IconButton(
            icon: Icon(Icons.medical_services),
            onPressed: () {
              si("Complete all fields to book your medical appointment");
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4A90E2).withAlpha(30),
                      Color(0xFF50C878).withAlpha(30),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: Color(0xFF4A90E2).withAlpha(60)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_hospital,
                      color: Color(0xFF4A90E2),
                      size: 32,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Medical Appointment",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A90E2),
                            ),
                          ),
                          Text(
                            "Book your appointment with our healthcare professionals",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Patient Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
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

                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Email",
                            value: patientEmail,
                            validator: Validator.email,
                            onChanged: (value) {
                              patientEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Phone",
                            value: patientPhone,
                            validator: Validator.required,
                            onChanged: (value) {
                              patientPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Date of Birth",
                            value: dateOfBirth,
                            onChanged: (value) {
                              dateOfBirth = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Gender",
                            items: genderItems,
                            value: selectedGender,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              selectedGender = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.emergency,
                          color: dangerColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Emergency Contact",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Emergency Contact Name",
                            value: emergencyContact,
                            validator: Validator.required,
                            onChanged: (value) {
                              emergencyContact = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Emergency Phone",
                            value: emergencyPhone,
                            validator: Validator.required,
                            onChanged: (value) {
                              emergencyPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.medical_information,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Medical Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QDropdownField(
                      label: "Blood Type",
                      items: bloodTypeItems,
                      value: bloodType,
                      onChanged: (value, label) {
                        bloodType = value;
                        setState(() {});
                      },
                    ),

                    QMemoField(
                      label: "Allergies",
                      value: allergies,
                      hint: "List any known allergies",
                      onChanged: (value) {
                        allergies = value;
                        setState(() {});
                      },
                    ),

                    QMemoField(
                      label: "Current Medications",
                      value: currentMedications,
                      hint: "List all medications you are currently taking",
                      onChanged: (value) {
                        currentMedications = value;
                        setState(() {});
                      },
                    ),

                    QMemoField(
                      label: "Medical History",
                      value: medicalHistory,
                      hint: "Previous surgeries, chronic conditions, etc.",
                      onChanged: (value) {
                        medicalHistory = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Appointment Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QDropdownField(
                      label: "Department",
                      items: departmentItems,
                      value: selectedDepartment,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedDepartment = value;
                        setState(() {});
                      },
                    ),

                    QDropdownField(
                      label: "Preferred Doctor",
                      items: doctorItems,
                      value: selectedDoctor,
                      onChanged: (value, label) {
                        selectedDoctor = value;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Appointment Date",
                            value: appointmentDate,
                            onChanged: (value) {
                              appointmentDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Appointment Time",
                            value: appointmentTime,
                            onChanged: (value) {
                              appointmentTime = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    QTextField(
                      label: "Reason for Visit",
                      value: appointmentReason,
                      validator: Validator.required,
                      hint: "Brief description of your concern",
                      onChanged: (value) {
                        appointmentReason = value;
                        setState(() {});
                      },
                    ),

                    QMemoField(
                      label: "Symptoms",
                      value: symptoms,
                      hint: "Describe your current symptoms in detail",
                      onChanged: (value) {
                        symptoms = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              if (hasInsurance)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Insurance Information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Insurance Provider",
                              value: insuranceProvider,
                              validator: hasInsurance ? Validator.required : null,
                              onChanged: (value) {
                                insuranceProvider = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QTextField(
                              label: "Insurance Number",
                              value: insuranceNumber,
                              validator: hasInsurance ? Validator.required : null,
                              onChanged: (value) {
                                insuranceNumber = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              QDropdownField(
                label: "Preferred Language",
                items: languageItems,
                value: preferredLanguage,
                onChanged: (value, label) {
                  preferredLanguage = value;
                  setState(() {});
                },
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: secondaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Visit Options",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Has Insurance",
                          "value": "insurance",
                          "checked": hasInsurance,
                        },
                        {
                          "label": "First Visit",
                          "value": "first_visit",
                          "checked": firstVisit,
                        },
                        {
                          "label": "Follow-up Visit",
                          "value": "follow_up",
                          "checked": followUpVisit,
                        },
                        {
                          "label": "Urgent Care",
                          "value": "urgent",
                          "checked": urgentCare,
                        }
                      ],
                      value: [
                        if (hasInsurance) {"label": "Has Insurance", "value": "insurance", "checked": true},
                        if (firstVisit) {"label": "First Visit", "value": "first_visit", "checked": true},
                        if (followUpVisit) {"label": "Follow-up Visit", "value": "follow_up", "checked": true},
                        if (urgentCare) {"label": "Urgent Care", "value": "urgent", "checked": true},
                      ],
                      onChanged: (values, ids) {
                        hasInsurance = values.any((v) => v["value"] == "insurance");
                        firstVisit = values.any((v) => v["value"] == "first_visit");
                        followUpVisit = values.any((v) => v["value"] == "follow_up");
                        urgentCare = values.any((v) => v["value"] == "urgent");
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Color(0xFF4A90E2).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: Color(0xFF4A90E2).withAlpha(40)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: Color(0xFF4A90E2),
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Please arrive 15 minutes early for your appointment. Bring a valid ID and insurance card if applicable.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4A90E2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Book Appointment",
                  size: bs.md,
                  onPressed: _bookAppointment,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
