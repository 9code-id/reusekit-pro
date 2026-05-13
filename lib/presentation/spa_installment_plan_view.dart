import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaInstallmentPlanView extends StatefulWidget {
  const SpaInstallmentPlanView({super.key});

  @override
  State<SpaInstallmentPlanView> createState() => _SpaInstallmentPlanViewState();
}

class _SpaInstallmentPlanViewState extends State<SpaInstallmentPlanView> {
  double totalAmount = 2499.99;
  String selectedPlan = "6_months";
  String selectedPaymentMethod = "credit_card";
  
  List<Map<String, dynamic>> installmentPlans = [
    {
      "id": "3_months",
      "duration": 3,
      "interestRate": 0.0,
      "monthlyPayment": 833.33,
      "totalCost": 2499.99,
      "savings": 0.0,
      "isPromotional": true,
      "title": "3 Months - 0% APR",
      "description": "Special promotional rate"
    },
    {
      "id": "6_months",
      "duration": 6,
      "interestRate": 5.99,
      "monthlyPayment": 425.50,
      "totalCost": 2553.00,
      "savings": 408.33,
      "isPromotional": false,
      "title": "6 Months",
      "description": "Most popular choice"
    },
    {
      "id": "12_months",
      "duration": 12,
      "interestRate": 9.99,
      "monthlyPayment": 219.75,
      "totalCost": 2637.00,
      "savings": 613.58,
      "isPromotional": false,
      "title": "12 Months",
      "description": "Lowest monthly payment"
    },
    {
      "id": "24_months",
      "duration": 24,
      "interestRate": 15.99,
      "monthlyPayment": 123.85,
      "totalCost": 2972.40,
      "savings": 709.90,
      "isPromotional": false,
      "title": "24 Months",
      "description": "Extended payment period"
    }
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "credit_card",
      "label": "Credit Card",
      "icon": Icons.credit_card,
      "description": "Automatic monthly charges"
    },
    {
      "id": "bank_account",
      "label": "Bank Account",
      "icon": Icons.account_balance,
      "description": "Direct bank transfer"
    },
    {
      "id": "debit_card",
      "label": "Debit Card",
      "icon": Icons.payment,
      "description": "Monthly debit payments"
    }
  ];

  Map<String, dynamic> get selectedPlanData => 
      installmentPlans.firstWhere((plan) => plan["id"] == selectedPlan);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Installment Plans"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPurchaseSummary(),
            _buildInstallmentPlans(),
            _buildPaymentMethodSelection(),
            _buildSelectedPlanSummary(),
            _buildInstallmentSchedule(),
            _buildApplyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseSummary() {
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
            "Purchase Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "https://picsum.photos/80/80?random=1&keyword=laptop",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MacBook Pro 16\" M3 Max",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "2TB Storage, 64GB RAM",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Space Black",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${totalAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstallmentPlans() {
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
            "Choose Your Plan",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Select an installment plan that works best for you",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          ...installmentPlans.map((plan) => _buildInstallmentPlanCard(plan)),
        ],
      ),
    );
  }

  Widget _buildInstallmentPlanCard(Map<String, dynamic> plan) {
    bool isSelected = selectedPlan == plan["id"];
    bool isPromotional = plan["isPromotional"] as bool;
    
    return GestureDetector(
      onTap: () {
        selectedPlan = plan["id"];
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${plan["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if (isPromotional) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "PROMO",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        "${plan["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
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
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: _buildPlanDetail(
                    "Monthly Payment",
                    "\$${(plan["monthlyPayment"] as double).toStringAsFixed(2)}",
                  ),
                ),
                Expanded(
                  child: _buildPlanDetail(
                    "Total Cost",
                    "\$${(plan["totalCost"] as double).toStringAsFixed(2)}",
                  ),
                ),
                Expanded(
                  child: _buildPlanDetail(
                    "Interest Rate",
                    "${(plan["interestRate"] as double).toStringAsFixed(2)}% APR",
                  ),
                ),
              ],
            ),
            if (plan["savings"] > 0) ...[
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.savings,
                      color: successColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Save \$${(plan["savings"] as double).toStringAsFixed(2)} vs paying upfront",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlanDetail(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSelection() {
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
            "Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Choose how you want to pay your monthly installments",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Column(
            spacing: spXs,
            children: paymentMethods.map((method) => _buildPaymentMethodTile(method)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile(Map<String, dynamic> method) {
    bool isSelected = selectedPaymentMethod == method["id"];
    
    return GestureDetector(
      onTap: () {
        selectedPaymentMethod = method["id"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(10) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              method["icon"] as IconData,
              color: isSelected ? primaryColor : disabledBoldColor,
              size: 24,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${method["label"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${method["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedPlanSummary() {
    Map<String, dynamic> plan = selectedPlanData;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Your Plan Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  "Duration",
                  "${plan["duration"]} months",
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  "Monthly Payment",
                  "\$${(plan["monthlyPayment"] as double).toStringAsFixed(2)}",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  "Interest Rate",
                  "${(plan["interestRate"] as double).toStringAsFixed(2)}% APR",
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  "Total Cost",
                  "\$${(plan["totalCost"] as double).toStringAsFixed(2)}",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
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

  Widget _buildInstallmentSchedule() {
    Map<String, dynamic> plan = selectedPlanData;
    int duration = plan["duration"] as int;
    double monthlyPayment = plan["monthlyPayment"] as double;
    
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
              Text(
                "Payment Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "$duration payments",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: duration > 6 ? 6 : duration,
              itemBuilder: (context, index) {
                DateTime paymentDate = DateTime.now().add(Duration(days: 30 * (index + 1)));
                bool isUpcoming = index < 3;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: isUpcoming ? infoColor.withAlpha(10) : disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: isUpcoming ? infoColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${paymentDate.dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Payment ${index + 1} of $duration",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${monthlyPayment.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (duration > 6)
            Text(
              "... and ${duration - 6} more payments",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Apply for Installment Plan",
            size: bs.md,
            onPressed: _applyForInstallment,
          ),
        ),
        Text(
          "Subject to credit approval. Terms and conditions apply.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "No impact on your credit score for checking eligibility",
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
    );
  }

  void _applyForInstallment() {
    Map<String, dynamic> plan = selectedPlanData;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Installment Plan"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("You're applying for:"),
            SizedBox(height: spSm),
            Text(
              "${plan["title"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "\$${(plan["monthlyPayment"] as double).toStringAsFixed(2)}/month for ${plan["duration"]} months",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: spSm),
            Text(
              "Total: \$${(plan["totalCost"] as double).toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => back(),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              back();
              _processApplication();
            },
          ),
        ],
      ),
    );
  }

  void _processApplication() async {
    showLoading();
    
    // Simulate credit check and approval process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    ss("Congratulations! Your installment plan has been approved.");
  }
}
