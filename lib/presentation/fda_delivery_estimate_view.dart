import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDeliveryEstimateView extends StatefulWidget {
  const FdaDeliveryEstimateView({super.key});

  @override
  State<FdaDeliveryEstimateView> createState() => _FdaDeliveryEstimateViewState();
}

class _FdaDeliveryEstimateViewState extends State<FdaDeliveryEstimateView> {
  String selectedRestaurantId = "1";
  String deliveryAddress = "123 Main Street, Downtown, City 12345";
  DateTime selectedTime = DateTime.now().add(Duration(hours: 1));
  bool isScheduledDelivery = false;
  String deliveryOption = "standard";

  List<Map<String, dynamic>> restaurants = [
    {
      "id": "1",
      "name": "Pizza Palace",
      "distance": 2.3,
      "preparationTime": 25,
      "image": "https://picsum.photos/100/100?random=1&keyword=pizza",
      "rating": 4.5,
      "deliveryFee": 3.99,
      "minOrder": 15.0,
      "rushFee": 2.0,
      "busyLevel": "Medium"
    },
    {
      "id": "2",
      "name": "Burger Junction",
      "distance": 1.8,
      "preparationTime": 15,
      "image": "https://picsum.photos/100/100?random=2&keyword=burger",
      "rating": 4.3,
      "deliveryFee": 2.99,
      "minOrder": 12.0,
      "rushFee": 1.5,
      "busyLevel": "Low"
    },
    {
      "id": "3",
      "name": "Sushi Master",
      "distance": 4.1,
      "preparationTime": 35,
      "image": "https://picsum.photos/100/100?random=3&keyword=sushi",
      "rating": 4.8,
      "deliveryFee": 5.99,
      "minOrder": 25.0,
      "rushFee": 3.0,
      "busyLevel": "High"
    }
  ];

  List<Map<String, dynamic>> deliveryOptions = [
    {
      "id": "standard",
      "name": "Standard Delivery",
      "description": "Regular delivery time",
      "extraTime": 0,
      "extraFee": 0.0,
      "icon": Icons.local_shipping
    },
    {
      "id": "express",
      "name": "Express Delivery",
      "description": "Faster delivery for urgent orders",
      "extraTime": -10,
      "extraFee": 4.99,
      "icon": Icons.flash_on
    },
    {
      "id": "priority",
      "name": "Priority Delivery",
      "description": "Highest priority, quickest delivery",
      "extraTime": -15,
      "extraFee": 8.99,
      "icon": Icons.priority_high
    }
  ];

