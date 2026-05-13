import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaCancelAppointmentView extends StatefulWidget {
  const MhaCancelAppointmentView({super.key});

  @override
  State<MhaCancelAppointmentView> createState() => _MhaCancelAppointmentViewState();
}

class _MhaCancelAppointmentViewState extends State<MhaCancelAppointmentView> {
  String cancellationReason = "";
  String additionalComments = "";
  bool refundRequested = false;
  bool confirmCancellation = false;
  
  final Map<String, dynamic> appointment = {
    "id": "APT001",
    "doctor": {
      "name": "Dr. Sarah Johnson",
      "specialty": "Cardiologist",
      "image": "https://picsum.photos/300/300?random=1&keyword=doctor",
      "hospital": "City General Hospital",
    },
    "date": "2024-01-15",
    "time": "10:30",
    "type": "Consultation",
    "fee": 150.0,
    "paymentStatus": "Paid",
  };
  
  final List<String> cancellationReasons = [
    "Personal emergency",
    "Medical emergency",
    "Schedule conflict",
    "Work commitment",
    "Travel plans",
    "Feeling unwell",
    "Family emergency",
    "Transportation issues",
    "Doctor recommended postponement",
    "Other",
  ];
  
  final Map<String, dynamic> cancellationPolicy = {
    "freeWindow": 24,
    "partialRefund": 12,
    "noRefund": 0,
    "cancellationFee": 25.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Appointment"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning Header
            _buildWarningHeader(),
            
            SizedBox(height: spMd),
            
            // Appointment Details
            _buildAppointmentDetailsCard(),
            
            SizedBox(height: spMd),
            
            // Cancellation Reason
            _buildCancellationReasonSection(),
            
            SizedBox(height: spMd),
            
            // Additional Comments
            _buildAdditionalCommentsSection(),
            
            SizedBox(height: spMd),
            
            // Refund Information
            _buildRefundInformationSection(),
            
            SizedBox(height: spMd),
            
            // Cancellation Policy
            _buildCancellationPolicyCard(),
            
            SizedBox(height: spMd),
            
            // Confirmation Checkbox
            _buildConfirmationSection(),
            
            SizedBox(height: spXl),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }
  
  Widget _buildWarningHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor, width: 2),
      ),
      child: Column(
        children: [
          Icon(Icons.warning, color: dangerColor, size: 48),
          SizedBox(height: spMd),
          Text(
            "Cancel Appointment",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: dangerColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "You are about to cancel your appointment. Please review the cancellation policy before proceeding.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildAppointmentDetailsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: Border(
          left: BorderSide(
            width: 4,
            color: primaryColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Appointment to Cancel",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${appointment["doctor"]["image"]}",
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
                      "${appointment["doctor"]["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${appointment["doctor"]["specialty"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${appointment["doctor"]["hospital"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem("ID", "${appointment["id"]}"),
                    ),
                    Expanded(
                      child: _buildDetailItem("Type", "${appointment["type"]}"),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem("Date", DateTime.parse(appointment["date"]).dMMMy),
                    ),
                    Expanded(
                      child: _buildDetailItem("Time", "${appointment["time"]}"),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem("Fee", "\$${(appointment["fee"] as double).currency}"),
                    ),
                    Expanded(
                      child: _buildDetailItem("Status", "${appointment["paymentStatus"]}"),
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
  
  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildCancellationReasonSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reason for Cancellation",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "Please help us understand why you're cancelling this appointment",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QDropdownField(
            label: "Select Reason",
            items: cancellationReasons.map((reason) => {
              "label": reason,
              "value": reason,
            }).toList(),
            value: cancellationReason,
            onChanged: (value, label) {
              cancellationReason = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildAdditionalCommentsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Comments (Optional)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "Any additional information you'd like to share",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QMemoField(
            label: "Comments",
            value: additionalComments,
            hint: "Please provide any additional details about your cancellation...",
            onChanged: (value) {
              additionalComments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildRefundInformationSection() {
    // Calculate refund amount based on time until appointment
    final appointmentDateTime = DateTime.parse("${appointment["date"]} ${appointment["time"]}");
    final hoursUntil = appointmentDateTime.difference(DateTime.now()).inHours;
    
    double refundAmount = 0;
    String refundStatus = "";
    
    if (hoursUntil >= cancellationPolicy["freeWindow"]) {
      refundAmount = appointment["fee"] as double;
      refundStatus = "Full Refund";
    } else if (hoursUntil >= cancellationPolicy["partialRefund"]) {
      refundAmount = (appointment["fee"] as double) - (cancellationPolicy["cancellationFee"] as double);
      refundStatus = "Partial Refund";
    } else {
      refundAmount = 0;
      refundStatus = "No Refund";
    }
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Refund Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: refundAmount > 0 ? successColor.withAlpha(10) : dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: refundAmount > 0 ? successColor : dangerColor,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Original Fee:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(appointment["fee"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                if (refundStatus == "Partial Refund") ...[
                  SizedBox(height: spSm),
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
                        "-\$${(cancellationPolicy["cancellationFee"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
                
                Divider(height: spMd * 2),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Refund Amount:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: refundAmount > 0 ? successColor : dangerColor,
                      ),
                    ),
                    Text(
                      "\$${refundAmount.currency}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: refundAmount > 0 ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: refundAmount > 0 ? successColor : dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    refundStatus,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          
          if (refundAmount > 0) ...[
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QSwitch(
                items: [
                  {
                    "label": "Request refund to original payment method",
                    "value": true,
                    "checked": refundRequested,
                  }
                ],
                value: refundRequested ? [{"label": "Request refund to original payment method", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  refundRequested = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: infoColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Refunds typically take 3-5 business days to process",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildCancellationPolicyCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.policy, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Cancellation Policy",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          _buildPolicyItem("Free cancellation 24+ hours before appointment"),
          _buildPolicyItem("Cancellation 12-24 hours: \$25 fee applied"),
          _buildPolicyItem("Cancellation less than 12 hours: No refund"),
          _buildPolicyItem("Emergency cancellations may be reviewed case-by-case"),
          _buildPolicyItem("Refunds processed within 3-5 business days"),
        ],
      ),
    );
  }
  
  Widget _buildPolicyItem(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: warningColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildConfirmationSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Confirmation Required",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: dangerColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QSwitch(
            items: [
              {
                "label": "I understand the cancellation policy and confirm that I want to cancel this appointment",
                "value": true,
                "checked": confirmCancellation,
              }
            ],
            value: confirmCancellation ? [{"label": "I understand the cancellation policy and confirm that I want to cancel this appointment", "value": true, "checked": true}] : [],
            onChanged: (values, ids) {
              confirmCancellation = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildBottomActions() {
    final canCancel = cancellationReason.isNotEmpty && confirmCancellation;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Keep Appointment",
              size: bs.md,
              color: successColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          
          SizedBox(width: spSm),
          
          Expanded(
            child: QButton(
              label: "Cancel Appointment",
              size: bs.md,
              color: dangerColor,
              onPressed: canCancel ? () async {
                // Show confirmation dialog
                bool isConfirmed = await confirm(
                  "Are you sure you want to cancel this appointment? This action cannot be undone."
                );
                
                if (isConfirmed) {
                  // Show loading
                  showLoading();
                  
                  // Simulate API call
                  await Future.delayed(Duration(seconds: 2));
                  
                  hideLoading();
                  
                  // Show success message
                  ss("Appointment cancelled successfully!");
                  
                  // Navigate back
                  Navigator.pop(context);
                  // navigateTo(AppointmentHistoryView)
                }
              } : null,
            ),
          ),
        ],
      ),
    );
  }
}
