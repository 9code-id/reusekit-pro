import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaRedeemGiftCardView extends StatefulWidget {
  const SpaRedeemGiftCardView({super.key});

  @override
  State<SpaRedeemGiftCardView> createState() => _SpaRedeemGiftCardViewState();
}

class _SpaRedeemGiftCardViewState extends State<SpaRedeemGiftCardView> {
  final formKey = GlobalKey<FormState>();
  
  String giftCardCode = "";
  Map<String, dynamic>? verifiedCard;
  bool isVerifying = false;
  bool isRedeemed = false;
  
  List<Map<String, dynamic>> availableServices = [
    {
      "id": "service1",
      "name": "Swedish Massage",
      "duration": "60 minutes",
      "price": 120.00,
      "description": "Relaxing full-body massage",
      "image": "https://picsum.photos/300/200?random=1&keyword=massage",
      "category": "Massage",
    },
    {
      "id": "service2",
      "name": "Deep Tissue Massage",
      "duration": "90 minutes",
      "price": 150.00,
      "description": "Therapeutic muscle tension relief",
      "image": "https://picsum.photos/300/200?random=2&keyword=therapy",
      "category": "Massage",
    },
    {
      "id": "service3",
      "name": "Facial Treatment",
      "duration": "75 minutes",
      "price": 85.00,
      "description": "Rejuvenating skincare treatment",
      "image": "https://picsum.photos/300/200?random=3&keyword=facial",
      "category": "Skincare",
    },
    {
      "id": "service4",
      "name": "Aromatherapy Session",
      "duration": "60 minutes",
      "price": 110.00,
      "description": "Essential oils relaxation therapy",
      "image": "https://picsum.photos/300/200?random=4&keyword=aromatherapy",
      "category": "Wellness",
    },
    {
      "id": "service5",
      "name": "Hot Stone Massage",
      "duration": "90 minutes",
      "price": 180.00,
      "description": "Heated stone therapeutic massage",
      "image": "https://picsum.photos/300/200?random=5&keyword=stones",
      "category": "Massage",
    },
    {
      "id": "service6",
      "name": "Couples Massage",
      "duration": "60 minutes",
      "price": 240.00,
      "description": "Romantic spa experience for two",
      "image": "https://picsum.photos/300/200?random=6&keyword=couples",
      "category": "Couples",
    },
  ];

