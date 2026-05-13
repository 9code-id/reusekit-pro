import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCart8View extends StatefulWidget {
  @override
  State<GrlCart8View> createState() => _GrlCart8ViewState();
}

class _GrlCart8ViewState extends State<GrlCart8View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Professional Photography Session",
      "provider": "Creative Studios",
      "price": 299.99,
      "originalPrice": 399.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=1&keyword=camera",
      "duration": "2 hours",
      "category": "Photography",
      "rating": 4.9,
      "includes": ["50 edited photos", "Online gallery", "Print release"],
      "addOns": [],
      "date": "2024-12-25",
      "time": "10:00 AM",
    },
    {
      "id": 2,
      "name": "Hair Styling & Makeup",
      "provider": "Beauty Experts",
      "price": 149.99,
      "originalPrice": 179.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=2&keyword=makeup",
      "duration": "3 hours",
      "category": "Beauty",
      "rating": 4.8,
      "includes": ["Hair styling", "Full makeup", "Touch-up kit"],
      "addOns": ["Nail art (+\$25)"],
      "date": "2024-12-25",
      "time": "8:00 AM",
    },
    {
      "id": 3,
      "name": "Personal Training Session",
      "provider": "FitLife Trainers",
      "price": 89.99,
      "originalPrice": 99.99,
      "quantity": 3,
      "image": "https://picsum.photos/120/120?random=3&keyword=fitness",
      "duration": "1 hour",
      "category": "Fitness",
      "rating": 4.7,
      "includes": ["Personalized workout", "Nutrition advice", "Progress tracking"],
      "addOns": [],
      "date": "2024-12-26",
      "time": "6:00 PM",
    },
  ];

  List<Map<String, dynamic>> availableAddOns = [
    {
      "id": 1,
      "serviceId": 1,
      "name": "Additional 1 hour session",
      "price": 150.0,
      "description": "Extend your photography session",
    },
    {
      "id": 2,
      "serviceId": 1,
      "name": "Rush delivery (24 hours)",
      "price": 75.0,
      "description": "Get your photos next day",
    },
    {
      "id": 3,
      "serviceId": 2,
      "name": "False eyelashes",
      "price": 35.0,
      "description": "Premium lash application",
    },
  ];

  List<Map<String, dynamic>> relatedServices = [
    {
      "id": 4,
      "name": "Video Recording",
      "provider": "Media Pro",
      "price": 199.99,
      "image": "https://picsum.photos/100/100?random=4&keyword=video",
      "rating": 4.6,
      "duration": "2 hours",
    },
    {
      "id": 5,
      "name": "Event Planning",
      "provider": "Party Planners",
      "price": 349.99,
      "image": "https://picsum.photos/100/100?random=5&keyword=party",
      "rating": 4.8,
      "duration": "Full day",
    },
  ];

  double serviceFee = 15.99;
  double bookingFee = 5.99;

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get addOnTotal {
    double total = 0.0;
    for (var item in cartItems) {
      final addOns = item["addOns"] as List;
      for (var addOn in addOns) {
        if (addOn.contains("+\$")) {
          final priceStr = addOn.split("+\$")[1].split(")")[0];
          total += double.tryParse(priceStr) ?? 0.0;
        }
      }
    }
    return total;
  }

  double get total {
    return subtotal + addOnTotal + serviceFee + bookingFee;
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
    ss("Service removed from cart");
  }

  void _addAddOn(Map<String, dynamic> addOn) {
    final serviceIndex = cartItems.indexWhere((item) => item["id"] == addOn["serviceId"]);
    if (serviceIndex != -1) {
      final addOns = cartItems[serviceIndex]["addOns"] as List;
      addOns.add("${addOn["name"]} (+\$${addOn["price"]})");
      setState(() {});
      ss("Add-on included");
    }
  }

  void _addRelatedService(Map<String, dynamic> service) {
    cartItems.add({
      "id": service["id"],
      "name": service["name"],
      "provider": service["provider"],
      "price": service["price"],
      "originalPrice": service["price"],
      "quantity": 1,
      "image": service["image"],
      "duration": service["duration"],
      "category": "Related Service",
      "rating": service["rating"],
      "includes": ["Service as described"],
      "addOns": [],
      "date": "2024-12-25",
      "time": "TBD",
    });
    relatedServices.removeWhere((s) => s["id"] == service["id"]);
    setState(() {});
    ss("${service["name"]} added to cart");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Booking"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              //navigateTo('calendar')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildServiceHeader(),
            _buildCartItems(),
            _buildAddOns(),
            if (relatedServices.isNotEmpty) _buildRelatedServices(),
            _buildOrderSummary(),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBookingBar(),
    );
  }

  Widget _buildServiceHeader() {
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
      child: Row(
        children: [
          Icon(
            Icons.calendar_month,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Service Booking Cart",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${cartItems.length} services scheduled",
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
            child: Text(
              "Premium",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
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
            "Booked Services",
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
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${item["image"]}",
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
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
                    SizedBox(height: spSm),
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["provider"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${item["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "•",
                          style: TextStyle(color: disabledColor),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${item["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
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
                        _buildQuantitySelector(item, index),
                      ],
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
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: infoColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Scheduled: ${item["date"]} at ${item["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Includes: ${(item["includes"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
                if ((item["addOns"] as List).isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Text(
                    "Add-ons: ${(item["addOns"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(Map<String, dynamic> item, int index) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
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
                size: 18,
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
                color: primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _updateQuantity(index, (item["quantity"] as int) + 1),
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.add,
                size: 18,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddOns() {
    if (availableAddOns.isEmpty) return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Add-ons",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ...List.generate(availableAddOns.length, (index) {
            final addOn = availableAddOns[index];
            return _buildAddOnItem(addOn);
          }),
        ],
      ),
    );
  }

  Widget _buildAddOnItem(Map<String, dynamic> addOn) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${addOn["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${addOn["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "+\$${((addOn["price"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Add",
            size: bs.sm,
            onPressed: () => _addAddOn(addOn),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedServices() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complete Your Experience",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: List.generate(relatedServices.length, (index) {
              final service = relatedServices[index];
              return _buildRelatedServiceItem(service);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedServiceItem(Map<String, dynamic> service) {
    return Container(
      width: 200,
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
              "${service["image"]}",
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${service["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${service["provider"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 12,
                color: warningColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${service["rating"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "• ${service["duration"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${((service["price"] as double)).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () => _addRelatedService(service),
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
            "Booking Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Service total", "\$${subtotal.currency}"),
          if (addOnTotal > 0)
            _buildSummaryRow("Add-ons", "\$${addOnTotal.currency}"),
          _buildSummaryRow("Service fee", "\$${serviceFee.currency}"),
          _buildSummaryRow("Booking fee", "\$${bookingFee.currency}"),
          Divider(height: spLg),
          _buildSummaryRow(
            "Total Amount", 
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
                  Icons.security,
                  color: successColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "100% satisfaction guarantee • Free cancellation up to 24 hours",
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
          label: "Confirm Booking • \$${total.currency}",
          onPressed: () {
            //navigateTo('booking_confirmation')
          },
        ),
      ),
    );
  }
}
