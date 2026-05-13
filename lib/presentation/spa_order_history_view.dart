import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaOrderHistoryView extends StatefulWidget {
  const SpaOrderHistoryView({super.key});

  @override
  State<SpaOrderHistoryView> createState() => _SpaOrderHistoryViewState();
}

class _SpaOrderHistoryViewState extends State<SpaOrderHistoryView> {
  String selectedFilter = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Upcoming", "value": "Upcoming"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> orders = [
    {
      "id": "SPA-001234",
      "orderDate": "2024-03-20",
      "status": "Upcoming",
      "totalAmount": 300.00,
      "services": [
        {
          "name": "Luxury Facial Treatment",
          "price": 120.00,
          "duration": "90 min",
          "scheduledDate": "2024-03-25",
          "scheduledTime": "14:00",
          "therapist": "Sarah Johnson",
          "room": "Room 101",
        },
        {
          "name": "Hot Stone Massage",
          "price": 180.00,
          "duration": "75 min",
          "scheduledDate": "2024-03-26",
          "scheduledTime": "16:00",
          "therapist": "Michael Chen",
          "room": "Room 205",
        },
      ],
      "image": "https://picsum.photos/80/80?random=1&keyword=spa",
    },
    {
      "id": "SPA-001233",
      "orderDate": "2024-03-15",
      "status": "Completed",
      "totalAmount": 250.00,
      "services": [
        {
          "name": "Aromatherapy Body Wrap",
          "price": 95.00,
          "duration": "60 min",
          "scheduledDate": "2024-03-18",
          "scheduledTime": "10:00",
          "therapist": "Emma Wilson",
          "room": "Room 203",
        },
        {
          "name": "Deep Tissue Massage",
          "price": 155.00,
          "duration": "90 min",
          "scheduledDate": "2024-03-18",
          "scheduledTime": "12:00",
          "therapist": "David Lee",
          "room": "Room 108",
        },
      ],
      "image": "https://picsum.photos/80/80?random=2&keyword=massage",
      "rating": 4.8,
      "review": "Amazing experience! The staff was professional and the treatments were relaxing.",
    },
    {
      "id": "SPA-001232",
      "orderDate": "2024-03-10",
      "status": "Completed",
      "totalAmount": 180.00,
      "services": [
        {
          "name": "Anti-Aging Skincare",
          "price": 160.00,
          "duration": "120 min",
          "scheduledDate": "2024-03-12",
          "scheduledTime": "15:00",
          "therapist": "Lisa Chen",
          "room": "Room 102",
        },
      ],
      "image": "https://picsum.photos/80/80?random=3&keyword=skincare",
      "rating": 5.0,
      "review": "Excellent service! My skin looks amazing.",
    },
    {
      "id": "SPA-001231",
      "orderDate": "2024-03-05",
      "status": "Cancelled",
      "totalAmount": 95.00,
      "services": [
        {
          "name": "Hair Spa Treatment",
          "price": 85.00,
          "duration": "45 min",
          "scheduledDate": "2024-03-08",
          "scheduledTime": "11:00",
          "therapist": "Anna Davis",
          "room": "Room 204",
        },
      ],
      "image": "https://picsum.photos/80/80?random=4&keyword=hair",
      "cancellationReason": "Schedule conflict",
    },
    {
      "id": "SPA-001230",
      "orderDate": "2024-02-28",
      "status": "Completed",
      "totalAmount": 320.00,
      "services": [
        {
          "name": "Couples Massage",
          "price": 320.00,
          "duration": "120 min",
          "scheduledDate": "2024-03-02",
          "scheduledTime": "18:00",
          "therapist": "Sarah Johnson & Michael Chen",
          "room": "Room 301",
        },
      ],
      "image": "https://picsum.photos/80/80?random=5&keyword=couples",
      "rating": 4.9,
      "review": "Perfect for our anniversary. Highly recommended!",
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = orders;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((order) => order["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) => 
        order["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        (order["services"] as List).any((service) => 
          service["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()))).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterModal();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search orders...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Filter Tabs
            QCategoryPicker(
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Orders List
            if (filteredOrders.isEmpty)
              _buildEmptyState()
            else
              Column(
                children: filteredOrders.map((order) {
                  return _buildOrderCard(order);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long,
              size: 120,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No orders found",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              selectedFilter == "All" 
                  ? "You haven't made any bookings yet"
                  : "No ${selectedFilter.toLowerCase()} orders found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Book Now",
              size: bs.md,
              onPressed: () {
                // Navigate to service list
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final status = order["status"] as String;
    Color statusColor;
    
    switch (status) {
      case "Upcoming":
        statusColor = infoColor;
        break;
      case "Completed":
        statusColor = successColor;
        break;
      case "Cancelled":
        statusColor = dangerColor;
        break;
      default:
        statusColor = disabledBoldColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order["id"],
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Ordered on ${order["orderDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Order Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Services List
                Column(
                  children: (order["services"] as List).map<Widget>((service) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusMd),
                              image: DecorationImage(
                                image: NetworkImage("${order["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service["name"],
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                if (status == "Upcoming")
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${service["scheduledDate"]} at ${service["scheduledTime"]}",
                                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                      ),
                                    ],
                                  ),
                                if (status == "Completed")
                                  Row(
                                    children: [
                                      Icon(Icons.check_circle, size: 14, color: successColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Completed on ${service["scheduledDate"]}",
                                        style: TextStyle(fontSize: 12, color: successColor),
                                      ),
                                    ],
                                  ),
                                if (status == "Cancelled")
                                  Row(
                                    children: [
                                      Icon(Icons.cancel, size: 14, color: dangerColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Cancelled",
                                        style: TextStyle(fontSize: 12, color: dangerColor),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(Icons.person, size: 14, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      service["therapist"],
                                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                    ),
                                    Spacer(),
                                    Text(
                                      "\$${(service["price"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
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
                  }).toList(),
                ),
                
                // Total Amount
                Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
                  ),
                  child: Row(
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
                        "\$${(order["totalAmount"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Review Section (for completed orders)
                if (status == "Completed" && order.containsKey("rating"))
                  Container(
                    margin: EdgeInsets.only(top: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Your Review",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (order["rating"] as double).floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 16,
                                  color: warningColor,
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          order["review"],
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // Cancellation Reason (for cancelled orders)
                if (status == "Cancelled" && order.containsKey("cancellationReason"))
                  Container(
                    margin: EdgeInsets.only(top: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: dangerColor, size: 16),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Reason: ${order["cancellationReason"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                
                SizedBox(height: spSm),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          _viewOrderDetails(order);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    if (status == "Upcoming")
                      Expanded(
                        child: QButton(
                          label: "Modify",
                          size: bs.sm,
                          onPressed: () {
                            _modifyOrder(order);
                          },
                        ),
                      ),
                    if (status == "Completed")
                      Expanded(
                        child: QButton(
                          label: order.containsKey("rating") ? "Update Review" : "Write Review",
                          size: bs.sm,
                          onPressed: () {
                            _writeReview(order);
                          },
                        ),
                      ),
                    if (status == "Cancelled")
                      Expanded(
                        child: QButton(
                          label: "Book Again",
                          size: bs.sm,
                          onPressed: () {
                            _bookAgain(order);
                          },
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

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusXl),
              topRight: Radius.circular(radiusXl),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Text(
                  "Filter Orders",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Column(
                  children: filterOptions.map((option) {
                    final isSelected = selectedFilter == option["value"];
                    
                    return GestureDetector(
                      onTap: () {
                        selectedFilter = option["value"];
                        setState(() {});
                        back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: option["value"],
                              groupValue: selectedFilter,
                              onChanged: (value) {
                                selectedFilter = value!;
                                setState(() {});
                                back();
                              },
                              activeColor: primaryColor,
                            ),
                            Text(
                              option["label"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                color: isSelected ? primaryColor : disabledBoldColor,
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
          ),
        );
      },
    );
  }

  void _viewOrderDetails(Map<String, dynamic> order) {
    // Navigate to order details
    ss("Viewing order details for ${order["id"]}");
  }

  void _modifyOrder(Map<String, dynamic> order) {
    // Navigate to order modification
    ss("Modifying order ${order["id"]}");
  }

  void _writeReview(Map<String, dynamic> order) {
    // Navigate to review page
    ss("Writing review for order ${order["id"]}");
  }

  void _bookAgain(Map<String, dynamic> order) {
    // Navigate to service booking
    ss("Booking services again from order ${order["id"]}");
  }
}
