import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaCancellationView extends StatefulWidget {
  const TtaCancellationView({super.key});

  @override
  State<TtaCancellationView> createState() => _TtaCancellationViewState();
}

class _TtaCancellationViewState extends State<TtaCancellationView> {
  String selectedBookingId = "";
  String cancellationReason = "";
  String additionalComments = "";
  bool agreeToTerms = false;
  bool isRefundable = true;

  List<Map<String, dynamic>> bookings = [
    {
      "id": "BK001",
      "type": "Flight",
      "title": "New York to London",
      "date": "2024-01-15",
      "time": "10:30 AM",
      "amount": 850.0,
      "status": "Confirmed",
      "refundable": true,
      "cancellationFee": 50.0,
      "refundAmount": 800.0,
      "airline": "British Airways",
      "flightNumber": "BA178"
    },
    {
      "id": "BK002", 
      "type": "Hotel",
      "title": "Grand Plaza Hotel",
      "date": "2024-01-16",
      "time": "3:00 PM",
      "amount": 450.0,
      "status": "Confirmed",
      "refundable": true,
      "cancellationFee": 25.0,
      "refundAmount": 425.0,
      "location": "London, UK",
      "nights": "3 nights"
    },
    {
      "id": "BK003",
      "type": "Car Rental",
      "title": "Premium SUV Rental",
      "date": "2024-01-17",
      "time": "9:00 AM", 
      "amount": 280.0,
      "status": "Confirmed",
      "refundable": false,
      "cancellationFee": 280.0,
      "refundAmount": 0.0,
      "company": "Hertz",
      "duration": "5 days"
    },
    {
      "id": "BK004",
      "type": "Tour",
      "title": "City Walking Tour",
      "date": "2024-01-18",
      "time": "2:00 PM",
      "amount": 75.0,
      "status": "Confirmed", 
      "refundable": true,
      "cancellationFee": 15.0,
      "refundAmount": 60.0,
      "duration": "3 hours",
      "groupSize": "2 people"
    }
  ];

  List<Map<String, dynamic>> cancellationReasons = [
    {"label": "Change of travel plans", "value": "change_plans"},
    {"label": "Emergency situation", "value": "emergency"},
    {"label": "Medical reasons", "value": "medical"},
    {"label": "Flight cancelled by airline", "value": "flight_cancelled"},
    {"label": "Hotel issues", "value": "hotel_issues"},
    {"label": "Weather conditions", "value": "weather"},
    {"label": "Other", "value": "other"}
  ];

  void _updateSelectedBooking(String bookingId) {
    final booking = bookings.firstWhere((b) => b["id"] == bookingId);
    isRefundable = booking["refundable"] as bool;
    setState(() {});
  }

  void _submitCancellation() async {
    if (selectedBookingId.isEmpty) {
      se("Please select a booking to cancel");
      return;
    }
    
    if (cancellationReason.isEmpty) {
      se("Please select a cancellation reason");
      return;
    }

    if (!agreeToTerms) {
      se("Please agree to the cancellation terms and conditions");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Cancellation request submitted successfully");
    //navigateTo('tta_refund_status_view')
  }

  @override
  Widget build(BuildContext context) {
    final selectedBooking = selectedBookingId.isNotEmpty 
        ? bookings.firstWhere((b) => b["id"] == selectedBookingId, orElse: () => {})
        : {};

    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Booking"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Cancellation Info Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: warningColor, size: 24),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Important Notice",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Cancellation fees may apply. Please review the terms before proceeding.",
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
            ),

            // Select Booking Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Select Booking to Cancel",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: List.generate(bookings.length, (index) {
                      final booking = bookings[index];
                      final isSelected = selectedBookingId == booking["id"];
                      
                      return GestureDetector(
                        onTap: () {
                          selectedBookingId = booking["id"];
                          _updateSelectedBooking(booking["id"]);
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: _getBookingTypeColor(booking["type"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getBookingTypeIcon(booking["type"]),
                                  color: _getBookingTypeColor(booking["type"]),
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${booking["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${booking["type"]} • ${booking["date"]} at ${booking["time"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${(booking["amount"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: (booking["refundable"] as bool) 
                                                ? successColor.withAlpha(20)
                                                : dangerColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            (booking["refundable"] as bool) ? "Refundable" : "Non-refundable",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: (booking["refundable"] as bool) 
                                                  ? successColor 
                                                  : dangerColor,
                                            ),
                                          ),
                                        ),
                                      ],
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
                    }),
                  ),
                ),
              ],
            ),

            // Cancellation Details
            if (selectedBookingId.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Cancellation Details",
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
                          "Original Amount:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${(selectedBooking["amount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cancellation Fee:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "-\$${(selectedBooking["cancellationFee"] as double).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: disabledColor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Refund Amount:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "\$${(selectedBooking["refundAmount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isRefundable ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Cancellation Reason
              QDropdownField(
                label: "Reason for Cancellation",
                items: cancellationReasons,
                value: cancellationReason,
                onChanged: (value, label) {
                  cancellationReason = value;
                  setState(() {});
                },
              ),

              // Additional Comments
              QMemoField(
                label: "Additional Comments (Optional)",
                value: additionalComments,
                hint: "Please provide any additional details about your cancellation...",
                onChanged: (value) {
                  additionalComments = value;
                  setState(() {});
                },
              ),

              // Terms and Conditions
              QSwitch(
                items: [
                  {
                    "label": "I agree to the cancellation terms and conditions",
                    "value": true,
                    "checked": agreeToTerms,
                  }
                ],
                value: [if (agreeToTerms) {"label": "I agree to the cancellation terms and conditions", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  agreeToTerms = values.isNotEmpty;
                  setState(() {});
                },
              ),

              // Refund Information
              if (isRefundable)
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(50)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Refund Information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "• Refunds typically take 5-7 business days to process\n• You will receive an email confirmation once processed\n• Refund will be credited to your original payment method",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Cancellation Request",
                  size: bs.md,
                  onPressed: _submitCancellation,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getBookingTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'flight':
        return primaryColor;
      case 'hotel':
        return successColor;
      case 'car rental':
        return warningColor;
      case 'tour':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getBookingTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'flight':
        return Icons.flight;
      case 'hotel':
        return Icons.hotel;
      case 'car rental':
        return Icons.directions_car;
      case 'tour':
        return Icons.tour;
      default:
        return Icons.bookmark;
    }
  }
}
