import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaAppointmentBookingView extends StatefulWidget {
  const LcaAppointmentBookingView({super.key});

  @override
  State<LcaAppointmentBookingView> createState() => _LcaAppointmentBookingViewState();
}

class _LcaAppointmentBookingViewState extends State<LcaAppointmentBookingView> {
  DateTime selectedDate = DateTime.now();
  String selectedFilter = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> appointments = [
    {
      "id": 1,
      "clientName": "John Smith",
      "email": "john.smith@email.com",
      "phone": "(555) 123-4567",
      "appointmentType": "Initial Consultation",
      "date": "2024-12-20T10:00:00Z",
      "endTime": "2024-12-20T11:00:00Z",
      "attorney": "Sarah Johnson, Esq.",
      "status": "Confirmed",
      "location": "Office - Conference Room A",
      "caseType": "Personal Injury",
      "priority": "High",
      "notes": "Motor vehicle accident case - initial consultation",
      "remindersSent": 1,
      "documents": ["Accident Report", "Medical Records"],
      "isNewClient": true,
      "referralSource": "Google Search",
    },
    {
      "id": 2,
      "clientName": "Maria Rodriguez",
      "email": "maria.rodriguez@email.com",
      "phone": "(555) 234-5678",
      "appointmentType": "Case Review",
      "date": "2024-12-21T14:30:00Z",
      "endTime": "2024-12-21T15:30:00Z",
      "attorney": "Michael Chen, Esq.",
      "status": "Pending",
      "location": "Client Office - Downtown",
      "caseType": "Employment Law",
      "priority": "Medium",
      "notes": "Wrongful termination case review meeting",
      "remindersSent": 0,
      "documents": ["Employment Contract", "Termination Letter"],
      "isNewClient": false,
      "referralSource": "Existing Client",
    },
    {
      "id": 3,
      "clientName": "Robert Davis",
      "email": "robert.davis@email.com",
      "phone": "(555) 345-6789",
      "appointmentType": "Document Signing",
      "date": "2024-12-22T09:15:00Z",
      "endTime": "2024-12-22T09:45:00Z",
      "attorney": "Emily Davis, Esq.",
      "status": "Confirmed",
      "location": "Office - Emily's Office",
      "caseType": "Family Law",
      "priority": "Low",
      "notes": "Custody agreement final signing",
      "remindersSent": 2,
      "documents": ["Custody Agreement", "Parenting Plan"],
      "isNewClient": false,
      "referralSource": "Ongoing Case",
    },
    {
      "id": 4,
      "clientName": "Jennifer Wilson",
      "email": "jennifer.wilson@email.com",
      "phone": "(555) 456-7890",
      "appointmentType": "Settlement Discussion",
      "date": "2024-12-23T16:00:00Z",
      "endTime": "2024-12-23T17:30:00Z",
      "attorney": "David Wilson, Esq.",
      "status": "Rescheduled",
      "location": "Video Call - Zoom",
      "caseType": "Contract Dispute",
      "priority": "High",
      "notes": "Discuss settlement offer from opposing party",
      "remindersSent": 1,
      "documents": ["Settlement Offer", "Damage Analysis"],
      "isNewClient": false,
      "referralSource": "Referral",
    },
    {
      "id": 5,
      "clientName": "Carlos Martinez",
      "email": "carlos.martinez@email.com",
      "phone": "(555) 567-8901",
      "appointmentType": "Initial Consultation",
      "date": "2024-12-24T11:30:00Z",
      "endTime": "2024-12-24T12:30:00Z",
      "attorney": "Jennifer Martinez, Esq.",
      "status": "Cancelled",
      "location": "Office - Conference Room B",
      "caseType": "Immigration Law",
      "priority": "Medium",
      "notes": "Visa application consultation - client cancelled",
      "remindersSent": 0,
      "documents": ["Passport", "Application Forms"],
      "isNewClient": true,
      "referralSource": "Community Center",
    },
  ];

  // New appointment form
  String clientName = "";
  String clientEmail = "";
  String clientPhone = "";
  String selectedAppointmentType = "Initial Consultation";
  DateTime? appointmentDate;
  TimeOfDay? appointmentTime;
  String selectedAttorney = "Sarah Johnson, Esq.";
  String selectedLocation = "Office - Conference Room A";
  String selectedCaseType = "Personal Injury";
  String appointmentNotes = "";

