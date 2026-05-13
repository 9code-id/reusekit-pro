import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaSignatureCaptureView extends StatefulWidget {
  const DlaSignatureCaptureView({super.key});

  @override
  State<DlaSignatureCaptureView> createState() => _DlaSignatureCaptureViewState();
}

class _DlaSignatureCaptureViewState extends State<DlaSignatureCaptureView> {
  String recipientName = "";
  String recipientId = "";
  String recipientRelation = "self";
  String recipientPhone = "";
  bool signatureCaptured = false;
  bool isDrawing = false;
  double strokeWidth = 2.0;
  Color strokeColor = primaryColor;
  
  final List<Map<String, dynamic>> relationOptions = [
    {"label": "Customer (Self)", "value": "self"},
    {"label": "Family Member", "value": "family"},
    {"label": "Spouse", "value": "spouse"},
    {"label": "Child", "value": "child"},
    {"label": "Parent", "value": "parent"},
    {"label": "Sibling", "value": "sibling"},
    {"label": "Neighbor", "value": "neighbor"},
    {"label": "Security Guard", "value": "security"},
    {"label": "Office Staff", "value": "office"},
    {"label": "Receptionist", "value": "receptionist"},
  ];

  final List<Map<String, dynamic>> strokeWidthOptions = [
    {"label": "Thin", "value": 1.0},
    {"label": "Normal", "value": 2.0},
    {"label": "Thick", "value": 3.0},
    {"label": "Bold", "value": 4.0},
  ];

  Widget _buildRecipientInfo() {
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
              Icon(Icons.person, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Recipient Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Recipient Name",
            value: recipientName,
            hint: "Full name of person receiving the package",
            onChanged: (value) {
              recipientName = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "ID Number (Optional)",
                  value: recipientId,
                  hint: "KTP/SIM/Passport number",
                  onChanged: (value) {
                    recipientId = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: recipientPhone,
                  hint: "+62 XXX-XXXX-XXXX",
                  onChanged: (value) {
                    recipientPhone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Relationship to Customer",
            items: relationOptions,
            value: recipientRelation,
            onChanged: (value, label) {
              recipientRelation = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureSettings() {
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
              Icon(Icons.brush, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Signature Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Stroke Width",
                  items: strokeWidthOptions,
                  value: strokeWidth,
                  onChanged: (value, label) {
                    strokeWidth = value;
                    setState(() {});
                  },
                ),
              ),
              Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: strokeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: strokeColor),
                ),
                child: Center(
                  child: Container(
                    width: 30,
                    height: strokeWidth,
                    color: strokeColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Text(
                "Color:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...([primaryColor, successColor, warningColor, dangerColor, infoColor]).map((color) => 
                GestureDetector(
                  onTap: () {
                    strokeColor = color;
                    setState(() {});
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(
                        color: strokeColor == color ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignaturePad() {
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
              Icon(Icons.draw, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Digital Signature",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (signatureCaptured)
                Icon(Icons.check_circle, color: successColor, size: 24),
            ],
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(30), width: 2),
            ),
            child: Stack(
              children: [
                if (!signatureCaptured && !isDrawing)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.draw, size: 40, color: disabledBoldColor),
                        SizedBox(height: spSm),
                        Text(
                          "Sign here with your finger",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Draw your signature on this area",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (signatureCaptured)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 60, color: successColor),
                        SizedBox(height: spSm),
                        Text(
                          "Signature Captured",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tap 'Clear' to redraw",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                GestureDetector(
                  onPanStart: (details) {
                    isDrawing = true;
                    setState(() {});
                  },
                  onPanUpdate: (details) {
                    // Simulate drawing
                  },
                  onPanEnd: (details) {
                    isDrawing = false;
                    signatureCaptured = true;
                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Clear",
                  icon: Icons.clear,
                  color: dangerColor,
                  size: bs.sm,
                  onPressed: () {
                    signatureCaptured = false;
                    isDrawing = false;
                    setState(() {});
                    si("Signature cleared");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Preview",
                  icon: Icons.preview,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: signatureCaptured ? () {
                    si("Preview signature");
                  } : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValidationInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Signature Validation",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Text(
            "• Signature must be clearly readable\n• Recipient name is required\n• Digital signature has legal validity\n• Timestamp will be automatically recorded",
            style: TextStyle(
              fontSize: 13,
              color: infoColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  bool get canSaveSignature {
    return signatureCaptured && recipientName.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signature Capture"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {
              si("Help with signature capture");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildRecipientInfo(),
            _buildSignatureSettings(),
            _buildSignaturePad(),
            _buildValidationInfo(),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    color: dangerColor,
                    size: bs.md,
                    onPressed: () {
                      sw("Signature capture cancelled");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Save Signature",
                    color: canSaveSignature ? successColor : disabledBoldColor,
                    size: bs.md,
                    onPressed: canSaveSignature ? () {
                      ss("Signature saved successfully!");
                    } : null,
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
