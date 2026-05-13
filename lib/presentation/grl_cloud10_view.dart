import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCloud10View extends StatefulWidget {
  @override
  State<GrlCloud10View> createState() => _GrlCloud10ViewState();
}

class _GrlCloud10ViewState extends State<GrlCloud10View> {
  bool loading = false;
  
  Map<String, dynamic> currentPlan = {
    "name": "Professional",
    "price": 9.99,
    "storage": "100 GB",
    "usedStorage": 45.2,
    "billingCycle": "monthly",
    "nextBilling": "2024-07-22T00:00:00Z",
    "status": "active",
  };

  List<Map<String, dynamic>> billingHistory = [
    {
      "id": "1",
      "amount": 9.99,
      "date": "2024-06-22T00:00:00Z",
      "status": "paid",
      "plan": "Professional",
      "cycle": "monthly",
      "paymentMethod": "•••• 4242",
    },
    {
      "id": "2",
      "amount": 9.99,
      "date": "2024-05-22T00:00:00Z",
      "status": "paid",
      "plan": "Professional",
      "cycle": "monthly",
      "paymentMethod": "•••• 4242",
    },
    {
      "id": "3",
      "amount": 9.99,
      "date": "2024-04-22T00:00:00Z",
      "status": "paid",
      "plan": "Professional",
      "cycle": "monthly",
      "paymentMethod": "•••• 4242",
    },
    {
      "id": "4",
      "amount": 29.99,
      "date": "2024-03-22T00:00:00Z",
      "status": "failed",
      "plan": "Professional",
      "cycle": "monthly",
      "paymentMethod": "•••• 1234",
    },
    {
      "id": "5",
      "amount": 9.99,
      "date": "2024-02-22T00:00:00Z",
      "status": "paid",
      "plan": "Professional",
      "cycle": "monthly",
      "paymentMethod": "•••• 4242",
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "1",
      "type": "card",
      "last4": "4242",
      "brand": "Visa",
      "expiryMonth": 12,
      "expiryYear": 2027,
      "isDefault": true,
    },
    {
      "id": "2",
      "type": "card",
      "last4": "1234",
      "brand": "Mastercard",
      "expiryMonth": 8,
      "expiryYear": 2026,
      "isDefault": false,
    },
  ];

