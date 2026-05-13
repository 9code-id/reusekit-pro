import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsSubscriptionView extends StatefulWidget {
  const BrsSubscriptionView({super.key});

  @override
  State<BrsSubscriptionView> createState() => _BrsSubscriptionViewState();
}

class _BrsSubscriptionViewState extends State<BrsSubscriptionView> {
  String selectedPlan = "Premium Monthly";
  String billingCycle = "Monthly";
  bool hasActiveSubscription = true;
  
  Map<String, dynamic> currentSubscription = {
    "plan": "Premium Monthly",
    "startDate": "March 1, 2024",
    "nextBilling": "April 1, 2024",
    "amount": 19.99,
    "status": "Active",
    "autoRenew": true,
  };

  List<Map<String, dynamic>> subscriptionPlans = [
    {
      "id": 1,
      "name": "Basic Monthly",
      "type": "Basic",
      "billingCycle": "Monthly",
      "price": 9.99,
      "originalPrice": 12.99,
      "discount": 23,
      "popular": false,
      "features": [
        "5 haircuts per month",
        "Basic styling services",
        "Online booking priority",
        "Member pricing",
        "Email support",
      ],
      "limitations": [
        "No premium services",
        "Limited barber selection",
      ],
    },
    {
      "id": 2,
      "name": "Premium Monthly",
      "type": "Premium",
      "billingCycle": "Monthly", 
      "price": 19.99,
      "originalPrice": 25.99,
      "discount": 23,
      "popular": true,
      "features": [
        "Unlimited haircuts",
        "All premium services included",
        "VIP booking access",
        "Any barber selection",
        "24/7 customer support",
        "Free products monthly",
        "Home service option",
      ],
      "limitations": [],
    },
    {
      "id": 3,
      "name": "Basic Yearly",
      "type": "Basic",
      "billingCycle": "Yearly",
      "price": 99.99,
      "originalPrice": 155.88,
      "discount": 36,
      "popular": false,
      "features": [
        "5 haircuts per month",
        "Basic styling services",
        "Online booking priority",
        "Member pricing",
        "Email support",
        "2 months free",
      ],
      "limitations": [
        "No premium services",
        "Limited barber selection",
      ],
    },
    {
      "id": 4,
      "name": "Premium Yearly",
      "type": "Premium",
      "billingCycle": "Yearly",
      "price": 199.99,
      "originalPrice": 311.88,
      "discount": 36,
      "popular": true,
      "features": [
        "Unlimited haircuts",
        "All premium services included",
        "VIP booking access",
        "Any barber selection",
        "24/7 customer support",
        "Free products monthly",
        "Home service option",
        "2 months free",
        "Exclusive events access",
      ],
      "limitations": [],
    },
  ];