  @override
  Widget build(BuildContext context) {
    final selectedRestaurant = restaurants.firstWhere((r) => r["id"] == selectedRestaurantId);
    final estimate = _calculateDeliveryEstimate(selectedRestaurant);

    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Estimate"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDeliveryEstimateCard(estimate),
            _buildRestaurantSelection(),
            _buildDeliveryOptions(),
            _buildAddressSection(),
            _buildTimeSelection(),
            _buildDeliveryDetails(selectedRestaurant, estimate),
            _buildFactorsAffectingDelivery(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryEstimateCard(Map<String, dynamic> estimate) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Estimated Delivery Time",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${estimate["minTime"]}-${estimate["maxTime"]} minutes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Expected arrival: ",
                      style: TextStyle(color: Colors.white.withAlpha(200)),
                    ),
                    Text(
                      "${estimate["arrivalTime"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Total cost: ",
                      style: TextStyle(color: Colors.white.withAlpha(200)),
                    ),
                    Text(
                      "\$${(estimate["totalCost"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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

  Widget _buildRestaurantSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Select Restaurant",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spXs,
            children: restaurants.map((restaurant) => _buildRestaurantOption(restaurant)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantOption(Map<String, dynamic> restaurant) {
    final isSelected = restaurant["id"] == selectedRestaurantId;

    return GestureDetector(
      onTap: () {
        selectedRestaurantId = restaurant["id"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${restaurant["image"]}",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${restaurant["name"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "${restaurant["rating"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "${restaurant["distance"]} km",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                  "${restaurant["preparationTime"]} min",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getBusyLevelColor(restaurant["busyLevel"]).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${restaurant["busyLevel"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: _getBusyLevelColor(restaurant["busyLevel"]),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Delivery Speed",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spXs,
            children: deliveryOptions.map((option) => _buildDeliveryOption(option)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption(Map<String, dynamic> option) {
    final isSelected = option["id"] == deliveryOption;

    return GestureDetector(
      onTap: () {
        deliveryOption = option["id"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
        ),
        child: Row(
          children: [
            Icon(
              option["icon"],
              color: isSelected ? primaryColor : disabledBoldColor,
              size: 24,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${option["name"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${option["description"]}",
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
                if ((option["extraFee"] as double) > 0)
                  Text(
                    "+\$${(option["extraFee"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                if ((option["extraTime"] as int) < 0)
                  Text(
                    "${(option["extraTime"] as int).abs()} min faster",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Delivery Address",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: primaryColor),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deliveryAddress,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Current location",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Change",
                size: bs.sm,
                onPressed: () {
                  // navigateTo(AddressSelectionView())
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Schedule delivery",
                      "value": true,
                      "checked": isScheduledDelivery,
                    }
                  ],
                  value: isScheduledDelivery ? [{"label": "Schedule delivery", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    isScheduledDelivery = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (isScheduledDelivery) ...[
            QDatePicker(
              label: "Delivery Date",
              value: selectedTime,
              onChanged: (value) {
                selectedTime = DateTime(
                  value.year,
                  value.month,
                  value.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTimePicker(
              label: "Delivery Time",
              value: TimeOfDay.fromDateTime(selectedTime),
              onChanged: (value) {
                if (value != null) {
                  selectedTime = DateTime(
                    selectedTime.year,
                    selectedTime.month,
                    selectedTime.day,
                    value.hour,
                    value.minute,
                  );
                  setState(() {});
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDeliveryDetails(Map<String, dynamic> restaurant, Map<String, dynamic> estimate) {
    final selectedOption = deliveryOptions.firstWhere((o) => o["id"] == deliveryOption);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Delivery Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildDetailRow("Restaurant prep time", "${restaurant["preparationTime"]} min"),
          _buildDetailRow("Travel distance", "${restaurant["distance"]} km"),
          _buildDetailRow("Estimated travel time", "${_calculateTravelTime(restaurant["distance"])} min"),
          if ((selectedOption["extraTime"] as int) != 0)
            _buildDetailRow("${selectedOption["name"]} adjustment", "${(selectedOption["extraTime"] as int).abs()} min ${(selectedOption["extraTime"] as int) < 0 ? 'faster' : 'slower'}"),
          Divider(),
          _buildDetailRow("Base delivery fee", "\$${(restaurant["deliveryFee"] as double).toStringAsFixed(2)}"),
          if ((selectedOption["extraFee"] as double) > 0)
            _buildDetailRow("${selectedOption["name"]} fee", "\$${(selectedOption["extraFee"] as double).toStringAsFixed(2)}"),
          if (restaurant["busyLevel"] == "High")
            _buildDetailRow("Rush hour fee", "\$${(restaurant["rushFee"] as double).toStringAsFixed(2)}"),
          Divider(),
          _buildDetailRow("Total delivery cost", "\$${(estimate["totalCost"] as double).toStringAsFixed(2)}", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: isTotal ? primaryColor : disabledBoldColor,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? primaryColor : disabledBoldColor,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFactorsAffectingDelivery() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: infoColor),
              SizedBox(width: spSm),
              Text(
                "Factors Affecting Delivery Time",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: [
              _buildFactorItem("Weather conditions", "Clear skies"),
              _buildFactorItem("Traffic conditions", "Light traffic"),
              _buildFactorItem("Restaurant busy level", "${restaurants.firstWhere((r) => r["id"] == selectedRestaurantId)["busyLevel"]}"),
              _buildFactorItem("Number of drivers", "15 drivers available"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFactorItem(String factor, String status) {
    return Row(
      children: [
        Text(
          "• $factor: ",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          status,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Confirm Order",
            onPressed: () {
              ss("Order confirmed! Estimated delivery: ${_calculateDeliveryEstimate(restaurants.firstWhere((r) => r["id"] == selectedRestaurantId))["arrivalTime"]}");
              // navigateTo(OrderTrackingView())
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "View Menu",
                size: bs.sm,
                onPressed: () {
                  // navigateTo(RestaurantMenuView(restaurantId: selectedRestaurantId))
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Save for Later",
                size: bs.sm,
                onPressed: () {
                  ss("Delivery estimate saved");
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Map<String, dynamic> _calculateDeliveryEstimate(Map<String, dynamic> restaurant) {
    final selectedOption = deliveryOptions.firstWhere((o) => o["id"] == deliveryOption);
    
    int baseTime = (restaurant["preparationTime"] as int) + _calculateTravelTime(restaurant["distance"] as double);
    int adjustedTime = baseTime + (selectedOption["extraTime"] as int);
    
    // Add rush hour delay if restaurant is busy
    if (restaurant["busyLevel"] == "High") {
      adjustedTime += 10;
    }
    
    int minTime = adjustedTime - 5;
    int maxTime = adjustedTime + 5;
    
    double totalCost = (restaurant["deliveryFee"] as double) + (selectedOption["extraFee"] as double);
    if (restaurant["busyLevel"] == "High") {
      totalCost += (restaurant["rushFee"] as double);
    }
    
    DateTime arrivalTime = isScheduledDelivery 
        ? selectedTime.add(Duration(minutes: adjustedTime))
        : DateTime.now().add(Duration(minutes: adjustedTime));
    
    return {
      "minTime": minTime,
      "maxTime": maxTime,
      "arrivalTime": "${arrivalTime.hour.toString().padLeft(2, '0')}:${arrivalTime.minute.toString().padLeft(2, '0')}",
      "totalCost": totalCost,
    };
  }

  int _calculateTravelTime(double distance) {
    // Assuming average speed of 30 km/h in city
    return ((distance / 30) * 60).round();
  }

  Color _getBusyLevelColor(String level) {
    switch (level) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
