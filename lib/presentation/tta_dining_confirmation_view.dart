import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaDiningConfirmationView extends StatefulWidget {
  const TtaDiningConfirmationView({super.key});

  @override
  State<TtaDiningConfirmationView> createState() => _TtaDiningConfirmationViewState();
}

class _TtaDiningConfirmationViewState extends State<TtaDiningConfirmationView> {
  bool isLoading = false;

  Map<String, dynamic> reservation = {
    "confirmationNumber": "RSV${DateTime.now().millisecondsSinceEpoch}",
    "restaurant": {
      "name": "Mama's Italian Kitchen",
      "image": "https://picsum.photos/400/200?random=1&keyword=restaurant",
      "address": "123 Main Street, Downtown",
      "phone": "+1 234-567-8901",
      "rating": 4.8,
      "cuisine": "Italian",
    },
    "date": DateTime.now().add(Duration(days: 2)).toIso8601String(),
    "time": "19:00",
    "partySize": 4,
    "seatingPreference": "Outdoor",
    "occasion": "Anniversary",
    "specialRequests": "Table by the window, birthday cake for dessert",
    "customer": {
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 555-123-4567",
    },
    "status": "Confirmed",
    "estimatedDuration": "2 hours",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reservation Confirmed"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Header
            Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: 60,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Reservation Confirmed!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Your table has been successfully reserved",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Confirmation Details Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant Header
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                    child: Image.network(
                      "${reservation["restaurant"]["image"]}",
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${reservation["restaurant"]["name"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${reservation["status"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spXs),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${reservation["restaurant"]["rating"]} • ${reservation["restaurant"]["cuisine"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spXs),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${reservation["restaurant"]["address"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
            ),

            SizedBox(height: spMd),

            // Reservation Details
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reservation Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  _buildDetailRow(
                    Icons.confirmation_number,
                    "Confirmation Number",
                    "${reservation["confirmationNumber"]}",
                  ),
                  
                  _buildDetailRow(
                    Icons.calendar_today,
                    "Date",
                    DateTime.parse("${reservation["date"]}").dMMMy,
                  ),
                  
                  _buildDetailRow(
                    Icons.access_time,
                    "Time",
                    "${reservation["time"]}",
                  ),
                  
                  _buildDetailRow(
                    Icons.people,
                    "Party Size",
                    "${reservation["partySize"]} guests",
                  ),
                  
                  _buildDetailRow(
                    Icons.event_seat,
                    "Seating",
                    "${reservation["seatingPreference"]}",
                  ),
                  
                  _buildDetailRow(
                    Icons.celebration,
                    "Occasion",
                    "${reservation["occasion"]}",
                  ),
                  
                  _buildDetailRow(
                    Icons.schedule,
                    "Estimated Duration",
                    "${reservation["estimatedDuration"]}",
                  ),
                  
                  if ("${reservation["specialRequests"]}".isNotEmpty)
                    _buildDetailRow(
                      Icons.note,
                      "Special Requests",
                      "${reservation["specialRequests"]}",
                      isMultiline: true,
                    ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Customer Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  _buildDetailRow(
                    Icons.person,
                    "Name",
                    "${reservation["customer"]["name"]}",
                  ),
                  
                  _buildDetailRow(
                    Icons.email,
                    "Email",
                    "${reservation["customer"]["email"]}",
                  ),
                  
                  _buildDetailRow(
                    Icons.phone,
                    "Phone",
                    "${reservation["customer"]["phone"]}",
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Important Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(77)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Important Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Text(
                    "• Please arrive within 15 minutes of your reservation time\n"
                    "• Your table will be held for 15 minutes past booking time\n"
                    "• To modify or cancel, contact the restaurant at least 2 hours in advance\n"
                    "• A confirmation email has been sent to your email address\n"
                    "• Present this confirmation or your confirmation number upon arrival",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Action Buttons
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add to Calendar",
                    size: bs.md,
                    onPressed: () {
                      ss("Reservation added to calendar");
                    },
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Call Restaurant",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('CallView')
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Get Directions",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('DirectionsView')
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Share",
                        size: bs.sm,
                        onPressed: () {
                          ss("Reservation details shared");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Modify Reservation",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('ModifyReservationView')
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Reminder Setup
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Set Reminder",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Text(
                    "Get notified before your reservation",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "30 min before",
                          size: bs.sm,
                          onPressed: () {
                            ss("Reminder set for 30 minutes before");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "1 hour before",
                          size: bs.sm,
                          onPressed: () {
                            ss("Reminder set for 1 hour before");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Footer
            Center(
              child: Column(
                children: [
                  Text(
                    "Thank you for choosing ${reservation["restaurant"]["name"]}!",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "We look forward to serving you",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {bool isMultiline = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            child: Icon(
              icon,
              size: 18,
              color: disabledBoldColor,
            ),
          ),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
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
}
