import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaRentalManagementView extends StatefulWidget {
  const CmaRentalManagementView({super.key});

  @override
  State<CmaRentalManagementView> createState() => _CmaRentalManagementViewState();
}

class _CmaRentalManagementViewState extends State<CmaRentalManagementView> {
  String selectedTab = "current";
  String filterStatus = "all";

  List<Map<String, dynamic>> currentRentals = [
    {
      "id": "1",
      "vehicle": "2024 Toyota Camry",
      "rental_company": "Enterprise",
      "pickup_date": "2024-03-15",
      "return_date": "2024-03-22",
      "pickup_location": "Downtown Branch",
      "return_location": "Airport Terminal",
      "daily_rate": 65.00,
      "total_cost": 455.00,
      "confirmation_number": "ENT-789456",
      "status": "active",
      "mileage_limit": 1500,
      "current_mileage": 450,
      "fuel_policy": "full_to_full",
      "insurance_type": "full_coverage",
      "image": "https://picsum.photos/300/200?random=1&keyword=toyota",
      "extras": ["GPS", "Child Seat", "Additional Driver"],
      "contact_number": "+1-800-RENT-CAR"
    },
    {
      "id": "2",
      "vehicle": "2024 Jeep Wrangler",
      "rental_company": "Hertz",
      "pickup_date": "2024-03-20",
      "return_date": "2024-03-25",
      "pickup_location": "Airport Terminal A",
      "return_location": "Airport Terminal A",
      "daily_rate": 89.00,
      "total_cost": 445.00,
      "confirmation_number": "HTZ-123789",
      "status": "upcoming",
      "mileage_limit": 1000,
      "current_mileage": 0,
      "fuel_policy": "full_to_full",
      "insurance_type": "basic",
      "image": "https://picsum.photos/300/200?random=2&keyword=jeep",
      "extras": ["4WD Package"],
      "contact_number": "+1-800-HERTZ-1"
    }
  ];

  List<Map<String, dynamic>> rentalHistory = [
    {
      "id": "3",
      "vehicle": "2023 Honda Accord",
      "rental_company": "Budget",
      "pickup_date": "2024-02-10",
      "return_date": "2024-02-17",
      "pickup_location": "City Center",
      "return_location": "City Center",
      "daily_rate": 55.00,
      "total_cost": 385.00,
      "confirmation_number": "BUD-456123",
      "status": "completed",
      "final_mileage": 890,
      "mileage_charges": 0,
      "fuel_charges": 0,
      "damage_charges": 0,
      "additional_fees": 15.00,
      "total_charges": 400.00,
      "image": "https://picsum.photos/300/200?random=3&keyword=honda",
      "rating_given": 4
    },
    {
      "id": "4",
      "vehicle": "2023 Ford Mustang",
      "rental_company": "Alamo",
      "pickup_date": "2024-01-05",
      "return_date": "2024-01-12",
      "pickup_location": "Airport Terminal B",
      "return_location": "Downtown Branch",
      "daily_rate": 125.00,
      "total_cost": 875.00,
      "confirmation_number": "ALM-789012",
      "status": "completed",
      "final_mileage": 1200,
      "mileage_charges": 45.00,
      "fuel_charges": 65.00,
      "damage_charges": 0,
      "additional_fees": 25.00,
      "total_charges": 1010.00,
      "image": "https://picsum.photos/300/200?random=4&keyword=mustang",
      "rating_given": 3
    }
  ];

  List<Map<String, dynamic>> upcomingReservations = [
    {
      "id": "5",
      "vehicle": "2024 BMW X5",
      "rental_company": "Avis",
      "pickup_date": "2024-04-01",
      "return_date": "2024-04-08",
      "pickup_location": "Luxury Car Center",
      "return_location": "Luxury Car Center",
      "daily_rate": 155.00,
      "total_cost": 1085.00,
      "confirmation_number": "AVS-567890",
      "status": "reserved",
      "mileage_limit": 1750,
      "fuel_policy": "full_to_full",
      "insurance_type": "premium",
      "image": "https://picsum.photos/300/200?random=5&keyword=bmw",
      "extras": ["Premium Package", "Concierge Service"],
      "contact_number": "+1-800-AVIS-123"
    }
  ];

  List<Map<String, dynamic>> rentalAlerts = [
    {
      "type": "return_reminder",
      "title": "Return Due Soon",
      "message": "Toyota Camry due back in 2 days",
      "severity": "warning",
      "rental_id": "1",
      "icon": Icons.schedule
    },
    {
      "type": "pickup_reminder",
      "title": "Pickup Tomorrow",
      "message": "Jeep Wrangler pickup scheduled for tomorrow",
      "severity": "info",
      "rental_id": "2",
      "icon": Icons.car_rental
    },
    {
      "type": "mileage_warning",
      "title": "Mileage Check",
      "message": "30% of mileage limit used on current rental",
      "severity": "info",
      "rental_id": "1",
      "icon": Icons.speed
    }
  ];

