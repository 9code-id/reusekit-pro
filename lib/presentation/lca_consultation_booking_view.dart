import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaConsultationBookingView extends StatefulWidget {
  const LcaConsultationBookingView({super.key});

  @override
  State<LcaConsultationBookingView> createState() => _LcaConsultationBookingViewState();
}

class _LcaConsultationBookingViewState extends State<LcaConsultationBookingView> {
  String searchQuery = "";
  String selectedAttorney = "";
  String selectedService = "";
  String selectedStatus = "";
  int currentTab = 0;

  // Sample data
  List<Map<String, dynamic>> consultations = [
    {
      "id": "CON-2024-001",
      "clientName": "Sarah Johnson",
      "clientEmail": "sarah.johnson@email.com",
      "clientPhone": "+1-555-0123",
      "attorneyName": "James Mitchell",
      "service": "Corporate Law",
      "consultationType": "Initial Consultation",
      "date": "2024-12-22",
      "time": "10:00 AM",
      "duration": 60,
      "status": "Confirmed",
      "fee": 300.0,
      "description": "Business incorporation and legal structure consultation",
      "priority": "High",
      "notes": "Client needs urgent advice on LLC formation",
      "location": "Conference Room A",
      "meetingType": "In-Person",
      "documents": ["Business Plan", "Partnership Agreement"],
    },
    {
      "id": "CON-2024-002",
      "clientName": "Michael Brown",
      "clientEmail": "m.brown@email.com",
      "clientPhone": "+1-555-0124",
      "attorneyName": "Lisa Thompson",
      "service": "Family Law",
      "consultationType": "Follow-up",
      "date": "2024-12-23",
      "time": "2:30 PM",
      "duration": 45,
      "status": "Pending",
      "fee": 200.0,
      "description": "Child custody arrangement review",
      "priority": "Medium",
      "notes": "Review custody modification papers",
      "location": "Virtual Meeting",
      "meetingType": "Video Call",
      "documents": ["Custody Agreement", "Court Order"],
    },
    {
      "id": "CON-2024-003",
      "clientName": "Emily Davis",
      "clientEmail": "emily.davis@email.com",
      "clientPhone": "+1-555-0125",
      "attorneyName": "Robert Wilson",
      "service": "Real Estate Law",
      "consultationType": "Property Review",
      "date": "2024-12-24",
      "time": "11:15 AM",
      "duration": 90,
      "status": "Cancelled",
      "fee": 400.0,
      "description": "Commercial property transaction review",
      "priority": "Low",
      "notes": "Client postponed due to financing issues",
      "location": "Client Office",
      "meetingType": "On-Site",
      "documents": ["Purchase Agreement", "Title Report"],
    },
  ];

  List<Map<String, dynamic>> attorneys = [
    {"label": "All Attorneys", "value": ""},
    {"label": "James Mitchell", "value": "James Mitchell"},
    {"label": "Lisa Thompson", "value": "Lisa Thompson"},
    {"label": "Robert Wilson", "value": "Robert Wilson"},
  ];

