
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'globals.dart';


void main() {
  runApp( DynamicCardApp());
}

class DynamicCardApp extends StatefulWidget {
  @override
  _DynamicCardAppState createState() => _DynamicCardAppState();
}
class _DynamicCardAppState extends State<DynamicCardApp> {

  void _changeLocale(Locale newLocale) {
    setState(() {
      currentLocale = newLocale;
      if (currentLocale ==  Locale('ar')) {
        widgetDirection = TextDirection.rtl;
      } else {
        widgetDirection = TextDirection.ltr;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: currentLocale,

      home:DynamicCardPageSet(
        changeLocale: _changeLocale, // Pass the function to change the locale
        // currentLocale: currentLocale, // Pass the current locale
      ),
    );

  }
}

class DynamicCardPageSet extends StatefulWidget {
  final void Function(Locale) changeLocale;
  // final Locale currentLocale;

  DynamicCardPageSet({required this.changeLocale});

  @override
  DynamicCardPageState createState() => DynamicCardPageState();
}

class DynamicCardPageState extends State<DynamicCardPageSet> {
  final List<String> cardTitles = ['123', '456', '789', '000'];
  final List<String> cardSubtitles =['24,000', '35,000', '45,000', '55,000'];
  final List<String> cardDate =['11/11/2012', '11/11/2012', '11/11/2012', '23/08/2023'];
  final List<List<String>> cardIcons =[['0','1'], ['0'],[], ['0','1']];
  final List<String> cardStatus = ['2', 'accepted', 'pending', '2'];
  String selectedLanguage = 'English';
  TextDirection _widgetDirection = widgetDirection; // Default direction



  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: _widgetDirection, // Default text direction
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                alignment: Alignment.topCenter,
                // log((AppLocalizations.of(context)!.financeRequests).toString()),
                child: Text(
                  AppLocalizations.of(context)!.financeRequests,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cardTitles.length,
                  itemBuilder: (context, index) {
                    return CardWidget(title: cardTitles[index], subtitle: cardSubtitles[index], date:cardDate[index], icons:cardIcons[index], status:cardStatus[index]);
                  },
                ),
              ),


              Container(
                padding: const EdgeInsets.all(4.0),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 104,
                      height: 40,
                      decoration: BoxDecoration(

                        border: Border.all(color: const Color(0XFF000000)),
                        borderRadius: BorderRadius.circular(6.0),

                      ),
                      child: DropdownButton<Locale>(
                        padding: EdgeInsets.only(left: 2.0,right :2.0),

                        value: currentLocale,
                        focusColor: Colors.white,
                        elevation: 8,
                        iconSize: 60,
                        items: [
                          DropdownMenuItem(
                            value: Locale('en'),
                            child: Text(AppLocalizations.of(context)!.english),
                          ),
                          DropdownMenuItem(
                            value:  Locale('ar'),
                            child: Text(AppLocalizations.of(context)!.arabic),
                          ),
                        ],
                        onChanged: (newLocale) {
                          widget.changeLocale(newLocale!);

                        },
                        icon: Container(

                          decoration: BoxDecoration(

                            color: Colors.grey[200],
                            border: const Border(
                              left: BorderSide(color: Color(0XFFEEEEEE)), // Change the color as needed
                              top: BorderSide(color: Color(0XFFEEEEEE)),
                              right: BorderSide(color: Color(0XFFEEEEEE)),
                              bottom: BorderSide(color: Color(0XFFEEEEEE)),
                            ),
                          ),
                          child: Icon(

                            Icons.arrow_drop_down,
                            size: 30,
                            color: Colors.black, // Change the arrow color as needed
                          ),
                        ),
                        isDense: true,
                        isExpanded: false,
                        underline: Container(), // Remove the underline
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

    );

  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final List<String> icons;
  final String status;

  const CardWidget({Key? key, required this.title,  required this.subtitle, required this.date, required this.icons, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String finalStatus;
    if (status == 'accepted')
      finalStatus= (AppLocalizations.of(context)!.accepted);
    else if (status == 'pending')
      finalStatus= ((AppLocalizations.of(context)!.pending));
    else
      finalStatus= (status + " " +AppLocalizations.of(context)!.offers);

    return Card(
      color: Colors.grey[300],
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text((AppLocalizations.of(context)!.financeRequest) + "- " + title),
            subtitle: Text((AppLocalizations.of(context)!.sar) + " " + subtitle),
            trailing: Text((AppLocalizations.of(context)!.created) + " " + date,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Card(
            surfaceTintColor: Colors.grey[400],

            margin: EdgeInsets.all(16.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,

                children: <Widget>[
                  ListTile(
                    trailing: Text(finalStatus,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for (String icon in icons)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Image.asset(
                              '$icon.png',
                              width: 30.0,
                              height: 30.0,
                            ),
                          ),
                      ],

                    ),

                  ),
                ]

            ),
          ),
        ],
      ),
    );
  }
}



