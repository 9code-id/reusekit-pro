import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaReturnPolicyView extends StatefulWidget {
  const SpaReturnPolicyView({super.key});

  @override
  State<SpaReturnPolicyView> createState() => _SpaReturnPolicyViewState();
}

class _SpaReturnPolicyViewState extends State<SpaReturnPolicyView> {
  String selectedPolicyType = "products";
  bool showReturnForm = false;
  String orderNumber = "";
  String returnReason = "";

  Map<String, Map<String, dynamic>> returnPolicies = {
    "products": {
      "title": "Spa Products Return Policy",
      "timeframe": "30 days",
      "conditions": [
        "Items must be unopened and unused",
        "Original packaging required",
        "Receipt or proof of purchase needed",
        "Return shipping costs apply unless item is defective",
      ],
      "eligible_items": [
        "Skincare products (unopened)",
        "Hair care products (unopened)",
        "Spa accessories and tools",
        "Gift sets and packages",
        "Aromatherapy items",
      ],
      "non_eligible": [
        "Opened cosmetics or skincare items",
        "Used bath products",
        "Personal care items for hygiene reasons",
        "Custom or personalized products",
        "Digital gift cards",
      ],
      "icon": Icons.shopping_bag,
    },
    "services": {
      "title": "Spa Services Cancellation Policy",
      "timeframe": "24 hours",
      "conditions": [
        "Cancellations must be made 24 hours in advance",
        "Same-day cancellations subject to 50% charge",
        "No-shows charged full amount",
        "Rescheduling allowed with 12-hour notice",
      ],
      "eligible_items": [
        "Individual treatment bookings",
        "Package deal appointments",
        "Group booking sessions",
        "Consultation appointments",
        "Membership services",
      ],
      "non_eligible": [
        "Completed services",
        "Gift certificate purchases",
        "Membership fees after 7 days",
        "Special event bookings",
        "Holiday packages during peak season",
      ],
      "icon": Icons.spa,
    },
    "memberships": {
      "title": "Membership Cancellation Policy",
      "timeframe": "7 days",
      "conditions": [
        "7-day cooling-off period for new memberships",
        "30-day written notice required for established memberships",
        "Unused credits refundable within 6 months",
        "Annual memberships prorated after 3 months",
      ],
      "eligible_items": [
        "Monthly membership plans",
        "Annual membership packages",
        "VIP membership tiers",
        "Family membership plans",
        "Corporate membership accounts",
      ],
      "non_eligible": [
        "Promotional membership deals",
        "Founding member packages",
        "Lifetime membership plans",
        "Gift memberships after activation",
        "Transferred memberships",
      ],
      "icon": Icons.card_membership,
    },
  };

  List<Map<String, dynamic>> returnSteps = [
    {
      "step": "1",
      "title": "Initiate Return",
      "description": "Contact our customer service team or use our online return form within the specified timeframe.",
      "icon": Icons.contact_support,
    },
    {
      "step": "2",
      "title": "Get Authorization",
      "description": "Receive a Return Authorization Number (RAN) and prepaid shipping label if applicable.",
      "icon": Icons.verified,
    },
    {
      "step": "3",
      "title": "Package Items",
      "description": "Carefully package items in original packaging with all accessories and documentation.",
      "icon": Icons.inventory_2,
    },
    {
      "step": "4",
      "title": "Ship Return",
      "description": "Ship the package using the provided label or your preferred shipping method with tracking.",
      "icon": Icons.local_shipping,
    },
    {
      "step": "5",
      "title": "Processing",
      "description": "Allow 5-7 business days for processing after we receive your returned items.",
      "icon": Icons.hourglass_empty,
    },
    {
      "step": "6",
      "title": "Refund Issued",
      "description": "Refund will be processed to your original payment method within 3-5 business days.",
      "icon": Icons.payment,
    },
  ];

