import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaHotelConfirmationView extends StatefulWidget {
  const TtaHotelConfirmationView({super.key});

  @override
  State<TtaHotelConfirmationView> createState() => _TtaHotelConfirmationViewState();
}

class _TtaHotelConfirmationViewState extends State<TtaHotelConfirmationView> {
  final Map<String, dynamic> bookingData = {
    "confirmationNumber": "HTL-2024-789456",
    "bookingDate": "2024-07-10",
    "status": "Confirmed",
    "hotel": {
      "name": "Grand Palace Hotel",
      "address": "123 Downtown Street, New York, NY 10001",
      "phone": "+1 (555) 123-4567",
      "email": "reservations@grandpalacehotel.com",
      "image": "https://picsum.photos/400/250?random=1&keyword=hotel"
    },
    "guest": {
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 987-6543"
    },
    "booking": {
      "room": "Deluxe Room",
      "checkIn": "2024-07-15",
      "checkOut": "2024-07-17",
      "nights": 2,
      "guests": 2,
      "roomPrice": 199,
      "totalRoomCost": 398,
      "taxes": 47.76,
      "serviceFee": 25.00,
      "totalAmount": 470.76
    },
    "specialRequests": [
      "Late check-out requested",
      "Airport transfer service",
      "High floor room preferred"
    ],
    "cancellationPolicy": "Free cancellation until 24 hours before check-in",
    "checkInTime": "3:00 PM",
    "checkOutTime": "12:00 PM"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSuccessHeader(),
            _buildConfirmationDetails(),
            _buildHotelInformation(),
            _buildBookingDetails(),
            _buildImportantInformation(),
            _buildActionButtons(),
            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            successColor,
            successColor.withAlpha(204),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.check_circle,
                color: successColor,
                size: 50,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Booking Confirmed!",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Your hotel reservation has been successfully confirmed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Text(
                "Confirmation #${bookingData["confirmationNumber"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationDetails() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Confirmation Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Icon(Icons.confirmation_number, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Confirmation Number",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${bookingData["confirmationNumber"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Copy to clipboard
                  ss("Confirmation number copied to clipboard");
                },
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.copy,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Icon(Icons.calendar_today, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(bookingData["bookingDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Icon(Icons.check_circle, color: successColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${bookingData["status"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHotelInformation() {
    final hotel = bookingData["hotel"];
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hotel Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Image.network(
                  "${hotel["image"]}",
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${hotel["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${hotel["address"]}",
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
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.phone, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${hotel["phone"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Make phone call
                },
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.call,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(Icons.email, color: primaryColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${hotel["email"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetails() {
    final booking = bookingData["booking"];
    final guest = bookingData["guest"];
    
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Guest Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Guest Information",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${guest["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${guest["email"]} • ${guest["phone"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Stay Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check-in",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(booking["checkIn"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${bookingData["checkInTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledOutlineBorderColor,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check-out",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(booking["checkOut"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${bookingData["checkOutTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Room Type",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${booking["room"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${booking["nights"]} nights, ${booking["guests"]} guests",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Special Requests
          if ((bookingData["specialRequests"] as List).isNotEmpty) ...[
            Text(
              "Special Requests",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Column(
              children: (bookingData["specialRequests"] as List).map((request) {
                return Padding(
                  padding: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "$request",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),
          ],
          
          // Price Breakdown
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${booking["roomPrice"]} x ${booking["nights"]} nights",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${booking["totalRoomCost"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Taxes & Fees",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${booking["taxes"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Service Fee",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${booking["serviceFee"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                Divider(height: spMd * 2),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Paid",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${booking["totalAmount"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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

  Widget _buildImportantInformation() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Important Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Cancellation Policy",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${bookingData["cancellationPolicy"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
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
                    Icon(Icons.access_time, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Check-in Instructions",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Please bring a valid photo ID and the credit card used for booking. Early check-in may be available for an additional fee.",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
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
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: QButton(
              label: "Download Confirmation",
              size: bs.md,
              onPressed: () {
                ss("Confirmation downloaded");
              },
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Share",
                  size: bs.md,
                  onPressed: () {
                    // Share confirmation
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add to Calendar",
                  size: bs.md,
                  onPressed: () {
                    // Add to calendar
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          GestureDetector(
            onTap: () {
              // Navigate to home
            },
            child: Text(
              "Back to Home",
              style: TextStyle(
                fontSize: 16,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
