import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPayment7View extends StatefulWidget {
  @override
  State<GrlPayment7View> createState() => _GrlPayment7ViewState();
}

class _GrlPayment7ViewState extends State<GrlPayment7View> {
  List<Map<String, dynamic>> cryptoAssets = [
    {
      "symbol": "BTC",
      "name": "Bitcoin",
      "balance": 1.25,
      "usdValue": 67500.00,
      "change24h": 2.5,
      "color": Colors.orange,
      "icon": Icons.currency_bitcoin,
    },
    {
      "symbol": "ETH",
      "name": "Ethereum",
      "balance": 8.75,
      "usdValue": 3200.00,
      "change24h": -1.2,
      "color": Colors.purple,
      "icon": Icons.diamond,
    },
    {
      "symbol": "BNB",
      "name": "Binance Coin",
      "balance": 45.0,
      "usdValue": 245.00,
      "change24h": 3.8,
      "color": Colors.amber,
      "icon": Icons.star,
    },
    {
      "symbol": "ADA",
      "name": "Cardano",
      "balance": 2500.0,
      "usdValue": 0.38,
      "change24h": 0.5,
      "color": Colors.blue,
      "icon": Icons.favorite,
    },
    {
      "symbol": "SOL",
      "name": "Solana",
      "balance": 12.5,
      "usdValue": 145.00,
      "change24h": -2.1,
      "color": Colors.green,
      "icon": Icons.flash_on,
    },
  ];

  List<Map<String, dynamic>> cryptoTransactions = [
    {
      "id": "tx_001",
      "type": "buy",
      "symbol": "BTC",
      "amount": 0.05,
      "usdAmount": 3375.00,
      "date": "2024-06-21",
      "status": "completed"
    },
    {
      "id": "tx_002",
      "type": "sell",
      "symbol": "ETH",
      "amount": 1.2,
      "usdAmount": 3840.00,
      "date": "2024-06-20",
      "status": "completed"
    },
    {
      "id": "tx_003",
      "type": "receive",
      "symbol": "BNB",
      "amount": 10.0,
      "usdAmount": 2450.00,
      "date": "2024-06-19",
      "status": "completed"
    },
    {
      "id": "tx_004",
      "type": "send",
      "symbol": "ADA",
      "amount": 500.0,
      "usdAmount": 190.00,
      "date": "2024-06-18",
      "status": "pending"
    },
  ];