  List<String> selectedServices = [];
  String bookingDate = DateTime.now().add(Duration(days: 1)).toIso8601String();
  String bookingTime = "10:00";
  String specialRequests = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem Gift Card"),
        actions: [
          if (verifiedCard != null) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              margin: EdgeInsets.only(right: spMd),
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "\$${(verifiedCard!["balance"] as double).currency}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              if (!isRedeemed) ...[
                // Gift Card Verification Section
                _buildVerificationSection(),
                
                if (verifiedCard != null) ...[
                  // Verified Card Display
                  _buildVerifiedCardSection(),
                  
                  // Service Selection
                  _buildServiceSelectionSection(),
                  
                  if (selectedServices.isNotEmpty) ...[
                    // Booking Details
                    _buildBookingDetailsSection(),
                    
                    // Summary & Redeem
                    _buildSummarySection(),
                  ],
                ],
              ] else
                _buildSuccessSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: verifiedCard != null && selectedServices.isNotEmpty && !isRedeemed
          ? Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: QButton(
                label: "Redeem & Book Services",
                size: bs.md,
                onPressed: _redeemGiftCard,
              ),
            )
          : null,
    );
  }

  Widget _buildVerificationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.card_giftcard,
                  color: primaryColor,
                  size: 28,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Gift Card Code",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Enter your gift card code to verify and redeem",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Gift Card Code",
                  value: giftCardCode,
                  hint: "Enter your gift card code",
                  validator: Validator.required,
                  onChanged: (value) {
                    giftCardCode = value.toUpperCase();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              QButton(
                label: isVerifying ? "Verifying..." : "Verify",
                size: bs.md,
                onPressed: isVerifying ? null : _verifyGiftCard,
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Gift card codes are case-insensitive and typically 10-15 characters long",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
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

  Widget _buildVerifiedCardSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, successColor.withAlpha(150)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.verified,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Gift Card Verified!",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available Balance",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "\$${(verifiedCard!["balance"] as double).currency}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "Expires",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(verifiedCard!["expiryDate"]).dMMMy}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (verifiedCard!["message"] != null && (verifiedCard!["message"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${verifiedCard!["message"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
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

  Widget _buildServiceSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Select Services",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Choose the services you'd like to book with your gift card",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 14,
          ),
        ),

        ResponsiveGridView(
          minItemWidth: 200,
          children: availableServices.map((service) {
            bool isSelected = selectedServices.contains(service["id"]);
            bool canAfford = (verifiedCard!["balance"] as double) >= (service["price"] as double);
            double totalSelected = _getTotalSelectedAmount();
            bool canAddMore = (totalSelected + (service["price"] as double)) <= (verifiedCard!["balance"] as double);
            bool isEnabled = canAfford && (isSelected || canAddMore);
            
            return GestureDetector(
              onTap: isEnabled ? () {
                if (isSelected) {
                  selectedServices.remove(service["id"]);
                } else {
                  selectedServices.add(service["id"]);
                }
                setState(() {});
              } : null,
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(50) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: isSelected ? primaryColor : 
                           isEnabled ? disabledOutlineBorderColor : 
                           disabledColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                          child: Image.network(
                            "${service["image"]}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            color: isEnabled ? null : Colors.grey.withAlpha(100),
                            colorBlendMode: isEnabled ? null : BlendMode.overlay,
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: isEnabled ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "\$${(service["price"] as double).currency}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${service["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: isEnabled ? (isSelected ? primaryColor : primaryColor) : disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${service["duration"]}",
                            style: TextStyle(
                              color: isEnabled ? successColor : disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${service["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          if (!isEnabled && !isSelected)
                            Text(
                              "Insufficient balance",
                              style: TextStyle(
                                color: dangerColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
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
    );
  }

  Widget _buildBookingDetailsSection() {
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
            "Booking Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          QDatePicker(
            label: "Preferred Date",
            value: DateTime.parse(bookingDate),
            onChanged: (value) {
              bookingDate = value.toIso8601String();
              setState(() {});
            },
          ),

          QTimePicker(
            label: "Preferred Time",
            value: bookingTime.timeOfDay,
            onChanged: (value) {
              bookingTime = value!.kkmm;
              setState(() {});
            },
          ),

          QMemoField(
            label: "Special Requests",
            value: specialRequests,
            hint: "Any special requirements or preferences (optional)",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    double totalAmount = _getTotalSelectedAmount();
    double remainingBalance = (verifiedCard!["balance"] as double) - totalAmount;
    List<Map<String, dynamic>> selectedServiceDetails = availableServices
        .where((service) => selectedServices.contains(service["id"]))
        .toList();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
        border: Border.all(color: primaryColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Booking Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...selectedServiceDetails.map((service) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    "${service["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "\$${(service["price"] as double).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            );
          }).toList(),

          Divider(),

          Row(
            children: [
              Text(
                "Total Amount",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Text(
                "\$${totalAmount.currency}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Text(
                "Remaining Balance",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Text(
                "\$${remainingBalance.currency}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: remainingBalance > 0 ? successColor : disabledBoldColor,
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Booking Date: ${DateTime.parse(bookingDate).dMMMy} at $bookingTime",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

  Widget _buildSuccessSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, successColor.withAlpha(150)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Icon(
            Icons.check_circle,
            size: 64,
            color: Colors.white,
          ),
          SizedBox(height: spMd),
          Text(
            "Gift Card Redeemed!",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Your services have been booked successfully. You'll receive a confirmation email shortly.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 16,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "View My Bookings",
            size: bs.md,
            color: Colors.white,
            onPressed: () {
              back();
            },
          ),
        ],
      ),
    );
  }

  double _getTotalSelectedAmount() {
    return selectedServices.fold(0.0, (total, serviceId) {
      Map<String, dynamic>? service = availableServices
          .firstWhere((s) => s["id"] == serviceId);
      return total + (service["price"] as double);
    });
  }

  void _verifyGiftCard() async {
    if (giftCardCode.isEmpty) {
      se("Please enter a gift card code");
      return;
    }

    isVerifying = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    // Simulate verification
    verifiedCard = {
      "id": "GC001",
      "code": giftCardCode,
      "balance": 300.00,
      "originalAmount": 300.00,
      "recipientName": "John Doe",
      "senderName": "Jane Smith",
      "message": "Enjoy your spa day!",
      "purchaseDate": "2024-11-15",
      "expiryDate": "2025-11-15",
      "status": "active",
    };

    isVerifying = false;
    setState(() {});
    ss("Gift card verified successfully!");
  }

  void _redeemGiftCard() async {
    if (selectedServices.isEmpty) {
      se("Please select at least one service");
      return;
    }

    bool isConfirmed = await confirm("Confirm booking and redeem gift card?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      isRedeemed = true;
      setState(() {});
      ss("Gift card redeemed and services booked!");
    }
  }
}