  Map<String, dynamic> usageStats = {
    "currentMonth": {
      "uploads": 156,
      "downloads": 89,
      "storage": 45.2,
      "bandwidth": 2.3,
    },
    "lastMonth": {
      "uploads": 142,
      "downloads": 76,
      "storage": 42.1,
      "bandwidth": 1.8,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account & Billing"),
        actions: [
          IconButton(
            icon: Icon(Icons.receipt),
            onPressed: _downloadInvoice,
          ),
        ],
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCurrentPlan(),
                SizedBox(height: spLg),
                _buildUsageStats(),
                SizedBox(height: spLg),
                _buildPaymentMethods(),
                SizedBox(height: spLg),
                _buildBillingHistory(),
                SizedBox(height: spLg),
                _buildAccountActions(),
              ],
            ),
          ),
    );
  }

  Widget _buildCurrentPlan() {
    double storagePercentage = (currentPlan["usedStorage"] as double) / 100;
    Color planStatusColor = currentPlan["status"] == "active" ? successColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.workspace_premium,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Current Plan",
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
                  color: planStatusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${currentPlan["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: planStatusColor,
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
                      "${currentPlan["name"]} Plan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${((currentPlan["price"] as double)).toStringAsFixed(2)}/${currentPlan["billingCycle"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
                    "Next billing",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    DateTime.parse("${currentPlan["nextBilling"]}").dMMMy,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Storage Usage",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "${((currentPlan["usedStorage"] as double)).toStringAsFixed(1)} GB",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                " of ${currentPlan["storage"]} used",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(storagePercentage * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: storagePercentage,
              child: Container(
                decoration: BoxDecoration(
                  color: _getStorageColor(storagePercentage),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Upgrade Plan",
                  size: bs.sm,
                  onPressed: _upgradePlan,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Change Billing",
                  size: bs.sm,
                  onPressed: _changeBilling,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUsageStats() {
    Map<String, dynamic> current = usageStats["currentMonth"] as Map<String, dynamic>;
    Map<String, dynamic> last = usageStats["lastMonth"] as Map<String, dynamic>;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Usage This Month",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildUsageMetric(
                  "Uploads",
                  "${current["uploads"]}",
                  _getChangeIndicator((current["uploads"] as int) - (last["uploads"] as int)),
                  Icons.cloud_upload,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildUsageMetric(
                  "Downloads",
                  "${current["downloads"]}",
                  _getChangeIndicator((current["downloads"] as int) - (last["downloads"] as int)),
                  Icons.cloud_download,
                  infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildUsageMetric(
                  "Storage",
                  "${((current["storage"] as double)).toStringAsFixed(1)} GB",
                  _getChangeIndicator(((current["storage"] as double) - (last["storage"] as double)).toInt()),
                  Icons.storage,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildUsageMetric(
                  "Bandwidth",
                  "${((current["bandwidth"] as double)).toStringAsFixed(1)} GB",
                  _getChangeIndicator(((current["bandwidth"] as double) - (last["bandwidth"] as double)).toInt()),
                  Icons.network_check,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUsageMetric(String title, String value, Widget changeIndicator, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          changeIndicator,
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Payment Methods",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: _addPaymentMethod,
              child: Text(
                "Add New",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...paymentMethods.map((method) => _buildPaymentMethodItem(method)).toList(),
      ],
    );
  }

  Widget _buildPaymentMethodItem(Map<String, dynamic> method) {
    bool isDefault = method["isDefault"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: isDefault 
          ? Border.all(color: primaryColor, width: 2)
          : Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.credit_card,
              size: 24,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${method["brand"]} •••• ${method["last4"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (isDefault) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "DEFAULT",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  "Expires ${method["expiryMonth"]}/${method["expiryYear"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: disabledBoldColor),
            onSelected: (value) => _handlePaymentMethodAction(value, method),
            itemBuilder: (context) => [
              if (!isDefault) PopupMenuItem(value: "default", child: Text("Set as Default")),
              PopupMenuItem(value: "edit", child: Text("Edit")),
              PopupMenuItem(value: "remove", child: Text("Remove")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillingHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Billing History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: _viewAllBilling,
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...billingHistory.take(3).map((billing) => _buildBillingHistoryItem(billing)).toList(),
      ],
    );
  }

  Widget _buildBillingHistoryItem(Map<String, dynamic> billing) {
    Color statusColor = billing["status"] == "paid" ? successColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              billing["status"] == "paid" ? Icons.check_circle : Icons.error,
              size: 20,
              color: statusColor,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${billing["plan"]} Plan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${billing["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Payment method: ${billing["paymentMethod"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  DateTime.parse("${billing["date"]}").dMMMy,
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
              Text(
                "\$${((billing["amount"] as double)).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () => _downloadInvoiceForBilling(billing),
                child: Text(
                  "Download",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActions() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Update Billing Info",
            size: bs.md,
            icon: Icons.edit,
            onPressed: _updateBillingInfo,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Cancel Subscription",
                size: bs.sm,
                onPressed: _cancelSubscription,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Export Data",
                size: bs.sm,
                onPressed: _exportAccountData,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStorageColor(double percentage) {
    if (percentage >= 0.9) return dangerColor;
    if (percentage >= 0.8) return warningColor;
    return primaryColor;
  }

  Widget _getChangeIndicator(int change) {
    if (change == 0) {
      return Text(
        "No change",
        style: TextStyle(
          fontSize: 10,
          color: disabledBoldColor,
        ),
      );
    }
    
    Color color = change > 0 ? successColor : dangerColor;
    IconData icon = change > 0 ? Icons.trending_up : Icons.trending_down;
    
    return Row(
      children: [
        Icon(
          icon,
          size: 12,
          color: color,
        ),
        SizedBox(width: spXs),
        Text(
          "${change > 0 ? '+' : ''}$change",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  void _upgradePlan() {
    si("Feature coming soon - Upgrade subscription plan");
  }

  void _changeBilling() {
    si("Feature coming soon - Change billing cycle");
  }

  void _addPaymentMethod() {
    si("Feature coming soon - Add new payment method");
  }

  void _handlePaymentMethodAction(String action, Map<String, dynamic> method) {
    switch (action) {
      case "default":
        _setDefaultPaymentMethod(method);
        break;
      case "edit":
        _editPaymentMethod(method);
        break;
      case "remove":
        _removePaymentMethod(method);
        break;
    }
  }

  void _setDefaultPaymentMethod(Map<String, dynamic> method) {
    for (var m in paymentMethods) {
      m["isDefault"] = false;
    }
    method["isDefault"] = true;
    setState(() {});
    ss("Payment method set as default");
  }

  void _editPaymentMethod(Map<String, dynamic> method) {
    si("Feature coming soon - Edit payment method");
  }

  void _removePaymentMethod(Map<String, dynamic> method) async {
    bool isConfirmed = await confirm("Remove this payment method?");
    if (isConfirmed) {
      paymentMethods.remove(method);
      setState(() {});
      sw("Payment method removed");
    }
  }

  void _viewAllBilling() {
    si("Feature coming soon - View complete billing history");
  }

  void _downloadInvoice() {
    ss("Invoice download started");
  }

  void _downloadInvoiceForBilling(Map<String, dynamic> billing) {
    ss("Invoice for ${DateTime.parse("${billing["date"]}").dMMMy} downloaded");
  }

  void _updateBillingInfo() {
    si("Feature coming soon - Update billing information");
  }

  void _cancelSubscription() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel your subscription?");
    if (isConfirmed) {
      se("Subscription cancellation is not available in demo mode");
    }
  }

  void _exportAccountData() {
    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Account data export started. You'll receive an email when ready.");
    });
  }
}
