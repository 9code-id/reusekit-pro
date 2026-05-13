import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReceipt3View extends StatefulWidget {
  @override
  State<GrlReceipt3View> createState() => _GrlReceipt3ViewState();
}

class _GrlReceipt3ViewState extends State<GrlReceipt3View> {
  Map<String, dynamic> receipt = {
    "id": "REST-789",
    "table": "Table 12",
    "date": "2024-06-22",
    "time": "19:30",
    "restaurant": "Bella Italia",
    "address": "789 Gourmet Street, Food District",
    "phone": "+1 555 234 5678",
    "server": "Maria Rodriguez",
    "guests": 4,
    "items": [
      {
        "category": "Appetizers",
        "items": [
          {"name": "Bruschetta", "qty": 2, "price": 12.50},
          {"name": "Caesar Salad", "qty": 1, "price": 14.99},
        ]
      },
      {
        "category": "Main Course",
        "items": [
          {"name": "Margherita Pizza", "qty": 1, "price": 18.99},
          {"name": "Spaghetti Carbonara", "qty": 2, "price": 22.50},
          {"name": "Grilled Salmon", "qty": 1, "price": 28.99},
        ]
      },
      {
        "category": "Beverages",
        "items": [
          {"name": "House Wine Red", "qty": 2, "price": 8.50},
          {"name": "Sparkling Water", "qty": 4, "price": 3.25},
          {"name": "Espresso", "qty": 3, "price": 4.50},
        ]
      },
      {
        "category": "Desserts",
        "items": [
          {"name": "Tiramisu", "qty": 2, "price": 9.99},
          {"name": "Gelato", "qty": 1, "price": 6.50},
        ]
      }
    ],
    "subtotal": 189.23,
    "service_charge": 18.92,
    "tax": 20.82,
    "tip": 25.00,
    "total": 253.97,
    "payment_method": "Cash"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Receipt"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.receipt),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.star_rate),
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
              _buildRestaurantHeader(),
              _buildTableInfo(),
              _buildMenuItems(),
              _buildBillSummary(),
              _buildPaymentInfo(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red[600]!, Colors.orange[400]!],
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
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.restaurant,
              color: Colors.red[600],
              size: 48,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "${receipt["restaurant"]}",
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
          SizedBox(height: spXs),
          Text(
            "${receipt["phone"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(220),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.orange[50],
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
            child: Row(
              children: [
                Icon(
                  Icons.table_restaurant,
                  color: Colors.orange[600],
                  size: 20,
                ),
                SizedBox(width: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${receipt["table"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[700],
                      ),
                    ),
                    Text(
                      "${receipt["guests"]} Guests",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${receipt["date"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange[700],
                ),
              ),
              Text(
                "${receipt["time"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.orange[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ORDER DETAILS",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.orange[700],
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: spMd),
          ...List.generate((receipt["items"] as List).length, (categoryIndex) {
            final category = (receipt["items"] as List)[categoryIndex];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: spSm,
                    horizontal: spMd,
                  ),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${category["category"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[700],
                    ),
                  ),
                ),
                ...List.generate((category["items"] as List).length, (itemIndex) {
                  final item = (category["items"] as List)[itemIndex];
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: spSm,
                      horizontal: spMd,
                    ),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.orange[300]!,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          child: Text(
                            "${item["qty"]}x",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange[600],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${((item["price"] as double) * (item["qty"] as int)).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: spSm),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBillSummary() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange[50]!, Colors.red[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.orange[200]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            "BILL SUMMARY",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.orange[700],
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Subtotal", (receipt["subtotal"] as double)),
          SizedBox(height: spSm),
          _buildSummaryRow("Service Charge (10%)", (receipt["service_charge"] as double)),
          SizedBox(height: spSm),
          _buildSummaryRow("Tax", (receipt["tax"] as double)),
          SizedBox(height: spSm),
          _buildSummaryRow("Tip", (receipt["tip"] as double), isHighlight: true),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.symmetric(vertical: spMd),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.orange[400]!,
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
                    color: Colors.red[700],
                  ),
                ),
                Text(
                  "\$${(receipt["total"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isHighlight ? FontWeight.w600 : FontWeight.normal,
            color: isHighlight ? Colors.green[700] : disabledBoldColor,
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isHighlight ? Colors.green[700] : Colors.orange[700],
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
                "PAYMENT RECEIVED",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.money,
                      color: Colors.green[700],
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
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Served by:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${receipt["server"]}",
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
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Text(
                  "🍝 Grazie Mille! 🍕",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[700],
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Thank you for dining with us!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange[700],
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "We hope you enjoyed your meal. Please rate your experience and visit us again soon!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: spXs),
                  child: Icon(
                    Icons.star,
                    color: Colors.orange[400],
                    size: 32,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: spSm),
          Text(
            "Tap stars to rate your experience",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
