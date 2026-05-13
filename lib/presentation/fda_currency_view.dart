import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaCurrencyView extends StatefulWidget {
  const FdaCurrencyView({super.key});

  @override
  State<FdaCurrencyView> createState() => _FdaCurrencyViewState();
}

class _FdaCurrencyViewState extends State<FdaCurrencyView> {
  String selectedCurrency = "USD";
  bool autoDetectCurrency = true;
  bool showConversion = false;
  String baseCurrency = "USD";

  List<Map<String, dynamic>> currencies = [
    {
      "code": "USD",
      "name": "US Dollar",
      "symbol": "\$",
      "flag": "🇺🇸",
      "rate": 1.0,
      "countries": ["United States", "Ecuador", "El Salvador"],
    },
    {
      "code": "EUR",
      "name": "Euro",
      "symbol": "€",
      "flag": "🇪🇺",
      "rate": 0.85,
      "countries": ["Germany", "France", "Italy", "Spain"],
    },
    {
      "code": "GBP",
      "name": "British Pound",
      "symbol": "£",
      "flag": "🇬🇧",
      "rate": 0.73,
      "countries": ["United Kingdom"],
    },
    {
      "code": "JPY",
      "name": "Japanese Yen",
      "symbol": "¥",
      "flag": "🇯🇵",
      "rate": 110.0,
      "countries": ["Japan"],
    },
    {
      "code": "CNY",
      "name": "Chinese Yuan",
      "symbol": "¥",
      "flag": "🇨🇳",
      "rate": 6.45,
      "countries": ["China"],
    },
    {
      "code": "CAD",
      "name": "Canadian Dollar",
      "symbol": "C\$",
      "flag": "🇨🇦",
      "rate": 1.25,
      "countries": ["Canada"],
    },
    {
      "code": "AUD",
      "name": "Australian Dollar",
      "symbol": "A\$",
      "flag": "🇦🇺",
      "rate": 1.35,
      "countries": ["Australia"],
    },
    {
      "code": "CHF",
      "name": "Swiss Franc",
      "symbol": "CHF",
      "flag": "🇨🇭",
      "rate": 0.92,
      "countries": ["Switzerland"],
    },
    {
      "code": "INR",
      "name": "Indian Rupee",
      "symbol": "₹",
      "flag": "🇮🇳",
      "rate": 74.5,
      "countries": ["India"],
    },
    {
      "code": "KRW",
      "name": "South Korean Won",
      "symbol": "₩",
      "flag": "🇰🇷",
      "rate": 1180.0,
      "countries": ["South Korea"],
    },
    {
      "code": "SGD",
      "name": "Singapore Dollar",
      "symbol": "S\$",
      "flag": "🇸🇬",
      "rate": 1.35,
      "countries": ["Singapore"],
    },
    {
      "code": "AED",
      "name": "UAE Dirham",
      "symbol": "د.إ",
      "flag": "🇦🇪",
      "rate": 3.67,
      "countries": ["United Arab Emirates"],
    },
  ];

  List<String> popularCurrencies = ["USD", "EUR", "GBP", "JPY", "CNY"];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentCurrency = currencies.firstWhere((curr) => curr["code"] == selectedCurrency);

    return Scaffold(
      appBar: AppBar(
        title: Text("Currency & Payments"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Current Currency Display
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(60)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Currency",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${currentCurrency["name"]} (${currentCurrency["code"]})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "${currentCurrency["flag"]}",
                        style: TextStyle(fontSize: 32),
                      ),
                      Text(
                        "${currentCurrency["symbol"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price Preview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.preview,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Price Preview",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Sample order:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${currentCurrency["symbol"]}${_convertPrice(25.99, currentCurrency["rate"])}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  if (showConversion && selectedCurrency != baseCurrency)
                    Text(
                      "≈ \$25.99 USD",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                ],
              ),
            ),

            // Currency Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Currency Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Auto-detect currency
                  Row(
                    children: [
                      Icon(
                        Icons.gps_fixed,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Auto-detect currency",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Automatically use local currency based on your location",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: autoDetectCurrency,
                        onChanged: (value) {
                          autoDetectCurrency = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),

                  // Show conversion
                  Row(
                    children: [
                      Icon(
                        Icons.currency_exchange,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Show USD conversion",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Display equivalent USD amount for all prices",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: showConversion,
                        onChanged: (value) {
                          showConversion = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Popular Currencies
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Popular Currencies",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: popularCurrencies.map((currCode) {
                      Map<String, dynamic> currency = currencies.firstWhere((curr) => curr["code"] == currCode);
                      bool isSelected = selectedCurrency == currCode;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedCurrency = currCode;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(30) : Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.withAlpha(60),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${currency["flag"]}",
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${currency["code"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${currency["symbol"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : disabledBoldColor,
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
            ),

            // All Currencies
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "All Currencies",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...currencies.map((currency) {
                    bool isSelected = selectedCurrency == currency["code"];
                    return GestureDetector(
                      onTap: () {
                        selectedCurrency = currency["code"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(30) : Colors.grey.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(60),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "${currency["flag"]}",
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${currency["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? primaryColor : Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "(${currency["code"]})",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${(currency["countries"] as List).join(", ")}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "${currency["symbol"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "1 USD = ${currency["rate"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Exchange Rate Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
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
                        "Exchange Rate Information",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Exchange rates are updated every 24 hours",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "• Rates may vary slightly from final charges on your payment method",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "• Currency conversion is provided for reference only",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: QButton(
          label: "Save Currency Settings",
          onPressed: () {
            ss("Currency changed to ${currentCurrency["name"]}");
            back();
          },
        ),
      ),
    );
  }

  String _convertPrice(double basePrice, double rate) {
    double convertedPrice = basePrice * rate;
    return convertedPrice.toStringAsFixed(2);
  }
}
