import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaBookingDetailView extends StatefulWidget {
  const EmaBookingDetailView({super.key});

  @override
  State<EmaBookingDetailView> createState() => _EmaBookingDetailViewState();
}

class _EmaBookingDetailViewState extends State<EmaBookingDetailView> {
  int selectedTabIndex = 0;
  
  Map<String, dynamic> bookingData = {
    "booking_id": "EMA-2024-001567",
    "status": "Confirmed",
    "booking_date": "2024-06-19T10:30:00Z",
    "payment_method": "Credit Card (**** 4567)",
    "payment_date": "2024-06-19T10:30:00Z",
    "event": {
      "title": "Flutter Conference 2024",
      "description": "Join us for the biggest Flutter conference of the year! Learn from industry experts, network with fellow developers, and discover the latest trends in mobile development.",
      "date": "2024-07-15",
      "start_time": "09:00",
      "end_time": "18:00",
      "location": "Grand Convention Center",
      "address": "123 Tech Street, Digital City, DC 12345",
      "website": "https://flutterconf2024.com",
      "organizer": "Flutter Community",
      "contact_email": "info@flutterconf2024.com",
      "image": "https://picsum.photos/400/250?random=1&keyword=conference",
      "category": "Technology",
      "tags": ["Flutter", "Mobile Development", "Conference", "Networking"]
    },
    "tickets": [
      {
        "id": "TKT-001",
        "type": "Regular",
        "category": "General Admission",
        "quantity": 2,
        "price": 150.0,
        "total": 300.0,
        "benefits": ["Conference Access", "Lunch Included", "Welcome Kit"]
      },
      {
        "id": "TKT-002",
        "type": "VIP",
        "category": "Premium Access",
        "quantity": 1,
        "price": 250.0,
        "total": 250.0,
        "benefits": ["Conference Access", "Premium Seating", "VIP Lunch", "Networking Session", "Exclusive Swag"]
      }
    ],
    "attendees": [
      {
        "id": "ATT-001",
        "name": "John Doe",
        "email": "john@example.com",
        "phone": "+1-555-0123",
        "ticket_type": "Regular",
        "ticket_id": "TKT-001-001",
        "check_in_status": "Not Checked In",
        "dietary_requirements": "Vegetarian"
      },
      {
        "id": "ATT-002",
        "name": "Jane Smith",
        "email": "jane@example.com",
        "phone": "+1-555-0124",
        "ticket_type": "Regular",
        "ticket_id": "TKT-001-002",
        "check_in_status": "Not Checked In",
        "dietary_requirements": "None"
      },
      {
        "id": "ATT-003",
        "name": "Mike Johnson",
        "email": "mike@example.com",
        "phone": "+1-555-0125",
        "ticket_type": "VIP",
        "ticket_id": "TKT-002-001",
        "check_in_status": "Not Checked In",
        "dietary_requirements": "Gluten Free"
      }
    ],
    "pricing": {
      "subtotal": 550.0,
      "tax": 55.0,
      "service_fee": 25.0,
      "discount": 0.0,
      "total": 630.0
    },
    "refund_policy": "Refunds available up to 7 days before the event. Processing fee may apply.",
    "transfer_policy": "Tickets can be transferred to another person up to 24 hours before the event.",
    "notes": "Please arrive 30 minutes early for registration and check-in."
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Booking details shared");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatusHeader(),
          _buildTabBar(),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildStatusHeader() {
    final status = bookingData["status"] as String;
    Color statusColor;
    IconData statusIcon;
    
    switch (status) {
      case "Confirmed":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "Pending":
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        break;
      case "Cancelled":
        statusColor = dangerColor;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = primaryColor;
        statusIcon = Icons.confirmation_number;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        border: Border(
          bottom: BorderSide(color: statusColor.withAlpha(50)),
        ),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking ${status}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "ID: ${bookingData["booking_id"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "\$${((bookingData["pricing"]["total"] as double)).currency}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ["Event", "Tickets", "Attendees", "Payment"];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowXs],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isSelected = selectedTabIndex == index;
            
            return GestureDetector(
              onTap: () {
                selectedTabIndex = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spLg, vertical: spMd),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? primaryColor : disabledBoldColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return _buildEventTab();
      case 1:
        return _buildTicketsTab();
      case 2:
        return _buildAttendeesTab();
      case 3:
        return _buildPaymentTab();
      default:
        return _buildEventTab();
    }
  }

  Widget _buildEventTab() {
    final event = bookingData["event"] as Map<String, dynamic>;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusLg),
            child: Image.network(
              "${event["image"]}",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${event["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                _buildEventDetailRow(Icons.calendar_today, "Date", "${DateTime.parse(event["date"]).dMMMy}"),
                _buildEventDetailRow(Icons.access_time, "Time", "${event["start_time"]} - ${event["end_time"]}"),
                _buildEventDetailRow(Icons.location_on, "Venue", "${event["location"]}"),
                _buildEventDetailRow(Icons.place, "Address", "${event["address"]}"),
                _buildEventDetailRow(Icons.business, "Organizer", "${event["organizer"]}"),
                _buildEventDetailRow(Icons.email, "Contact", "${event["contact_email"]}"),
                _buildEventDetailRow(Icons.language, "Website", "${event["website"]}"),
                _buildEventDetailRow(Icons.category, "Category", "${event["category"]}"),
              ],
            ),
          ),
          Container(
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
                  "Tags",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: (event["tags"] as List).map((tag) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: primaryColor),
        SizedBox(width: spSm),
        Text(
          "$label:",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTicketsTab() {
    final tickets = bookingData["tickets"] as List;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: tickets.map((ticket) => Container(
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
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${ticket["type"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "× ${ticket["quantity"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                "${ticket["category"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  Text("Price per ticket:"),
                  Spacer(),
                  Text(
                    "\$${((ticket["price"] as double)).currency}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "\$${((ticket["total"] as double)).currency}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Divider(),
              Text(
                "Benefits:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              ...(ticket["benefits"] as List).map((benefit) => Row(
                children: [
                  Icon(Icons.check, size: 16, color: successColor),
                  SizedBox(width: spSm),
                  Text(
                    "$benefit",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              )),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildAttendeesTab() {
    final attendees = bookingData["attendees"] as List;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(Icons.people, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Total Attendees: ${attendees.length}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ...attendees.map((attendee) => Container(
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
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: primaryColor.withAlpha(50),
                      child: Text(
                        "${(attendee["name"] as String).substring(0, 1)}",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
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
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
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
                Divider(),
                _buildAttendeeDetailRow("Phone", "${attendee["phone"]}"),
                _buildAttendeeDetailRow("Ticket ID", "${attendee["ticket_id"]}"),
                _buildAttendeeDetailRow("Check-in Status", "${attendee["check_in_status"]}"),
                _buildAttendeeDetailRow("Dietary Requirements", "${attendee["dietary_requirements"]}"),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAttendeeDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentTab() {
    final pricing = bookingData["pricing"] as Map<String, dynamic>;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
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
                _buildPricingRow("Subtotal", pricing["subtotal"] as double),
                _buildPricingRow("Tax", pricing["tax"] as double),
                _buildPricingRow("Service Fee", pricing["service_fee"] as double),
                if ((pricing["discount"] as double) > 0)
                  _buildPricingRow("Discount", -(pricing["discount"] as double), isDiscount: true),
                Divider(),
                Row(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${((pricing["total"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
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
                  "Payment Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildPaymentDetailRow(Icons.payment, "Payment Method", "${bookingData["payment_method"]}"),
                _buildPaymentDetailRow(Icons.schedule, "Payment Date", "${DateTime.parse(bookingData["payment_date"]).dMMMy}"),
                _buildPaymentDetailRow(Icons.receipt, "Transaction ID", "${bookingData["booking_id"]}"),
              ],
            ),
          ),
          Container(
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
                  "Policies",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildPolicyRow(Icons.money_off, "Refund Policy", "${bookingData["refund_policy"]}"),
                _buildPolicyRow(Icons.swap_horiz, "Transfer Policy", "${bookingData["transfer_policy"]}"),
                if (bookingData["notes"] != null)
                  _buildPolicyRow(Icons.info, "Notes", "${bookingData["notes"]}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRow(String label, double amount, {bool isDiscount = false}) {
    return Row(
      children: [
        Text(label),
        Spacer(),
        Text(
          "${isDiscount ? '-' : ''}\$${(amount.abs()).currency}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDiscount ? successColor : null,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: primaryColor),
        SizedBox(width: spSm),
        Text(
          "$label:",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: disabledBoldColor),
          ),
        ),
      ],
    );
  }

  Widget _buildPolicyRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: primaryColor),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: spXs),
              Text(
                value,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QButton(
              label: "Download Tickets",
              icon: Icons.download,
              size: bs.md,
              onPressed: () {
                ss("Tickets downloaded successfully");
              },
            ),
          ),
          Expanded(
            child: QButton(
              label: "Manage Booking",
              icon: Icons.edit,
              size: bs.md,
              onPressed: () {
                _showManageOptions();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions() {
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
            spacing: spMd,
            children: [
              Row(
                children: [
                  Text(
                    "More Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Column(
                spacing: spSm,
                children: [
                  _buildOptionButton(Icons.email, "Email Confirmation", () {
                    Navigator.pop(context);
                    ss("Confirmation email sent");
                  }),
                  _buildOptionButton(Icons.calendar_today, "Add to Calendar", () {
                    Navigator.pop(context);
                    ss("Event added to calendar");
                  }),
                  _buildOptionButton(Icons.directions, "Get Directions", () {
                    Navigator.pop(context);
                    ss("Opening directions");
                  }),
                  _buildOptionButton(Icons.support, "Contact Support", () {
                    Navigator.pop(context);
                    //navigateTo support
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showManageOptions() {
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
            spacing: spMd,
            children: [
              Row(
                children: [
                  Text(
                    "Manage Booking",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Column(
                spacing: spSm,
                children: [
                  _buildOptionButton(Icons.swap_horiz, "Transfer Tickets", () {
                    Navigator.pop(context);
                    //navigateTo EmaTicketTransferView
                  }),
                  _buildOptionButton(Icons.money_off, "Request Refund", () {
                    Navigator.pop(context);
                    //navigateTo EmaTicketRefundView
                  }),
                  _buildOptionButton(Icons.edit, "Update Attendee Info", () {
                    Navigator.pop(context);
                    //navigateTo EmaAttendeeManagementView
                  }),
                  _buildOptionButton(Icons.qr_code, "Show QR Codes", () {
                    Navigator.pop(context);
                    //navigateTo EmaQrScannerView
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          border: Border.all(color: disabledOutlineBorderColor),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryColor),
            SizedBox(width: spSm),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
          ],
        ),
      ),
    );
  }
}
