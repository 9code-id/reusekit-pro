import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaTicketPricingView extends StatefulWidget {
  const EmaTicketPricingView({super.key});

  @override
  State<EmaTicketPricingView> createState() => _EmaTicketPricingViewState();
}

class _EmaTicketPricingViewState extends State<EmaTicketPricingView> {
  String selectedTicketType = "vip_package";
  int quantity = 1;
  List<String> selectedAddOns = [];
  String promoCode = "";
  bool showPriceBreakdown = false;
  
  Map<String, dynamic> eventDetails = {
    "name": "Grand Concert 2025",
    "venue": "Madison Square Garden",
    "date": "2025-07-15",
    "time": "19:30",
    "image": "https://picsum.photos/400/300?random=1&keyword=concert",
  };

  List<Map<String, dynamic>> ticketTypes = [
    {
      "id": "vip_package",
      "name": "VIP Experience Package",
      "price": 500.0,
      "description": "Complete VIP experience with premium seating and exclusive perks",
      "available": 25,
      "color": primaryColor,
      "processingFee": 25.0,
      "serviceFee": 15.0,
    },
    {
      "id": "premium_seating",
      "name": "Premium Seating",
      "price": 280.0,
      "description": "Premium seats with excellent view and enhanced comfort",
      "available": 120,
      "color": successColor,
      "processingFee": 15.0,
      "serviceFee": 10.0,
    },
    {
      "id": "regular_admission",
      "name": "Regular Admission",
      "price": 150.0,
      "description": "Standard seating with great view",
      "available": 450,
      "color": infoColor,
      "processingFee": 10.0,
      "serviceFee": 8.0,
    },
    {
      "id": "economy_seats",
      "name": "Economy Seats",
      "price": 80.0,
      "description": "Budget-friendly seating option",
      "available": 300,
      "color": warningColor,
      "processingFee": 5.0,
      "serviceFee": 5.0,
    },
  ];

  List<Map<String, dynamic>> addOns = [
    {
      "id": "parking",
      "name": "VIP Parking",
      "price": 25.0,
      "description": "Reserved parking spot near venue entrance",
      "icon": Icons.local_parking,
      "available": true,
    },
    {
      "id": "merchandise",
      "name": "Official T-Shirt",
      "price": 35.0,
      "description": "Limited edition event t-shirt",
      "icon": Icons.checkroom,
      "available": true,
    },
    {
      "id": "food_package",
      "name": "Food & Beverage Package",
      "price": 45.0,
      "description": "Complimentary drinks and snacks during event",
      "icon": Icons.restaurant,
      "available": true,
    },
    {
      "id": "photo_package",
      "name": "Professional Photos",
      "price": 30.0,
      "description": "Professional photos during the event",
      "icon": Icons.camera_alt,
      "available": false,
    },
    {
      "id": "program",
      "name": "Commemorative Program",
      "price": 15.0,
      "description": "Special edition event program with artist signatures",
      "icon": Icons.book,
      "available": true,
    },
  ];

  List<Map<String, dynamic>> promoCodes = [
    {
      "code": "EARLY2025",
      "discount": 50.0,
      "type": "fixed",
      "description": "Early bird discount",
      "minAmount": 200.0,
    },
    {
      "code": "STUDENT15",
      "discount": 15.0,
      "type": "percentage",
      "description": "Student discount",
      "minAmount": 0.0,
    },
    {
      "code": "GROUP20",
      "discount": 20.0,
      "type": "percentage",
      "description": "Group booking discount",
      "minAmount": 400.0,
    },
  ];

  Map<String, dynamic> getCurrentTicketType() {
    return ticketTypes.firstWhere((type) => type["id"] == selectedTicketType);
  }

  double getSubtotal() {
    final ticketType = getCurrentTicketType();
    double ticketPrice = (ticketType["price"] as double) * quantity;
    double addOnPrice = selectedAddOns.fold(0.0, (sum, addOnId) {
      final addOn = addOns.firstWhere((addon) => addon["id"] == addOnId);
      return sum + ((addOn["price"] as double) * quantity);
    });
    return ticketPrice + addOnPrice;
  }

  double getProcessingFee() {
    final ticketType = getCurrentTicketType();
    return (ticketType["processingFee"] as double) * quantity;
  }

  double getServiceFee() {
    final ticketType = getCurrentTicketType();
    return (ticketType["serviceFee"] as double) * quantity;
  }

  double getTaxes() {
    return getSubtotal() * 0.08; // 8% tax
  }

  double getDiscount() {
    if (promoCode.isEmpty) return 0.0;
    
    final promo = promoCodes.where((p) => p["code"] == promoCode).firstOrNull;
    if (promo == null) return 0.0;
    
    double subtotal = getSubtotal();
    if (subtotal < (promo["minAmount"] as double)) return 0.0;
    
    if (promo["type"] == "percentage") {
      return subtotal * ((promo["discount"] as double) / 100);
    } else {
      return promo["discount"] as double;
    }
  }

  double getTotal() {
    double subtotal = getSubtotal();
    double fees = getProcessingFee() + getServiceFee();
    double taxes = getTaxes();
    double discount = getDiscount();
    return subtotal + fees + taxes - discount;
  }

