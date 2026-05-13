import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaBookingConfirmationView extends StatefulWidget {
  const EmaBookingConfirmationView({super.key});

  @override
  State<EmaBookingConfirmationView> createState() => _EmaBookingConfirmationViewState();
}

class _EmaBookingConfirmationViewState extends State<EmaBookingConfirmationView> {
  Map<String, dynamic> bookingData = {
    "booking_id": "EMA-2024-001567",
    "event": {
      "title": "Flutter Conference 2024",
      "date": "2024-07-15",
      "time": "09:00",
      "location": "Grand Convention Center",
      "address": "123 Tech Street, Digital City",
      "image": "https://picsum.photos/400/200?random=1&keyword=conference"
    },
    "tickets": [
      {
        "type": "Regular",
        "quantity": 2,
        "price": 150.0,
        "total": 300.0
      },
      {
        "type": "VIP",
        "quantity": 1,
        "price": 250.0,
        "total": 250.0
      }
    ],
    "attendees": [
      {
        "name": "John Doe",
        "email": "john@example.com",
        "ticket_type": "Regular"
      },
      {
        "name": "Jane Smith",
        "email": "jane@example.com", 
        "ticket_type": "Regular"
      },
      {
        "name": "Mike Johnson",
        "email": "mike@example.com",
        "ticket_type": "VIP"
      }
    ],
    "subtotal": 550.0,
    "tax": 55.0,
    "service_fee": 25.0,
    "total": 630.0,
    "payment_method": "Credit Card (**** 4567)",
    "status": "Confirmed",
    "confirmation_date": "2024-06-19T10:30:00Z"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Confirmation"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSuccessHeader(),
            _buildBookingDetails(),
            _buildEventCard(),
            _buildTicketBreakdown(),
            _buildAttendeesList(),
            _buildPaymentSummary(),
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
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            Icons.check_circle,
            color: successColor,
            size: 64,
          ),
          Text(
            "Booking Confirmed!",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Text(
            "Your booking has been successfully confirmed. You will receive an email confirmation shortly.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "Booking ID: ${bookingData["booking_id"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Booking Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Icon(Icons.confirmation_number, size: 20, color: primaryColor),
              SizedBox(width: spSm),
              Text("Booking ID"),
              Spacer(),
              Text(
                "${bookingData["booking_id"]}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, size: 20, color: primaryColor),
              SizedBox(width: spSm),
              Text("Confirmation Date"),
              Spacer(),
              Text(
                DateTime.parse("${bookingData["confirmation_date"]}").dMMMy,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.verified, size: 20, color: successColor),
              SizedBox(width: spSm),
              Text("Status"),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${bookingData["status"]}",
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard() {
    final event = bookingData["event"] as Map<String, dynamic>;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            child: Image.network(
              "${event["image"]}",
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text("${DateTime.parse(event["date"]).dMMMy}"),
                    SizedBox(width: spMd),
                    Icon(Icons.access_time, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text("${event["time"]}"),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${event["location"]}",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${event["address"]}",
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketBreakdown() {
    final tickets = bookingData["tickets"] as List;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Ticket Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...tickets.map((ticket) => Row(
            children: [
              Text("${ticket["type"]} × ${ticket["quantity"]}"),
              Spacer(),
              Text(
                "\$${((ticket["total"] as double)).currency}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildAttendeesList() {
    final attendees = bookingData["attendees"] as List;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Attendees (${attendees.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...attendees.map((attendee) => Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: primaryColor.withAlpha(50),
                  child: Text(
                    "${(attendee["name"] as String).substring(0, 1)}",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${attendee["name"]}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${attendee["email"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${attendee["ticket_type"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
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

  Widget _buildPaymentSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Payment Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text("Subtotal"),
              Spacer(),
              Text("\$${((bookingData["subtotal"] as double)).currency}"),
            ],
          ),
          Row(
            children: [
              Text("Tax"),
              Spacer(),
              Text("\$${((bookingData["tax"] as double)).currency}"),
            ],
          ),
          Row(
            children: [
              Text("Service Fee"),
              Spacer(),
              Text("\$${((bookingData["service_fee"] as double)).currency}"),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Text(
                "\$${((bookingData["total"] as double)).currency}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.payment, size: 16, color: primaryColor),
              SizedBox(width: spXs),
              Text("Paid via ${bookingData["payment_method"]}"),
            ],
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
            label: "Download Tickets",
            icon: Icons.download,
            size: bs.md,
            onPressed: () {
              ss("Tickets downloaded successfully");
            },
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "View Booking History",
            size: bs.md,
            onPressed: () {
              //navigateTo EmaBookingHistoryView
            },
          ),
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Share",
                icon: Icons.share,
                size: bs.md,
                onPressed: () {
                  ss("Booking details shared");
                },
              ),
            ),
            Expanded(
              child: QButton(
                label: "Support",
                icon: Icons.help_outline,
                size: bs.md,
                onPressed: () {
                  //navigateTo support
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
