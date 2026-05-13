import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaRefundStatusView extends StatefulWidget {
  const TtaRefundStatusView({super.key});

  @override
  State<TtaRefundStatusView> createState() => _TtaRefundStatusViewState();
}

class _TtaRefundStatusViewState extends State<TtaRefundStatusView> {
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> refundRequests = [
    {
      "id": "REF001",
      "bookingId": "BK001",
      "type": "Flight",
      "title": "New York to London",
      "requestDate": "2024-01-10",
      "originalAmount": 850.0,
      "cancellationFee": 50.0,
      "refundAmount": 800.0,
      "status": "completed",
      "processedDate": "2024-01-12",
      "estimatedDays": "5-7",
      "actualDays": 2,
      "reason": "Change of travel plans",
      "transactionId": "TXN123456789",
      "paymentMethod": "Credit Card ending in 4567"
    },
    {
      "id": "REF002",
      "bookingId": "BK002",
      "type": "Hotel",
      "title": "Grand Plaza Hotel",
      "requestDate": "2024-01-08",
      "originalAmount": 450.0,
      "cancellationFee": 25.0,
      "refundAmount": 425.0,
      "status": "processing",
      "processedDate": null,
      "estimatedDays": "5-7",
      "actualDays": null,
      "reason": "Emergency situation",
      "transactionId": null,
      "paymentMethod": "Credit Card ending in 1234"
    },
    {
      "id": "REF003",
      "bookingId": "BK003",
      "type": "Tour",
      "title": "City Walking Tour",
      "requestDate": "2024-01-15",
      "originalAmount": 75.0,
      "cancellationFee": 15.0,
      "refundAmount": 60.0,
      "status": "pending",
      "processedDate": null,
      "estimatedDays": "3-5",
      "actualDays": null,
      "reason": "Weather conditions",
      "transactionId": null,
      "paymentMethod": "PayPal"
    },
    {
      "id": "REF004",
      "bookingId": "BK004",
      "type": "Car Rental",
      "title": "Economy Car Rental",
      "requestDate": "2024-01-05",
      "originalAmount": 200.0,
      "cancellationFee": 40.0,
      "refundAmount": 160.0,
      "status": "rejected",
      "processedDate": "2024-01-06",
      "estimatedDays": null,
      "actualDays": null,
      "reason": "Medical reasons",
      "transactionId": null,
      "paymentMethod": "Debit Card ending in 9876",
      "rejectionReason": "Cancellation beyond allowed time limit"
    },
    {
      "id": "REF005",
      "bookingId": "BK005",
      "type": "Flight",
      "title": "London to Paris",
      "requestDate": "2024-01-18",
      "originalAmount": 320.0,
      "cancellationFee": 30.0,
      "refundAmount": 290.0,
      "status": "under_review",
      "processedDate": null,
      "estimatedDays": "7-10",
      "actualDays": null,
      "reason": "Flight cancelled by airline",
      "transactionId": null,
      "paymentMethod": "Credit Card ending in 3456"
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Requests", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Processing", "value": "processing"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Completed", "value": "completed"},
    {"label": "Rejected", "value": "rejected"}
  ];

  List<Map<String, dynamic>> get filteredRequests {
    if (selectedFilter == "all") {
      return refundRequests;
    }
    return refundRequests.where((request) => request["status"] == selectedFilter).toList();
  }

  void _showRefundDetails(Map<String, dynamic> refund) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Refund Details",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spLg,
                  children: [
                    // Status Badge
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(refund["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: _getStatusColor(refund["status"]).withAlpha(50),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getStatusIcon(refund["status"]),
                                color: _getStatusColor(refund["status"]),
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                _getStatusText(refund["status"]),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(refund["status"]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Booking Information
                    _buildDetailSection(
                      "Booking Information",
                      [
                        _buildDetailRow("Booking ID", "${refund["bookingId"]}"),
                        _buildDetailRow("Type", "${refund["type"]}"),
                        _buildDetailRow("Title", "${refund["title"]}"),
                        _buildDetailRow("Request Date", "${refund["requestDate"]}"),
                        _buildDetailRow("Reason", "${refund["reason"]}"),
                      ],
                    ),

                    // Financial Details
                    _buildDetailSection(
                      "Financial Details",
                      [
                        _buildDetailRow("Original Amount", "\$${(refund["originalAmount"] as double).currency}"),
                        _buildDetailRow("Cancellation Fee", "-\$${(refund["cancellationFee"] as double).currency}"),
                        _buildDetailRow("Refund Amount", "\$${(refund["refundAmount"] as double).currency}", 
                          valueColor: _getStatusColor(refund["status"])),
                        _buildDetailRow("Payment Method", "${refund["paymentMethod"]}"),
                      ],
                    ),

                    // Processing Information
                    _buildDetailSection(
                      "Processing Information",
                      [
                        if (refund["processedDate"] != null)
                          _buildDetailRow("Processed Date", "${refund["processedDate"]}"),
                        if (refund["actualDays"] != null)
                          _buildDetailRow("Processing Time", "${refund["actualDays"]} days"),
                        if (refund["estimatedDays"] != null)
                          _buildDetailRow("Estimated Time", "${refund["estimatedDays"]} business days"),
                        if (refund["transactionId"] != null)
                          _buildDetailRow("Transaction ID", "${refund["transactionId"]}"),
                        if (refund["rejectionReason"] != null)
                          _buildDetailRow("Rejection Reason", "${refund["rejectionReason"]}", 
                            valueColor: dangerColor),
                      ],
                    ),

                    // Action Buttons
                    if (refund["status"] == "pending" || refund["status"] == "under_review")
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Contact Support",
                              size: bs.sm,
                              onPressed: () {
                                Navigator.pop(context);
                                //navigateTo('tta_support_view')
                              },
                            ),
                          ),
                          if (refund["status"] == "pending")
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: dangerColor),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _cancelRefundRequest(refund["id"]);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      child: Center(
                                        child: Text(
                                          "Cancel Request",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? primaryColor,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  void _cancelRefundRequest(String refundId) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this refund request?");
    if (!isConfirmed) return;

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Refund request cancelled successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refund Status"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Summary Stats
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${refundRequests.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Total Requests",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${((refundRequests.where((r) => r["status"] == "completed").fold(0.0, (sum, r) => sum + (r["refundAmount"] as double)))).currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Total Refunded",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${refundRequests.where((r) => r["status"] == "processing" || r["status"] == "pending" || r["status"] == "under_review").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filter Section
            QDropdownField(
              label: "Filter by Status",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Refund Requests List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Refund Requests (${filteredRequests.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (filteredRequests.isEmpty)
                  Container(
                    padding: EdgeInsets.all(spXl),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 48,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No refund requests found",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Your refund requests will appear here",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    spacing: spSm,
                    children: List.generate(filteredRequests.length, (index) {
                      final refund = filteredRequests[index];
                      
                      return GestureDetector(
                        onTap: () => _showRefundDetails(refund),
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                            border: Border.all(
                              color: _getStatusColor(refund["status"]).withAlpha(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: _getBookingTypeColor(refund["type"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      _getBookingTypeIcon(refund["type"]),
                                      color: _getBookingTypeColor(refund["type"]),
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${refund["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Refund ID: ${refund["id"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(refund["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: _getStatusColor(refund["status"]).withAlpha(50),
                                      ),
                                    ),
                                    child: Text(
                                      _getStatusText(refund["status"]),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(refund["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Request Date:",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${refund["requestDate"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Refund Amount:",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(refund["refundAmount"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _getStatusColor(refund["status"]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (refund["status"] == "processing" || refund["status"] == "under_review")
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.schedule, color: infoColor, size: 16),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Expected processing time: ${refund["estimatedDays"]} business days",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'processing':
      case 'under_review':
        return warningColor;
      case 'pending':
        return infoColor;
      case 'rejected':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'processing':
        return Icons.sync;
      case 'under_review':
        return Icons.visibility;
      case 'pending':
        return Icons.schedule;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'completed':
        return 'Completed';
      case 'processing':
        return 'Processing';
      case 'under_review':
        return 'Under Review';
      case 'pending':
        return 'Pending';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Unknown';
    }
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