  void validatePromoCode() {
    if (promoCode.isEmpty) return;
    
    final promo = promoCodes.where((p) => p["code"] == promoCode).firstOrNull;
    if (promo == null) {
      se("Invalid promo code");
      return;
    }
    
    double subtotal = getSubtotal();
    if (subtotal < (promo["minAmount"] as double)) {
      sw("Minimum amount of \$${(promo["minAmount"] as double).currency} required for this promo code");
      return;
    }
    
    ss("Promo code applied successfully!");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentTicketType = getCurrentTicketType();

    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket Pricing"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {
              //navigateTo('PricingHelpView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Info
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                    child: Image.network(
                      "${eventDetails["image"]}",
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${eventDetails["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${eventDetails["venue"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.event, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${DateTime.parse("${eventDetails["date"]}").dMMMy} at ${eventDetails["time"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
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

            // Ticket Type Selection
            Text(
              "Select Ticket Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: ticketTypes.map((ticket) {
                bool isSelected = ticket["id"] == selectedTicketType;
                bool isAvailable = (ticket["available"] as int) > 0;

                return GestureDetector(
                  onTap: isAvailable ? () {
                    selectedTicketType = ticket["id"];
                    setState(() {});
                  } : null,
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? (ticket["color"] as Color).withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? ticket["color"] as Color : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: ticket["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${ticket["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? ticket["color"] as Color : Colors.black87,
                                ),
                              ),
                            ),
                            if (isSelected) ...[
                              Icon(
                                Icons.check_circle,
                                color: ticket["color"] as Color,
                                size: 20,
                              ),
                            ],
                          ],
                        ),
                        Text(
                          "\$${(ticket["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${ticket["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${ticket["available"]} available",
                          style: TextStyle(
                            fontSize: 12,
                            color: isAvailable ? successColor : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Quantity Selection
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quantity",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      QButton(
                        icon: Icons.remove,
                        size: bs.sm,
                        onPressed: quantity > 1 ? () {
                          quantity--;
                          setState(() {});
                        } : null,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "$quantity",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: spMd),
                      QButton(
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: quantity < currentTicketType["available"] ? () {
                          quantity++;
                          setState(() {});
                        } : null,
                      ),
                      Spacer(),
                      Text(
                        "Max: ${currentTicketType["available"]}",
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

            // Add-ons
            Text(
              "Add-ons (Optional)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: addOns.map((addOn) {
                bool isSelected = selectedAddOns.contains(addOn["id"]);
                bool isAvailable = addOn["available"];

                return GestureDetector(
                  onTap: isAvailable ? () {
                    if (isSelected) {
                      selectedAddOns.remove(addOn["id"]);
                    } else {
                      selectedAddOns.add(addOn["id"]);
                    }
                    setState(() {});
                  } : null,
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              addOn["icon"],
                              color: isAvailable ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${addOn["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isAvailable ? Colors.black87 : disabledBoldColor,
                                ),
                              ),
                            ),
                            if (isSelected) ...[
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 20,
                              ),
                            ],
                          ],
                        ),
                        Text(
                          "\$${(addOn["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isAvailable ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${addOn["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (!isAvailable) ...[
                          Text(
                            "Currently unavailable",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
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

            // Promo Code
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Promo Code",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Enter promo code",
                          value: promoCode,
                          hint: "e.g., EARLY2025, STUDENT15",
                          onChanged: (value) {
                            promoCode = value.toUpperCase();
                            setState(() {});
                          },
                        ),
                      ),
                      QButton(
                        label: "Apply",
                        size: bs.sm,
                        onPressed: promoCode.isNotEmpty ? validatePromoCode : null,
                      ),
                    ],
                  ),
                  if (getDiscount() > 0) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "Promo code applied! You saved \$${getDiscount().currency}",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Price Breakdown
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "Price Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showPriceBreakdown = !showPriceBreakdown;
                          setState(() {});
                        },
                        child: Row(
                          spacing: spXs,
                          children: [
                            Text(
                              showPriceBreakdown ? "Hide" : "Show",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              showPriceBreakdown ? Icons.expand_less : Icons.expand_more,
                              color: primaryColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (showPriceBreakdown) ...[
                    Divider(),
                    Row(
                      children: [
                        Text("${currentTicketType["name"]} x $quantity"),
                        Spacer(),
                        Text("\$${((currentTicketType["price"] as double) * quantity).currency}"),
                      ],
                    ),
                    if (selectedAddOns.isNotEmpty) ...[
                      ...selectedAddOns.map((addOnId) {
                        final addOn = addOns.firstWhere((a) => a["id"] == addOnId);
                        return Row(
                          children: [
                            Text("${addOn["name"]} x $quantity"),
                            Spacer(),
                            Text("\$${((addOn["price"] as double) * quantity).currency}"),
                          ],
                        );
                      }),
                    ],
                    Divider(),
                    Row(
                      children: [
                        Text("Subtotal"),
                        Spacer(),
                        Text("\$${getSubtotal().currency}"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Processing Fee"),
                        Spacer(),
                        Text("\$${getProcessingFee().currency}"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Service Fee"),
                        Spacer(),
                        Text("\$${getServiceFee().currency}"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Taxes (8%)"),
                        Spacer(),
                        Text("\$${getTaxes().currency}"),
                      ],
                    ),
                    if (getDiscount() > 0) ...[
                      Row(
                        children: [
                          Text(
                            "Discount ($promoCode)",
                            style: TextStyle(color: successColor),
                          ),
                          Spacer(),
                          Text(
                            "-\$${getDiscount().currency}",
                            style: TextStyle(color: successColor),
                          ),
                        ],
                      ),
                    ],
                    Divider(),
                  ],

                  Row(
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${getTotal().currency}",
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
            ),

            // Continue Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue to Booking",
                size: bs.md,
                onPressed: () {
                  //navigateTo('EmaTicketBookingView')
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
