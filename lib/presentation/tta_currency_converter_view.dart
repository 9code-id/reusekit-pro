import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaCurrencyConverterView extends StatefulWidget {
  const TtaCurrencyConverterView({super.key});

  @override
  State<TtaCurrencyConverterView> createState() => _TtaCurrencyConverterViewState();
}

class _TtaCurrencyConverterViewState extends State<TtaCurrencyConverterView> {
  String fromCurrency = "USD";
  String toCurrency = "EUR";
  String amount = "";
  String convertedAmount = "0.00";
  bool isLoading = false;

  List<Map<String, dynamic>> currencyItems = [
    {"label": "US Dollar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "British Pound (GBP)", "value": "GBP"},
    {"label": "Japanese Yen (JPY)", "value": "JPY"},
    {"label": "Canadian Dollar (CAD)", "value": "CAD"},
    {"label": "Australian Dollar (AUD)", "value": "AUD"},
    {"label": "Swiss Franc (CHF)", "value": "CHF"},
    {"label": "Chinese Yuan (CNY)", "value": "CNY"},
    {"label": "Indian Rupee (INR)", "value": "INR"},
    {"label": "Singapore Dollar (SGD)", "value": "SGD"},
  ];

  List<Map<String, dynamic>> exchangeRates = [
    {"from": "USD", "to": "EUR", "rate": 0.85, "change": 0.002},
    {"from": "USD", "to": "GBP", "rate": 0.73, "change": -0.001},
    {"from": "USD", "to": "JPY", "rate": 110.25, "change": 0.45},
    {"from": "EUR", "to": "USD", "rate": 1.18, "change": -0.003},
    {"from": "GBP", "to": "USD", "rate": 1.37, "change": 0.005},
    {"from": "JPY", "to": "USD", "rate": 0.0091, "change": -0.0001},
  ];

  List<Map<String, dynamic>> favorites = [
    {"from": "USD", "to": "EUR", "rate": 0.85},
    {"from": "EUR", "to": "USD", "rate": 1.18},
    {"from": "GBP", "to": "USD", "rate": 1.37},
  ];

  void _convertCurrency() {
    if (amount.isEmpty) return;
    
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      double inputAmount = double.tryParse(amount) ?? 0.0;
      double rate = 0.85; // Mock rate
      double result = inputAmount * rate;
      
      setState(() {
        convertedAmount = result.toStringAsFixed(2);
        isLoading = false;
      });
    });
  }

  void _swapCurrencies() {
    setState(() {
      String temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
    
    if (amount.isNotEmpty) {
      _convertCurrency();
    }
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
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Convert Currency",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  QNumberField(
                    label: "Amount",
                    value: amount,
                    validator: Validator.required,
                    onChanged: (value) {
                      amount = value;
                      setState(() {});
                    },
                  ),
                  
                  // From Currency
                  QDropdownField(
                    label: "From Currency",
                    items: currencyItems,
                    value: fromCurrency,
                    onChanged: (value, label) {
                      fromCurrency = value;
                      setState(() {});
                    },
                  ),
                  
                  // Swap Button
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: _swapCurrencies,
                        icon: Icon(
                          Icons.swap_vert,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  
                  // To Currency
                  QDropdownField(
                    label: "To Currency",
                    items: currencyItems,
                    value: toCurrency,
                    onChanged: (value, label) {
                      toCurrency = value;
                      setState(() {});
                    },
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isLoading ? "Converting..." : "Convert",
                      size: bs.md,
                      onPressed: isLoading ? null : _convertCurrency,
                    ),
                  ),
                  
                  // Result
                  if (convertedAmount != "0.00") ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: successColor.withAlpha(100)),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Text(
                            "$amount $fromCurrency =",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "$convertedAmount $toCurrency",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Exchange Rates
            Text(
              "Live Exchange Rates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(exchangeRates.length, (index) {
                  final rate = exchangeRates[index];
                  bool isPositive = (rate["change"] as double) > 0;
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: index < exchangeRates.length - 1 
                        ? Border(bottom: BorderSide(color: disabledColor))
                        : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${rate["from"]}/${rate["to"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: spXxs,
                          children: [
                            Text(
                              "${(rate["rate"] as double).toStringAsFixed(4)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: spXxs,
                              children: [
                                Icon(
                                  isPositive ? Icons.trending_up : Icons.trending_down,
                                  size: 14,
                                  color: isPositive ? successColor : dangerColor,
                                ),
                                Text(
                                  "${isPositive ? '+' : ''}${(rate["change"] as double).toStringAsFixed(3)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isPositive ? successColor : dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            
            // Favorites
            Text(
              "Favorite Conversions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(favorites.length, (index) {
                  final favorite = favorites[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: index < favorites.length - 1 
                        ? Border(bottom: BorderSide(color: disabledColor))
                        : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXxs,
                            children: [
                              Text(
                                "1 ${favorite["from"]} = ${(favorite["rate"] as double).toStringAsFixed(4)} ${favorite["to"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${favorite["from"]} to ${favorite["to"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            fromCurrency = favorite["from"];
                            toCurrency = favorite["to"];
                            setState(() {});
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
