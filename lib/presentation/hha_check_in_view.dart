import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaCheckInView extends StatefulWidget {
  const HhaCheckInView({super.key});

  @override
  State<HhaCheckInView> createState() => _HhaCheckInViewState();
}

class _HhaCheckInViewState extends State<HhaCheckInView> {
  int currentStep = 0;
  bool isLoading = false;
  String searchQuery = "";
  
  // Check-in form data
  Map<String, dynamic> checkInData = {
    "confirmationNumber": "",
    "guestName": "",
    "email": "",
    "phone": "",
    "arrivalTime": "",
    "roomNumber": "",
    "keyCards": 2,
    "parking": false,
    "breakfast": false,
    "specialRequests": "",
    "identificationVerified": false,
    "paymentConfirmed": false,
    "agreementSigned": false,
  };

  // Sample reservation data
  List<Map<String, dynamic>> reservations = [
    {
      "confirmationNumber": "HTL-2024-061501",
      "guestName": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 234 567 8900",
      "checkInDate": "2024-06-15",
      "checkOutDate": "2024-06-18",
      "roomType": "Deluxe Suite",
      "roomNumber": "1205",
      "adults": 2,
      "children": 1,
      "status": "Confirmed",
      "arrivalTime": "15:30",
      "totalAmount": 864.0,
      "paidAmount": 432.0,
      "remainingBalance": 432.0,
      "specialRequests": "High floor room with city view, late check-out requested",
      "services": ["Airport Pickup", "Spa Package"],
      "vipGuest": true,
      "loyaltyMember": "Gold",
    },
    {
      "confirmationNumber": "HTL-2024-061502",
      "guestName": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "phone": "+1 234 567 8901",
      "checkInDate": "2024-06-15",
      "checkOutDate": "2024-06-16",
      "roomType": "Standard Room",
      "roomNumber": "0807",
      "adults": 1,
      "children": 0,
      "status": "Confirmed",
      "arrivalTime": "14:00",
      "totalAmount": 120.0,
      "paidAmount": 120.0,
      "remainingBalance": 0.0,
      "specialRequests": "",
      "services": [],
      "vipGuest": false,
      "loyaltyMember": null,
    },
    {
      "confirmationNumber": "HTL-2024-061503",
      "guestName": "Michael Brown",
      "email": "m.brown@email.com",
      "phone": "+1 234 567 8902",
      "checkInDate": "2024-06-15",
      "checkOutDate": "2024-06-20",
      "roomType": "Presidential Suite",
      "roomNumber": "2001",
      "adults": 2,
      "children": 0,
      "status": "Confirmed",
      "arrivalTime": "16:00",
      "totalAmount": 2500.0,
      "paidAmount": 1250.0,
      "remainingBalance": 1250.0,
      "specialRequests": "Welcome amenities, private dining setup",
      "services": ["Airport Pickup", "Private Butler", "Spa Package"],
      "vipGuest": true,
      "loyaltyMember": "Platinum",
    },
  ];

  List<Map<String, dynamic>> checkInSteps = [
    {
      "title": "Search Reservation",
      "description": "Find guest reservation by confirmation number or name",
      "icon": Icons.search,
      "completed": false,
    },
    {
      "title": "Verify Identity",
      "description": "Check guest identification and verify booking details",
      "icon": Icons.verified_user,
      "completed": false,
    },
    {
      "title": "Room Assignment",
      "description": "Assign room and prepare key cards",
      "icon": Icons.room_service,
      "completed": false,
    },
    {
      "title": "Final Details",
      "description": "Confirm services, payment, and complete check-in",
      "icon": Icons.assignment_turned_in,
      "completed": false,
    },
  ];

  Map<String, dynamic>? selectedReservation;