  List<Map<String, dynamic>> policyTypes = [
    {"label": "Products", "value": "products", "icon": Icons.shopping_bag},
    {"label": "Services", "value": "services", "icon": Icons.spa},
    {"label": "Memberships", "value": "memberships", "icon": Icons.card_membership},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Return Policy"),
        actions: [
          QButton(
            icon: Icons.assignment_return,
            size: bs.sm,
            onPressed: () {
              showReturnForm = !showReturnForm;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Return Policy Header
            _buildReturnPolicyHeader(),

            // Policy Type Selection
            _buildPolicyTypeSelection(),

            // Return Form
            if (showReturnForm) _buildReturnForm(),

            // Policy Details
            _buildPolicyDetails(),

            // Return Process Steps
            _buildReturnSteps(),

            // Important Notes
            _buildImportantNotes(),
          ],
        ),
      ),
    );
  }

  Widget _buildReturnPolicyHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment_return, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Return & Refund Policy",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Your satisfaction is our priority",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Key Stats
          Row(
            children: [
              _buildStatCard("30 DAYS", "Return window", Icons.schedule),
              SizedBox(width: spSm),
              _buildStatCard("FREE", "Return shipping*", Icons.local_shipping),
              SizedBox(width: spSm),
              _buildStatCard("24/7", "Support available", Icons.support_agent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String subtitle, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(51),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: Colors.white.withAlpha(100),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            SizedBox(height: spXs),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withAlpha(180),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyTypeSelection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.grey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Policy Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: policyTypes.map((type) {
              bool isSelected = selectedPolicyType == type["value"];
              return GestureDetector(
                onTap: () {
                  selectedPolicyType = type["value"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        type["icon"] as IconData,
                        color: isSelected ? Colors.white : primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${type["label"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReturnForm() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: infoColor.withAlpha(100),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment_return, color: infoColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Initiate Return Request",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Order Number",
            value: orderNumber,
            onChanged: (value) {
              orderNumber = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Reason for Return",
            value: returnReason,
            onChanged: (value) {
              returnReason = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Submit Return Request",
              size: bs.sm,
              onPressed: () {
                _submitReturnRequest();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyDetails() {
    final policy = returnPolicies[selectedPolicyType]!;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Policy Header
          Row(
            children: [
              Icon(
                policy["icon"] as IconData,
                color: primaryColor,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${policy["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${policy["timeframe"]} return window",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Conditions
          _buildPolicySection(
            "Return Conditions",
            policy["conditions"] as List<String>,
            Icons.rule,
            warningColor,
          ),
          SizedBox(height: spMd),

          // Eligible Items
          _buildPolicySection(
            "Eligible for Return",
            policy["eligible_items"] as List<String>,
            Icons.check_circle,
            successColor,
          ),
          SizedBox(height: spMd),

          // Non-Eligible Items
          _buildPolicySection(
            "Not Eligible for Return",
            policy["non_eligible"] as List<String>,
            Icons.cancel,
            dangerColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPolicySection(String title, List<String> items, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: color.withAlpha(100),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: spXs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6),
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 13,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildReturnSteps() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Return Process",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          ...returnSteps.map((step) => _buildReturnStepCard(step)).toList(),
        ],
      ),
    );
  }

  Widget _buildReturnStepCard(Map<String, dynamic> step) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "${step["step"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Icon(
            step["icon"] as IconData,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${step["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${step["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportantNotes() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: warningColor.withAlpha(100),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.important_devices, color: warningColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Important Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          _buildNoteItem(
            "Refund Timeline",
            "Refunds typically take 5-10 business days to appear on your statement after processing",
          ),
          
          _buildNoteItem(
            "Return Shipping",
            "We provide prepaid return labels for defective items. Customer covers return shipping for other reasons",
          ),
          
          _buildNoteItem(
            "Partial Returns",
            "Items purchased as part of a set or package deal may need to be returned together",
          ),
          
          _buildNoteItem(
            "Gift Returns",
            "Gift recipients can return items for store credit without revealing purchase price",
          ),

          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Contact Customer Service",
              size: bs.sm,
              onPressed: () {
                _contactCustomerService();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: warningColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitReturnRequest() {
    if (orderNumber.isEmpty) {
      se("Please enter your order number");
      return;
    }
    
    if (returnReason.isEmpty) {
      se("Please provide a reason for return");
      return;
    }
    
    ss("Return request submitted for order #$orderNumber");
    //navigateTo ( ReturnStatusView )
  }

  void _contactCustomerService() {
    ss("Contacting customer service");
    //navigateTo ( CustomerSupportView )
  }
}
