import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaReturnProcessingView extends StatefulWidget {
  const DlaReturnProcessingView({super.key});

  @override
  State<DlaReturnProcessingView> createState() => _DlaReturnProcessingViewState();
}

class _DlaReturnProcessingViewState extends State<DlaReturnProcessingView> {
  String returnId = "RET-240115-001";
  String originalDeliveryId = "DEL-240115-001";
  String packageId = "PKG-240115-001";
  String processingStatus = "received";
  String inspectionResult = "pending";
  String refundStatus = "pending";
  String qualityNotes = "";
  bool refundApproved = false;
  double refundAmount = 250000;
  String refundMethod = "original_payment";
  String processingNotes = "";
  
  final List<Map<String, dynamic>> processingSteps = [
    {
      "step": "Package Received",
      "status": "completed",
      "timestamp": "2024-01-15 14:30",
      "description": "Return package received at warehouse",
    },
    {
      "step": "Quality Inspection",
      "status": "in_progress",
      "timestamp": "2024-01-15 15:00",
      "description": "Checking package condition and contents",
    },
    {
      "step": "Refund Authorization",
      "status": "pending",
      "timestamp": "",
      "description": "Waiting for refund approval",
    },
    {
      "step": "Payment Processing",
      "status": "pending",
      "timestamp": "",
      "description": "Processing refund to customer",
    },
    {
      "step": "Completion",
      "status": "pending",
      "timestamp": "",
      "description": "Return process completed",
    },
  ];

  final List<Map<String, dynamic>> inspectionResults = [
    {"label": "Package Intact", "value": "intact"},
    {"label": "Minor Damage", "value": "minor_damage"},
    {"label": "Major Damage", "value": "major_damage"},
    {"label": "Items Missing", "value": "missing_items"},
    {"label": "Wrong Items", "value": "wrong_items"},
    {"label": "Not Returnable", "value": "not_returnable"},
  ];

  final List<Map<String, dynamic>> refundMethodOptions = [
    {"label": "Original Payment Method", "value": "original_payment"},
    {"label": "Store Credit", "value": "store_credit"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "Cash Refund", "value": "cash"},
  ];

  Widget _buildProcessingHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: infoColor, size: 32),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Return Processing",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Processing customer return request",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Return ID:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      returnId,
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Original Delivery:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      originalDeliveryId,
                      style: TextStyle(
                        fontSize: 14,
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
  }

  Widget _buildProcessingSteps() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Processing Timeline",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...processingSteps.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> step = entry.value;
            return _buildProcessingStep(step, index, processingSteps.length);
          }),
        ],
      ),
    );
  }

  Widget _buildProcessingStep(Map<String, dynamic> step, int index, int totalSteps) {
    Color stepColor = step["status"] == "completed" 
        ? successColor 
        : step["status"] == "in_progress" 
            ? warningColor 
            : disabledBoldColor;
    
    IconData stepIcon = step["status"] == "completed" 
        ? Icons.check_circle 
        : step["status"] == "in_progress" 
            ? Icons.sync 
            : Icons.radio_button_unchecked;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(stepIcon, color: stepColor, size: 24),
            if (index < totalSteps - 1)
              Container(
                width: 2,
                height: 40,
                color: stepColor.withAlpha(100),
              ),
          ],
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${step["step"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: stepColor,
                ),
              ),
              Text(
                "${step["description"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              if (step["timestamp"].toString().isNotEmpty)
                Text(
                  "${step["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              SizedBox(height: spSm),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQualityInspection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Quality Inspection",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: inspectionResult == "pending" 
                      ? warningColor.withAlpha(20)
                      : inspectionResult == "intact"
                          ? successColor.withAlpha(20)
                          : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  inspectionResult.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: inspectionResult == "pending" 
                        ? warningColor
                        : inspectionResult == "intact"
                            ? successColor
                            : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Inspection Result",
            items: inspectionResults,
            value: inspectionResult,
            onChanged: (value, label) {
              inspectionResult = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Quality Notes",
            value: qualityNotes,
            hint: "Add detailed notes about package condition...",
            onChanged: (value) {
              qualityNotes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRefundSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.monetization_on, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Refund Processing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: refundApproved ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  refundApproved ? "APPROVED" : "PENDING",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: refundApproved ? successColor : warningColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Text(
                  "Refund Amount:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${refundAmount.currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          QDropdownField(
            label: "Refund Method",
            items: refundMethodOptions,
            value: refundMethod,
            onChanged: (value, label) {
              refundMethod = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: refundApproved ? "Approved" : "Approve Refund",
                  icon: refundApproved ? Icons.check_circle : Icons.approval,
                  color: refundApproved ? successColor : primaryColor,
                  size: bs.sm,
                  onPressed: refundApproved ? null : () {
                    refundApproved = true;
                    setState(() {});
                    ss("Refund approved");
                  },
                ),
              ),
              if (refundApproved)
                Expanded(
                  child: QButton(
                    label: "Process Payment",
                    icon: Icons.payment,
                    color: infoColor,
                    size: bs.sm,
                    onPressed: () {
                      ss("Processing refund payment");
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingNotes() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Processing Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Internal Notes",
            value: processingNotes,
            hint: "Add internal processing notes...",
            onChanged: (value) {
              processingNotes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    bool canComplete = inspectionResult != "pending" && refundApproved;
    
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: QButton(
            label: "Update Customer",
            icon: Icons.email,
            color: infoColor,
            size: bs.md,
            onPressed: () {
              si("Sending update to customer");
            },
          ),
        ),
        Expanded(
          child: QButton(
            label: "Complete Return",
            icon: Icons.done_all,
            color: canComplete ? successColor : disabledBoldColor,
            size: bs.md,
            onPressed: canComplete ? () {
              ss("Return processing completed!");
            } : null,
          ),
        ),
      ],
    );
  }

  Widget _buildProcessingSummary() {
    int completedSteps = processingSteps.where((step) => step["status"] == "completed").length;
    double progress = completedSteps / processingSteps.length;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Processing Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          Text(
            "$completedSteps of ${processingSteps.length} steps completed",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Return Processing"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              si("Refreshing return status");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildProcessingHeader(),
            _buildProcessingSummary(),
            _buildProcessingSteps(),
            _buildQualityInspection(),
            _buildRefundSection(),
            _buildProcessingNotes(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
}
