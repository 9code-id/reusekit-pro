import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaMultiplePaymentView extends StatefulWidget {
  const SpaMultiplePaymentView({super.key});

  @override
  State<SpaMultiplePaymentView> createState() => _SpaMultiplePaymentViewState();
}

class _SpaMultiplePaymentViewState extends State<SpaMultiplePaymentView> {
  double totalAmount = 1299.99;
  List<Map<String, dynamic>> paymentSplits = [
    {
      "id": 1,
      "method": "credit_card",
      "methodLabel": "Credit Card •••• 1234",
      "amount": 649.99,
      "percentage": 50.0,
      "isEditing": false,
    },
    {
      "id": 2,
      "method": "paypal",
      "methodLabel": "PayPal Account",
      "amount": 650.00,
      "percentage": 50.0,
      "isEditing": false,
    }
  ];

  List<Map<String, dynamic>> availablePaymentMethods = [
    {
      "id": "credit_card_1",
      "type": "credit_card",
      "label": "Visa •••• 1234",
      "icon": Icons.credit_card,
      "brand": "Visa"
    },
    {
      "id": "credit_card_2",
      "type": "credit_card",
      "label": "Mastercard •••• 5678",
      "icon": Icons.credit_card,
      "brand": "Mastercard"
    },
    {
      "id": "paypal",
      "type": "digital_wallet",
      "label": "PayPal Account",
      "icon": Icons.payment,
      "brand": "PayPal"
    },
    {
      "id": "apple_pay",
      "type": "digital_wallet",
      "label": "Apple Pay",
      "icon": Icons.apple,
      "brand": "Apple"
    },
    {
      "id": "google_pay",
      "type": "digital_wallet",
      "label": "Google Pay",
      "icon": Icons.g_mobiledata,
      "brand": "Google"
    },
    {
      "id": "gift_card",
      "type": "gift_card",
      "label": "Gift Card",
      "icon": Icons.card_giftcard,
      "brand": "Gift Card"
    }
  ];

