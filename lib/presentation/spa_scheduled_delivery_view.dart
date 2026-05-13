import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaScheduledDeliveryView extends StatefulWidget {
  const SpaScheduledDeliveryView({super.key});

  @override
  State<SpaScheduledDeliveryView> createState() => _SpaScheduledDeliveryViewState();
}

class _SpaScheduledDeliveryViewState extends State<SpaScheduledDeliveryView> {
  String selectedDate = DateTime.now().add(Duration(days: 1)).toString();
  String selectedTimeSlot = "morning";
  String deliveryFrequency = "once";
  String deliveryAddress = "";
  String contactNumber = "";
  String specialInstructions = "";
  bool enableNotifications = true;
  bool flexibleDelivery = false;

  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Monthly Spa Box Subscription",
      "category": "Subscription",
      "price": 79.99,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=1&keyword=spa",
      "recurring": true,
    },
    {
      "id": 2,
      "name": "Organic Face Serum Collection",
      "category": "Skincare",
      "price": 145.00,
      "quantity": 2,
      "image": "https://picsum.photos/80/80?random=2&keyword=serum",
      "recurring": false,
    },
    {
      "id": 3,
      "name": "Essential Oils Starter Kit",
      "category": "Aromatherapy",
      "price": 89.50,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=3&keyword=oils",
      "recurring": false,
    },
  ];

  List<Map<String, dynamic>> timeSlots = [
    {
      "label": "Morning (8 AM - 12 PM)",
      "value": "morning",
      "icon": Icons.wb_sunny,
      "available": true,
      "popular": true,
    },
    {
      "label": "Afternoon (12 PM - 5 PM)",
      "value": "afternoon",
      "icon": Icons.wb_sunny_outlined,
      "available": true,
      "popular": false,
    },
    {
      "label": "Evening (5 PM - 8 PM)",
      "value": "evening",
      "icon": Icons.nights_stay,
      "available": true,
      "popular": true,
    },
    {
      "label": "Weekend Only",
      "value": "weekend",
      "icon": Icons.weekend,
      "available": false,
      "popular": false,
    },
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {
      "label": "One-time Delivery",
      "value": "once",
      "description": "Single scheduled delivery",
      "icon": Icons.today,
    },
    {
      "label": "Weekly",
      "value": "weekly",
      "description": "Every week on the same day",
      "icon": Icons.calendar_view_week,
    },
    {
      "label": "Bi-weekly",
      "value": "biweekly",
      "description": "Every 2 weeks",
      "icon": Icons.date_range,
    },
    {
      "label": "Monthly",
      "value": "monthly",
      "description": "Once a month",
      "icon": Icons.calendar_month,
    },
  ];

  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get deliveryFee => deliveryFrequency == "once" ? 4.99 : 0.0;
  double get total => subtotal + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Delivery"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              _showDeliveryCalendar();
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
            _buildScheduleHeader(),
            _buildOrderSummary(),
            _buildDeliveryDate(),
            _buildTimeSlots(),
            _buildFrequencyOptions(),
            _buildDeliveryAddress(),
            _buildContactDetails(),
            _buildSpecialInstructions(),
            _buildDeliveryPreferences(),
            _buildScheduleSummary(),
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
                  deliveryFrequency == "once" ? "Total Amount" : "Monthly Cost",
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
                label: "Schedule Delivery",
                onPressed: () => _scheduleDelivery(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleHeader() {
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
              Icons.schedule,
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
                  "Scheduled Delivery",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Plan your spa product deliveries in advance",
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
    bool isRecurring = item["recurring"] as bool;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isRecurring ? successColor.withAlpha(25) : Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isRecurring ? successColor.withAlpha(76) : disabledOutlineBorderColor,
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
          if (isRecurring)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Recurring",
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

  Widget _buildDeliveryDate() {
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
                Icons.calendar_today,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Select Delivery Date",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDatePicker(
            label: "Preferred Delivery Date",
            value: DateTime.parse(selectedDate),
            onChanged: (value) {
              selectedDate = value.toString();
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
                    "Deliveries can be scheduled up to 30 days in advance",
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

  Widget _buildTimeSlots() {
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
            "Preferred Time Slot",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...timeSlots.map((slot) => _buildTimeSlot(slot)),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(Map<String, dynamic> slot) {
    bool isSelected = selectedTimeSlot == slot["value"];
    bool isAvailable = slot["available"] as bool;
    bool isPopular = slot["popular"] as bool;
    
    return GestureDetector(
      onTap: isAvailable ? () {
        selectedTimeSlot = slot["value"];
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
                slot["icon"] as IconData,
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
                    children: [
                      Text(
                        "${slot["label"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isAvailable ? primaryColor : disabledColor,
                        ),
                      ),
                      if (isPopular && isAvailable)
                        Container(
                          margin: EdgeInsets.only(left: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Popular",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (!isAvailable)
                    Text(
                      "Currently unavailable for selected date",
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

  Widget _buildFrequencyOptions() {
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
            "Delivery Frequency",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: frequencyOptions.map((frequency) => _buildFrequencyOption(frequency)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFrequencyOption(Map<String, dynamic> frequency) {
    bool isSelected = deliveryFrequency == frequency["value"];
    
    return GestureDetector(
      onTap: () {
        deliveryFrequency = frequency["value"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(25) : Colors.grey.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : disabledBoldColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                frequency["icon"] as IconData,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${frequency["label"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${frequency["description"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            if (isSelected)
              Container(
                margin: EdgeInsets.only(top: spXs),
                child: Icon(
                  Icons.check_circle,
                  color: primaryColor,
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddress() {
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
                "Delivery Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Complete Address",
            value: deliveryAddress,
            hint: "Enter your complete delivery address...",
            validator: Validator.required,
            onChanged: (value) {
              deliveryAddress = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetails() {
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
                Icons.phone,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Contact Number",
            value: contactNumber,
            hint: "Enter your phone number",
            validator: Validator.required,
            onChanged: (value) {
              contactNumber = value;
              setState(() {});
            },
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
            hint: "Any special instructions for delivery...",
            onChanged: (value) {
              specialInstructions = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryPreferences() {
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
            "Delivery Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable delivery notifications",
                "value": "notifications",
                "checked": enableNotifications,
              }
            ],
            value: [
              if (enableNotifications)
                {
                  "label": "Enable delivery notifications",
                  "value": "notifications",
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              enableNotifications = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Allow flexible delivery timing",
                "value": "flexible",
                "checked": flexibleDelivery,
              }
            ],
            value: [
              if (flexibleDelivery)
                {
                  "label": "Allow flexible delivery timing",
                  "value": "flexible",
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              flexibleDelivery = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSummary() {
    String frequencyLabel = frequencyOptions.firstWhere((f) => f["value"] == deliveryFrequency)["label"];
    String timeSlotLabel = timeSlots.firstWhere((t) => t["value"] == selectedTimeSlot)["label"];
    
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
            "Schedule Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildSummaryRow("Delivery Date", DateTime.parse(selectedDate).dMMMy),
          _buildSummaryRow("Time Slot", timeSlotLabel),
          _buildSummaryRow("Frequency", frequencyLabel),
          _buildSummaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
          if (deliveryFee > 0)
            _buildSummaryRow("Delivery Fee", "\$${deliveryFee.toStringAsFixed(2)}"),
          Divider(
            color: disabledOutlineBorderColor,
            thickness: 1,
          ),
          _buildSummaryRow(
            deliveryFrequency == "once" ? "Total" : "Monthly Cost",
            "\$${total.toStringAsFixed(2)}",
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? fsH6 : 15,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? primaryColor : disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? fsH6 : 15,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? successColor : primaryColor,
          ),
        ),
      ],
    );
  }

  void _showDeliveryCalendar() {
    showDatePicker(
      context: context,
      initialDate: DateTime.parse(selectedDate),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 30)),
    ).then((date) {
      if (date != null) {
        selectedDate = date.toString();
        setState(() {});
      }
    });
  }

  void _scheduleDelivery() async {
    if (deliveryAddress.isEmpty) {
      se("Please enter delivery address");
      return;
    }

    if (contactNumber.isEmpty) {
      se("Please enter contact number");
      return;
    }

    bool isConfirmed = await confirm("Confirm scheduled delivery for \$${total.toStringAsFixed(2)}?");
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Delivery scheduled successfully! You'll receive confirmation details shortly.");
      
      // Navigate back or to schedule management page
      // ss('Next page'));
    }
  }
}
