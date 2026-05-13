import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCheckout6View extends StatefulWidget {
  const GrlCheckout6View({Key? key}) : super(key: key);

  @override
  State<GrlCheckout6View> createState() => _GrlCheckout6ViewState();
}

class _GrlCheckout6ViewState extends State<GrlCheckout6View> {
  String selectedStore = "downtown";
  String selectedPickupTime = "today_3pm";
  String customerName = "John Doe";
  String customerEmail = "john.doe@email.com";
  String customerPhone = "+1 (555) 123-4567";
  String specialRequests = "";
  bool notifyOnReady = true;
  
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> orderItems = [
    {
      "id": 1,
      "name": "MacBook Pro 16-inch",
      "image": "https://picsum.photos/80/80?random=1&keyword=laptop",
      "price": 2499.00,
      "quantity": 1,
      "sku": "MBP16-2024",
      "available": true,
    },
    {
      "id": 2,
      "name": "Magic Mouse",
      "image": "https://picsum.photos/80/80?random=2&keyword=mouse",
      "price": 79.00,
      "quantity": 1,
      "sku": "MM-2024",
      "available": true,
    },
    {
      "id": 3,
      "name": "USB-C Cable",
      "image": "https://picsum.photos/80/80?random=3&keyword=cable",
      "price": 19.99,
      "quantity": 2,
      "sku": "USBC-CABLE",
      "available": false,
    },
  ];

  List<Map<String, dynamic>> storeLocations = [
    {
      "id": "downtown",
      "name": "Downtown Store",
      "address": "123 Main Street, Downtown",
      "phone": "+1 (555) 987-6543",
      "hours": "Mon-Sat: 9AM-9PM, Sun: 11AM-7PM",
      "distance": "2.3 miles",
      "available": true,
    },
    {
      "id": "mall",
      "name": "Shopping Mall",
      "address": "456 Mall Avenue, Level 2",
      "phone": "+1 (555) 876-5432",
      "hours": "Mon-Sun: 10AM-10PM",
      "distance": "5.7 miles",
      "available": true,
    },
    {
      "id": "airport",
      "name": "Airport Terminal",
      "address": "789 Airport Blvd, Terminal A",
      "phone": "+1 (555) 765-4321",
      "hours": "Daily: 6AM-11PM",
      "distance": "12.1 miles",
      "available": false,
    },
  ];

  List<Map<String, dynamic>> pickupTimes = [
    {
      "id": "today_3pm",
      "label": "Today at 3:00 PM",
      "date": "March 15, 2024",
      "time": "3:00 PM",
      "available": true,
    },
    {
      "id": "today_5pm",
      "label": "Today at 5:00 PM",
      "date": "March 15, 2024",
      "time": "5:00 PM",
      "available": true,
    },
    {
      "id": "tomorrow_10am",
      "label": "Tomorrow at 10:00 AM",
      "date": "March 16, 2024",
      "time": "10:00 AM",
      "available": true,
    },
    {
      "id": "tomorrow_2pm",
      "label": "Tomorrow at 2:00 PM",
      "date": "March 16, 2024",
      "time": "2:00 PM",
      "available": false,
    },
  ];

