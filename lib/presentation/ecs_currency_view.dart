import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsCurrencyView extends StatefulWidget {
  const EcsCurrencyView({super.key});

  @override
  State<EcsCurrencyView> createState() => _EcsCurrencyViewState();
}

class _EcsCurrencyViewState extends State<EcsCurrencyView> {
  String selectedCurrency = "USD";
  bool loading = false;
  String searchQuery = "";

  List<Map<String, dynamic>> currencies = [
    {
      "code": "USD",
      "name": "US Dollar",
      "symbol": "\$",
      "country": "United States",
      "flag": "🇺🇸",
      "rate": 1.0,
    },
    {
      "code": "EUR",
      "name": "Euro",
      "symbol": "€",
      "country": "European Union",
      "flag": "🇪🇺",
      "rate": 0.85,
    },
    {
      "code": "GBP",
      "name": "British Pound",
      "symbol": "£",
      "country": "United Kingdom",
      "flag": "🇬🇧",
      "rate": 0.73,
    },
    {
      "code": "JPY",
      "name": "Japanese Yen",
      "symbol": "¥",
      "country": "Japan",
      "flag": "🇯🇵",
      "rate": 110.0,
    },
    {
      "code": "CAD",
      "name": "Canadian Dollar",
      "symbol": "C\$",
      "country": "Canada",
      "flag": "🇨🇦",
      "rate": 1.25,
    },
    {
      "code": "AUD",
      "name": "Australian Dollar",
      "symbol": "A\$",
      "country": "Australia",
      "flag": "🇦🇺",
      "rate": 1.35,
    },
    {
      "code": "CHF",
      "name": "Swiss Franc",
      "symbol": "CHF",
      "country": "Switzerland",
      "flag": "🇨🇭",
      "rate": 0.92,
    },
    {
      "code": "CNY",
      "name": "Chinese Yuan",
      "symbol": "¥",
      "country": "China",
      "flag": "🇨🇳",
      "rate": 6.45,
    },
    {
      "code": "INR",
      "name": "Indian Rupee",
      "symbol": "₹",
      "country": "India",
      "flag": "🇮🇳",
      "rate": 74.5,
    },
    {
      "code": "KRW",
      "name": "South Korean Won",
      "symbol": "₩",
      "country": "South Korea",
      "flag": "🇰🇷",
      "rate": 1180.0,
    },
    {
      "code": "BRL",
      "name": "Brazilian Real",
      "symbol": "R\$",
      "country": "Brazil",
      "flag": "🇧🇷",
      "rate": 5.2,
    },
    {
      "code": "MXN",
      "name": "Mexican Peso",
      "symbol": "MX\$",
      "country": "Mexico",
      "flag": "🇲🇽",
      "rate": 20.0,
    },
    {
      "code": "SGD",
      "name": "Singapore Dollar",
      "symbol": "S\$",
      "country": "Singapore",
      "flag": "🇸🇬",
      "rate": 1.35,
    },
    {
      "code": "HKD",
      "name": "Hong Kong Dollar",
      "symbol": "HK\$",
      "country": "Hong Kong",
      "flag": "🇭🇰",
      "rate": 7.8,
    },
    {
      "code": "NZD",
      "name": "New Zealand Dollar",
      "symbol": "NZ\$",
      "country": "New Zealand",
      "flag": "🇳🇿",
      "rate": 1.42,
    },
  ];

  List<Map<String, dynamic>> get filteredCurrencies {
    if (searchQuery.isEmpty) return currencies;
    return currencies.where((currency) {
      return currency["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             currency["code"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             currency["country"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void _changeCurrency(String currencyCode) async {
    if (selectedCurrency == currencyCode) return;

    loading = true;
    selectedCurrency = currencyCode;
    setState(() {});

    // Simulate currency change process
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    var currency = currencies.firstWhere((curr) => curr["code"] == currencyCode);
    ss("Currency changed to ${currency["name"]}");
  }

  String _formatPrice(double price, String currencyCode) {
    var currency = currencies.firstWhere((curr) => curr["code"] == currencyCode);
    double convertedPrice = price * (currency["rate"] as double);
    String symbol = currency["symbol"] as String;
    
    if (currencyCode == "JPY" || currencyCode == "KRW") {
      return "$symbol${convertedPrice.toStringAsFixed(0)}";
    }
    return "$symbol${convertedPrice.toStringAsFixed(2)}";
  }

  Widget _buildCurrencyItem(Map<String, dynamic> currency) {
    bool isSelected = selectedCurrency == currency["code"];

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: GestureDetector(
        onTap: () => _changeCurrency(currency["code"] as String),
        child: Container(
          padding: EdgeInsets.all(spSm),
          child: Row(
            children: [
              // Flag
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Center(
                  child: Text(
                    "${currency["flag"]}",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),

              SizedBox(width: spSm),

              // Currency Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${currency["code"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${currency["symbol"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${currency["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${currency["country"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Exchange Rate & Sample Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "1 USD = ${(currency["rate"] as double).toStringAsFixed(2)} ${currency["code"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _formatPrice(99.99, currency["code"] as String),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),

              SizedBox(width: spSm),

              // Selection Indicator
              if (isSelected)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              else
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Currency"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Changing currency...",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Currency"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Currency Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Current currency: ${currencies.firstWhere((curr) => curr["code"] == selectedCurrency)["name"]} (${currencies.firstWhere((curr) => curr["code"] == selectedCurrency)["symbol"]})",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Search
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search currencies",
                    value: searchQuery,
                    hint: "Search by name, code, or country",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.clear,
                  size: bs.sm,
                  onPressed: () {
                    searchQuery = "";
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Header
            Text(
              "Choose Your Currency",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            Text(
              "All prices will be displayed in your selected currency",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),

            SizedBox(height: spMd),

            // Currencies List
            if (filteredCurrencies.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Results Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try searching with different keywords",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredCurrencies.map((currency) => _buildCurrencyItem(currency)).toList(),
              ),

            SizedBox(height: spMd),

            // Exchange Rate Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Exchange Rate Information",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Exchange rates are updated daily\n• Rates shown are approximate and may vary\n• Final prices may include additional fees\n• Some payment methods may have currency restrictions",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
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
}