  double get totalAllocated => paymentSplits.fold(0.0, (sum, split) => sum + (split["amount"] as double));
  double get remaining => totalAmount - totalAllocated;
  bool get isValidSplit => (remaining.abs() < 0.01) && paymentSplits.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Split Payment"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _addPaymentMethod,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOrderSummary(),
            _buildPaymentSplitOverview(),
            _buildPaymentSplits(),
            _buildAddPaymentMethod(),
            _buildSplitSummary(),
            _buildCompletePaymentButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
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
            "Order Total",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Total Amount to Pay",
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "\$${totalAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
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
                    "Split this payment across multiple methods",
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
      ),
    );
  }

  Widget _buildPaymentSplitOverview() {
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
            "Payment Split Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildSplitStatCard(
                  "Allocated",
                  totalAllocated,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSplitStatCard(
                  "Remaining",
                  remaining,
                  remaining > 0.01 ? warningColor : successColor,
                ),
              ),
            ],
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: paymentSplits.map((split) {
                double percentage = (split["amount"] as double) / totalAmount;
                return Expanded(
                  flex: (percentage * 100).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _getPaymentMethodColor(split["method"]),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitStatCard(String label, double amount, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSplits() {
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
            "Payment Methods",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...paymentSplits.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> split = entry.value;
            return _buildPaymentSplitItem(split, index);
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentSplitItem(Map<String, dynamic> split, int index) {
    bool isEditing = split["isEditing"] as bool;
    Color methodColor = _getPaymentMethodColor(split["method"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: methodColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: methodColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: methodColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getPaymentMethodIcon(split["method"]),
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${split["methodLabel"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${(split["percentage"] as double).toStringAsFixed(1)}% of total",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isEditing) ...[
                Text(
                  "\$${(split["amount"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () => _editPaymentSplit(index),
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  onPressed: () => _removePaymentSplit(index),
                ),
              ],
            ],
          ),
          if (isEditing) ...[
            Row(
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Amount (\$)",
                    value: (split["amount"] as double).toStringAsFixed(2),
                    onChanged: (value) {
                      double amount = double.tryParse(value) ?? 0.0;
                      _updatePaymentSplit(index, amount);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Save",
                  size: bs.sm,
                  onPressed: () => _savePaymentSplit(index),
                ),
                SizedBox(width: spXs),
                QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () => _cancelEditPaymentSplit(index),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddPaymentMethod() {
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
            "Add Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: availablePaymentMethods.map((method) => _buildPaymentMethodOption(method)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(Map<String, dynamic> method) {
    bool isAlreadyUsed = paymentSplits.any((split) => split["method"] == method["id"]);
    
    return GestureDetector(
      onTap: isAlreadyUsed ? null : () => _addPaymentSplit(method),
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isAlreadyUsed ? disabledColor.withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isAlreadyUsed ? disabledColor : primaryColor.withAlpha(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isAlreadyUsed ? disabledColor : _getPaymentMethodColor(method["id"]),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                method["icon"] as IconData,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${method["label"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isAlreadyUsed ? disabledBoldColor : primaryColor,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (isAlreadyUsed)
              Text(
                "In Use",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isValidSplit ? successColor.withAlpha(10) : warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isValidSplit ? successColor.withAlpha(30) : warningColor.withAlpha(30),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                isValidSplit ? Icons.check_circle : Icons.warning,
                color: isValidSplit ? successColor : warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  isValidSplit ? "Payment split is valid" : "Payment split needs adjustment",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isValidSplit ? successColor : warningColor,
                  ),
                ),
              ),
            ],
          ),
          if (!isValidSplit)
            Text(
              remaining > 0 
                  ? "You need to allocate \$${remaining.toStringAsFixed(2)} more"
                  : "You have allocated \$${(-remaining).toStringAsFixed(2)} too much",
              style: TextStyle(
                fontSize: 12,
                color: warningColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCompletePaymentButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Complete Payment - \$${totalAmount.toStringAsFixed(2)}",
        size: bs.md,
        onPressed: isValidSplit ? _completePayment : null,
      ),
    );
  }

  Color _getPaymentMethodColor(String method) {
    switch (method) {
      case "credit_card":
      case "credit_card_1":
      case "credit_card_2":
        return primaryColor;
      case "paypal":
        return infoColor;
      case "apple_pay":
        return Colors.black;
      case "google_pay":
        return successColor;
      case "gift_card":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  IconData _getPaymentMethodIcon(String method) {
    switch (method) {
      case "credit_card":
      case "credit_card_1":
      case "credit_card_2":
        return Icons.credit_card;
      case "paypal":
        return Icons.payment;
      case "apple_pay":
        return Icons.apple;
      case "google_pay":
        return Icons.g_mobiledata;
      case "gift_card":
        return Icons.card_giftcard;
      default:
        return Icons.payment;
    }
  }

  void _addPaymentMethod() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Payment Method"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: availablePaymentMethods
              .where((method) => !paymentSplits.any((split) => split["method"] == method["id"]))
              .map((method) => _buildPaymentMethodDialogOption(method))
              .toList(),
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodDialogOption(Map<String, dynamic> method) {
    return GestureDetector(
      onTap: () {
        back();
        _addPaymentSplit(method);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spXs),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: disabledColor),
        ),
        child: Row(
          children: [
            Icon(
              method["icon"] as IconData,
              color: _getPaymentMethodColor(method["id"]),
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                "${method["label"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addPaymentSplit(Map<String, dynamic> method) {
    double remainingAmount = remaining > 0 ? remaining : 0;
    
    setState(() {
      paymentSplits.add({
        "id": DateTime.now().millisecondsSinceEpoch,
        "method": method["id"],
        "methodLabel": method["label"],
        "amount": remainingAmount,
        "percentage": (remainingAmount / totalAmount) * 100,
        "isEditing": false,
      });
    });
  }

  void _removePaymentSplit(int index) async {
    bool isConfirmed = await confirm("Remove this payment method?");
    if (isConfirmed) {
      setState(() {
        paymentSplits.removeAt(index);
      });
    }
  }

  void _editPaymentSplit(int index) {
    setState(() {
      paymentSplits[index]["isEditing"] = true;
    });
  }

  void _updatePaymentSplit(int index, double amount) {
    setState(() {
      paymentSplits[index]["amount"] = amount;
      paymentSplits[index]["percentage"] = (amount / totalAmount) * 100;
    });
  }

  void _savePaymentSplit(int index) {
    setState(() {
      paymentSplits[index]["isEditing"] = false;
    });
  }

  void _cancelEditPaymentSplit(int index) {
    setState(() {
      paymentSplits[index]["isEditing"] = false;
    });
  }

  void _completePayment() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Split Payment"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("You will be charged across ${paymentSplits.length} payment methods:"),
            SizedBox(height: spSm),
            ...paymentSplits.map((split) => Text(
              "${split["methodLabel"]}: \$${(split["amount"] as double).toStringAsFixed(2)}",
              style: TextStyle(fontSize: 14),
            )),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => back(),
          ),
          QButton(
            label: "Confirm",
            size: bs.sm,
            onPressed: () {
              back();
              _processPayment();
            },
          ),
        ],
      ),
    );
  }

  void _processPayment() async {
    showLoading();
    
    // Simulate processing each payment method
    for (int i = 0; i < paymentSplits.length; i++) {
      await Future.delayed(Duration(seconds: 1));
    }
    
    hideLoading();
    ss("Payment completed successfully across ${paymentSplits.length} methods!");
  }
}
