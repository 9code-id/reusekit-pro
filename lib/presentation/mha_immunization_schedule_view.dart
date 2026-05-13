import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaImmunizationScheduleView extends StatefulWidget {
  const MhaImmunizationScheduleView({super.key});

  @override
  State<MhaImmunizationScheduleView> createState() => _MhaImmunizationScheduleViewState();
}

class _MhaImmunizationScheduleViewState extends State<MhaImmunizationScheduleView> {
  final formKey = GlobalKey<FormState>();
  
  // Filter states
  String selectedAgeGroup = "All Ages";
  String selectedStatus = "All";
  String searchQuery = "";
  
  // Form states for adding vaccination
  String vaccineName = "";
  String vaccineDescription = "";
  String selectedAge = "Birth";
  String selectedCategory = "Routine";
  String dueDate = DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
  String status = "Pending";
  String notes = "";
  bool isCompleted = false;
  
  List<Map<String, dynamic>> ageGroups = [
    {"label": "All Ages", "value": "All Ages"},
    {"label": "Birth", "value": "Birth"},
    {"label": "2 Months", "value": "2 Months"},
    {"label": "4 Months", "value": "4 Months"},
    {"label": "6 Months", "value": "6 Months"},
    {"label": "12 Months", "value": "12 Months"},
    {"label": "15 Months", "value": "15 Months"},
    {"label": "18 Months", "value": "18 Months"},
    {"label": "2 Years", "value": "2 Years"},
    {"label": "4-6 Years", "value": "4-6 Years"},
    {"label": "11-12 Years", "value": "11-12 Years"},
    {"label": "Adult", "value": "Adult"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Scheduled", "value": "Scheduled"},
  ];
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Routine", "value": "Routine"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Occupational", "value": "Occupational"},
    {"label": "High Risk", "value": "High Risk"},
  ];
  
  List<Map<String, dynamic>> immunizations = [
    {
      "id": "1",
      "name": "Hepatitis B",
      "description": "Protects against hepatitis B virus infection",
      "age": "Birth",
      "category": "Routine",
      "dueDate": "2024-01-15",
      "status": "Completed",
      "completedDate": "2024-01-10",
      "provider": "Dr. Smith",
      "location": "City Health Clinic",
      "notes": "First dose of series",
      "nextDue": "2024-03-15",
      "series": "1 of 3",
      "priority": "High",
    },
    {
      "id": "2",
      "name": "DTaP",
      "description": "Diphtheria, Tetanus, and Pertussis vaccine",
      "age": "2 Months",
      "category": "Routine",
      "dueDate": "2024-03-20",
      "status": "Scheduled",
      "scheduledTime": "10:30 AM",
      "provider": "Dr. Johnson",
      "location": "Pediatric Clinic",
      "notes": "First dose",
      "series": "1 of 5",
      "priority": "High",
    },
    {
      "id": "3",
      "name": "Polio (IPV)",
      "description": "Inactivated Poliovirus vaccine",
      "age": "2 Months",
      "category": "Routine",
      "dueDate": "2024-03-20",
      "status": "Pending",
      "provider": "Dr. Johnson",
      "location": "Pediatric Clinic",
      "notes": "Can be given with DTaP",
      "series": "1 of 4",
      "priority": "High",
    },
    {
      "id": "4",
      "name": "Hib",
      "description": "Haemophilus influenzae type b vaccine",
      "age": "2 Months",
      "category": "Routine",
      "dueDate": "2024-03-20",
      "status": "Pending",
      "series": "1 of 4",
      "priority": "Medium",
    },
    {
      "id": "5",
      "name": "PCV13",
      "description": "Pneumococcal conjugate vaccine",
      "age": "2 Months",
      "category": "Routine",
      "dueDate": "2024-03-20",
      "status": "Pending",
      "series": "1 of 4",
      "priority": "High",
    },
    {
      "id": "6",
      "name": "Rotavirus",
      "description": "Rotavirus vaccine",
      "age": "2 Months",
      "category": "Routine",
      "dueDate": "2024-03-20",
      "status": "Pending",
      "series": "1 of 3",
      "priority": "Medium",
    },
    {
      "id": "7",
      "name": "MMR",
      "description": "Measles, Mumps, and Rubella vaccine",
      "age": "12 Months",
      "category": "Routine",
      "dueDate": "2024-12-15",
      "status": "Pending",
      "series": "1 of 2",
      "priority": "High",
    },
    {
      "id": "8",
      "name": "Varicella",
      "description": "Chickenpox vaccine",
      "age": "12 Months",
      "category": "Routine",
      "dueDate": "2024-12-15",
      "status": "Pending",
      "series": "1 of 2",
      "priority": "Medium",
    },
    {
      "id": "9",
      "name": "Hepatitis A",
      "description": "Protects against hepatitis A virus",
      "age": "12 Months",
      "category": "Routine",
      "dueDate": "2024-12-15",
      "status": "Pending",
      "series": "1 of 2",
      "priority": "Medium",
    },
    {
      "id": "10",
      "name": "HPV",
      "description": "Human Papillomavirus vaccine",
      "age": "11-12 Years",
      "category": "Routine",
      "dueDate": "2025-06-15",
      "status": "Pending",
      "series": "1 of 3",
      "priority": "High",
    },
    {
      "id": "11",
      "name": "Meningococcal",
      "description": "Meningococcal conjugate vaccine",
      "age": "11-12 Years",
      "category": "Routine",
      "dueDate": "2025-06-15",
      "status": "Pending",
      "series": "1 of 2",
      "priority": "High",
    },
    {
      "id": "12",
      "name": "Yellow Fever",
      "description": "Required for travel to certain countries",
      "age": "Adult",
      "category": "Travel",
      "dueDate": "2024-08-01",
      "status": "Overdue",
      "notes": "Required for Brazil trip",
      "priority": "Medium",
    },
  ];
  
  List<Map<String, dynamic>> get filteredImmunizations {
    return immunizations.where((immunization) {
      bool matchesAge = selectedAgeGroup == "All Ages" || 
                       immunization["age"] == selectedAgeGroup;
      bool matchesStatus = selectedStatus == "All" || 
                          immunization["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty ||
                          immunization["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          immunization["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesAge && matchesStatus && matchesSearch;
    }).toList();
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Scheduled":
        return infoColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledColor;
    }
  }
  
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }
  
  void _showImmunizationDetail(Map<String, dynamic> immunization) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${immunization["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${immunization["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getStatusColor(immunization["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: _getStatusColor(immunization["status"]),
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  immunization["status"] == "Completed" ? Icons.check_circle :
                                  immunization["status"] == "Scheduled" ? Icons.schedule :
                                  immunization["status"] == "Overdue" ? Icons.warning :
                                  Icons.pending,
                                  color: _getStatusColor(immunization["status"]),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${immunization["status"]}",
                                  style: TextStyle(
                                    color: _getStatusColor(immunization["status"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(immunization["priority"] ?? "Medium").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: _getPriorityColor(immunization["priority"] ?? "Medium"),
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.priority_high,
                                  color: _getPriorityColor(immunization["priority"] ?? "Medium"),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${immunization["priority"] ?? "Medium"} Priority",
                                  style: TextStyle(
                                    color: _getPriorityColor(immunization["priority"] ?? "Medium"),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
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
                            "Vaccination Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fsH6,
                            ),
                          ),
                          SizedBox(height: spSm),
                          _buildDetailRow("Age Group", immunization["age"]),
                          _buildDetailRow("Category", immunization["category"]),
                          _buildDetailRow("Series", immunization["series"] ?? "Single dose"),
                          _buildDetailRow("Due Date", DateTime.parse(immunization["dueDate"]).dMMMy),
                          if (immunization["status"] == "Completed" && immunization["completedDate"] != null)
                            _buildDetailRow("Completed Date", DateTime.parse(immunization["completedDate"]).dMMMy),
                          if (immunization["status"] == "Scheduled" && immunization["scheduledTime"] != null)
                            _buildDetailRow("Scheduled Time", immunization["scheduledTime"]),
                          if (immunization["nextDue"] != null)
                            _buildDetailRow("Next Due", DateTime.parse(immunization["nextDue"]).dMMMy),
                        ],
                      ),
                    ),
                    if (immunization["provider"] != null || immunization["location"] != null) ...[
                      SizedBox(height: spMd),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Provider Information",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fsH6,
                              ),
                            ),
                            SizedBox(height: spSm),
                            if (immunization["provider"] != null)
                              _buildDetailRow("Provider", immunization["provider"]),
                            if (immunization["location"] != null)
                              _buildDetailRow("Location", immunization["location"]),
                          ],
                        ),
                      ),
                    ],
                    if (immunization["notes"] != null && immunization["notes"].toString().isNotEmpty) ...[
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Notes",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fsH6,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${immunization["notes"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        if (immunization["status"] != "Completed") ...[
                          Expanded(
                            child: QButton(
                              label: immunization["status"] == "Scheduled" ? "Reschedule" : "Schedule",
                              icon: Icons.calendar_today,
                              size: bs.sm,
                              onPressed: () {
                                Navigator.pop(context);
                                _showScheduleDialog(immunization);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                        ],
                        Expanded(
                          child: QButton(
                            label: immunization["status"] == "Completed" ? "View Record" : "Mark Complete",
                            icon: immunization["status"] == "Completed" ? Icons.visibility : Icons.check,
                            size: bs.sm,
                            onPressed: () {
                              Navigator.pop(context);
                              if (immunization["status"] != "Completed") {
                                _showCompleteDialog(immunization);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showScheduleDialog(Map<String, dynamic> immunization) {
    String selectedDate = immunization["dueDate"];
    String selectedTime = "09:00 AM";
    String selectedProvider = immunization["provider"] ?? "";
    String selectedLocation = immunization["location"] ?? "";
    String scheduleNotes = "";
    
    List<Map<String, dynamic>> timeSlots = [
      {"label": "09:00 AM", "value": "09:00 AM"},
      {"label": "10:00 AM", "value": "10:00 AM"},
      {"label": "11:00 AM", "value": "11:00 AM"},
      {"label": "02:00 PM", "value": "02:00 PM"},
      {"label": "03:00 PM", "value": "03:00 PM"},
      {"label": "04:00 PM", "value": "04:00 PM"},
    ];
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: disabledColor)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Schedule ${immunization["name"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: [
                      QDatePicker(
                        label: "Appointment Date",
                        value: DateTime.parse(selectedDate),
                        onChanged: (value) {
                          selectedDate = value.toString().split(' ')[0];
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QDropdownField(
                        label: "Appointment Time",
                        items: timeSlots,
                        value: selectedTime,
                        onChanged: (value, label) {
                          selectedTime = value;
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QTextField(
                        label: "Healthcare Provider",
                        value: selectedProvider,
                        hint: "Dr. Smith",
                        onChanged: (value) {
                          selectedProvider = value;
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QTextField(
                        label: "Clinic/Hospital",
                        value: selectedLocation,
                        hint: "City Health Clinic",
                        onChanged: (value) {
                          selectedLocation = value;
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QMemoField(
                        label: "Additional Notes",
                        value: scheduleNotes,
                        hint: "Any special instructions or reminders",
                        onChanged: (value) {
                          scheduleNotes = value;
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Schedule Appointment",
                          icon: Icons.calendar_today,
                          size: bs.md,
                          onPressed: () {
                            // Update immunization
                            setState(() {
                              immunization["status"] = "Scheduled";
                              immunization["dueDate"] = selectedDate;
                              immunization["scheduledTime"] = selectedTime;
                              immunization["provider"] = selectedProvider;
                              immunization["location"] = selectedLocation;
                              if (scheduleNotes.isNotEmpty) {
                                immunization["notes"] = scheduleNotes;
                              }
                            });
                            Navigator.pop(context);
                            ss("Appointment scheduled successfully");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showCompleteDialog(Map<String, dynamic> immunization) {
    String completedDate = DateTime.now().toString().split(' ')[0];
    String provider = immunization["provider"] ?? "";
    String location = immunization["location"] ?? "";
    String batchNumber = "";
    String manufacturer = "";
    String completionNotes = "";
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: disabledColor)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Mark ${immunization["name"]} Complete",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: [
                      QDatePicker(
                        label: "Date Administered",
                        value: DateTime.parse(completedDate),
                        onChanged: (value) {
                          completedDate = value.toString().split(' ')[0];
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QTextField(
                        label: "Healthcare Provider",
                        value: provider,
                        hint: "Dr. Smith",
                        onChanged: (value) {
                          provider = value;
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QTextField(
                        label: "Clinic/Hospital",
                        value: location,
                        hint: "City Health Clinic",
                        onChanged: (value) {
                          location = value;
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QTextField(
                        label: "Batch/Lot Number",
                        value: batchNumber,
                        hint: "ABC123XYZ",
                        onChanged: (value) {
                          batchNumber = value;
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QTextField(
                        label: "Manufacturer",
                        value: manufacturer,
                        hint: "Pfizer, Moderna, etc.",
                        onChanged: (value) {
                          manufacturer = value;
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QMemoField(
                        label: "Notes",
                        value: completionNotes,
                        hint: "Any reactions or additional information",
                        onChanged: (value) {
                          completionNotes = value;
                          setModalState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Mark as Completed",
                          icon: Icons.check_circle,
                          size: bs.md,
                          onPressed: () {
                            // Update immunization
                            setState(() {
                              immunization["status"] = "Completed";
                              immunization["completedDate"] = completedDate;
                              immunization["provider"] = provider;
                              immunization["location"] = location;
                              immunization["batchNumber"] = batchNumber;
                              immunization["manufacturer"] = manufacturer;
                              if (completionNotes.isNotEmpty) {
                                immunization["notes"] = completionNotes;
                              }
                            });
                            Navigator.pop(context);
                            ss("Vaccination record updated successfully");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showAddImmunizationDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Add Immunization",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: [
                      QTextField(
                        label: "Vaccine Name",
                        value: vaccineName,
                        validator: Validator.required,
                        hint: "e.g., Hepatitis B, DTaP",
                        onChanged: (value) {
                          vaccineName = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QMemoField(
                        label: "Description",
                        value: vaccineDescription,
                        hint: "Brief description of the vaccine",
                        onChanged: (value) {
                          vaccineDescription = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QDropdownField(
                        label: "Age Group",
                        items: ageGroups.where((age) => age["value"] != "All Ages").toList(),
                        value: selectedAge,
                        onChanged: (value, label) {
                          selectedAge = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QDatePicker(
                        label: "Due Date",
                        value: DateTime.parse(dueDate),
                        onChanged: (value) {
                          dueDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      QMemoField(
                        label: "Notes",
                        value: notes,
                        hint: "Any additional information",
                        onChanged: (value) {
                          notes = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Add Immunization",
                          icon: Icons.add,
                          size: bs.md,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                immunizations.add({
                                  "id": DateTime.now().millisecondsSinceEpoch.toString(),
                                  "name": vaccineName,
                                  "description": vaccineDescription,
                                  "age": selectedAge,
                                  "category": selectedCategory,
                                  "dueDate": dueDate,
                                  "status": "Pending",
                                  "notes": notes,
                                  "series": "1 of 1",
                                  "priority": "Medium",
                                });
                                // Reset form
                                vaccineName = "";
                                vaccineDescription = "";
                                selectedAge = "Birth";
                                selectedCategory = "Routine";
                                dueDate = DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
                                notes = "";
                              });
                              Navigator.pop(context);
                              ss("Immunization added successfully");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatsCard() {
    int totalVaccines = immunizations.length;
    int completedVaccines = immunizations.where((v) => v["status"] == "Completed").length;
    int pendingVaccines = immunizations.where((v) => v["status"] == "Pending").length;
    int overdueVaccines = immunizations.where((v) => v["status"] == "Overdue").length;
    double completionRate = totalVaccines > 0 ? (completedVaccines / totalVaccines) * 100 : 0;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.vaccines, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Immunization Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$totalVaccines",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$completedVaccines",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Completed",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$pendingVaccines",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$overdueVaccines",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Overdue",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${completionRate.toStringAsFixed(1)}% Complete",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Immunization Progress",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildImmunizationCard(Map<String, dynamic> immunization) {
    bool isOverdue = immunization["status"] == "Overdue";
    bool isCompleted = immunization["status"] == "Completed";
    bool isScheduled = immunization["status"] == "Scheduled";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isOverdue ? Border.all(color: dangerColor, width: 2) : 
                isCompleted ? Border.all(color: successColor) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(immunization["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  immunization["status"] == "Completed" ? Icons.check_circle :
                  immunization["status"] == "Scheduled" ? Icons.schedule :
                  immunization["status"] == "Overdue" ? Icons.warning :
                  Icons.vaccines,
                  color: _getStatusColor(immunization["status"]),
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${immunization["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${immunization["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(immunization["status"]),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${immunization["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.child_care, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${immunization["age"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${immunization["category"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
              if (immunization["series"] != null) ...[
                SizedBox(width: spMd),
                Icon(Icons.format_list_numbered, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${immunization["series"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                isCompleted ? Icons.check : Icons.calendar_today,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                isCompleted ? 
                  "Completed: ${DateTime.parse(immunization["completedDate"]).dMMMy}" :
                  "Due: ${DateTime.parse(immunization["dueDate"]).dMMMy}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
              if (isScheduled && immunization["scheduledTime"] != null) ...[
                SizedBox(width: spMd),
                Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${immunization["scheduledTime"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
          if (immunization["priority"] != null) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(
                  Icons.priority_high,
                  size: 16,
                  color: _getPriorityColor(immunization["priority"]),
                ),
                SizedBox(width: spXs),
                Text(
                  "${immunization["priority"]} Priority",
                  style: TextStyle(
                    color: _getPriorityColor(immunization["priority"]),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showImmunizationDetail(immunization),
                ),
              ),
              SizedBox(width: spSm),
              if (!isCompleted) ...[
                QButton(
                  icon: isScheduled ? Icons.edit_calendar : Icons.calendar_today,
                  size: bs.sm,
                  onPressed: () => _showScheduleDialog(immunization),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () => _showCompleteDialog(immunization),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Immunization Schedule"),
        actions: [
          GestureDetector(
            onTap: _showAddImmunizationDialog,
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCard(),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter & Search",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Search Vaccines",
                    value: searchQuery,
                    hint: "Search by name or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Age Group",
                          items: ageGroups,
                          value: selectedAgeGroup,
                          onChanged: (value, label) {
                            selectedAgeGroup = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
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
            Row(
              children: [
                Text(
                  "Immunizations",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${filteredImmunizations.length}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            if (filteredImmunizations.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.vaccines,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No immunizations found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or add a new immunization",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredImmunizations.map((immunization) => _buildImmunizationCard(immunization)),
          ],
        ),
      ),
    );
  }
}
