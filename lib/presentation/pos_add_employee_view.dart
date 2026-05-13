import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosAddEmployeeView extends StatefulWidget {
  const PosAddEmployeeView({super.key});

  @override
  State<PosAddEmployeeView> createState() => _PosAddEmployeeViewState();
}

class _PosAddEmployeeViewState extends State<PosAddEmployeeView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String address = "";
  String dateOfBirth = "";
  String selectedGender = "";
  String selectedDepartment = "";
  String selectedRole = "";
  String selectedEmploymentType = "";
  String startDate = "";
  String profileImage = "";
  String baseSalary = "";
  String hourlyRate = "";
  String selectedWorkSchedule = "";
  String notes = "";
  
  List<Map<String, dynamic>> genderItems = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
  ];
  
  List<Map<String, dynamic>> departmentItems = [
    {"label": "Sales", "value": "sales"},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Service", "value": "service"},
    {"label": "Management", "value": "management"},
    {"label": "Cashier", "value": "cashier"},
    {"label": "Inventory", "value": "inventory"},
  ];
  
  List<Map<String, dynamic>> roleItems = [
    {"label": "Manager", "value": "manager"},
    {"label": "Assistant Manager", "value": "assistant_manager"},
    {"label": "Cashier", "value": "cashier"},
    {"label": "Server", "value": "server"},
    {"label": "Chef", "value": "chef"},
    {"label": "Barista", "value": "barista"},
    {"label": "Cleaner", "value": "cleaner"},
  ];
  
  List<Map<String, dynamic>> employmentTypeItems = [
    {"label": "Full Time", "value": "full_time"},
    {"label": "Part Time", "value": "part_time"},
    {"label": "Contract", "value": "contract"},
    {"label": "Intern", "value": "intern"},
  ];
  
  List<Map<String, dynamic>> workScheduleItems = [
    {"label": "Morning Shift (6AM - 2PM)", "value": "morning"},
    {"label": "Afternoon Shift (2PM - 10PM)", "value": "afternoon"},
    {"label": "Night Shift (10PM - 6AM)", "value": "night"},
    {"label": "Flexible Hours", "value": "flexible"},
    {"label": "Weekend Only", "value": "weekend"},
  ];
  
  void _saveEmployee() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Employee added successfully");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Employee"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _saveEmployee,
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
              // Profile Image Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Text(
                      "Profile Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QImagePicker(
                      label: "Profile Photo",
                      value: profileImage,
                      hint: "Upload employee photo",
                      onChanged: (value) {
                        profileImage = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Personal Information Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
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
                      "Personal Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "First Name",
                            value: firstName,
                            validator: Validator.required,
                            onChanged: (value) {
                              firstName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Last Name",
                            value: lastName,
                            validator: Validator.required,
                            onChanged: (value) {
                              lastName = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Email Address",
                      value: email,
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Phone Number",
                      value: phone,
                      validator: Validator.required,
                      onChanged: (value) {
                        phone = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Address",
                      value: address,
                      validator: Validator.required,
                      onChanged: (value) {
                        address = value;
                        setState(() {});
                      },
                    ),
                    QDatePicker(
                      label: "Date of Birth",
                      value: dateOfBirth.isNotEmpty 
                          ? DateTime.parse(dateOfBirth)
                          : DateTime.now().subtract(Duration(days: 7300)),
                      onChanged: (value) {
                        dateOfBirth = value.toString();
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Gender",
                      items: genderItems,
                      value: selectedGender,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedGender = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Employment Details Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
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
                      "Employment Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
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
                      label: "Role/Position",
                      items: roleItems,
                      value: selectedRole,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedRole = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Employment Type",
                      items: employmentTypeItems,
                      value: selectedEmploymentType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedEmploymentType = value;
                        setState(() {});
                      },
                    ),
                    QDatePicker(
                      label: "Start Date",
                      value: startDate.isNotEmpty 
                          ? DateTime.parse(startDate)
                          : DateTime.now(),
                      onChanged: (value) {
                        startDate = value.toString();
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Work Schedule",
                      items: workScheduleItems,
                      value: selectedWorkSchedule,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedWorkSchedule = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Compensation Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
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
                      "Compensation",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Base Salary (\$)",
                            value: baseSalary,
                            validator: Validator.required,
                            onChanged: (value) {
                              baseSalary = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QNumberField(
                            label: "Hourly Rate (\$)",
                            value: hourlyRate,
                            onChanged: (value) {
                              hourlyRate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Additional Notes Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
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
                      "Additional Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Notes",
                      value: notes,
                      hint: "Any additional notes about the employee",
                      onChanged: (value) {
                        notes = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Action Buttons
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Cancel",
                        color: disabledColor,
                        size: bs.md,
                        onPressed: () => back(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Save Employee",
                        size: bs.md,
                        onPressed: _saveEmployee,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
