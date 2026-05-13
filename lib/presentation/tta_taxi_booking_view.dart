import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaTaxiBookingView extends StatefulWidget {
  const TtaTaxiBookingView({super.key});

  @override
  State<TtaTaxiBookingView> createState() => _TtaTaxiBookingViewState();
}

class _TtaTaxiBookingViewState extends State<TtaTaxiBookingView> {
  String pickupLocation = "";
  String dropoffLocation = "";
  String selectedVehicleType = "Standard";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool scheduleRide = false;
  String paymentMethod = "Card";

  List<Map<String, dynamic>> vehicleTypes = [
    {
      "type": "Standard",
      "description": "Affordable everyday rides",
      "capacity": "4 passengers",
      "estimatedPrice": "€12-15",
      "eta": "3-5 min",
      "icon": Icons.directions_car
    },
    {
      "type": "Comfort",
      "description": "Newer cars with extra legroom", 
      "capacity": "4 passengers",
      "estimatedPrice": "€16-20",
      "eta": "5-8 min",
      "icon": Icons.car_rental
    },
    {
      "type": "Premium",
      "description": "High-end cars and top drivers",
      "capacity": "4 passengers", 
      "estimatedPrice": "€25-30",
      "eta": "8-12 min",
      "icon": Icons.dining
    },
    {
      "type": "XL",
      "description": "Extra space for groups",
      "capacity": "6 passengers",
      "estimatedPrice": "€18-22",
      "eta": "6-10 min",
      "icon": Icons.airport_shuttle
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Credit/Debit Card", "value": "Card"},
    {"label": "PayPal", "value": "PayPal"},
    {"label": "Apple Pay", "value": "ApplePay"},
    {"label": "Google Pay", "value": "GooglePay"},
    {"label": "Cash", "value": "Cash"},
  ];

  List<Map<String, dynamic>> nearbyDrivers = [
    {
      "name": "Alexandre Dubois",
      "rating": 4.9,
      "reviewCount": 1247,
      "vehicle": "Toyota Prius",
      "licensePlate": "ABC-123",
      "estimatedArrival": "2 min",
      "distance": "0.3 km"
    },
    {
      "name": "Marie Laurent", 
      "rating": 4.8,
      "reviewCount": 892,
      "vehicle": "Renault Clio",
      "licensePlate": "XYZ-789",
      "estimatedArrival": "4 min",
      "distance": "0.6 km"
    },
    {
      "name": "Pierre Martin",
      "rating": 4.7,
      "reviewCount": 1534,
      "vehicle": "Mercedes E-Class",
      "licensePlate": "LUX-456",
      "estimatedArrival": "6 min",
      "distance": "0.8 km"
    },
  ];

  List<Map<String, dynamic>> recentTrips = [
    {
      "from": "Charles de Gaulle Airport",
      "to": "Eiffel Tower",
      "date": "Yesterday",
      "price": "€45.50",
      "driver": "Jean Michel"
    },
    {
      "from": "Hotel Le Bristol",
      "to": "Louvre Museum", 
      "date": "2 days ago",
      "price": "€18.20",
      "driver": "Sophie Bernard"
    },
    {
      "from": "Gare du Nord",
      "to": "Notre-Dame Cathedral",
      "date": "3 days ago", 
      "price": "€22.80",
      "driver": "Antoine Moreau"
    },
  ];

  void _bookRide() {
    if (pickupLocation.isEmpty || dropoffLocation.isEmpty) {
      se("Please enter pickup and dropoff locations");
      return;
    }

    showLoading();
    
    // Simulate booking process
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Ride booked successfully! Driver will arrive in 3 minutes.");
    });
  }

  void _swapLocations() {
    setState(() {
      String temp = pickupLocation;
      pickupLocation = dropoffLocation;
      dropoffLocation = temp;
    });
  }

  String _getCurrentLocation() {
    return "Current Location (Latitude: 48.8566, Longitude: 2.3522)";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book a Taxi"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Form
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Where are you going?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  // Location Inputs
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Pickup Location",
                          value: pickupLocation,
                          onChanged: (value) {
                            pickupLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.my_location,
                        size: bs.sm,
                        onPressed: () {
                          pickupLocation = _getCurrentLocation();
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Dropoff Location",
                          value: dropoffLocation,
                          onChanged: (value) {
                            dropoffLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: _swapLocations,
                          icon: Icon(
                            Icons.swap_vert,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Schedule Ride Toggle
                  QSwitch(
                    items: [
                      {
                        "label": "Schedule for later",
                        "value": true,
                        "checked": scheduleRide,
                      }
                    ],
                    value: scheduleRide ? [{"label": "Schedule for later", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      scheduleRide = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  // Schedule DateTime (if enabled)
                  if (scheduleRide) ...[
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Date",
                            value: selectedDate,
                            onChanged: (value) {
                              selectedDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Time",
                            value: selectedTime,
                            onChanged: (value) {
                              selectedTime = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Payment Method
                  QDropdownField(
                    label: "Payment Method",
                    items: paymentMethods,
                    value: paymentMethod,
                    onChanged: (value, label) {
                      paymentMethod = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Vehicle Types
            Text(
              "Choose Vehicle Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: List.generate(vehicleTypes.length, (index) {
                final vehicle = vehicleTypes[index];
                bool isSelected = selectedVehicleType == vehicle["type"];
                
                return GestureDetector(
                  onTap: () {
                    selectedVehicleType = "${vehicle["type"]}";
                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(30) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : primaryColor.withAlpha(30),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            vehicle["icon"] as IconData,
                            color: isSelected ? Colors.white : primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${vehicle["type"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : primaryColor,
                                ),
                              ),
                              Text(
                                "${vehicle["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${vehicle["capacity"]}",
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
                          spacing: spXs,
                          children: [
                            Text(
                              "${vehicle["estimatedPrice"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "ETA: ${vehicle["eta"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            // Book Button
            Container(
              width: double.infinity,
              child: QButton(
                label: scheduleRide ? "Schedule Ride" : "Book Now",
                size: bs.md,
                onPressed: _bookRide,
              ),
            ),

            // Nearby Drivers
            Text(
              "Nearby Drivers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: List.generate(nearbyDrivers.length, (index) {
                final driver = nearbyDrivers[index];
                
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${driver["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              spacing: spXs,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 16,
                                ),
                                Text(
                                  "${driver["rating"]} (${driver["reviewCount"]} reviews)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${driver["vehicle"]} • ${driver["licensePlate"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: spXs,
                        children: [
                          Text(
                            "${driver["estimatedArrival"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "${driver["distance"]} away",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),

            // Recent Trips
            Text(
              "Recent Trips",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: List.generate(recentTrips.length, (index) {
                final trip = recentTrips[index];
                
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.history,
                          color: infoColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${trip["from"]} → ${trip["to"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Driver: ${trip["driver"]} • ${trip["date"]}",
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
                        spacing: spXs,
                        children: [
                          Text(
                            "${trip["price"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              pickupLocation = "${trip["from"]}";
                              dropoffLocation = "${trip["to"]}";
                              setState(() {});
                            },
                            child: Icon(
                              Icons.refresh,
                              color: primaryColor,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
