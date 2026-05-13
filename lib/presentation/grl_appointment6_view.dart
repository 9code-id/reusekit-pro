import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAppointment6View extends StatefulWidget {
  @override
  State<GrlAppointment6View> createState() => _GrlAppointment6ViewState();
}

class _GrlAppointment6ViewState extends State<GrlAppointment6View> {
  Map<String, dynamic> appointment = {
    "id": "APT-2024-001",
    "doctor": "Dr. Sarah Johnson",
    "specialty": "Cardiologist",
    "date": "2024-01-15",
    "time": "09:00",
    "duration": "30 minutes",
    "location": "Room 301, Medical Center",
    "address": "123 Healthcare Ave, Medical District",
    "phone": "+1 (555) 123-4567",
    "status": "confirmed",
    "type": "consultation",
    "fee": 150.0,
    "patient": "John Doe",
    "patientId": "P12345",
    "notes": "Follow-up for cardiac evaluation. Patient has been experiencing chest pain.",
    "instructions": "Please arrive 15 minutes early. Bring your insurance card and ID.",
    "doctorImage": "https://picsum.photos/100/100?random=1&keyword=doctor",
    "qrCode": "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=APT-2024-001",
  };

  bool showQRCode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Details"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              ss("Appointment details shared");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Appointment Confirmed",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "ID: ${appointment["id"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.qr_code,
                    size: bs.sm,
                    onPressed: () {
                      showQRCode = !showQRCode;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            if (showQRCode) ...[
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "QR Code for Check-in",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Image.network(
                      "${appointment["qrCode"]}",
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Show this QR code at the reception",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: spLg),

            // Doctor Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Doctor Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          image: DecorationImage(
                            image: NetworkImage("${appointment["doctorImage"]}"),
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
                              "${appointment["doctor"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${appointment["specialty"]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "4.9 (127 reviews)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Profile",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Contact",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Appointment Details
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
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
                  SizedBox(height: spMd),

                  _buildDetailRow(
                    Icons.calendar_today,
                    "Date",
                    DateTime.parse("${appointment["date"]}").dMMMy,
                  ),
                  
                  _buildDetailRow(
                    Icons.access_time,
                    "Time",
                    "${appointment["time"]}",
                  ),
                  
                  _buildDetailRow(
                    Icons.timer,
                    "Duration",
                    "${appointment["duration"]}",
                  ),
                  
                  _buildDetailRow(
                    Icons.medical_services,
                    "Type",
                    "${appointment["type"]}".toUpperCase(),
                  ),
                  
                  _buildDetailRow(
                    Icons.person,
                    "Patient",
                    "${appointment["patient"]} (${appointment["patientId"]})",
                  ),
                  
                  _buildDetailRow(
                    Icons.attach_money,
                    "Fee",
                    "\$${((appointment["fee"] as num).toDouble()).currency}",
                    valueColor: successColor,
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Location Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  _buildDetailRow(
                    Icons.location_on,
                    "Room",
                    "${appointment["location"]}",
                  ),
                  
                  _buildDetailRow(
                    Icons.home,
                    "Address",
                    "${appointment["address"]}",
                  ),
                  
                  _buildDetailRow(
                    Icons.phone,
                    "Phone",
                    "${appointment["phone"]}",
                  ),

                  SizedBox(height: spMd),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Get Directions",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Call Clinic",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Notes and Instructions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notes & Instructions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  if ("${appointment["notes"]}".isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: infoColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Patient Notes",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${appointment["notes"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                  ],

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: warningColor.withAlpha(30),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Important Instructions",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${appointment["instructions"]}",
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

            SizedBox(height: spLg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reschedule",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to cancel this appointment?");
                      if (isConfirmed) {
                        showLoading();
                        await Future.delayed(Duration(seconds: 2));
                        hideLoading();
                        ss("Appointment cancelled successfully");
                        back();
                      }
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Add to Calendar
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add to Calendar",
                size: bs.md,
                onPressed: () {
                  ss("Event added to calendar");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
