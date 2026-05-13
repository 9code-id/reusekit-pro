import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaAppointmentHistoryView extends StatefulWidget {
  const MhaAppointmentHistoryView({super.key});

  @override
  State<MhaAppointmentHistoryView> createState() => _MhaAppointmentHistoryViewState();
}

class _MhaAppointmentHistoryViewState extends State<MhaAppointmentHistoryView> {
  String selectedFilter = "All";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> appointments = [
    {
      "id": "APT001",
      "doctor": {
        "name": "Dr. Sarah Johnson",
        "specialty": "Cardiologist",
        "image": "https://picsum.photos/300/300?random=1&keyword=doctor",
        "hospital": "City General Hospital",
      },
      "date": "2024-01-15",
      "time": "10:30",
      "type": "Consultation",
      "status": "Completed",
      "fee": 150.0,
      "rating": 5,
      "notes": "Regular checkup completed. Everything looks good.",
    },
    {
      "id": "APT002",
      "doctor": {
        "name": "Dr. Michael Chen",
        "specialty": "Dermatologist",
        "image": "https://picsum.photos/300/300?random=2&keyword=doctor",
        "hospital": "Skin Care Clinic",
      },
      "date": "2024-01-20",
      "time": "14:00",
      "type": "Follow-up",
      "status": "Confirmed",
      "fee": 120.0,
      "rating": null,
      "notes": null,
    },
    {
      "id": "APT003",
      "doctor": {
        "name": "Dr. Emily Davis",
        "specialty": "Pediatrician",
        "image": "https://picsum.photos/300/300?random=3&keyword=doctor",
        "hospital": "Children's Hospital",
      },
      "date": "2024-01-10",
      "time": "09:00",
      "type": "Vaccination",
      "status": "Cancelled",
      "fee": 80.0,
      "rating": null,
      "notes": "Appointment cancelled due to patient illness.",
    },
    {
      "id": "APT004",
      "doctor": {
        "name": "Dr. Robert Wilson",
        "specialty": "Orthopedic",
        "image": "https://picsum.photos/300/300?random=4&keyword=doctor",
        "hospital": "Sports Medicine Center",
      },
      "date": "2024-01-05",
      "time": "11:30",
      "type": "Consultation",
      "status": "Completed",
      "fee": 200.0,
      "rating": 4,
      "notes": "X-ray results reviewed. Physical therapy recommended.",
    },
    {
      "id": "APT005",
      "doctor": {
        "name": "Dr. Lisa Thompson",
        "specialty": "Gynecologist",
        "image": "https://picsum.photos/300/300?random=5&keyword=doctor",
        "hospital": "Women's Health Center",
      },
      "date": "2024-01-25",
      "time": "15:30",
      "type": "Screening",
      "status": "Confirmed",
      "fee": 180.0,
      "rating": null,
      "notes": null,
    },
  ];
  