  List<Map<String, dynamic>> subscriptionHistory = [
    {
      "date": "March 1, 2024",
      "plan": "Premium Monthly",
      "amount": 19.99,
      "status": "Paid",
      "invoice": "INV-2024-001",
    },
    {
      "date": "February 1, 2024", 
      "plan": "Premium Monthly",
      "amount": 19.99,
      "status": "Paid",
      "invoice": "INV-2024-002",
    },
    {
      "date": "January 1, 2024",
      "plan": "Premium Monthly", 
      "amount": 19.99,
      "status": "Paid",
      "invoice": "INV-2024-003",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription Plans"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showBillingHistory();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Subscription Status
            if (hasActiveSubscription)
              Container(
                margin: EdgeInsets.all(spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [successColor, successColor.withAlpha(200)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Active Subscription",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${currentSubscription["status"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${currentSubscription["plan"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Started: ${currentSubscription["startDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                              Text(
                                "Next billing: ${currentSubscription["nextBilling"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${currentSubscription["amount"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Manage Plan",
                            size: bs.sm,
                            onPressed: () {
                              _showManageSubscription();
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Cancel",
                            size: bs.sm,
                            onPressed: () {
                              _showCancelDialog();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            
            // Billing Cycle Selector
            Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Text(
                    "Billing Cycle:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Row(
                      children: ["Monthly", "Yearly"].map((cycle) {
                        bool isSelected = billingCycle == cycle;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              billingCycle = cycle;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: cycle == "Monthly" ? spSm : 0),
                              padding: EdgeInsets.symmetric(vertical: spSm),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                cycle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Subscription Plans
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Choose Your Plan",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            
            SizedBox(height: spSm),
            
            ...subscriptionPlans.where((plan) => plan["billingCycle"] == billingCycle).map((plan) {
              bool isSelected = selectedPlan == plan["name"];
              bool isCurrent = hasActiveSubscription && currentSubscription["plan"] == plan["name"];
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd, left: spMd, right: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected ? [shadowMd] : [shadowSm],
                ),
                child: Column(
                  children: [
                    // Plan Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(50) : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${plan["type"]} Plan",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? primaryColor : Colors.black,
                                      ),
                                    ),
                                    if (plan["popular"] as bool)
                                      Container(
                                        margin: EdgeInsets.only(left: spSm),
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: warningColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Popular",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    if (isCurrent)
                                      Container(
                                        margin: EdgeInsets.only(left: spSm),
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Current",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  "${plan["billingCycle"]} billing",
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
                              if ((plan["discount"] as int) > 0)
                                Text(
                                  "\$${plan["originalPrice"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              Text(
                                "\$${plan["price"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : Colors.black,
                                ),
                              ),
                              if ((plan["discount"] as int) > 0)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Save ${plan["discount"]}%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Plan Features
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What's included:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spSm),
                          ...(plan["features"] as List).map((feature) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "$feature",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          
                          if ((plan["limitations"] as List).isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Text(
                              "Limitations:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spSm),
                            ...(plan["limitations"] as List).map((limitation) {
                              return Container(
                                margin: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      color: dangerColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "$limitation",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                          
                          SizedBox(height: spMd),
                          
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: isCurrent ? "Current Plan" : isSelected ? "Subscribe Now" : "Select Plan",
                              size: bs.md,
                              onPressed: isCurrent ? null : () {
                                if (isSelected) {
                                  _showSubscribeDialog(plan);
                                } else {
                                  selectedPlan = "${plan["name"]}";
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            // Benefits Summary
            Container(
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Subscription Benefits",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Cancel anytime, no commitment\n• Exclusive member pricing\n• Priority booking access\n• 24/7 customer support\n• Flexible scheduling options",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSubscribeDialog(Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          title: Text("Subscribe to ${plan["type"]} Plan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("You're about to subscribe to:"),
              SizedBox(height: spSm),
              Text(
                "${plan["name"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${plan["price"]} per ${plan["billingCycle"].toLowerCase()}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if ((plan["discount"] as int) > 0) ...[
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "You save ${plan["discount"]}% with this plan!",
                    style: TextStyle(
                      color: successColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ss("Subscribing to ${plan["name"]}");
              },
              child: Text("Subscribe"),
            ),
          ],
        );
      },
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          title: Text("Cancel Subscription"),
          content: Text("Are you sure you want to cancel your subscription? You'll lose access to premium features at the end of your billing cycle."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Keep Plan"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                sw("Subscription cancelled. Access continues until ${currentSubscription["nextBilling"]}");
              },
              child: Text("Cancel", style: TextStyle(color: dangerColor)),
            ),
          ],
        );
      },
    );
  }

  void _showManageSubscription() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Manage Subscription",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              _buildManageOption(
                Icons.upgrade,
                "Upgrade Plan",
                "Switch to a higher tier plan",
                () {
                  Navigator.pop(context);
                  si("Opening upgrade options");
                },
              ),
              
              _buildManageOption(
                Icons.schedule,
                "Change Billing Date",
                "Modify your billing cycle date",
                () {
                  Navigator.pop(context);
                  si("Changing billing date");
                },
              ),
              
              _buildManageOption(
                Icons.pause,
                "Pause Subscription",
                "Temporarily pause your subscription",
                () {
                  Navigator.pop(context);
                  si("Pausing subscription");
                },
              ),
              
              _buildManageOption(
                Icons.payment,
                "Update Payment Method",
                "Change your payment information",
                () {
                  Navigator.pop(context);
                  si("Updating payment method");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildManageOption(IconData icon, String title, String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: disabledOutlineBorderColor),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showBillingHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Billing History",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Expanded(
                child: ListView.builder(
                  itemCount: subscriptionHistory.length,
                  itemBuilder: (context, index) {
                    final history = subscriptionHistory[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.receipt,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${history["plan"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${history["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${history["invoice"]}",
                                  style: TextStyle(
                                    fontSize: 11,
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
                                "\$${history["amount"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${history["status"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