  List<Map<String, dynamic>> get filteredRentals {
    List<Map<String, dynamic>> allRentals = [
      ...currentRentals,
      ...upcomingReservations,
    ];

    if (filterStatus != "all") {
      allRentals = allRentals.where((rental) => rental["status"] == filterStatus).toList();
    }

    return allRentals;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "upcoming":
      case "reserved":
        return infoColor;
      case "completed":
        return primaryColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "active":
        return Icons.directions_car;
      case "upcoming":
      case "reserved":
        return Icons.schedule;
      case "completed":
        return Icons.check_circle;
      case "cancelled":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rental Management"),
        actions: [
          IconButton(
            onPressed: () {
              _showQuickActions();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // Alerts Section
          if (rentalAlerts.isNotEmpty) ...[
            Container(
              height: 100,
              child: QHorizontalScroll(
                children: rentalAlerts.map((alert) {
                  Color alertColor;
                  switch (alert["severity"]) {
                    case "warning":
                      alertColor = warningColor;
                      break;
                    case "danger":
                      alertColor = dangerColor;
                      break;
                    default:
                      alertColor = infoColor;
                  }

                  return Container(
                    width: 260,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: alertColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: alertColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              alert["icon"] as IconData,
                              color: alertColor,
                              size: 18,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${alert["title"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: alertColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${alert["message"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: alertColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: spMd),
          ],

          // Tab Selection
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: [
                {"label": "Current & Upcoming", "value": "current"},
                {"label": "Rental History", "value": "history"},
                {"label": "Manage Bookings", "value": "manage"},
              ],
              value: selectedTab,
              onChanged: (index, label, value, item) {
                selectedTab = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spMd),

          // Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "current":
        return _buildCurrentRentals();
      case "history":
        return _buildRentalHistory();
      case "manage":
        return _buildManageBookings();
      default:
        return _buildCurrentRentals();
    }
  }

  Widget _buildCurrentRentals() {
    List<Map<String, dynamic>> allRentals = [...currentRentals, ...upcomingReservations];
    
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: allRentals.length,
      itemBuilder: (context, index) {
        final rental = allRentals[index];
        final statusColor = _getStatusColor(rental["status"]);
        final statusIcon = _getStatusIcon(rental["status"]);

        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              // Vehicle Image
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Stack(
                  children: [
                    Image.network(
                      "${rental["image"]}",
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(statusIcon, size: 12, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              "${rental["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusXs),
                          boxShadow: [shadowSm],
                        ),
                        child: Text(
                          "${rental["rental_company"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Rental Details
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Vehicle & Confirmation
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${rental["vehicle"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Confirmation: ${rental["confirmation_number"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${(rental["daily_rate"] as double).currency}/day",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Rental Period
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: primaryColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Pickup: ${DateTime.parse(rental["pickup_date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "Return: ${DateTime.parse(rental["return_date"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: primaryColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "From: ${rental["pickup_location"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (rental["pickup_location"] != rental["return_location"]) ...[
                            SizedBox(height: 2),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    "To: ${rental["return_location"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: spSm),

                    // Rental Stats (for active rentals)
                    if (rental["status"] == "active") ...[
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mileage Used",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${rental["current_mileage"]} / ${rental["mileage_limit"]} miles",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Days Left",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(rental["return_date"]).difference(DateTime.now()).inDays}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Total Cost",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(rental["total_cost"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),
                    ],

                    // Extras & Features
                    if (rental["extras"] != null && (rental["extras"] as List).isNotEmpty) ...[
                      Wrap(
                        spacing: spXs,
                        runSpacing: 4,
                        children: (rental["extras"] as List).map((extra) => 
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$extra",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ).toList(),
                      ),

                      SizedBox(height: spSm),
                    ],

                    // Action Buttons
                    Row(
                      children: [
                        if (rental["status"] == "active") ...[
                          Expanded(
                            child: QButton(
                              label: "Extend Rental",
                              size: bs.sm,
                              onPressed: () {
                                _extendRental(rental);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Contact Support",
                              size: bs.sm,
                              onPressed: () {
                                _contactSupport(rental);
                              },
                            ),
                          ),
                        ] else if (rental["status"] == "upcoming" || rental["status"] == "reserved") ...[
                          Expanded(
                            child: QButton(
                              label: "Modify Booking",
                              size: bs.sm,
                              onPressed: () {
                                _modifyBooking(rental);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Cancel",
                              size: bs.sm,
                              onPressed: () {
                                _cancelBooking(rental);
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRentalHistory() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: rentalHistory.length,
      itemBuilder: (context, index) {
        final rental = rentalHistory[index];
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${rental["image"]}",
                      width: 80,
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
                          "${rental["vehicle"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${rental["rental_company"]} • ${DateTime.parse(rental["pickup_date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        if (rental["rating_given"] != null) ...[
                          Row(
                            children: [
                              ...List.generate(5, (starIndex) => 
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: starIndex < (rental["rating_given"] as int) ? warningColor : disabledColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${rental["rating_given"]}/5",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "COMPLETED",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: spSm),

              // Final Bill Summary
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    _buildBillRow("Base Rental", rental["total_cost"] as double),
                    if ((rental["mileage_charges"] as double) > 0)
                      _buildBillRow("Mileage Charges", rental["mileage_charges"] as double),
                    if ((rental["fuel_charges"] as double) > 0)
                      _buildBillRow("Fuel Charges", rental["fuel_charges"] as double),
                    if ((rental["damage_charges"] as double) > 0)
                      _buildBillRow("Damage Charges", rental["damage_charges"] as double),
                    if ((rental["additional_fees"] as double) > 0)
                      _buildBillRow("Additional Fees", rental["additional_fees"] as double),
                    Container(
                      height: 1,
                      color: primaryColor.withAlpha(100),
                      margin: EdgeInsets.symmetric(vertical: spXs),
                    ),
                    _buildBillRow("Total Charges", rental["total_charges"] as double, isTotal: true),
                  ],
                ),
              ),

              SizedBox(height: spSm),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Receipt",
                      size: bs.sm,
                      onPressed: () {
                        _viewReceipt(rental);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Book Again",
                      size: bs.sm,
                      onPressed: () {
                        _bookAgain(rental);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildManageBookings() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filter Bookings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All Statuses", "value": "all"},
                    {"label": "Active", "value": "active"},
                    {"label": "Upcoming", "value": "upcoming"},
                    {"label": "Reserved", "value": "reserved"},
                  ],
                  value: filterStatus,
                  onChanged: (value, label) {
                    filterStatus = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),

                _buildQuickActionTile(
                  "New Reservation",
                  "Book a new rental car",
                  Icons.add_box,
                  () => _newReservation(),
                ),
                _buildQuickActionTile(
                  "Find My Rental",
                  "Locate current rental vehicle",
                  Icons.my_location,
                  () => _findMyRental(),
                ),
                _buildQuickActionTile(
                  "Emergency Assistance",
                  "24/7 roadside assistance",
                  Icons.emergency,
                  () => _emergencyAssistance(),
                ),
                _buildQuickActionTile(
                  "Rental History Report",
                  "Download complete rental history",
                  Icons.download,
                  () => _downloadHistory(),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Filtered Bookings List
          Text(
            "Bookings (${filteredRentals.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          Column(
            children: filteredRentals.map((rental) {
              final statusColor = _getStatusColor(rental["status"]);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: statusColor.withAlpha(100)),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 50,
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${rental["vehicle"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${rental["rental_company"]} • ${rental["confirmation_number"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(rental["pickup_date"]).dMMMy} - ${DateTime.parse(rental["return_date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${rental["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${(rental["total_cost"] as double).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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

  Widget _buildBillRow(String label, double amount, {bool isTotal = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 13 : 12,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? primaryColor : disabledBoldColor,
              ),
            ),
          ),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              fontSize: isTotal ? 13 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? primaryColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionTile(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radiusSm),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(icon, color: primaryColor, size: 20),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
          ],
        ),
      ),
    );
  }

  void _extendRental(Map<String, dynamic> rental) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Extend Rental"),
        content: Text("Extend your rental for ${rental["vehicle"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Rental extension request submitted");
            },
            child: Text("Extend"),
          ),
        ],
      ),
    );
  }

  void _contactSupport(Map<String, dynamic> rental) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contact Support"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rental: ${rental["vehicle"]}"),
            Text("Company: ${rental["rental_company"]}"),
            Text("Phone: ${rental["contact_number"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Calling ${rental["contact_number"]}");
            },
            child: Text("Call"),
          ),
        ],
      ),
    );
  }

  void _modifyBooking(Map<String, dynamic> rental) {
    si("Opening booking modification for ${rental["confirmation_number"]}");
  }

  void _cancelBooking(Map<String, dynamic> rental) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel Booking"),
        content: Text("Are you sure you want to cancel this reservation?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Keep"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Booking cancelled successfully");
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _viewReceipt(Map<String, dynamic> rental) {
    si("Displaying receipt for ${rental["confirmation_number"]}");
  }

  void _bookAgain(Map<String, dynamic> rental) {
    si("Starting new reservation for ${rental["vehicle"]}");
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            _buildQuickActionTile("New Reservation", "Book a new rental car", Icons.add_box, () => _newReservation()),
            _buildQuickActionTile("Emergency Assistance", "24/7 roadside help", Icons.emergency, () => _emergencyAssistance()),
            _buildQuickActionTile("Find My Rental", "Locate current vehicle", Icons.my_location, () => _findMyRental()),
          ],
        ),
      ),
    );
  }

  void _newReservation() {
    Navigator.pop(context);
    si("Opening new rental reservation");
  }

  void _emergencyAssistance() {
    Navigator.pop(context);
    si("Connecting to emergency assistance");
  }

  void _findMyRental() {
    Navigator.pop(context);
    si("Locating your rental vehicle");
  }

  void _downloadHistory() {
    si("Downloading rental history report");
  }
}
