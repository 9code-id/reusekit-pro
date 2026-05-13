import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlConfirmation2View extends StatefulWidget {
  @override
  State<GrlConfirmation2View> createState() => _GrlConfirmation2ViewState();
}

class _GrlConfirmation2ViewState extends State<GrlConfirmation2View> {
  String appointmentId = "APT-2024-005678";
  String doctorName = "Dr. Sarah Martinez";
  String specialty = "Cardiologist";
  String appointmentDate = "2024-02-20";
  String appointmentTime = "14:30";
  String duration = "30 minutes";
  String clinicName = "Heart Care Medical Center";
  String clinicAddress = "456 Medical Plaza, Suite 201\nDowntown, NY 10002";
  String patientName = "John Smith";
  String patientPhone = "+1 (555) 123-4567";
  String patientEmail = "john.smith@email.com";
  String reason = "Regular check-up and blood pressure monitoring";
  String notes = "Please bring your insurance card and previous test results";
  bool reminderSet = true;
  String insuranceProvider = "Blue Cross Blue Shield";
  double consultationFee = 150.00;
  double copay = 25.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Confirmed"),
        actions: [
          QButton(
            icon: Icons.calendar_month,
            size: bs.sm,
            onPressed: () => _addToCalendar(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSuccessHeader(),
            _buildAppointmentDetails(),
            _buildDoctorInfo(),
            _buildClinicInfo(),
            _buildPatientInfo(),
            _buildPaymentInfo(),
            _buildPreparationInstructions(),
            _buildReminderSettings(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, successColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_hospital,
              size: 48,
              color: successColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Appointment Confirmed!",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Your medical appointment has been scheduled",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(230),
              fontSize: 16,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "Appointment #$appointmentId",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fsH6,
              ),
            ),
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
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Appointment Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(100)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateTime.parse(appointmentDate).dMMMy}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "at $appointmentTime ($duration)",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: primaryColor.withAlpha(100)),
                Row(
                  children: [
                    Icon(Icons.medical_services, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Reason: $reason",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
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
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Healthcare Provider",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage("https://picsum.photos/100/100?random=1&keyword=doctor"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      specialty,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "4.8 (127 reviews)",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () => _contactDoctor(),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "Board-certified cardiologist with 15+ years of experience specializing in preventive cardiology and heart disease management.",
              style: TextStyle(
                color: infoColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Clinic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow(Icons.local_hospital, "Clinic", clinicName),
          _buildInfoRow(Icons.location_on, "Address", clinicAddress),
          _buildInfoRow(Icons.phone, "Phone", "+1 (555) 987-6543"),
          _buildInfoRow(Icons.local_parking, "Parking", "Free parking available on-site"),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, color: disabledBoldColor, size: 32),
                  Text(
                    "Clinic Location Map",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
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
        spacing: spSm,
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
          _buildInfoRow(Icons.person, "Patient Name", patientName),
          _buildInfoRow(Icons.phone, "Phone", patientPhone),
          _buildInfoRow(Icons.email, "Email", patientEmail),
          _buildInfoRow(Icons.health_and_safety, "Insurance", insuranceProvider),
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
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Consultation Fee:", style: TextStyle(fontWeight: FontWeight.w600)),
              Text("\$${consultationFee.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Insurance Copay:", style: TextStyle(color: disabledBoldColor)),
              Text("\$${copay.toStringAsFixed(2)}", style: TextStyle(color: disabledBoldColor)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Responsibility:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${copay.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: successColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Payment will be collected at the time of your visit. We accept cash, cards, and HSA/FSA.",
                    style: TextStyle(
                      color: successColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreparationInstructions() {
    List<String> instructions = [
      "Arrive 15 minutes early for check-in",
      "Bring a valid photo ID and insurance card",
      "Bring a list of current medications",
      "Bring previous test results if available",
      "Wear comfortable clothing",
      "Fast for 12 hours if blood work is needed",
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preparation Instructions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (notes.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      notes,
                      style: TextStyle(
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ...instructions.map((instruction) => Container(
            margin: EdgeInsets.only(bottom: spXs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    instruction,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildReminderSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reminder Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Send appointment reminders",
                "value": true,
                "checked": reminderSet,
              }
            ],
            value: [
              if (reminderSet)
                {
                  "label": "Send appointment reminders",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              reminderSet = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (reminderSet)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications, color: infoColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Reminder Schedule",
                        style: TextStyle(
                          color: infoColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• 24 hours before appointment\n• 2 hours before appointment\n• SMS and email notifications",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Add to Calendar",
            size: bs.md,
            onPressed: () => _addToCalendar(),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Reschedule",
                size: bs.sm,
                onPressed: () => _rescheduleAppointment(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Cancel",
                size: bs.sm,
                onPressed: () => _cancelAppointment(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Get Directions",
                size: bs.sm,
                onPressed: () => _getDirections(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Contact Clinic",
                size: bs.sm,
                onPressed: () => _contactClinic(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _addToCalendar() {
    ss("Appointment added to calendar successfully!");
  }

  void _contactDoctor() {
    ss("Opening message to doctor...");
  }

  void _rescheduleAppointment() {
    si("Redirecting to reschedule options...");
  }

  void _cancelAppointment() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this appointment?");
    if (isConfirmed) {
      ss("Appointment cancelled successfully");
    }
  }

  void _getDirections() {
    si("Opening directions to clinic...");
  }

  void _contactClinic() {
    si("Contacting clinic...");
  }
}