  List<Map<String, dynamic>> services = [
    {"label": "All Services", "value": ""},
    {"label": "Corporate Law", "value": "Corporate Law"},
    {"label": "Family Law", "value": "Family Law"},
    {"label": "Real Estate Law", "value": "Real Estate Law"},
    {"label": "Criminal Defense", "value": "Criminal Defense"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Cancelled", "value": "Cancelled"},
    {"label": "Completed", "value": "Completed"},
  ];

  List<Map<String, dynamic>> get filteredConsultations {
    return consultations.where((consultation) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${consultation["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${consultation["clientName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${consultation["service"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesAttorney = selectedAttorney.isEmpty || consultation["attorneyName"] == selectedAttorney;
      bool matchesService = selectedService.isEmpty || consultation["service"] == selectedService;
      bool matchesStatus = selectedStatus.isEmpty || consultation["status"] == selectedStatus;
      
      return matchesSearch && matchesAttorney && matchesService && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return successColor;
      case 'Pending':
        return warningColor;
      case 'Cancelled':
        return dangerColor;
      case 'Completed':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return dangerColor;
      case 'Medium':
        return warningColor;
      case 'Low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildConsultationCard(Map<String, dynamic> consultation) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${consultation["status"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${consultation["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${consultation["clientName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${consultation["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${consultation["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${consultation["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${consultation["attorneyName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${consultation["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${consultation["priority"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor("${consultation["priority"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.gavel, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${consultation["service"]} - ${consultation["consultationType"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${consultation["date"]} at ${consultation["time"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${consultation["duration"]} min",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${consultation["location"]} (${consultation["meetingType"]})",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "\$${(consultation["fee"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          if ("${consultation["description"]}".isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${consultation["description"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showConsultationDetails(consultation),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _showEditConsultation(consultation),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showConsultationActions(consultation),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                size: 16,
                color: successColor,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showConsultationDetails(Map<String, dynamic> consultation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Consultation Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow("ID", "${consultation["id"]}"),
              _buildDetailRow("Client", "${consultation["clientName"]}"),
              _buildDetailRow("Email", "${consultation["clientEmail"]}"),
              _buildDetailRow("Phone", "${consultation["clientPhone"]}"),
              _buildDetailRow("Attorney", "${consultation["attorneyName"]}"),
              _buildDetailRow("Service", "${consultation["service"]}"),
              _buildDetailRow("Type", "${consultation["consultationType"]}"),
              _buildDetailRow("Date & Time", "${consultation["date"]} at ${consultation["time"]}"),
              _buildDetailRow("Duration", "${consultation["duration"]} minutes"),
              _buildDetailRow("Location", "${consultation["location"]}"),
              _buildDetailRow("Meeting Type", "${consultation["meetingType"]}"),
              _buildDetailRow("Fee", "\$${(consultation["fee"] as double).currency}"),
              _buildDetailRow("Status", "${consultation["status"]}"),
              _buildDetailRow("Priority", "${consultation["priority"]}"),
              if ("${consultation["notes"]}".isNotEmpty)
                _buildDetailRow("Notes", "${consultation["notes"]}"),
              if ((consultation["documents"] as List).isNotEmpty) ...[
                SizedBox(height: spSm),
                Text(
                  "Documents:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...(consultation["documents"] as List).map((doc) => 
                  Padding(
                    padding: EdgeInsets.only(left: spSm, top: spXs),
                    child: Text("• $doc"),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
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
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showEditConsultation(Map<String, dynamic> consultation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Consultation"),
        content: Text("Edit consultation functionality would be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Consultation updated successfully");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showConsultationActions(Map<String, dynamic> consultation) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.check_circle, color: successColor),
              title: Text("Confirm Consultation"),
              onTap: () {
                Navigator.pop(context);
                ss("Consultation confirmed");
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel, color: warningColor),
              title: Text("Cancel Consultation"),
              onTap: () {
                Navigator.pop(context);
                sw("Consultation cancelled");
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule, color: infoColor),
              title: Text("Reschedule"),
              onTap: () {
                Navigator.pop(context);
                si("Reschedule dialog opened");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete"),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this consultation?");
                if (isConfirmed) {
                  se("Consultation deleted");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNewConsultationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Book New Consultation"),
        content: Text("New consultation booking form would be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("New consultation booked successfully");
            },
            child: Text("Book"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> todayConsultations = filteredConsultations.where((c) => c["date"] == "2024-12-22").map((consultation) => _buildConsultationCard(consultation)).toList();
    List<Widget> upcomingConsultations = filteredConsultations.where((c) => c["date"] != "2024-12-22").map((consultation) => _buildConsultationCard(consultation)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Consultation Booking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showNewConsultationDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Consultations", "${consultations.length}", Icons.event_available, primaryColor),
                _buildStatCard("Today's Meetings", "${todayConsultations.length}", Icons.today, successColor),
                _buildStatCard("Pending Approval", "${consultations.where((c) => c["status"] == "Pending").length}", Icons.pending_actions, warningColor),
                _buildStatCard("This Month Revenue", "\$${(consultations.fold(0.0, (sum, c) => sum + (c["fee"] as double))).currency}", Icons.attach_money, infoColor),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search consultations...",
                    value: searchQuery,
                    hint: "Search by ID, client name, or service",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Attorney",
                    items: attorneys,
                    value: selectedAttorney,
                    onChanged: (value, label) {
                      selectedAttorney = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Service",
                    items: services,
                    value: selectedService,
                    onChanged: (value, label) {
                      selectedService = value;
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
            
            SizedBox(height: spMd),
            
            // Today's Consultations
            if (todayConsultations.isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.today, color: primaryColor),
                  SizedBox(width: spXs),
                  Text(
                    "Today's Consultations",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${todayConsultations.length}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              ...todayConsultations,
              SizedBox(height: spMd),
            ],
            
            // Upcoming Consultations
            Row(
              children: [
                Icon(Icons.upcoming, color: primaryColor),
                SizedBox(width: spXs),
                Text(
                  "Upcoming Consultations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${upcomingConsultations.length}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            if (upcomingConsultations.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No upcoming consultations found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Book a new consultation to get started",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...upcomingConsultations,
          ],
        ),
      ),
    );
  }
}
