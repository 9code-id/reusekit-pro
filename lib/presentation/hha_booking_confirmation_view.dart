import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaBookingConfirmationView extends StatefulWidget {
  const HhaBookingConfirmationView({super.key});

  @override
  State<HhaBookingConfirmationView> createState() => _HhaBookingConfirmationViewState();
}

class _HhaBookingConfirmationViewState extends State<HhaBookingConfirmationView> {
  int currentStep = 0;
  bool isLoading = false;
  
  // Booking details
  Map<String, dynamic> bookingData = {
    "confirmationNumber": "HTL-2024-061501",
    "status": "Confirmed",
    "bookingDate": "2024-06-15T14:30:00",
    "totalAmount": 1440.0,
    "depositPaid": 720.0,
    "remainingBalance": 720.0,
    "paymentMethod": "Credit Card (**** 1234)",
    "cancellationPolicy": "Free cancellation until 24 hours before check-in",
    
    // Guest information
    "guest": {
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 234 567 8900",
      "nationality": "United States",
      "specialRequests": "High floor room with city view",
    },
    
    // Stay details
    "checkIn": "2024-06-20",
    "checkOut": "2024-06-25",
    "nights": 5,
    "guests": {
      "adults": 2,
      "children": 1,
      "infants": 0,
    },
    
    // Room details
    "room": {
      "number": "1205",
      "type": "Deluxe Suite",
      "floor": 12,
      "view": "City View",
      "bedType": "King Bed + Sofa Bed",
      "maxOccupancy": 4,
      "pricePerNight": 288.0,
      "amenities": [
        "Free WiFi",
        "Air Conditioning",
        "Mini Bar",
        "Room Service",
        "City View",
        "Balcony",
        "Work Desk",
        "Safe",
        "Coffee Machine",
        "Flat Screen TV"
      ],
    },
    
    // Hotel information
    "hotel": {
      "name": "Grand Palace Hotel",
      "address": "123 Luxury Boulevard, Downtown City, DC 12345",
      "phone": "+1 555 123 4567",
      "email": "reservations@grandpalace.com",
      "checkInTime": "3:00 PM",
      "checkOutTime": "11:00 AM",
      "website": "www.grandpalace.com",
    },
    
    // Additional services
    "services": [
      {
        "name": "Airport Pickup",
        "price": 45.0,
        "date": "2024-06-20",
        "time": "2:00 PM",
        "status": "Confirmed",
      },
      {
        "name": "Spa Package",
        "price": 120.0,
        "date": "2024-06-22",
        "time": "10:00 AM",
        "status": "Pending",
      },
      {
        "name": "Late Check-out",
        "price": 50.0,
        "date": "2024-06-25",
        "time": "2:00 PM",
        "status": "Requested",
      },
    ],
    
    // Booking timeline
    "timeline": [
      {
        "title": "Booking Created",
        "description": "Reservation request submitted",
        "timestamp": "2024-06-15T14:30:00",
        "status": "completed",
      },
      {
        "title": "Payment Processed",
        "description": "Deposit payment of \$720.00 processed",
        "timestamp": "2024-06-15T14:32:00",
        "status": "completed",
      },
      {
        "title": "Booking Confirmed",
        "description": "Reservation confirmed and room assigned",
        "timestamp": "2024-06-15T14:35:00",
        "status": "completed",
      },
      {
        "title": "Check-in Ready",
        "description": "Check-in available from 3:00 PM",
        "timestamp": "2024-06-20T15:00:00",
        "status": "pending",
      },
    ],
  };

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Modify Booking",
      "description": "Change dates, room type, or guest details",
      "icon": Icons.edit,
      "color": infoColor,
      "action": "modify",
    },
    {
      "title": "Add Services",
      "description": "Book additional services or amenities",
      "icon": Icons.room_service,
      "color": primaryColor,
      "action": "services",
    },
    {
      "title": "Cancel Booking",
      "description": "Cancel your reservation",
      "icon": Icons.cancel,
      "color": dangerColor,
      "action": "cancel",
    },
    {
      "title": "Contact Hotel",
      "description": "Get in touch with hotel staff",
      "icon": Icons.phone,
      "color": successColor,
      "action": "contact",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      case 'requested':
        return infoColor;
      case 'completed':
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildConfirmationHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Icon(
            Icons.check_circle,
            size: 60,
            color: Colors.white,
          ),
          SizedBox(height: spSm),
          Text(
            "Booking Confirmed!",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Confirmation #${bookingData["confirmationNumber"]}",
            style: TextStyle(
              fontSize: fsH6,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.email, color: Colors.white, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Confirmation sent to ${bookingData["guest"]["email"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingSummary() {
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
          Text(
            "Booking Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          // Hotel & Room Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/200/200?random=1&keyword=hotel"),
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
                      "${bookingData["hotel"]["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${bookingData["room"]["type"]} - Room ${bookingData["room"]["number"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${bookingData["room"]["bedType"]} • ${bookingData["room"]["view"]}",
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
          
          // Stay Details
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
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
                            DateTime.parse(bookingData["checkIn"]).dMMMy,
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${bookingData["hotel"]["checkInTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${bookingData["nights"]} nights",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Check-out",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            DateTime.parse(bookingData["checkOut"]).dMMMy,
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${bookingData["hotel"]["checkOutTime"]}",
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
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Guest Details
          Row(
            children: [
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${bookingData["guests"]["adults"]} Adults",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              if ((bookingData["guests"]["children"] as int) > 0) ...[
                Text(" • ", style: TextStyle(color: disabledBoldColor)),
                Text(
                  "${bookingData["guests"]["children"]} Children",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
              ],
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Price Breakdown
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${bookingData["nights"]} nights × \$${(bookingData["room"]["pricePerNight"] as double).currency}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${(((bookingData["nights"] as int).toDouble()) * (bookingData["room"]["pricePerNight"] as double)).currency}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                  ],
                ),
                if ((bookingData["services"] as List).isNotEmpty) ...[
                  SizedBox(height: spXs),
                  ...(bookingData["services"] as List).map((service) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${service["name"]}",
                            style: TextStyle(fontSize: 14, color: disabledBoldColor),
                          ),
                          Text(
                            "\$${(service["price"] as double).currency}",
                            style: TextStyle(fontSize: 14, color: disabledBoldColor),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${(bookingData["totalAmount"] as double).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
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

  Widget _buildPaymentInfo() {
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
          Text(
            "Payment Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              Icon(Icons.credit_card, color: successColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${bookingData["paymentMethod"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Paid",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Deposit Paid:", style: TextStyle(fontSize: 14)),
                    Text(
                      "\$${(bookingData["depositPaid"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Remaining Balance:", style: TextStyle(fontSize: 14)),
                    Text(
                      "\$${(bookingData["remainingBalance"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          if ((bookingData["remainingBalance"] as double) > 0) ...[
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Pay Remaining Balance",
                size: bs.sm,
                onPressed: () => _processRemainingPayment(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGuestDetails() {
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
          Text(
            "Guest Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: primaryColor.withAlpha(20),
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${bookingData["guest"]["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${bookingData["guest"]["email"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${bookingData["guest"]["phone"]}",
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
          
          if (bookingData["guest"]["specialRequests"] != null && 
              (bookingData["guest"]["specialRequests"] as String).isNotEmpty) ...[
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Special Requests:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${bookingData["guest"]["specialRequests"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHotelInfo() {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/200/200?random=2&keyword=hotel"),
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
                      "${bookingData["hotel"]["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${bookingData["hotel"]["address"]}",
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
          
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.phone, size: 16, color: disabledBoldColor),
                  SizedBox(width: spSm),
                  Text(
                    "${bookingData["hotel"]["phone"]}",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Icon(Icons.email, size: 16, color: disabledBoldColor),
                  SizedBox(width: spSm),
                  Text(
                    "${bookingData["hotel"]["email"]}",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Icon(Icons.language, size: 16, color: disabledBoldColor),
                  SizedBox(width: spSm),
                  Text(
                    "${bookingData["hotel"]["website"]}",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: quickActions.map((action) {
        return GestureDetector(
          onTap: () => _handleQuickAction(action["action"]),
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: action["color"],
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      action["icon"],
                      color: action["color"],
                      size: 24,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${action["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${action["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBookingTimeline() {
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
          Text(
            "Booking Timeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Column(
            children: (bookingData["timeline"] as List).asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;
              bool isLast = index == (bookingData["timeline"] as List).length - 1;
              
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: _getStatusColor(item["status"]),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item["status"] == "completed" ? Icons.check : Icons.schedule,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 40,
                          color: disabledColor,
                        ),
                    ],
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${item["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          DateTime.parse(item["timestamp"]).dMMMykkss,
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                        if (!isLast) SizedBox(height: spMd),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'modify':
        _showModifyDialog();
        break;
      case 'services':
        _showServicesDialog();
        break;
      case 'cancel':
        _showCancelDialog();
        break;
      case 'contact':
        _showContactDialog();
        break;
    }
  }

  void _showModifyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Modify Booking"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("What would you like to modify?"),
            SizedBox(height: spMd),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text("Change Dates"),
                  onTap: () {
                    Navigator.pop(context);
                    si("Redirecting to date modification...");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.room),
                  title: Text("Change Room Type"),
                  onTap: () {
                    Navigator.pop(context);
                    si("Redirecting to room selection...");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text("Change Guest Details"),
                  onTap: () {
                    Navigator.pop(context);
                    si("Redirecting to guest information...");
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showServicesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Additional Services"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Available services you can add to your booking:"),
            SizedBox(height: spMd),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.local_taxi),
                  title: Text("Airport Transfer"),
                  subtitle: Text("\$45.00"),
                ),
                ListTile(
                  leading: Icon(Icons.spa),
                  title: Text("Spa Package"),
                  subtitle: Text("\$120.00"),
                ),
                ListTile(
                  leading: Icon(Icons.restaurant),
                  title: Text("Restaurant Reservation"),
                  subtitle: Text("Free"),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "View All Services",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              si("Redirecting to services catalog...");
            },
          ),
        ],
      ),
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel Booking"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Are you sure you want to cancel this booking?"),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cancellation Policy:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${bookingData["cancellationPolicy"]}"),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Keep Booking"),
          ),
          QButton(
            label: "Cancel Booking",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              _processCancellation();
            },
          ),
        ],
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contact Hotel"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Call Hotel"),
              subtitle: Text("${bookingData["hotel"]["phone"]}"),
              onTap: () {
                Navigator.pop(context);
                ss("Calling hotel...");
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Send Email"),
              subtitle: Text("${bookingData["hotel"]["email"]}"),
              onTap: () {
                Navigator.pop(context);
                ss("Opening email client...");
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text("Live Chat"),
              subtitle: Text("Chat with hotel staff"),
              onTap: () {
                Navigator.pop(context);
                ss("Opening live chat...");
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _processRemainingPayment() async {
    setState(() {
      isLoading = true;
    });

    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      isLoading = false;
      bookingData["depositPaid"] = bookingData["totalAmount"];
      bookingData["remainingBalance"] = 0.0;
    });
    
    ss("Payment processed successfully!");
  }

  void _processCancellation() async {
    setState(() {
      isLoading = true;
    });

    // Simulate cancellation processing
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      isLoading = false;
      bookingData["status"] = "Cancelled";
    });
    
    se("Booking has been cancelled. Refund will be processed within 3-5 business days.");
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Confirmation"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => ss("Sharing booking details..."),
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => ss("Printing confirmation..."),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildConfirmationHeader(),
            SizedBox(height: spMd),
            _buildBookingSummary(),
            SizedBox(height: spMd),
            _buildPaymentInfo(),
            SizedBox(height: spMd),
            _buildGuestDetails(),
            SizedBox(height: spMd),
            _buildHotelInfo(),
            SizedBox(height: spMd),
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            _buildQuickActions(),
            SizedBox(height: spMd),
            _buildBookingTimeline(),
          ],
        ),
      ),
    );
  }
}
