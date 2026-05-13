import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReceipt6View extends StatefulWidget {
  @override
  State<GrlReceipt6View> createState() => _GrlReceipt6ViewState();
}

class _GrlReceipt6ViewState extends State<GrlReceipt6View> {
  Map<String, dynamic> receipt = {
    "id": "HTL-2024-789",
    "confirmation": "CNF-ABC123",
    "hotel": "Grand Plaza Hotel",
    "address": "789 Luxury Avenue, Downtown",
    "phone": "+1 555 987 6543",
    "email": "reservations@grandplaza.com",
    "website": "www.grandplaza.com",
    "guest": {
      "name": "Robert Johnson",
      "email": "robert.j@email.com",
      "phone": "+1 555 123 9876",
      "address": "123 Travel Street, Explorer City"
    },
    "booking": {
      "check_in": "2024-06-20",
      "check_out": "2024-06-22",
      "nights": 2,
      "adults": 2,
      "children": 1,
      "room_type": "Deluxe Ocean View Suite",
      "room_number": "1205"
    },
    "services": [
      {"name": "Room Charges (2 nights)", "qty": 2, "price": 299.00, "total": 598.00},
      {"name": "Resort Fee", "qty": 2, "price": 35.00, "total": 70.00},
      {"name": "Breakfast Buffet", "qty": 3, "price": 28.00, "total": 84.00},
      {"name": "Spa Treatment", "qty": 1, "price": 150.00, "total": 150.00},
      {"name": "Room Service", "qty": 2, "price": 45.00, "total": 90.00},
      {"name": "Parking", "qty": 2, "price": 25.00, "total": 50.00}
    ],
    "subtotal": 1042.00,
    "tax": 124.44,
    "service_charge": 52.10,
    "total": 1218.54,
    "payment_method": "Credit Card",
    "card_number": "**** 5678",
    "folio": "F-789456"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Receipt"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.hotel),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.rate_review),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowLg],
          ),
          child: Column(
            children: [
              _buildHotelHeader(),
              _buildBookingInfo(),
              _buildGuestInfo(),
              _buildRoomDetails(),
              _buildServicesList(),
              _buildChargesSummary(),
              _buildPaymentInfo(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHotelHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple[700]!, Colors.indigo[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusLg),
          topRight: Radius.circular(radiusLg),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.hotel,
              color: Colors.purple[700],
              size: 48,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "${receipt["hotel"]}",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${receipt["address"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(220),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                color: Colors.white.withAlpha(200),
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${receipt["phone"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(220),
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.language,
                color: Colors.white.withAlpha(200),
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${receipt["website"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(220),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking Reference",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${receipt["confirmation"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long,
                  color: Colors.purple[600],
                  size: 20,
                ),
                SizedBox(height: spXs),
                Text(
                  "Folio: ${receipt["folio"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestInfo() {
    final guest = receipt["guest"] as Map<String, dynamic>;
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.purple[600],
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "GUEST INFORMATION",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[700],
                  letterSpacing: 1,
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
                      "Primary Guest",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${guest["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[700],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${guest["email"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${guest["phone"]}",
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
        ],
      ),
    );
  }

  Widget _buildRoomDetails() {
    final booking = receipt["booking"] as Map<String, dynamic>;
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.hotel_class,
                color: Colors.indigo[600],
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "ACCOMMODATION DETAILS",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[700],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: Colors.indigo[200]!,
                width: 1,
              ),
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
                            "Room Type",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${booking["room_type"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Room ${booking["room_number"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildStayDetail("Check-in", "${booking["check_in"]}", Icons.login),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.indigo[200],
                    ),
                    Expanded(
                      child: _buildStayDetail("Check-out", "${booking["check_out"]}", Icons.logout),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.indigo[200],
                    ),
                    Expanded(
                      child: _buildStayDetail("Nights", "${booking["nights"]}", Icons.nights_stay),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGuestCount("Adults", (booking["adults"] as int)),
                    SizedBox(width: spLg),
                    _buildGuestCount("Children", (booking["children"] as int)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStayDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.indigo[600],
          size: 20,
        ),
        SizedBox(height: spXs),
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
            fontWeight: FontWeight.bold,
            color: Colors.indigo[700],
          ),
        ),
      ],
    );
  }

  Widget _buildGuestCount(String label, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          label == "Adults" ? Icons.person : Icons.child_care,
          color: Colors.indigo[600],
          size: 16,
        ),
        SizedBox(width: spXs),
        Text(
          "$count $label",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.indigo[700],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesList() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.room_service,
                color: Colors.purple[600],
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "CHARGES & SERVICES",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[700],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.purple[200]!,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusLg),
                      topRight: Radius.circular(radiusLg),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "DESCRIPTION",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "QTY",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "RATE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "AMOUNT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...List.generate((receipt["services"] as List).length, (index) {
                  final service = (receipt["services"] as List)[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.white : Colors.purple[25],
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.purple[100]!,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "${service["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${service["qty"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "\$${(service["price"] as double).toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "\$${(service["total"] as double).toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.purple[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChargesSummary() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple[50]!, Colors.indigo[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.purple[200]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            "BILLING SUMMARY",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.purple[700],
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Subtotal", (receipt["subtotal"] as double)),
          SizedBox(height: spSm),
          _buildSummaryRow("Service Charge (5%)", (receipt["service_charge"] as double)),
          SizedBox(height: spSm),
          _buildSummaryRow("Tax & Fees", (receipt["tax"] as double)),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.symmetric(vertical: spMd),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.purple[400]!,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TOTAL AMOUNT",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
                Text(
                  "\$${(receipt["total"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.purple[700],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.green[300]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green[600],
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "PAYMENT PROCESSED",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Method:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: Colors.green[600],
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${receipt["payment_method"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Card Number:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${receipt["card_number"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(spLg),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[100]!, Colors.indigo[100]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Text(
                  "🏨 Thank You for Staying With Us! 🏨",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "We hope you enjoyed your stay at Grand Plaza Hotel",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple[700],
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple[200],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rate,
                            color: Colors.purple[700],
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Rate Your Stay",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.purple[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo[200],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.book_online,
                            color: Colors.indigo[700],
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Book Again",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.indigo[700],
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
          Text(
            "For assistance or future reservations:",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${receipt["phone"]} | ${receipt["email"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.purple[600],
            ),
          ),
        ],
      ),
    );
  }
}