  double get subtotal => orderItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get tax => subtotal * 0.0875;
  double get total => subtotal + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Pickup"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: _viewMap,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spLg,
            children: [
              _buildOrderSummary(),
              _buildStoreSelection(),
              _buildPickupTimeSelection(),
              _buildCustomerInformation(),
              _buildSpecialRequests(),
              _buildPickupInstructions(),
              _buildOrderTotal(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  Widget _buildOrderSummary() {
    int availableItems = orderItems.where((item) => item["available"] == true).length;
    int unavailableItems = orderItems.length - availableItems;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Items for Pickup",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  if (unavailableItems > 0) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$unavailableItems unavailable",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                  ],
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$availableItems ready",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: orderItems.map((item) {
              bool isAvailable = item["available"];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isAvailable ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isAvailable ? Colors.green.shade200 : Colors.red.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${item["image"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: isAvailable ? successColor : dangerColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isAvailable ? Icons.check : Icons.close,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isAvailable ? Colors.black : Colors.red.shade700,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "SKU: ${item["sku"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Qty: ${item["quantity"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isAvailable ? primaryColor : Colors.red.shade700,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: isAvailable ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            isAvailable ? "Ready" : "Out of Stock",
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Store Location",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: storeLocations.map((store) {
              bool isSelected = selectedStore == store["id"];
              bool isAvailable = store["available"];
              
              return GestureDetector(
                onTap: isAvailable ? () {
                  selectedStore = store["id"];
                  setState(() {});
                } : null,
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: !isAvailable 
                        ? Colors.grey.shade100
                        : isSelected 
                            ? primaryColor.withAlpha(25)
                            : Colors.grey.shade50,
                    border: Border.all(
                      color: !isAvailable 
                          ? Colors.grey.shade300
                          : isSelected 
                              ? primaryColor 
                              : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: !isAvailable 
                            ? Colors.grey.shade400
                            : isSelected 
                                ? primaryColor 
                                : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: !isAvailable 
                              ? Colors.grey.shade400
                              : isSelected 
                                  ? primaryColor 
                                  : Colors.grey.shade500,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.store,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${store["name"]}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: !isAvailable ? Colors.grey.shade500 : Colors.black,
                                  ),
                                ),
                                Text(
                                  "${store["distance"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${store["address"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${store["phone"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${store["hours"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (!isAvailable)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Temporarily Closed",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
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
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPickupTimeSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Pickup Time",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: pickupTimes.map((timeSlot) {
              bool isSelected = selectedPickupTime == timeSlot["id"];
              bool isAvailable = timeSlot["available"];
              
              return GestureDetector(
                onTap: isAvailable ? () {
                  selectedPickupTime = timeSlot["id"];
                  setState(() {});
                } : null,
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: !isAvailable 
                        ? Colors.grey.shade100
                        : isSelected 
                            ? primaryColor.withAlpha(25)
                            : Colors.grey.shade50,
                    border: Border.all(
                      color: !isAvailable 
                          ? Colors.grey.shade300
                          : isSelected 
                              ? primaryColor 
                              : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: !isAvailable 
                            ? Colors.grey.shade400
                            : isSelected 
                                ? primaryColor 
                                : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${timeSlot["time"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: !isAvailable ? Colors.grey.shade500 : Colors.black,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${timeSlot["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (!isAvailable) ...[
                        SizedBox(height: spXs),
                        Text(
                          "Fully Booked",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInformation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pickup Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Full Name",
            value: customerName,
            hint: "Enter your full name",
            validator: Validator.required,
            onChanged: (value) {
              customerName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Email Address",
            value: customerEmail,
            hint: "Enter your email",
            validator: Validator.email,
            onChanged: (value) {
              customerEmail = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Phone Number",
            value: customerPhone,
            hint: "Enter your phone number",
            validator: Validator.required,
            onChanged: (value) {
              customerPhone = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Notify me when order is ready",
                      "value": true,
                      "checked": notifyOnReady,
                    }
                  ],
                  value: [
                    if (notifyOnReady)
                      {
                        "label": "Notify me when order is ready",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    notifyOnReady = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialRequests() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Special Requests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Additional notes (optional)",
            value: specialRequests,
            hint: "e.g., Please have items ready at customer service desk, Call when arrived...",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPickupInstructions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info,
                color: Colors.blue,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Pickup Instructions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "• Bring a valid photo ID that matches the name on the order",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue.shade600,
                ),
              ),
              Text(
                "• Your order confirmation email or SMS",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue.shade600,
                ),
              ),
              Text(
                "• Visit the customer service desk upon arrival",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue.shade600,
                ),
              ),
              Text(
                "• Allow 15 minutes processing time if arriving early",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTotal() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          _buildPriceRow("Subtotal", subtotal),
          _buildPriceRow("Store Pickup", 0.00),
          _buildPriceRow("Tax", tax),
          Divider(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    String storeName = storeLocations.firstWhere((s) => s["id"] == selectedStore)["name"];
    String pickupTime = pickupTimes.firstWhere((t) => t["id"] == selectedPickupTime)["label"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowLg],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.store,
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Pickup at $storeName",
                        style: TextStyle(
                          fontSize: 13,
                          color: primaryColor,
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
                      Icons.schedule,
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        pickupTime,
                        style: TextStyle(
                          fontSize: 13,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Confirm Pickup Order",
              size: bs.md,
              onPressed: _confirmPickupOrder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
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
            amount == 0.00 ? "FREE" : "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: amount == 0.00 ? successColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _viewMap() {
    si("Opening store locations map...");
  }

  void _confirmPickupOrder() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      Future.delayed(Duration(seconds: 3), () {
        hideLoading();
        ss("Pickup order confirmed! You'll receive a notification when ready.");
        // Navigate to order confirmation
      });
    }
  }
}