  String selectedAction = "buy";
  String selectedCrypto = "BTC";
  String tradeAmount = "";
  String recipientAddress = "";
  bool showTradeForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Wallet"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              si("QR Scanner coming soon!");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildPortfolioOverview(),
          _buildQuickActions(),
          Expanded(
            child: showTradeForm ? _buildTradeForm() : _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioOverview() {
    double totalValue = cryptoAssets.fold(0.0, (sum, asset) => 
        sum + ((asset["balance"] as double) * (asset["usdValue"] as double)));
    
    double totalChange = cryptoAssets.fold(0.0, (sum, asset) => 
        sum + (asset["change24h"] as double));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Text(
            "Total Portfolio Value",
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 14,
            ),
          ),
          Text(
            "\$${totalValue.toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.white,
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                totalChange >= 0 ? Icons.trending_up : Icons.trending_down,
                color: totalChange >= 0 ? successColor : dangerColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${totalChange >= 0 ? '+' : ''}${totalChange.toStringAsFixed(2)}%",
                style: TextStyle(
                  color: totalChange >= 0 ? successColor : dangerColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                " (24h)",
                style: TextStyle(
                  color: Colors.white.withAlpha(200),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> actions = [
      {"title": "Buy", "icon": Icons.add_circle, "color": successColor, "action": "buy"},
      {"title": "Sell", "icon": Icons.remove_circle, "color": dangerColor, "action": "sell"},
      {"title": "Send", "icon": Icons.send, "color": primaryColor, "action": "send"},
      {"title": "Receive", "icon": Icons.call_received, "color": Colors.blue, "action": "receive"},
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: actions.map((action) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                _handleQuickAction("${action["action"]}");
              },
              child: Container(
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (action["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        action["icon"] as IconData,
                        color: action["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${action["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      child: Column(
        children: [
          _buildTabSelector(),
          Expanded(
            child: _buildAssetsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Show assets
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "My Assets",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Show transactions (not implemented in this simple version)
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                child: Text(
                  "Transactions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetsList() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: cryptoAssets.map((asset) {
          return _buildAssetCard(asset);
        }).toList(),
      ),
    );
  }

  Widget _buildAssetCard(Map<String, dynamic> asset) {
    double totalValue = (asset["balance"] as double) * (asset["usdValue"] as double);
    double change24h = asset["change24h"] as double;
    bool isPositive = change24h >= 0;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (asset["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              asset["icon"] as IconData,
              color: asset["color"] as Color,
              size: 24,
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
                      "${asset["symbol"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${asset["name"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${(asset["balance"] as double).toStringAsFixed(asset["symbol"] == "BTC" ? 8 : 4)} ${asset["symbol"]}",
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
              Text(
                "\$${totalValue.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isPositive ? successColor : dangerColor,
                      size: 12,
                    ),
                    Text(
                      "${change24h.abs().toStringAsFixed(2)}%",
                      style: TextStyle(
                        color: isPositive ? successColor : dangerColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
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

  Widget _buildTradeForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${selectedAction.toUpperCase()} Crypto",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                icon: Icons.close,
                size: bs.sm,
                onPressed: () {
                  showTradeForm = false;
                  _clearTradeForm();
                  setState(() {});
                },
              ),
            ],
          ),
          _buildActionSelector(),
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
                Text(
                  "Trade Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QDropdownField(
                  label: "Select Cryptocurrency",
                  items: cryptoAssets.map((asset) => {
                    "label": "${asset["symbol"]} - ${asset["name"]}",
                    "value": asset["symbol"],
                  }).toList(),
                  value: selectedCrypto,
                  onChanged: (value, label) {
                    selectedCrypto = value;
                    setState(() {});
                  },
                ),
                if (selectedAction == "buy" || selectedAction == "sell")
                  QNumberField(
                    label: selectedAction == "buy" 
                        ? "Amount in USD (\$)"
                        : "Amount in ${selectedCrypto}",
                    value: tradeAmount,
                    onChanged: (value) {
                      tradeAmount = value;
                      setState(() {});
                    },
                  ),
                if (selectedAction == "send") ...[
                  QNumberField(
                    label: "Amount (${selectedCrypto})",
                    value: tradeAmount,
                    onChanged: (value) {
                      tradeAmount = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Recipient Address",
                    value: recipientAddress,
                    hint: "Enter wallet address",
                    onChanged: (value) {
                      recipientAddress = value;
                      setState(() {});
                    },
                  ),
                ],
                if (selectedAction == "receive")
                  _buildReceiveQRCode(),
              ],
            ),
          ),
          if (selectedAction != "receive") ...[
            _buildTradeSummary(),
            _buildTradeWarning(),
            QButton(
              label: _getActionButtonText(),
              onPressed: _canExecuteTrade() ? () {
                _executeTrade();
              } : null,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionSelector() {
    List<String> actions = ["buy", "sell", "send", "receive"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: actions.map((action) {
          bool isSelected = selectedAction == action;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedAction = action;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                margin: EdgeInsets.only(right: spXs),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  action.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : disabledBoldColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReceiveQRCode() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.qr_code,
              size: 100,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Your ${selectedCrypto} Address",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontFamily: "monospace",
            ),
          ),
          SizedBox(height: spSm),
          QButton(
            label: "Copy Address",
            size: bs.sm,
            onPressed: () {
              ss("Address copied to clipboard");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTradeSummary() {
    if (tradeAmount.isEmpty || selectedAction == "receive") return Container();
    
    Map<String, dynamic> selectedAsset = cryptoAssets.firstWhere(
      (asset) => asset["symbol"] == selectedCrypto,
    );
    
    double amount = double.tryParse(tradeAmount) ?? 0.0;
    double rate = selectedAsset["usdValue"] as double;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Transaction Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (selectedAction == "buy")
            _buildSummaryRow("You Pay", "\$${amount.toStringAsFixed(2)}"),
          if (selectedAction == "buy")
            _buildSummaryRow("You Get", "${(amount / rate).toStringAsFixed(8)} $selectedCrypto"),
          if (selectedAction == "sell")
            _buildSummaryRow("You Sell", "${amount.toStringAsFixed(8)} $selectedCrypto"),
          if (selectedAction == "sell")
            _buildSummaryRow("You Get", "\$${(amount * rate).toStringAsFixed(2)}"),
          if (selectedAction == "send")
            _buildSummaryRow("Amount", "${amount.toStringAsFixed(8)} $selectedCrypto"),
          _buildSummaryRow("Network Fee", "~\$2.50"),
          _buildSummaryRow("Exchange Rate", "1 $selectedCrypto = \$${rate.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _buildTradeWarning() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: warningColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: warningColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "Cryptocurrency investments are subject to market risk. Please trade responsibly.",
              style: TextStyle(
                fontSize: 12,
                color: warningColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  String _getActionButtonText() {
    switch (selectedAction) {
      case "buy":
        return "Buy $selectedCrypto";
      case "sell":
        return "Sell $selectedCrypto";
      case "send":
        return "Send $selectedCrypto";
      default:
        return "Execute";
    }
  }

  bool _canExecuteTrade() {
    if (selectedAction == "receive") return false;
    if (selectedAction == "send") {
      return tradeAmount.isNotEmpty && recipientAddress.isNotEmpty;
    }
    return tradeAmount.isNotEmpty;
  }

  void _clearTradeForm() {
    tradeAmount = "";
    recipientAddress = "";
  }

  void _handleQuickAction(String action) {
    selectedAction = action;
    showTradeForm = true;
    setState(() {});
  }

  void _executeTrade() {
    showLoading();
    
    // Simulate trade execution
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      showTradeForm = false;
      _clearTradeForm();
      
      String message;
      switch (selectedAction) {
        case "buy":
          message = "$selectedCrypto purchased successfully!";
          break;
        case "sell":
          message = "$selectedCrypto sold successfully!";
          break;
        case "send":
          message = "$selectedCrypto sent successfully!";
          break;
        default:
          message = "Transaction completed!";
      }
      
      ss(message);
      setState(() {});
    });
  }
}
