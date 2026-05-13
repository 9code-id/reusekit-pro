import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaFailedDeliveryView extends StatefulWidget {
  const LtaFailedDeliveryView({super.key});

  @override
  State<LtaFailedDeliveryView> createState() => _LtaFailedDeliveryViewState();
}

class _LtaFailedDeliveryViewState extends State<LtaFailedDeliveryView> {
  bool loading = false;
  String deliveryId = "DEL-2024-001523";
  String selectedFailureReason = "Customer Not Available";
  String customReason = "";
  String selectedNextAction = "Reschedule";
  String additionalNotes = "";
  String attemptNumber = "1";
  String nextAttemptDate = "";
  String nextAttemptTime = "";
  String returnToDepot = "";
  bool notifyCustomer = true;
  bool requireSignature = false;
  List<String> evidencePhotos = [];
  String customerNotification = "";

  List<Map<String, dynamic>> failureReasons = [
    {"label": "Customer Not Available", "value": "Customer Not Available"},
    {"label": "Address Not Found", "value": "Address Not Found"},
    {"label": "Incorrect Address", "value": "Incorrect Address"},
    {"label": "Access Denied", "value": "Access Denied"},
    {"label": "Building Closed", "value": "Building Closed"},
    {"label": "Customer Refused Package", "value": "Customer Refused Package"},
    {"label": "Damaged Package", "value": "Damaged Package"},
    {"label": "Wrong Package", "value": "Wrong Package"},
    {"label": "Incomplete Documentation", "value": "Incomplete Documentation"},
    {"label": "Weather Conditions", "value": "Weather Conditions"},
    {"label": "Vehicle Issues", "value": "Vehicle Issues"},
    {"label": "Security Restrictions", "value": "Security Restrictions"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> nextActionOptions = [
    {"label": "Reschedule Delivery", "value": "Reschedule"},
    {"label": "Return to Depot", "value": "Return"},
    {"label": "Leave at Safe Location", "value": "Safe Location"},
    {"label": "Deliver to Neighbor", "value": "Neighbor"},
    {"label": "Hold for Pickup", "value": "Hold"},
    {"label": "Contact Customer", "value": "Contact"},
    {"label": "Cancel Delivery", "value": "Cancel"},
  ];

  Map<String, dynamic> deliveryData = {
    "id": "DEL-2024-001523",
    "trackingNumber": "LTA-TRK-789456123",
    "customerName": "John Mitchell",
    "customerPhone": "+1 (555) 123-4567",
    "customerEmail": "john.mitchell@email.com",
    "deliveryAddress": "125 Business Plaza, Suite 402, Downtown District",
    "packageType": "Standard Package",
    "packageWeight": "2.5 kg",
    "originalDeliveryDate": "2024-01-15",
    "originalDeliveryTime": "14:00 - 16:00",
    "driverName": "Michael Rodriguez",
    "driverPhone": "+1 (555) 987-6543",
    "vehicleNumber": "LTA-VH-234",
    "specialInstructions": "Ring doorbell twice, wait 2 minutes",
    "maxAttempts": 3,
    "currentAttempt": 1,
  };

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    attemptNumber = "${deliveryData["currentAttempt"]}";
    nextAttemptDate = DateTime.now().add(Duration(days: 1)).toIso8601String().split('T')[0];
    nextAttemptTime = "10:00";

    loading = false;
    setState(() {});
  }

  void _captureEvidence() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Capture Evidence",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Take a photo to document the failed delivery attempt",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: disabledBoldColor),
                borderRadius: BorderRadius.circular(radiusSm),
                color: Colors.grey[100],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Tap to capture evidence",
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
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Capture",
            size: bs.sm,
            onPressed: () {
              _saveEvidence();
              back();
            },
          ),
        ],
      ),
    );
  }

  void _saveEvidence() {
    String photoId = "evidence_${DateTime.now().millisecondsSinceEpoch}";
    evidencePhotos.add(photoId);
    ss("Evidence photo captured");
    setState(() {});
  }

  void _submitFailedDelivery() async {
    if (selectedFailureReason.isEmpty) {
      se("Please select a failure reason");
      return;
    }

    if (selectedFailureReason == "Other" && customReason.isEmpty) {
      se("Please provide custom reason details");
      return;
    }

    if (selectedNextAction.isEmpty) {
      se("Please select next action");
      return;
    }

    if (selectedNextAction == "Reschedule" && (nextAttemptDate.isEmpty || nextAttemptTime.isEmpty)) {
      se("Please set next attempt date and time");
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Failed delivery reported successfully");
    
    if (notifyCustomer) {
      _sendCustomerNotification();
    }
    
    //navigateTo ('')
  }

  void _sendCustomerNotification() {
    ss("Customer notification sent");
  }

  void _scheduleNextAttempt() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Schedule Next Attempt",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDatePicker(
              label: "Next Attempt Date",
              value: DateTime.parse(nextAttemptDate),
              onChanged: (value) {
                nextAttemptDate = value.toIso8601String().split('T')[0];
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTimePicker(
              label: "Next Attempt Time",
              value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $nextAttemptTime:00")),
              onChanged: (value) {
                nextAttemptTime = value!.kkmm;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Schedule",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Next delivery attempt scheduled");
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Failed Delivery"),
        actions: [
          IconButton(
            onPressed: _captureEvidence,
            icon: Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: () {
              // Contact support
            },
            icon: Icon(Icons.support_agent),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Failed Delivery Alert
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error, color: dangerColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Delivery Failed",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildInfoRow("Delivery ID", deliveryId),
                  _buildInfoRow("Customer", "${deliveryData["customerName"]}"),
                  _buildInfoRow("Attempt", "$attemptNumber of ${deliveryData["maxAttempts"]}"),
                  _buildInfoRow("Date/Time", "${deliveryData["originalDeliveryDate"]} ${deliveryData["originalDeliveryTime"]}"),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Delivery Information Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  _buildInfoRow("Address", "${deliveryData["deliveryAddress"]}"),
                  _buildInfoRow("Package", "${deliveryData["packageType"]} (${deliveryData["packageWeight"]})"),
                  _buildInfoRow("Driver", "${deliveryData["driverName"]}"),
                  _buildInfoRow("Vehicle", "${deliveryData["vehicleNumber"]}"),
                  if ((deliveryData["specialInstructions"] as String).isNotEmpty)
                    _buildInfoRow("Instructions", "${deliveryData["specialInstructions"]}"),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Failure Reason
            Text(
              "Failure Reason",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QDropdownField(
              label: "Select Failure Reason",
              items: failureReasons,
              value: selectedFailureReason,
              onChanged: (value, label) {
                selectedFailureReason = value;
                setState(() {});
              },
            ),

            if (selectedFailureReason == "Other") ...[
              SizedBox(height: spSm),
              QTextField(
                label: "Custom Reason",
                value: customReason,
                hint: "Please specify the reason for failed delivery",
                onChanged: (value) {
                  customReason = value;
                  setState(() {});
                },
              ),
            ],

            SizedBox(height: spMd),

            // Evidence Photos
            Text(
              "Evidence Photos",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            if (evidencePhotos.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledBoldColor, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(radiusSm),
                  color: Colors.grey[50],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.photo_camera,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No evidence photos captured",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Capture Evidence",
                      icon: Icons.camera_alt,
                      size: bs.sm,
                      onPressed: _captureEvidence,
                    ),
                  ],
                ),
              ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "${evidencePhotos.length} Evidence Phoss('Next page') Captured",
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Photos",
                            icon: Icons.visibility,
                            size: bs.sm,
                            onPressed: () {
                              // Show photos
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Add More",
                            icon: Icons.add_a_photo,
                            size: bs.sm,
                            onPressed: _captureEvidence,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: spMd),

            // Next Action
            Text(
              "Next Action",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QDropdownField(
              label: "Select Next Action",
              items: nextActionOptions,
              value: selectedNextAction,
              onChanged: (value, label) {
                selectedNextAction = value;
                setState(() {});
              },
            ),

            // Conditional fields based on next action
            if (selectedNextAction == "Reschedule") ...[
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reschedule Details",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Next Attempt Date",
                            value: DateTime.parse(nextAttemptDate),
                            onChanged: (value) {
                              nextAttemptDate = value.toIso8601String().split('T')[0];
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Time",
                            value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $nextAttemptTime:00")),
                            onChanged: (value) {
                              nextAttemptTime = value!.kkmm;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            if (selectedNextAction == "Return") ...[
              SizedBox(height: spSm),
              QDropdownField(
                label: "Return to Depot",
                items: [
                  {"label": "Main Warehouse", "value": "Main Warehouse"},
                  {"label": "Local Depot", "value": "Local Depot"},
                  {"label": "Sorting Center", "value": "Sorting Center"},
                ],
                value: returnToDepot,
                onChanged: (value, label) {
                  returnToDepot = value;
                  setState(() {});
                },
              ),
            ],

            SizedBox(height: spMd),

            // Customer Notification
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Notify Customer",
                        "value": true,
                        "checked": notifyCustomer,
                      }
                    ],
                    value: [
                      if (notifyCustomer)
                        {
                          "label": "Notify Customer",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        notifyCustomer = values.isNotEmpty;
                      });
                    },
                  ),
                ),
              ],
            ),

            if (notifyCustomer) ...[
              SizedBox(height: spSm),
              QMemoField(
                label: "Customer Notification Message",
                value: customerNotification,
                hint: "Message to send to customer about failed delivery",
                onChanged: (value) {
                  customerNotification = value;
                  setState(() {});
                },
              ),
            ],

            SizedBox(height: spMd),

            // Additional Notes
            QMemoField(
              label: "Additional Notes",
              value: additionalNotes,
              hint: "Any additional information about the failed delivery",
              onChanged: (value) {
                additionalNotes = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Warning for max attempts
            if ((deliveryData["currentAttempt"] as int) >= (deliveryData["maxAttempts"] as int) - 1) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "This is the final delivery attempt. Package will be returned to sender if not delivered.",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
            ],

            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Failed Delivery",
                icon: Icons.report_problem,
                size: bs.md,
                onPressed: _submitFailedDelivery,
              ),
            ),

            if (selectedNextAction == "Reschedule") ...[
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Schedule Next Attempt",
                  icon: Icons.schedule,
                  size: bs.md,
                  onPressed: _scheduleNextAttempt,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