  List<Map<String, dynamic>> get filteredReservations {
    return reservations.where((reservation) {
      return searchQuery.isEmpty ||
          reservation["confirmationNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          reservation["guestName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          reservation["email"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      case 'checked-in':
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Color _getLoyaltyColor(String? level) {
    switch (level?.toLowerCase()) {
      case 'platinum':
        return Color(0xFF9C88FF);
      case 'gold':
        return Color(0xFFFFD700);
      case 'silver':
        return Color(0xFFC0C0C0);
      default:
        return disabledColor;
    }
  }

  Widget _buildSearchStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Search Guest Reservation",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Enter confirmation number, guest name, or email to find the reservation.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Search reservations...",
          value: searchQuery,
          hint: "Confirmation number, name, or email",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        if (filteredReservations.isNotEmpty) ...[
          Text(
            "Today's Check-ins (${filteredReservations.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: filteredReservations.map((reservation) {
              bool isSelected = selectedReservation?["confirmationNumber"] == reservation["confirmationNumber"];
              
              return GestureDetector(
                onTap: () {
                  selectedReservation = reservation;
                  checkInData["confirmationNumber"] = reservation["confirmationNumber"];
                  checkInData["guestName"] = reservation["guestName"];
                  checkInData["email"] = reservation["email"];
                  checkInData["phone"] = reservation["phone"];
                  checkInData["roomNumber"] = reservation["roomNumber"];
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${reservation["guestName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Conf: ${reservation["confirmationNumber"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(reservation["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${reservation["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(reservation["status"]),
                                  ),
                                ),
                              ),
                              if (reservation["vipGuest"] == true) ...[
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "VIP",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                              if (reservation["loyaltyMember"] != null) ...[
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getLoyaltyColor(reservation["loyaltyMember"]),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${reservation["loyaltyMember"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${reservation["roomType"]} - Room ${reservation["roomNumber"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${reservation["adults"]} Adult(s)${(reservation["children"] as int) > 0 ? ', ${reservation["children"]} Child(ren)' : ''}",
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
                                "Arrival: ${reservation["arrivalTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Stay: ${DateTime.parse(reservation["checkInDate"]).dMMMy} - ${DateTime.parse(reservation["checkOutDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if ((reservation["remainingBalance"] as double) > 0) ...[
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning, size: 16, color: warningColor),
                              SizedBox(width: spXs),
                              Text(
                                "Outstanding Balance: \$${(reservation["remainingBalance"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ] else if (searchQuery.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Icon(Icons.search_off, size: 48, color: infoColor),
                SizedBox(height: spSm),
                Text(
                  "No reservations found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Try searching with a different confirmation number, name, or email.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVerificationStep() {
    if (selectedReservation == null) return Container();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Identity Verification",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Verify guest identity and confirm booking details.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Guest Information Card
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: primaryColor.withAlpha(20),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedReservation!["guestName"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${selectedReservation!["email"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${selectedReservation!["phone"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              // Booking Details
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Confirmation:", style: TextStyle(fontSize: 12)),
                        Text(
                          "${selectedReservation!["confirmationNumber"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Room:", style: TextStyle(fontSize: 12)),
                        Text(
                          "${selectedReservation!["roomType"]} - ${selectedReservation!["roomNumber"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Guests:", style: TextStyle(fontSize: 12)),
                        Text(
                          "${selectedReservation!["adults"]} Adults${(selectedReservation!["children"] as int) > 0 ? ', ${selectedReservation!["children"]} Children' : ''}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Stay:", style: TextStyle(fontSize: 12)),
                        Text(
                          "${DateTime.parse(selectedReservation!["checkInDate"]).dMMMy} - ${DateTime.parse(selectedReservation!["checkOutDate"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
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
        ),
        
        SizedBox(height: spMd),
        
        // Verification Checklist
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verification Checklist",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QSwitch(
                items: [
                  {
                    "label": "Government ID verified (passport, driver's license)",
                    "value": "id_verified",
                    "checked": checkInData["identificationVerified"],
                  }
                ],
                value: checkInData["identificationVerified"] ? [{"label": "Government ID verified (passport, driver's license)", "value": "id_verified", "checked": true}] : [],
                onChanged: (values, ids) {
                  checkInData["identificationVerified"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Guest signature obtained",
                    "value": "signature",
                    "checked": checkInData["agreementSigned"],
                  }
                ],
                value: checkInData["agreementSigned"] ? [{"label": "Guest signature obtained", "value": "signature", "checked": true}] : [],
                onChanged: (values, ids) {
                  checkInData["agreementSigned"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoomAssignmentStep() {
    if (selectedReservation == null) return Container();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Room Assignment & Key Cards",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Prepare room and generate key cards for guest.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Room Information
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/200/200?random=3&keyword=hotel-room"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Room ${selectedReservation!["roomNumber"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${selectedReservation!["roomType"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Floor ${(selectedReservation!["roomNumber"] as String).substring(0, 1)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Ready",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              // Room Status Checks
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 16, color: successColor),
                        SizedBox(width: spXs),
                        Text(
                          "Room cleaned and inspected",
                          style: TextStyle(fontSize: 12, color: successColor),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 16, color: successColor),
                        SizedBox(width: spXs),
                        Text(
                          "Amenities restocked",
                          style: TextStyle(fontSize: 12, color: successColor),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 16, color: successColor),
                        SizedBox(width: spXs),
                        Text(
                          "Climate control set to 72°F",
                          style: TextStyle(fontSize: 12, color: successColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Key Card Settings
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Key Card Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QNumberField(
                label: "Number of Key Cards",
                value: checkInData["keyCards"].toString(),
                onChanged: (value) {
                  checkInData["keyCards"] = int.tryParse(value) ?? 2;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Generate Key Cards",
                        size: bs.md,
                        onPressed: () => _generateKeyCards(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFinalDetailsStep() {
    if (selectedReservation == null) return Container();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Final Check-in Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Confirm services, handle payment, and complete check-in process.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Payment Summary
        if ((selectedReservation!["remainingBalance"] as double) > 0) ...[
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Amount:", style: TextStyle(fontSize: 14)),
                    Text(
                      "\$${(selectedReservation!["totalAmount"] as double).currency}",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Paid Amount:", style: TextStyle(fontSize: 14)),
                    Text(
                      "\$${(selectedReservation!["paidAmount"] as double).currency}",
                      style: TextStyle(fontSize: 14, color: successColor),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Outstanding Balance:", style: TextStyle(fontSize: 14)),
                    Text(
                      "\$${(selectedReservation!["remainingBalance"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                QSwitch(
                  items: [
                    {
                      "label": "Payment collected and processed",
                      "value": "payment_confirmed",
                      "checked": checkInData["paymentConfirmed"],
                    }
                  ],
                  value: checkInData["paymentConfirmed"] ? [{"label": "Payment collected and processed", "value": "payment_confirmed", "checked": true}] : [],
                  onChanged: (values, ids) {
                    checkInData["paymentConfirmed"] = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                if (!checkInData["paymentConfirmed"]) ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Process Payment",
                          size: bs.sm,
                          onPressed: () => _processPayment(),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spMd),
        ],
        
        // Additional Services
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Additional Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QSwitch(
                items: [
                  {
                    "label": "Parking space required",
                    "value": "parking",
                    "checked": checkInData["parking"],
                  }
                ],
                value: checkInData["parking"] ? [{"label": "Parking space required", "value": "parking", "checked": true}] : [],
                onChanged: (values, ids) {
                  checkInData["parking"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Breakfast package included",
                    "value": "breakfast",
                    "checked": checkInData["breakfast"],
                  }
                ],
                value: checkInData["breakfast"] ? [{"label": "Breakfast package included", "value": "breakfast", "checked": true}] : [],
                onChanged: (values, ids) {
                  checkInData["breakfast"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Special Requests
        if (selectedReservation!["specialRequests"] != null && 
            (selectedReservation!["specialRequests"] as String).isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
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
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${selectedReservation!["specialRequests"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
        ],
        
        // Additional Notes
        QMemoField(
          label: "Check-in Notes",
          value: checkInData["specialRequests"],
          hint: "Any additional notes or observations during check-in...",
          onChanged: (value) {
            checkInData["specialRequests"] = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: checkInSteps.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> step = entry.value;
          bool isActive = index == currentStep;
          bool isCompleted = step["completed"] || index < currentStep;
          
          return Expanded(
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCompleted ? successColor : (isActive ? primaryColor : disabledColor),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check : step["icon"],
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${step["title"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isCompleted ? successColor : (isActive ? primaryColor : disabledBoldColor),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (currentStep) {
      case 0:
        return _buildSearchStep();
      case 1:
        return _buildVerificationStep();
      case 2:
        return _buildRoomAssignmentStep();
      case 3:
        return _buildFinalDetailsStep();
      default:
        return Container();
    }
  }

  bool _canProceedToNextStep() {
    switch (currentStep) {
      case 0:
        return selectedReservation != null;
      case 1:
        return checkInData["identificationVerified"] && checkInData["agreementSigned"];
      case 2:
        return true; // Room assignment is always ready
      case 3:
        return selectedReservation!["remainingBalance"] == 0 || checkInData["paymentConfirmed"];
      default:
        return false;
    }
  }

  void _nextStep() {
    if (_canProceedToNextStep() && currentStep < checkInSteps.length - 1) {
      checkInSteps[currentStep]["completed"] = true;
      currentStep++;
      setState(() {});
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _generateKeyCards() async {
    setState(() {
      isLoading = true;
    });
    
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      isLoading = false;
    });
    
    ss("${checkInData["keyCards"]} key cards generated successfully!");
  }

  void _processPayment() async {
    setState(() {
      isLoading = true;
    });
    
    await Future.delayed(Duration(seconds: 3));
    
    setState(() {
      isLoading = false;
      checkInData["paymentConfirmed"] = true;
      selectedReservation!["paidAmount"] = selectedReservation!["totalAmount"];
      selectedReservation!["remainingBalance"] = 0.0;
    });
    
    ss("Payment processed successfully!");
  }

  void _completeCheckIn() async {
    if (!_canProceedToNextStep()) {
      se("Please complete all required steps before finishing check-in.");
      return;
    }
    
    bool isConfirmed = await confirm("Complete check-in for ${selectedReservation!["guestName"]}?");
    if (!isConfirmed) return;
    
    setState(() {
      isLoading = true;
    });
    
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      isLoading = false;
      selectedReservation!["status"] = "Checked-in";
      checkInSteps[currentStep]["completed"] = true;
    });
    
    ss("Check-in completed successfully! Welcome ${selectedReservation!["guestName"]}!");
    
    // Reset for next guest
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        currentStep = 0;
        selectedReservation = null;
        checkInData = {
          "confirmationNumber": "",
          "guestName": "",
          "email": "",
          "phone": "",
          "arrivalTime": "",
          "roomNumber": "",
          "keyCards": 2,
          "parking": false,
          "breakfast": false,
          "specialRequests": "",
          "identificationVerified": false,
          "paymentConfirmed": false,
          "agreementSigned": false,
        };
        for (var step in checkInSteps) {
          step["completed"] = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Processing...",
                style: TextStyle(
                  fontSize: fsH6,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Check-in"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                searchQuery = "";
                selectedReservation = null;
                currentStep = 0;
                for (var step in checkInSteps) {
                  step["completed"] = false;
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildStepIndicator(),
            SizedBox(height: spMd),
            _buildCurrentStepContent(),
            SizedBox(height: spMd),
            
            // Navigation Buttons
            Row(
              children: [
                if (currentStep > 0) ...[
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      onPressed: _previousStep,
                    ),
                  ),
                  SizedBox(width: spSm),
                ],
                Expanded(
                  child: QButton(
                    label: currentStep == checkInSteps.length - 1 ? "Complete Check-in" : "Next",
                    size: bs.md,
                    onPressed: currentStep == checkInSteps.length - 1 ? _completeCheckIn : (_canProceedToNextStep() ? _nextStep : null),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
