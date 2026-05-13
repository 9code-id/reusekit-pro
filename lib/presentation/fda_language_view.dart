import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaLanguageView extends StatefulWidget {
  const FdaLanguageView({super.key});

  @override
  State<FdaLanguageView> createState() => _FdaLanguageViewState();
}

class _FdaLanguageViewState extends State<FdaLanguageView> {
  String selectedLanguage = "English";
  String selectedRegion = "United States";

  List<Map<String, dynamic>> languages = [
    {
      "name": "English",
      "code": "en",
      "flag": "🇺🇸",
      "regions": ["United States", "United Kingdom", "Canada", "Australia"],
    },
    {
      "name": "Spanish",
      "code": "es",
      "flag": "🇪🇸",
      "regions": ["Spain", "Mexico", "Argentina", "Colombia"],
    },
    {
      "name": "French",
      "code": "fr",
      "flag": "🇫🇷",
      "regions": ["France", "Canada", "Belgium", "Switzerland"],
    },
    {
      "name": "German",
      "code": "de",
      "flag": "🇩🇪",
      "regions": ["Germany", "Austria", "Switzerland"],
    },
    {
      "name": "Italian",
      "code": "it",
      "flag": "🇮🇹",
      "regions": ["Italy", "Switzerland"],
    },
    {
      "name": "Portuguese",
      "code": "pt",
      "flag": "🇵🇹",
      "regions": ["Portugal", "Brazil"],
    },
    {
      "name": "Chinese",
      "code": "zh",
      "flag": "🇨🇳",
      "regions": ["China", "Taiwan", "Hong Kong", "Singapore"],
    },
    {
      "name": "Japanese",
      "code": "ja",
      "flag": "🇯🇵",
      "regions": ["Japan"],
    },
    {
      "name": "Korean",
      "code": "ko",
      "flag": "🇰🇷",
      "regions": ["South Korea"],
    },
    {
      "name": "Arabic",
      "code": "ar",
      "flag": "🇸🇦",
      "regions": ["Saudi Arabia", "UAE", "Egypt", "Lebanon"],
    },
    {
      "name": "Hindi",
      "code": "hi",
      "flag": "🇮🇳",
      "regions": ["India"],
    },
    {
      "name": "Russian",
      "code": "ru",
      "flag": "🇷🇺",
      "regions": ["Russia"],
    },
  ];

  bool autoDetectLanguage = false;
  bool translateMenus = true;
  bool translateReviews = false;

  @override
  Widget build(BuildContext context) {
    List<String> currentRegions = languages
        .firstWhere((lang) => lang["name"] == selectedLanguage)["regions"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Language & Region"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Current Language Info
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
                      Icons.language,
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
                          "Current Language",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$selectedLanguage ($selectedRegion)",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    languages.firstWhere((lang) => lang["name"] == selectedLanguage)["flag"],
                    style: TextStyle(fontSize: 32),
                  ),
                ],
              ),
            ),

            // Language Selection
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
                    "Select Language",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...languages.map((language) {
                    bool isSelected = selectedLanguage == language["name"];
                    return GestureDetector(
                      onTap: () {
                        selectedLanguage = language["name"];
                        selectedRegion = (language["regions"] as List)[0];
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
                              "${language["flag"]}",
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${language["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? primaryColor : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${(language["regions"] as List).length} regions available",
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
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Region Selection
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
                    "Select Region",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Region affects date format, time format, and currency display",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Region",
                    items: currentRegions.map((region) => {
                      "label": region,
                      "value": region,
                    }).toList(),
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Language Preferences
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
                    "Language Preferences",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Auto-detect language
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Auto-detect language",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Automatically detect language from your device",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: autoDetectLanguage,
                        onChanged: (value) {
                          autoDetectLanguage = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),

                  // Translate menus
                  Row(
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Translate restaurant menus",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Automatically translate menu items to your language",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: translateMenus,
                        onChanged: (value) {
                          translateMenus = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),

                  // Translate reviews
                  Row(
                    children: [
                      Icon(
                        Icons.rate_review,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Translate reviews",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Show translated reviews from other customers",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: translateReviews,
                        onChanged: (value) {
                          translateReviews = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sample Text Preview
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
                        Icons.preview,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Preview",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _getPreviewText(),
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    _getDateTimeFormat(),
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Download Languages
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
                    "Offline Languages",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Download languages for offline use when you don't have internet connection",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  QButton(
                    label: "Download $selectedLanguage",
                    icon: Icons.download,
                    size: bs.sm,
                    onPressed: () {
                      ss("$selectedLanguage language pack downloaded");
                    },
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
          label: "Apply Changes",
          onPressed: () {
            ss("Language changed to $selectedLanguage ($selectedRegion)");
            back();
          },
        ),
      ),
    );
  }

  String _getPreviewText() {
    switch (selectedLanguage) {
      case "Spanish":
        return "¡Tu pedido ha sido entregado! Gracias por elegir nuestra aplicación.";
      case "French":
        return "Votre commande a été livrée ! Merci d'avoir choisi notre application.";
      case "German":
        return "Ihre Bestellung wurde geliefert! Vielen Dank, dass Sie unsere App gewählt haben.";
      case "Italian":
        return "Il tuo ordine è stato consegnato! Grazie per aver scelto la nostra app.";
      case "Portuguese":
        return "Seu pedido foi entregue! Obrigado por escolher nosso aplicativo.";
      case "Chinese":
        return "您的订单已送达！感谢您选择我们的应用程序。";
      case "Japanese":
        return "ご注文が配達されました！当アプリをお選びいただきありがとうございます。";
      case "Korean":
        return "주문이 배달되었습니다! 저희 앱을 선택해 주셔서 감사합니다.";
      case "Arabic":
        return "تم تسليم طلبك! شكرًا لاختيارك تطبيقنا.";
      case "Hindi":
        return "आपका ऑर्डर डिलीवर हो गया है! हमारे ऐप को चुनने के लिए धन्यवाद।";
      case "Russian":
        return "Ваш заказ доставлен! Спасибо за выбор нашего приложения.";
      default:
        return "Your order has been delivered! Thank you for choosing our app.";
    }
  }

  String _getDateTimeFormat() {
    switch (selectedRegion) {
      case "United States":
        return "Date format: MM/DD/YYYY, Time: 12-hour format";
      case "United Kingdom":
      case "France":
      case "Germany":
      case "Italy":
        return "Date format: DD/MM/YYYY, Time: 24-hour format";
      case "Japan":
      case "China":
      case "Korea":
        return "Date format: YYYY/MM/DD, Time: 24-hour format";
      default:
        return "Date format: DD/MM/YYYY, Time: 24-hour format";
    }
  }
}
