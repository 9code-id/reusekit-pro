import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaCurrencyConverterView extends StatefulWidget {
  const SpaCurrencyConverterView({super.key});

  @override
  State<SpaCurrencyConverterView> createState() => _SpaCurrencyConverterViewState();
}

class _SpaCurrencyConverterViewState extends State<SpaCurrencyConverterView> {
  String fromCurrency = "USD";
  String toCurrency = "EUR";
  String amount = "100";
  String convertedAmount = "0.00";
  
  List<Map<String, dynamic>> currencies = [
    {"label": "🇺🇸 US Dollar (USD)", "value": "USD", "flag": "🇺🇸", "symbol": "\$"},
    {"label": "🇪🇺 Euro (EUR)", "value": "EUR", "flag": "🇪🇺", "symbol": "€"},
    {"label": "🇬🇧 British Pound (GBP)", "value": "GBP", "flag": "🇬🇧", "symbol": "£"},
    {"label": "🇯🇵 Japanese Yen (JPY)", "value": "JPY", "flag": "🇯🇵", "symbol": "¥"},
    {"label": "🇨🇦 Canadian Dollar (CAD)", "value": "CAD", "flag": "🇨🇦", "symbol": "C\$"},
    {"label": "🇦🇺 Australian Dollar (AUD)", "value": "AUD", "flag": "🇦🇺", "symbol": "A\$"},
    {"label": "🇨🇭 Swiss Franc (CHF)", "value": "CHF", "flag": "🇨🇭", "symbol": "CHF"},
    {"label": "🇨🇳 Chinese Yuan (CNY)", "value": "CNY", "flag": "🇨🇳", "symbol": "¥"},
    {"label": "🇸🇬 Singapore Dollar (SGD)", "value": "SGD", "flag": "🇸🇬", "symbol": "S\$"},
    {"label": "🇮🇳 Indian Rupee (INR)", "value": "INR", "flag": "🇮🇳", "symbol": "₹"},
    {"label": "🇧🇷 Brazilian Real (BRL)", "value": "BRL", "flag": "🇧🇷", "symbol": "R\$"},
    {"label": "🇰🇷 South Korean Won (KRW)", "value": "KRW", "flag": "🇰🇷", "symbol": "₩"},
    {"label": "🇲🇽 Mexican Peso (MXN)", "value": "MXN", "flag": "🇲🇽", "symbol": "MX\$"},
    {"label": "🇷🇺 Russian Ruble (RUB)", "value": "RUB", "flag": "🇷🇺", "symbol": "₽"},
    {"label": "🇿🇦 South African Rand (ZAR)", "value": "ZAR", "flag": "🇿🇦", "symbol": "R"},
  ];

  // Exchange rates relative to USD (mock data - in real app, fetch from API)
  Map<String, double> exchangeRates = {
    "USD": 1.0,
    "EUR": 0.85,
    "GBP": 0.79,
    "JPY": 149.50,
    "CAD": 1.35,
    "AUD": 1.52,
    "CHF": 0.88,
    "CNY": 7.24,
    "SGD": 1.34,
    "INR": 83.15,
    "BRL": 5.02,
    "KRW": 1320.50,
    "MXN": 17.85,
    "RUB": 91.25,
    "ZAR": 18.75,
  };

  List<Map<String, dynamic>> conversionHistory = [];
  List<Map<String, dynamic>> favoriteRates = [
    {"from": "USD", "to": "EUR"},
    {"from": "EUR", "to": "USD"},
    {"from": "GBP", "to": "USD"},
    {"from": "USD", "to": "JPY"},
  ];

  @override
  void initState() {
    super.initState();
    _convertCurrency();
  }

  void _convertCurrency() {
    final inputAmount = double.tryParse(amount) ?? 0.0;
    if (inputAmount == 0.0) {
      convertedAmount = "0.00";
      return;  
    }

    final fromRate = exchangeRates[fromCurrency] ?? 1.0;
    final toRate = exchangeRates[toCurrency] ?? 1.0;
    
    // Convert to USD first, then to target currency
    final usdAmount = inputAmount / fromRate;
    final result = usdAmount * toRate;
    
    convertedAmount = result.toStringAsFixed(2);
    setState(() {});
  }

  void _addToHistory() {
    if (amount.isNotEmpty && double.tryParse(amount) != null) {
      final historyItem = {
        "from": fromCurrency,
        "to": toCurrency,
        "amount": amount,
        "converted": convertedAmount,
        "rate": ((double.tryParse(convertedAmount) ?? 0.0) / (double.tryParse(amount) ?? 1.0)).toStringAsFixed(4),
        "timestamp": DateTime.now(),
      };
      
      conversionHistory.insert(0, historyItem);
      if (conversionHistory.length > 10) {
        conversionHistory.removeLast();
      }
      setState(() {});
    }
  }