  List<Map<String, dynamic>> get filteredAppointments {
    List<Map<String, dynamic>> filtered = appointments;
    
    // Filter by status
    if (selectedFilter != "All") {
      filtered = filtered.where((appointment) => 
        appointment["status"] == selectedFilter).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((appointment) => 
        appointment["doctor"]["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        appointment["doctor"]["specialty"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        appointment["id"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    // Sort by date (newest first)
    filtered.sort((a, b) => DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"])));
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment History"),
        actions: [
          IconButton(
            onPressed: () {
              // navigateTo(BookAppointmentView)
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            color: primaryColor.withAlpha(10),
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search appointments...",
                        value: searchQuery,
                        hint: "Doctor name, specialty, or ID",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Filter Options
                QCategoryPicker(
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Confirmed", "value": "Confirmed"},
                    {"label": "Completed", "value": "Completed"},
                    {"label": "Cancelled", "value": "Cancelled"},
                  ],
                  value: selectedFilter,
                  onChanged: (index, label, value, item) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Statistics Summary
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                _buildStatCard("Total", "${appointments.length}", primaryColor),
                SizedBox(width: spSm),
                _buildStatCard("Completed", "${appointments.where((a) => a["status"] == "Completed").length}", successColor),
                SizedBox(width: spSm),
                _buildStatCard("Upcoming", "${appointments.where((a) => a["status"] == "Confirmed").length}", warningColor),
                SizedBox(width: spSm),
                _buildStatCard("Cancelled", "${appointments.where((a) => a["status"] == "Cancelled").length}", dangerColor),
              ],
            ),
          ),
          
          // Appointments List
          Expanded(
            child: filteredAppointments.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    itemCount: filteredAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = filteredAppointments[index];
                      return _buildAppointmentCard(appointment);
                    },
                  ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color, width: 1),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    final status = appointment["status"] as String;
    Color statusColor = primaryColor;
    
    switch (status) {
      case "Completed":
        statusColor = successColor;
        break;
      case "Confirmed":
        statusColor = warningColor;
        break;
      case "Cancelled":
        statusColor = dangerColor;
        break;
    }
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${appointment["id"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Doctor Information
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${appointment["doctor"]["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              SizedBox(width: spMd),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${appointment["doctor"]["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${appointment["doctor"]["specialty"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${appointment["doctor"]["hospital"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Action Button
              GestureDetector(
                onTap: () {
                  _showAppointmentActions(appointment);
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Appointment Details
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(Icons.calendar_today, "Date", DateTime.parse(appointment["date"]).dMMMy),
              ),
              Expanded(
                child: _buildDetailItem(Icons.access_time, "Time", "${appointment["time"]}"),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(Icons.medical_services, "Type", "${appointment["type"]}"),
              ),
              Expanded(
                child: _buildDetailItem(Icons.payment, "Fee", "\$${(appointment["fee"] as double).currency}"),
              ),
            ],
          ),
          
          // Notes (if available)
          if (appointment["notes"] != null) ...[
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notes:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${appointment["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          // Rating (if completed)
          if (status == "Completed" && appointment["rating"] != null) ...[
            SizedBox(height: spMd),
            Row(
              children: [
                Text(
                  "Your Rating:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                ...List.generate(5, (index) {
                  return Icon(
                    index < (appointment["rating"] as int) ? Icons.star : Icons.star_border,
                    color: warningColor,
                    size: 16,
                  );
                }),
              ],
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 16),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(spXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: 80,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No Appointments Found",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "You don't have any appointments matching your search criteria.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Book Appointment",
            size: bs.md,
            onPressed: () {
              // navigateTo(BookAppointmentView)
            },
          ),
        ],
      ),
    );
  }
  
  void _showAppointmentActions(Map<String, dynamic> appointment) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Appointment Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              if (appointment["status"] == "Confirmed") ...[
                _buildActionButton(
                  Icons.edit,
                  "Reschedule",
                  "Change appointment date/time",
                  () {
                    Navigator.pop(context);
                    // navigateTo(RescheduleAppointmentView)
                  },
                ),
                _buildActionButton(
                  Icons.cancel,
                  "Cancel",
                  "Cancel this appointment",
                  () {
                    Navigator.pop(context);
                    // navigateTo(CancelAppointmentView)
                  },
                ),
              ],
              
              if (appointment["status"] == "Completed" && appointment["rating"] == null) ...[
                _buildActionButton(
                  Icons.star,
                  "Rate Doctor",
                  "Share your experience",
                  () {
                    Navigator.pop(context);
                    // navigateTo(RateDoctorView)
                  },
                ),
              ],
              
              _buildActionButton(
                Icons.visibility,
                "View Details",
                "See full appointment details",
                () {
                  Navigator.pop(context);
                  // navigateTo(AppointmentDetailView)
                },
              ),
              
              _buildActionButton(
                Icons.download,
                "Download Receipt",
                "Get appointment receipt",
                () {
                  Navigator.pop(context);
                  ss("Receipt downloaded successfully");
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildActionButton(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        margin: EdgeInsets.only(bottom: spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryColor, size: 24),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: disabledBoldColor, size: 16),
          ],
        ),
      ),
    );
  }
}
