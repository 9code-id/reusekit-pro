import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCart9View extends StatefulWidget {
  @override
  State<GrlCart9View> createState() => _GrlCart9ViewState();
}

class _GrlCart9ViewState extends State<GrlCart9View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "type": "flight",
      "title": "New York to London",
      "subtitle": "Round Trip • Economy",
      "price": 899.99,
      "originalPrice": 1099.99,
      "quantity": 2,
      "image": "https://picsum.photos/120/120?random=1&keyword=airplane",
      "details": {
        "departure": "Dec 25, 2024 at 10:30 AM",
        "return": "Jan 2, 2025 at 6:45 PM",
        "airline": "SkyLine Airways",
        "duration": "7h 30m",
        "stops": "Non-stop"
      },
      "passengers": 2,
      "baggage": "1 carry-on included",
    },
    {
      "id": 2,
      "type": "hotel",
      "title": "Grand Palace Hotel",
      "subtitle": "Deluxe Suite • 7 nights",
      "price": 299.99,
      "originalPrice": 399.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=2&keyword=hotel",
      "details": {
        "checkIn": "Dec 25, 2024",
        "checkOut": "Jan 1, 2025",
        "location": "Central London",
        "rating": "5 stars",
        "amenities": "Pool, Spa, Gym"
      },
      "passengers": 2,
      "cancellation": "Free cancellation",
    },
    {
      "id": 3,
      "type": "rental",
      "title": "Premium Car Rental",
      "subtitle": "BMW X3 • 7 days",
      "price": 89.99,
      "originalPrice": 119.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=3&keyword=car",
      "details": {
        "pickup": "Dec 25, 2024 at 2:00 PM",
        "dropoff": "Jan 1, 2025 at 12:00 PM",
        "location": "Heathrow Airport",
        "fuel": "Full to Full",
        "insurance": "Comprehensive"
      },
      "passengers": 2,
      "mileage": "Unlimited mileage",
    },
  ];

  List<Map<String, dynamic>> travelExtras = [
    {
      "id": 4,
      "name": "Travel Insurance",
      "description": "Comprehensive coverage",
      "price": 89.99,
      "image": "https://picsum.photos/80/80?random=4&keyword=insurance",
      "coverage": "Medical, Trip cancellation",
    },
    {
      "id": 5,
      "name": "Airport Lounge Access",
      "description": "Priority Pass membership",
      "price": 129.99,
      "image": "https://picsum.photos/80/80?random=5&keyword=lounge",
      "coverage": "200+ lounges worldwide",
    },
    {
      "id": 6,
      "name": "City Tour Package",
      "description": "Full day guided tour",
      "price": 79.99,
      "image": "https://picsum.photos/80/80?random=6&keyword=tour",
      "coverage": "All major attractions",
    },
  ];

  double taxesFees = 89.99;
  double bookingFee = 25.99;
  List<String> addedExtras = [];

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get extrasTotal {
    return addedExtras.length * 89.99; // Simplified calculation
  }

  double get total {
    return subtotal + extrasTotal + taxesFees + bookingFee;
  }

  void _updateQuantity(int index, int newQuantity) {
    if (newQuantity <= 0) {
      _removeItem(index);
      return;
    }
    cartItems[index]["quantity"] = newQuantity;
    setState(() {});
  }

  void _removeItem(int index) {
    cartItems.removeAt(index);
    setState(() {});
    ss("Item removed from trip");
  }

  void _addTravelExtra(Map<String, dynamic> extra) {
    addedExtras.add(extra["name"] as String);
    travelExtras.removeWhere((e) => e["id"] == extra["id"]);
    setState(() {});
    ss("${extra["name"]} added to trip");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Cart"),
        actions: [
          IconButton(
            icon: Icon(Icons.flight_takeoff),
            onPressed: () {
              //navigateTo('my_trips')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTravelHeader(),
            _buildCartItems(),
            _buildTravelExtras(),
            _buildOrderSummary(),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBookingBar(),
    );
  }

  Widget _buildTravelHeader() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.luggage,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Travel Booking Cart",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Planning your perfect trip",
                      style: TextStyle(
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shield,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Protected",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.groups,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Text(
                  "Trip for 2 passengers • 7 days",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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

  Widget _buildCartItems() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trip Components",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ...List.generate(cartItems.length, (index) {
            final item = cartItems[index];
            return _buildCartItem(item, index);
          }),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${item["image"]}",
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getTypeColor(item["type"] as String),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        _getTypeLabel(item["type"] as String),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${item["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _removeItem(index),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["subtitle"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$${((item["price"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if ((item["originalPrice"] as double) > (item["price"] as double))
                              Text(
                                "\$${((item["originalPrice"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        if (item["type"] == "flight")
                          _buildQuantitySelector(item, index),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildItemDetails(item),
        ],
      ),
    );
  }

  Widget _buildItemDetails(Map<String, dynamic> item) {
    final details = item["details"] as Map<String, dynamic>;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item["type"] == "flight") ...[
            _buildDetailRow("Departure", details["departure"] as String),
            _buildDetailRow("Return", details["return"] as String),
            _buildDetailRow("Airline", details["airline"] as String),
            _buildDetailRow("Duration", details["duration"] as String),
          ] else if (item["type"] == "hotel") ...[
            _buildDetailRow("Check-in", details["checkIn"] as String),
            _buildDetailRow("Check-out", details["checkOut"] as String),
            _buildDetailRow("Location", details["location"] as String),
            _buildDetailRow("Rating", details["rating"] as String),
          ] else if (item["type"] == "rental") ...[
            _buildDetailRow("Pickup", details["pickup"] as String),
            _buildDetailRow("Drop-off", details["dropoff"] as String),
            _buildDetailRow("Location", details["location"] as String),
            _buildDetailRow("Insurance", details["insurance"] as String),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 12,
                color: infoColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: infoColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "flight":
        return primaryColor;
      case "hotel":
        return successColor;
      case "rental":
        return warningColor;
      default:
        return infoColor;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "flight":
        return "FLIGHT";
      case "hotel":
        return "HOTEL";
      case "rental":
        return "RENTAL";
      default:
        return "SERVICE";
    }
  }

  Widget _buildQuantitySelector(Map<String, dynamic> item, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _updateQuantity(index, (item["quantity"] as int) - 1),
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.remove,
                size: 16,
                color: primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Text(
              "${item["quantity"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _updateQuantity(index, (item["quantity"] as int) + 1),
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.add,
                size: 16,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelExtras() {
    if (travelExtras.isEmpty) return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enhance Your Trip",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: List.generate(travelExtras.length, (index) {
              final extra = travelExtras[index];
              return _buildTravelExtraItem(extra);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelExtraItem(Map<String, dynamic> extra) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${extra["image"]}",
              width: double.infinity,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${extra["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${extra["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${extra["coverage"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${((extra["price"] as double)).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () => _addTravelExtra(extra),
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
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
            "Trip Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Trip components", "\$${subtotal.currency}"),
          if (extrasTotal > 0)
            _buildSummaryRow("Travel extras", "\$${extrasTotal.currency}"),
          _buildSummaryRow("Taxes & fees", "\$${taxesFees.currency}"),
          _buildSummaryRow("Booking fee", "\$${bookingFee.currency}"),
          Divider(height: spLg),
          _buildSummaryRow(
            "Total Trip Cost", 
            "\$${total.currency}",
            isTotal: true,
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.verified_user,
                  color: successColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "24/7 support • Price lock guarantee • Flexible booking",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
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

  Widget _buildSummaryRow(String label, String value, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.bold,
              color: color ?? (isTotal ? primaryColor : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: SafeArea(
        child: QButton(
          label: "Book Trip • \$${total.currency}",
          onPressed: () {
            //navigateTo('travel_confirmation')
          },
        ),
      ),
    );
  }
}