  List<String> appointmentTypes = [
    "Initial Consultation",
    "Case Review",
    "Document Signing",
    "Settlement Discussion",
    "Court Preparation",
    "Follow-up Meeting"
  ];

  List<String> attorneys = [
    "Sarah Johnson, Esq.",
    "Michael Chen, Esq.",
    "Emily Davis, Esq.",
    "David Wilson, Esq.",
    "Jennifer Martinez, Esq."
  ];

  List<String> locations = [
    "Office - Conference Room A",
    "Office - Conference Room B",
    "Office - Sarah's Office",
    "Office - Michael's Office",
    "Client Location",
    "Video Call - Zoom",
    "Video Call - Teams"
  ];

  List<String> caseTypes = [
    "Personal Injury",
    "Employment Law",
    "Family Law",
    "Contract Dispute",
    "Immigration Law",
    "Criminal Defense",
    "Real Estate"
  ];

  List<String> statusFilters = ["All", "Confirmed", "Pending", "Rescheduled", "Cancelled"];

  List<Map<String, dynamic>> get filteredAppointments {
    List<Map<String, dynamic>> filtered = appointments;

    if (selectedFilter != "All") {
      filtered = filtered.where((appointment) => appointment["status"] == selectedFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((appointment) =>
          "${appointment["clientName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${appointment["appointmentType"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${appointment["caseType"]}".toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  List<Map<String, dynamic>> get todayAppointments {
    DateTime today = DateTime.now();
    return appointments.where((appointment) {
      DateTime appointmentDate = DateTime.parse("${appointment["date"]}");
      return appointmentDate.year == today.year &&
             appointmentDate.month == today.month &&
             appointmentDate.day == today.day &&
             appointment["status"] != "Cancelled";
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Rescheduled":
        return infoColor;
      case "Cancelled":
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

  void _showAppointmentDetails(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${appointment["clientName"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              // Client Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Client Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text("Name: ${appointment["clientName"]}"),
                    Text("Email: ${appointment["email"]}"),
                    Text("Phone: ${appointment["phone"]}"),
                    Text("New Client: ${appointment["isNewClient"] ? "Yes" : "No"}"),
                    Text("Referral: ${appointment["referralSource"]}"),
                  ],
                ),
              ),

              // Appointment Details
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Appointment Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text("Type: ${appointment["appointmentType"]}"),
                    Text("Date: ${DateTime.parse("${appointment["date"]}").dMMMy}"),
                    Text("Time: ${TimeOfDay.fromDateTime(DateTime.parse("${appointment["date"]}")).kkmm} - ${TimeOfDay.fromDateTime(DateTime.parse("${appointment["endTime"]}")).kkmm}"),
                    Text("Attorney: ${appointment["attorney"]}"),
                    Text("Location: ${appointment["location"]}"),
                    Text("Case Type: ${appointment["caseType"]}"),
                  ],
                ),
              ),

              // Status Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor("${appointment["status"]}").withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Status & Priority",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor("${appointment["status"]}"),
                      ),
                    ),
                    Text("Status: ${appointment["status"]}"),
                    Text("Priority: ${appointment["priority"]}"),
                    Text("Reminders Sent: ${appointment["remindersSent"]}"),
                  ],
                ),
              ),

