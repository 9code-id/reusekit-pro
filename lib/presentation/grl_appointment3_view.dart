import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAppointment3View extends StatefulWidget {
  @override
  State<GrlAppointment3View> createState() => _GrlAppointment3ViewState();
}

class _GrlAppointment3ViewState extends State<GrlAppointment3View> {
  Map<String, dynamic> appointment = {
    "id": "APT001",
    "patientName": "Sarah Johnson",
    "patientPhone": "+1 (555) 123-4567",
    "patientEmail": "sarah.johnson@email.com",
    "doctorName": "Dr. Michael Chen",
    "doctorSpecialty": "Cardiology",
    "doctorPhone": "+1 (555) 987-6543",
    "doctorAvatar": "https://picsum.photos/100/100?random=1&keyword=doctor",
    "date": "2024-01-15",
    "time": "09:00",
    "duration": "30 min",
    "type": "Check-up",
    "status": "confirmed",
    "location": "CardioHealth Medical Center",
    "address": "123 Medical Plaza, Suite 400, New York, NY 10001",
    "notes": "Regular cardiac check-up and blood pressure monitoring. Please bring previous test results.",
    "consultationFee": 120.0,
    "isPaid": true,
    "reminderSet": true,
    "createdAt": "2024-01-10T14:30:00Z"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Details"),
        actions: [
          GestureDetector(
            onTap: () {
              _showAppointmentMenu();
            },
            child: Icon(
              Icons.more_vert,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildStatusCard(),
            _buildDoctorInfo(),
            _buildAppointmentDetails(),
            _buildPatientInfo(),
            _buildLocationInfo(),
            _buildNotesSection(),
            _buildPaymentInfo(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    Color statusColor = _getStatusColor(appointment["status"]);
    IconData statusIcon = _getStatusIcon(appointment["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: statusColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              statusIcon,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Appointment ${appointment["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                Text(
                  "ID: ${appointment["id"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
          if (appointment["reminderSet"])
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spXs,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_active,
                    size: 12,
                    color: infoColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Reminder Set",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_hospital,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Doctor Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${appointment["doctorAvatar"]}",
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${appointment["doctorName"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${appointment["doctorSpecialty"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${appointment["doctorPhone"]}",
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
              Column(
                spacing: spXs,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Call doctor
                      ss("Calling ${appointment["doctorName"]}");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.phone,
                        color: successColor,
                        size: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Message doctor
                      ss("Messaging ${appointment["doctorName"]}");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.message,
                        color: infoColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.event,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Appointment Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildDetailItem(
                Icons.calendar_today,
                "Date",
                DateTime.parse(appointment["date"]).dMMMy,
              ),
              _buildDetailItem(
                Icons.access_time,
                "Time",
                "${appointment["time"]}",
              ),
              _buildDetailItem(
                Icons.schedule,
                "Duration",
                "${appointment["duration"]}",
              ),
              _buildDetailItem(
                Icons.medical_services,
                "Type",
                "${appointment["type"]}",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Patient Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildInfoRow(Icons.person, "Name", "${appointment["patientName"]}"),
          _buildInfoRow(Icons.phone, "Phone", "${appointment["patientPhone"]}"),
          _buildInfoRow(Icons.email, "Email", "${appointment["patientEmail"]}"),
        ],
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Location",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildInfoRow(Icons.business, "Clinic", "${appointment["location"]}"),
          _buildInfoRow(Icons.place, "Address", "${appointment["address"]}"),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Get Directions",
                  size: bs.sm,
                  icon: Icons.directions,
                  onPressed: () {
                    ss("Opening directions to ${appointment["location"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Call Clinic",
                  size: bs.sm,
                  icon: Icons.phone,
                  color: successColor,
                  onPressed: () {
                    ss("Calling ${appointment["location"]}");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.note,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Appointment Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              "${appointment["notes"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.payment,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Payment Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Consultation Fee:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${(appointment["consultationFee"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Status:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: appointment["isPaid"] 
                      ? successColor.withAlpha(20) 
                      : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  appointment["isPaid"] ? "PAID" : "PENDING",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: appointment["isPaid"] ? successColor : warningColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        SizedBox(
          width: 60,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    if (appointment["status"] == "completed" || appointment["status"] == "cancelled") {
      return Container(
        width: double.infinity,
        child: QButton(
          label: "Book New Appointment",
          size: bs.md,
          onPressed: () {
            // Navigate to booking page
          },
        ),
      );
    }
    
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Reschedule",
                size: bs.md,
                color: warningColor,
                onPressed: () {
                  ss("Rescheduling appointment");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Cancel",
                size: bs.md,
                color: dangerColor,
                onPressed: () {
                  _cancelAppointment();
                },
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Join Video Call",
            size: bs.md,
            icon: Icons.video_call,
            onPressed: () {
              ss("Joining video consultation");
            },
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'completed':
        return infoColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'confirmed':
        return Icons.check_circle;
      case 'pending':
        return Icons.schedule;
      case 'completed':
        return Icons.task_alt;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  void _showAppointmentMenu() {
    ss("Showing appointment menu options");
  }

  void _cancelAppointment() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this appointment?");
    if (isConfirmed) {
      appointment["status"] = "cancelled";
      setState(() {});
      ss("Appointment cancelled successfully");
    }
  }
}
