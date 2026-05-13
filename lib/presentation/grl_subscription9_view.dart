import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSubscription9View extends StatefulWidget {
  @override
  State<GrlSubscription9View> createState() => _GrlSubscription9ViewState();
}

class _GrlSubscription9ViewState extends State<GrlSubscription9View> {
  Map<String, dynamic> currentSubscription = {
    "plan": "Pro",
    "price": 29.99,
    "nextBilling": "2025-07-22",
    "status": "active",
    "autoRenew": true,
  };

  bool showCancelForm = false;
  String cancellationReason = "";
  String feedback = "";
  bool retainDataAccess = true;
  bool allowReactivation = true;

  List<Map<String, dynamic>> cancellationReasons = [
    {"value": "too_expensive", "label": "Too expensive"},
    {"value": "not_using", "label": "Not using the service enough"},
    {"value": "missing_features", "label": "Missing features I need"},
    {"value": "found_alternative", "label": "Found a better alternative"},
    {"value": "temporary_pause", "label": "Temporary pause (will return later)"},
    {"value": "technical_issues", "label": "Technical issues"},
    {"value": "other", "label": "Other"},
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Subscription"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Contact support for assistance");
            },
          ),
        ],
      ),
      body: showCancelForm
          ? _buildCancellationForm()
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildCurrentPlanInfo(),
                  _buildRetentionOffers(),
                  _buildAlternativeOptions(),
                  _buildCancellationWarning(),
                  _buildCancelButton(),
                ],
              ),
            ),
    );
  }

  Widget _buildCurrentPlanInfo() {
    final nextBilling = DateTime.parse(currentSubscription["nextBilling"]);
    final daysLeft = nextBilling.difference(DateTime.now()).inDays;
    
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(20), secondaryColor.withAlpha(20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(100)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.workspace_premium,
                  color: primaryColor,
                  size: 32,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We're sorry to see you go!",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Your ${currentSubscription["plan"]} subscription is currently active",
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
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Current Plan:",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${currentSubscription["plan"]} - \$${(currentSubscription["price"] as double).toStringAsFixed(2)}/month",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Next billing:",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${nextBilling.dMMMy} ($daysLeft days)",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Status:",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "ACTIVE",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildRetentionOffers() {
    List<Map<String, dynamic>> offers = [
      {
        "title": "50% Off Next 3 Months",
        "description": "Continue with your Pro plan at half the price",
        "price": 14.99,
        "originalPrice": 29.99,
        "duration": "3 months",
        "color": successColor,
      },
      {
        "title": "Downgrade to Basic",
        "description": "Switch to Basic plan with essential features",
        "price": 9.99,
        "originalPrice": 29.99,
        "duration": "ongoing",
        "color": infoColor,
      },
      {
        "title": "Pause Subscription",
        "description": "Pause for up to 3 months, resume anytime",
        "price": 0.00,
        "originalPrice": 29.99,
        "duration": "up to 3 months",
        "color": warningColor,
      },
    ];

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
            "Before you go, consider these options:",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: offers.map((offer) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (offer["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: (offer["color"] as Color).withAlpha(100)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (offer["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            offer["title"].contains("Off") 
                                ? Icons.local_offer
                                : offer["title"].contains("Downgrade")
                                    ? Icons.trending_down
                                    : Icons.pause_circle,
                            color: offer["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${offer["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: offer["color"] as Color,
                                ),
                              ),
                              Text(
                                "${offer["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if ((offer["price"] as double) > 0) ...[
                              if ((offer["originalPrice"] as double) != (offer["price"] as double))
                                Text(
                                  "\$${(offer["originalPrice"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              Text(
                                "\$${(offer["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: offer["color"] as Color,
                                ),
                              ),
                            ] else ...[
                              Text(
                                "FREE",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: offer["color"] as Color,
                                ),
                              ),
                            ],
                            Text(
                              "${offer["duration"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Accept This Offer",
                        size: bs.sm,
                        onPressed: () {
                          ss("Offer accepted: ${offer["title"]}");
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeOptions() {
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
            "Need Help?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.help_center,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact Support",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Get help with any issues or questions",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Contact",
                      size: bs.sm,
                      onPressed: () {
                        si("Opening support chat");
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Learn More",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Explore tutorials and best practices",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Learn",
                      size: bs.sm,
                      onPressed: () {
                        si("Opening learning resources");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationWarning() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(100)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Text(
                  "What happens when you cancel?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.close,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "You'll lose access to all premium features immediately",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.close,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Your data will be deleted after 30 days",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.close,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "No refunds for the current billing period",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "You can reactivate anytime with the same account",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "I still want to cancel",
            size: bs.md,
            onPressed: () {
              showCancelForm = true;
              setState(() {});
            },
          ),
        ),
        Text(
          "Cancellation takes effect immediately. You can reactivate anytime.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCancellationForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          children: [
            Container(
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCancelForm = false;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Cancellation Details",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Help us improve by telling us why you're canceling:",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  QDropdownField(
                    label: "Reason for Cancellation",
                    items: cancellationReasons,
                    value: cancellationReason,
                    validator: Validator.required,
                    onChanged: (value, label) {
                      cancellationReason = value;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Additional Feedback (Optional)",
                    value: feedback,
                    hint: "Tell us more about your experience or what we could improve...",
                    onChanged: (value) {
                      feedback = value;
                      setState(() {});
                    },
                  ),
                  Column(
                    spacing: spSm,
                    children: [
                      QSwitch(
                        label: "Keep data access for 30 days",
                        items: [
                          {
                            "label": "Retain my data for potential reactivation",
                            "value": "retain_data",
                            "checked": retainDataAccess,
                          }
                        ],
                        value: retainDataAccess ? [{"label": "Retain my data for potential reactivation", "value": "retain_data", "checked": true}] : [],
                        onChanged: (values, ids) {
                          retainDataAccess = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      QSwitch(
                        label: "Allow easy reactivation",
                        items: [
                          {
                            "label": "Send me reactivation offers via email",
                            "value": "allow_reactivation",
                            "checked": allowReactivation,
                          }
                        ],
                        value: allowReactivation ? [{"label": "Send me reactivation offers via email", "value": "allow_reactivation", "checked": true}] : [],
                        onChanged: (values, ids) {
                          allowReactivation = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: dangerColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Final Confirmation",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "By confirming cancellation, your subscription will be terminated immediately and you'll lose access to all premium features.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    child: QButton(
                      label: "Keep Subscription",
                      size: bs.md,
                      onPressed: () {
                        showCancelForm = false;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: QButton(
                      label: "Confirm Cancellation",
                      size: bs.md,
                      onPressed: _confirmCancellation,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmCancellation() async {
    if (!formKey.currentState!.validate()) {
      se("Please select a cancellation reason");
      return;
    }

    bool isConfirmed = await confirm(
      "Are you sure you want to cancel your subscription? This action cannot be undone."
    );

    if (isConfirmed) {
      // Update subscription status
      currentSubscription["status"] = "cancelled";
      currentSubscription["autoRenew"] = false;
      
      setState(() {});
      
      ss("Subscription cancelled successfully. We're sorry to see you go!");
      
      // Navigate back or show success screen
      showCancelForm = false;
      setState(() {});
    }
  }
}