              // Required Documents
              if (appointment["documents"] != null && (appointment["documents"] as List).isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Required Documents",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      ...(appointment["documents"] as List).map((doc) => Text("• $doc")).toList(),
                    ],
                  ),
                ),

              // Notes
              if (appointment["notes"] != null && "${appointment["notes"]}".isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Notes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text("${appointment["notes"]}"),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          if (appointment["status"] != "Cancelled")
            QButton(
              label: "Edit",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                // Edit appointment
              },
            ),
        ],
      ),
    );
  }

  void _showBookingForm() {
    // Reset form
    clientName = "";
    clientEmail = "";
    clientPhone = "";
    selectedAppointmentType = "Initial Consultation";
    appointmentDate = DateTime.now().add(Duration(days: 1));
    appointmentTime = TimeOfDay(hour: 10, minute: 0);
    selectedAttorney = "Sarah Johnson, Esq.";
    selectedLocation = "Office - Conference Room A";
    selectedCaseType = "Personal Injury";
    appointmentNotes = "";

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Book Appointment"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: spSm,
              children: [
                QTextField(
                  label: "Client Name",
                  value: clientName,
                  onChanged: (value) {
                    clientName = value;
                    setDialogState(() {});
                  },
                ),
                QTextField(
                  label: "Email",
                  value: clientEmail,
                  onChanged: (value) {
                    clientEmail = value;
                    setDialogState(() {});
                  },
                ),
                QTextField(
                  label: "Phone",
                  value: clientPhone,
                  onChanged: (value) {
                    clientPhone = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Appointment Type",
                  items: appointmentTypes.map((type) => {"label": type, "value": type}).toList(),
                  value: selectedAppointmentType,
                  onChanged: (value, label) {
                    selectedAppointmentType = value;
                    setDialogState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Date",
                        value: appointmentDate ?? DateTime.now(),
                        onChanged: (value) {
                          appointmentDate = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "Time",
                        value: appointmentTime ?? TimeOfDay.now(),
                        onChanged: (value) {
                          appointmentTime = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Attorney",
                  items: attorneys.map((attorney) => {"label": attorney, "value": attorney}).toList(),
                  value: selectedAttorney,
                  onChanged: (value, label) {
                    selectedAttorney = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Location",
                  items: locations.map((location) => {"label": location, "value": location}).toList(),
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Case Type",
                  items: caseTypes.map((type) => {"label": type, "value": type}).toList(),
                  value: selectedCaseType,
                  onChanged: (value, label) {
                    selectedCaseType = value;
                    setDialogState(() {});
                  },
                ),
                QMemoField(
                  label: "Notes",
                  value: appointmentNotes,
                  onChanged: (value) {
                    appointmentNotes = value;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Book Appointment",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Appointment booked successfully");
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showBookingForm,
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // View calendar
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
            // Today's Appointments
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Today's Appointments",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${todayAppointments.length} appointments",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (todayAppointments.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Text(
                        "No appointments scheduled for today",
                        style: TextStyle(
                          color: disabledColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  else
                    ...todayAppointments.map((appointment) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${appointment["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getStatusColor("${appointment["status"]}"),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${appointment["clientName"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${appointment["status"]}").withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${appointment["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor("${appointment["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${appointment["appointmentType"]} • ${appointment["caseType"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${TimeOfDay.fromDateTime(DateTime.parse("${appointment["date"]}")).kkmm} - ${TimeOfDay.fromDateTime(DateTime.parse("${appointment["endTime"]}")).kkmm}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.location_on,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "${appointment["location"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.info_outline,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              onPressed: () => _showAppointmentDetails(appointment),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),

            // Search and Filters
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
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search appointments...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {
                          // Perform search
                        },
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Filter by Status",
                    items: statusFilters.map((status) => {"label": status, "value": status}).toList(),
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Appointment Statistics
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Appointment Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${appointments.where((a) => a["status"] == "Confirmed").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Confirmed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${appointments.where((a) => a["status"] == "Pending").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Pending",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${appointments.where((a) => a["isNewClient"] == true).length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "New Clients",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // All Appointments List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "All Appointments",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Book New",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: _showBookingForm,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: disabledOutlineBorderColor),
                  ...filteredAppointments.map((appointment) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () => _showAppointmentDetails(appointment),
                        child: Row(
                          children: [
                            // Client Avatar
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _getStatusColor("${appointment["status"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: Text(
                                  "${appointment["clientName"]}".substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor("${appointment["status"]}"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            // Appointment Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${appointment["clientName"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${appointment["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${appointment["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor("${appointment["status"]}"),
                                          ),
                                        ),
                                      ),
                                      if (appointment["isNewClient"] == true) ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: infoColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "NEW",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: infoColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "${appointment["appointmentType"]} • ${appointment["caseType"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${DateTime.parse("${appointment["date"]}").dMMMy} at ${TimeOfDay.fromDateTime(DateTime.parse("${appointment["date"]}")).kkmm}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "${appointment["attorney"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor("${appointment["priority"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${appointment["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getPriorityColor("${appointment["priority"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Arrow Icon
                            Icon(
                              Icons.chevron_right,
                              color: disabledColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Quick Actions",
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
                        child: QButton(
                          label: "Book Appointment",
                          icon: Icons.add_circle_outline,
                          size: bs.sm,
                          onPressed: _showBookingForm,
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Send Reminders",
                          icon: Icons.notification_add,
                          size: bs.sm,
                          onPressed: () {
                            // Send appointment reminders
                          },
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
  }
}
