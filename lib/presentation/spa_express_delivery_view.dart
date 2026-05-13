import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaExpressDeliveryView extends StatefulWidget {
  const SpaExpressDeliveryView({super.key});

  @override
  State<SpaExpressDeliveryView> createState() => _SpaExpressDeliveryViewState();
}

class _SpaExpressDeliveryViewState extends State<SpaExpressDeliveryView> {
  String selectedDeliveryWindow = "1";
  String selectedLocation = "";
  String specialInstructions = "";
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Luxury Face Mask Set",
      "category": "Skincare",
      "price": 89.99,
      "quantity": 2,
      "image": "https://picsum.photos/80/80?random=1&keyword=skincare",
      "urgentAvailable": true,
    },
    {
      "id": 2,
      "name": "Aromatherapy Essential Oils Kit",
      "category": "Wellness",
      "price": 124.50,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=2&keyword=oils",
      "urgentAvailable": true,
    },
    {
      "id": 3,
      "name": "Spa Gift Voucher",
      "category": "Gift Cards",
      "price": 200.00,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=3&keyword=gift",
      "urgentAvailable": false,
    },
  ];

  List<Map<String, dynamic>> deliveryWindows = [
    {
      "label": "1 Hour Express",
      "value": "1",
      "price": 19.99,
      "description": "Guaranteed delivery within 1 hour",
      "icon": Icons.rocket_launch,
      "available": true,
    },
    {
      "label": "2 Hour Express",
      "value": "2",
      "price": 14.99,
      "description": "Guaranteed delivery within 2 hours",
      "icon": Icons.local_shipping,
      "available": true,
    },
    {
      "label": "3 Hour Express",
      "value": "3",
      "price": 9.99,
      "description": "Guaranteed delivery within 3 hours",
      "icon": Icons.schedule,
      "available": true,
    },
    {
      "label": "Same Day Express",
      "value": "same",
      "price": 6.99,
      "description": "Delivered before 8 PM today",
      "icon": Icons.today,
      "available": false,
    },
  ];

  bool isExpressAvailable = true;
  bool trackingEnabled = true;
  bool prioritySupport = true;

  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get deliveryFee => (deliveryWindows.firstWhere((window) => window["value"] == selectedDeliveryWindow)["price"] as double);
  double get total => subtotal + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Express Delivery"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showExpressDeliveryInfo();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildExpressHeader(),
            _buildOrderSummary(),
            _buildDeliveryOptions(),
            _buildDeliveryLocation(),
            _buildSpecialInstructions(),
            _buildExpressFeatures(),
            _buildPricingSummary(),
            _buildExpressWarning(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Amount",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: disabledBoldColor,
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
            Container(
              width: double.infinity,
              child: QButton(
                label: "Confirm Express Delivery",
                onPressed: isExpressAvailable ? () => _confirmExpressDelivery() : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpressHeader() {
    return Container(
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.flash_on,
              color: Colors.white,
              size: 32,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Express Delivery",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Fast, reliable delivery with priority handling",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${cartItems.length} items",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...cartItems.map((item) => _buildOrderItem(item)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    bool urgentAvailable = item["urgentAvailable"] as bool;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: urgentAvailable ? Colors.green.withAlpha(25) : Colors.red.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: urgentAvailable ? successColor.withAlpha(76) : dangerColor.withAlpha(76),
          width: 1,
        ),
      ),
      child: Row(
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
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${item["category"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Qty: ${item["quantity"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: urgentAvailable ? successColor : dangerColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              urgentAvailable ? "Express Ready" : "Not Available",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
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
            "Express Delivery Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...deliveryWindows.map((window) => _buildDeliveryOption(window)),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption(Map<String, dynamic> window) {
    bool isSelected = selectedDeliveryWindow == window["value"];
    bool isAvailable = window["available"] as bool;
    
    return GestureDetector(
      onTap: isAvailable ? () {
        selectedDeliveryWindow = window["value"];
        setState(() {});
      } : null,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(25) : (isAvailable ? Colors.grey.withAlpha(25) : Colors.grey.withAlpha(51)),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: isSelected ? primaryColor : (isAvailable ? disabledOutlineBorderColor : disabledColor),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : (isAvailable ? disabledBoldColor : disabledColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                window["icon"] as IconData,
                color: Colors.white,
                size: 20,
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
                      Text(
                        "${window["label"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isAvailable ? primaryColor : disabledColor,
                        ),
                      ),
                      Text(
                        "+\$${(window["price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isAvailable ? successColor : disabledColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${window["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: isAvailable ? disabledBoldColor : disabledColor,
                    ),
                  ),
                  if (!isAvailable)
                    Text(
                      "Currently unavailable",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: dangerColor,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryLocation() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Express Delivery Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Delivery Address",
            value: selectedLocation,
            hint: "Enter complete delivery address",
            validator: Validator.required,
            onChanged: (value) {
              selectedLocation = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: infoColor,
                  size: 18,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Express delivery is available within 25km radius of our spa locations",
                    style: TextStyle(
                      fontSize: 13,
                      color: infoColor,
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

  Widget _buildSpecialInstructions() {
    return Container(
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
            "Special Instructions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Delivery Instructions",
            value: specialInstructions,
            hint: "Any special instructions for express delivery...",
            onChanged: (value) {
              specialInstructions = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpressFeatures() {
    List<Map<String, dynamic>> features = [
      {
        "title": "Real-time Tracking",
        "description": "Track your delivery driver in real-time",
        "icon": Icons.track_changes,
        "enabled": trackingEnabled,
      },
      {
        "title": "Priority Support",
        "description": "Direct line to express delivery support",
        "icon": Icons.headset_mic,
        "enabled": prioritySupport,
      },
      {
        "title": "Temperature Control",
        "description": "Special handling for spa products",
        "icon": Icons.ac_unit,
        "enabled": true,
      },
    ];

    return Container(
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
            "Express Features Included",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...features.map((feature) => Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    feature["icon"] as IconData,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${feature["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${feature["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 18,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPricingSummary() {
    return Container(
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
            "Pricing Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: TextStyle(
                  fontSize: 15,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${subtotal.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Express Delivery Fee",
                style: TextStyle(
                  fontSize: 15,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${deliveryFee.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Divider(
            color: disabledOutlineBorderColor,
            thickness: 1,
          ),
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
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpressWarning() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: warningColor.withAlpha(76),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Express Delivery Terms",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Text(
            "• Express delivery times are estimates and may vary based on traffic and weather conditions\n• Products requiring special handling may take additional time\n• Delivery fee is non-refundable once driver is dispatched\n• Be available at delivery address during the selected time window",
            style: TextStyle(
              fontSize: 13,
              color: warningColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _showExpressDeliveryInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Express Delivery Info"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Our express delivery service ensures your spa products reach you quickly and safely.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: spSm),
            Text(
              "Features:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("• Real-time tracking"),
            Text("• Priority handling"),
            Text("• Temperature controlled transport"),
            Text("• Direct customer support"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _confirmExpressDelivery() async {
    if (selectedLocation.isEmpty) {
      se("Please enter delivery address");
      return;
    }

    bool isConfirmed = await confirm("Confirm express delivery for \$${total.toStringAsFixed(2)}?");
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Express delivery confirmed! You'll receive tracking details shortly.");
      
      // Navigate back or to tracking page
      // ss('Next page'));
    }
  }
}
