import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReceipt8View extends StatefulWidget {
  @override
  State<GrlReceipt8View> createState() => _GrlReceipt8ViewState();
}

class _GrlReceipt8ViewState extends State<GrlReceipt8View> {
  Map<String, dynamic> receipt = {
    "id": "UTL-789654",
    "account": "123456789",
    "billing_period": "May 2024",
    "due_date": "2024-07-15",
    "company": "PowerGrid Electric Company",
    "address": "789 Energy Blvd, Power City",
    "phone": "+1 555 789 0123",
    "website": "www.powergrid.com",
    "customer": {
      "name": "Jennifer Davis",
      "address": "456 Maple Avenue, Hometown",
      "service_address": "456 Maple Avenue, Hometown",
      "account_type": "Residential"
    },
    "meter": {
      "number": "EL123456789",
      "previous_reading": 8456,
      "current_reading": 8756,
      "usage_kwh": 300,
      "reading_date": "2024-05-31"
    },
    "usage_details": {
      "days_in_period": 31,
      "daily_average": 9.7,
      "last_year_same_period": 285
    },
    "charges": [
      {"description": "Basic Service Charge", "rate": "Fixed", "amount": 12.50},
      {"description": "Energy Charge (300 kWh)", "rate": "\$0.1245/kWh", "amount": 37.35},
      {"description": "Distribution Charge", "rate": "\$0.0589/kWh", "amount": 17.67},
      {"description": "Transmission Charge", "rate": "\$0.0234/kWh", "amount": 7.02},
      {"description": "Environmental Fee", "rate": "Fixed", "amount": 2.50},
      {"description": "State Tax (6.5%)", "rate": "6.5%", "amount": 5.02}
    ],
    "total_current": 82.06,
    "previous_balance": 0.00,
    "payments_received": 0.00,
    "total_due": 82.06,
    "payment_methods": [
      "Online at www.powergrid.com",
      "Phone: 1-800-PAY-BILL",
      "Auto Pay available",
      "Mail payment to PO Box 789"
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Utility Bill"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.electrical_services),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.payment),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowLg],
          ),
          child: Column(
            children: [
              _buildCompanyHeader(),
              _buildAccountInfo(),
              _buildCustomerInfo(),
              _buildMeterInfo(),
              _buildUsageChart(),
              _buildChargesBreakdown(),
              _buildBillSummary(),
              _buildPaymentMethods(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[800]!, Colors.cyan[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusLg),
          topRight: Radius.circular(radiusLg),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.flash_on,
              color: Colors.blue[800],
              size: 48,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "${receipt["company"]}",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${receipt["address"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(220),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                color: Colors.white.withAlpha(200),
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${receipt["phone"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(220),
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.language,
                color: Colors.white.withAlpha(200),
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${receipt["website"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(220),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Number",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${receipt["account"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Text(
                  "DUE DATE",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[700],
                  ),
                ),
                Text(
                  "${receipt["due_date"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[700],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Billing Period",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${receipt["billing_period"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    final customer = receipt["customer"] as Map<String, dynamic>;
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.blue[600],
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "CUSTOMER INFORMATION",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                  letterSpacing: 1,
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
                      "Customer Name",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${customer["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Billing Address",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${customer["address"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.blue[600],
                      size: 20,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${customer["account_type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[600],
                      ),
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

  Widget _buildMeterInfo() {
    final meter = receipt["meter"] as Map<String, dynamic>;
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.cyan[50],
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.electrical_services,
                color: Colors.cyan[600],
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "METER READING",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan[700],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: Colors.cyan[200]!,
                width: 1,
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
                          Text(
                            "Meter Number",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${meter["number"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.cyan[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Reading Date: ${meter["reading_date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.cyan[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildReadingDetail("Previous", "${meter["previous_reading"]}", "kWh"),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.cyan[600],
                      size: 20,
                    ),
                    Expanded(
                      child: _buildReadingDetail("Current", "${meter["current_reading"]}", "kWh"),
                    ),
                    Icon(
                      Icons.flash_on,
                      color: Colors.orange[600],
                      size: 20,
                    ),
                    Expanded(
                      child: _buildReadingDetail("Usage", "${meter["usage_kwh"]}", "kWh"),
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

  Widget _buildReadingDetail(String label, String value, String unit) {
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
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: Colors.cyan[700],
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            fontSize: 10,
            color: Colors.cyan[600],
          ),
        ),
      ],
    );
  }

  Widget _buildUsageChart() {
    final usage = receipt["usage_details"] as Map<String, dynamic>;
    final currentUsage = (receipt["meter"] as Map<String, dynamic>)["usage_kwh"] as int;
    final lastYearUsage = usage["last_year_same_period"] as int;
    final difference = currentUsage - lastYearUsage;
    final isHigher = difference > 0;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                color: Colors.blue[600],
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "USAGE COMPARISON",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "This Period",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "$currentUsage kWh",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      Text(
                        "${usage["days_in_period"]} days",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Same Period Last Year",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "$lastYearUsage kWh",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Previous year",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isHigher ? Colors.red[50] : Colors.green[50],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: isHigher ? Colors.red[200]! : Colors.green[200]!,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isHigher ? Icons.trending_up : Icons.trending_down,
                  color: isHigher ? Colors.red[600] : Colors.green[600],
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "${isHigher ? '+' : ''}$difference kWh vs. last year",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isHigher ? Colors.red[700] : Colors.green[700],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Center(
            child: Text(
              "Daily Average: ${(usage["daily_average"] as double).toStringAsFixed(1)} kWh/day",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChargesBreakdown() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: Colors.blue[600],
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "CHARGES BREAKDOWN",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue[200]!,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusLg),
                      topRight: Radius.circular(radiusLg),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "DESCRIPTION",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "RATE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "AMOUNT",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...List.generate((receipt["charges"] as List).length, (index) {
                  final charge = (receipt["charges"] as List)[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.white : Colors.blue[25],
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue[100]!,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "${charge["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${charge["rate"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "\$${(charge["amount"] as double).toStringAsFixed(2)}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillSummary() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[100]!, Colors.cyan[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.blue[300]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            "BILL SUMMARY",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Current Charges", (receipt["total_current"] as double)),
          SizedBox(height: spSm),
          _buildSummaryRow("Previous Balance", (receipt["previous_balance"] as double)),
          SizedBox(height: spSm),
          _buildSummaryRow("Payments Received", -(receipt["payments_received"] as double), isCredit: true),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.symmetric(vertical: spMd),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.blue[400]!,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TOTAL AMOUNT DUE",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
                Text(
                  "\$${(receipt["total_due"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.schedule,
                  color: Colors.orange[600],
                  size: 16,
                ),
                SizedBox(width: spSm),
                Text(
                  "Due by ${receipt["due_date"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isCredit = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "${isCredit && amount != 0 ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isCredit ? Colors.green[600] : Colors.blue[700],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.green[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.payment,
                color: Colors.green[600],
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "PAYMENT OPTIONS",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...List.generate((receipt["payment_methods"] as List).length, (index) {
            final method = (receipt["payment_methods"] as List)[index] as String;
            return Container(
              padding: EdgeInsets.symmetric(vertical: spSm),
              child: Row(
                children: [
                  Icon(
                    _getPaymentIcon(method),
                    color: Colors.green[600],
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      method,
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getPaymentIcon(String method) {
    if (method.contains("Online")) return Icons.computer;
    if (method.contains("Phone")) return Icons.phone;
    if (method.contains("Auto")) return Icons.autorenew;
    if (method.contains("Mail")) return Icons.mail;
    return Icons.payment;
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(spLg),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[100]!, Colors.cyan[100]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Text(
                  "⚡ Thank You for Your Business ⚡",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "PowerGrid Electric Company - Powering Your Future",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[700],
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "Questions about your bill? Visit our website or call customer service.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Text(
                  "Energy Saving Tip:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Set your thermostat 2-3 degrees higher in summer and lower in winter to save on energy costs.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