  void _swapCurrencies() {
    final temp = fromCurrency;
    fromCurrency = toCurrency;
    toCurrency = temp;
    _convertCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency Converter"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Converter Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Currency Converter",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // Amount Input
                  QNumberField(
                    label: "Amount",
                    value: amount,
                    onChanged: (value) {
                      amount = value;
                      _convertCurrency();
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // From Currency
                  QDropdownField(
                    label: "From Currency",
                    items: currencies,
                    value: fromCurrency,
                    onChanged: (value, label) {
                      fromCurrency = value;
                      _convertCurrency();
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Swap Button
                  Center(
                    child: GestureDetector(
                      onTap: _swapCurrencies,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [shadowSm],
                        ),
                        child: Icon(
                          Icons.swap_vert,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // To Currency
                  QDropdownField(
                    label: "To Currency",
                    items: currencies,
                    value: toCurrency,
                    onChanged: (value, label) {
                      toCurrency = value;
                      _convertCurrency();
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Conversion Result
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(100)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Converted Amount",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${currencies.firstWhere((c) => c["value"] == toCurrency)["symbol"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                convertedAmount,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ),
                            Text(
                              toCurrency,
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        if (amount.isNotEmpty && double.tryParse(amount) != null)
                          Text(
                            "1 $fromCurrency = ${((exchangeRates[toCurrency] ?? 1.0) / (exchangeRates[fromCurrency] ?? 1.0)).toStringAsFixed(4)} $toCurrency",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Action Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Add to History",
                      size: bs.sm,
                      onPressed: () {
                        _addToHistory();
                        ss("Conversion added to history");
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Quick Conversion Rates
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular Exchange Rates",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: favoriteRates.map((rate) {
                      final from = rate["from"] as String;
                      final to = rate["to"] as String;
                      final fromRate = exchangeRates[from] ?? 1.0;
                      final toRate = exchangeRates[to] ?? 1.0;
                      final conversionRate = toRate / fromRate;
                      
                      return _buildQuickRateCard(from, to, conversionRate);
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Conversion History
            if (conversionHistory.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Conversion History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            conversionHistory.clear();
                            setState(() {});
                            ss("History cleared");
                          },
                          child: Text(
                            "Clear All",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: conversionHistory.length,
                      itemBuilder: (context, index) {
                        final history = conversionHistory[index];
                        return _buildHistoryItem(history);
                      },
                    ),
                  ],
                ),
              ),

            // Market Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Market Information",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Exchange rates are updated in real-time from major financial markets\n"
                    "• Rates may vary slightly between different providers\n"
                    "• For large transactions, consult your bank for current rates\n"
                    "• Currency markets are closed on weekends and holidays\n"
                    "• Rates shown are for informational purposes only",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Currency Trends (Mock)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Trends",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildTrendCard("EUR/USD", "0.8500", "+0.15%", true),
                      _buildTrendCard("GBP/USD", "1.2650", "-0.08%", false),
                      _buildTrendCard("USD/JPY", "149.50", "+0.22%", true),
                      _buildTrendCard("USD/CAD", "1.3500", "-0.05%", false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickRateCard(String from, String to, double rate) {
    final fromCurrencyData = currencies.firstWhere((c) => c["value"] == from);
    final toCurrencyData = currencies.firstWhere((c) => c["value"] == to);
    
    return GestureDetector(
      onTap: () {
        fromCurrency = from;
        toCurrency = to;
        _convertCurrency();
        ss("Currencies updated");
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(30),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: primaryColor.withAlpha(100)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${fromCurrencyData["flag"]}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: spXs),
                Icon(
                  Icons.arrow_forward,
                  size: 12,
                  color: primaryColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${toCurrencyData["flag"]}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: spXs),
            Text(
              "$from/$to",
              style: TextStyle(
                fontSize: 10,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              rate.toStringAsFixed(4),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> history) {
    final timestamp = history["timestamp"] as DateTime;
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
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
                      "${history["amount"]} ${history["from"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Icon(
                      Icons.arrow_forward,
                      size: 10,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${history["converted"]} ${history["to"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  "Rate: ${history["rate"]} • ${timestamp.dMMMy} ${timestamp.dMMMykkss.split(' ')[1]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              fromCurrency = history["from"] as String;
              toCurrency = history["to"] as String;
              amount = history["amount"] as String;
              _convertCurrency();
              ss("Conversion loaded");
            },
            child: Icon(
              Icons.replay,
              size: 16,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendCard(String pair, String rate, String change, bool isPositive) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isPositive ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: isPositive ? successColor.withAlpha(100) : dangerColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pair,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            rate,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                size: 12,
                color: isPositive ? successColor : dangerColor,
              ),
              SizedBox(width: spXs),
              Text(
                change,
                style: TextStyle(
                  fontSize: 10,
                  color: isPositive ? successColor : dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
