import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:techi/Model/Currency.dart';
import 'Model/Currency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // یه تابع بازگشتی از نوع ویجت است که قراره ویجت برامون بیلد کنه
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 243, 243, 243),
          fontFamily: "dana",
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontFamily: 'dana',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black),
            bodyText1: TextStyle(
                fontFamily: 'dana',
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 30, 30, 30)),
            headline2: TextStyle(
                fontFamily: 'dana',
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.white),
            headline3: TextStyle(
                fontFamily: 'dana',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.red),
            headline4: TextStyle(
                fontFamily: 'dana',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.green),
          )),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''), //farsi
      ],
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  home({
    Key? key,
  }) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<Currency> currency = [];

  Future getresponse(BuildContext context)async {
    var url = "http://sasansafari.com/flutter/api.php?access_key=flutter123456";
    var value = await http.get(Uri.parse(url));
    print(value.statusCode);
    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        _showSnackBar(context, "بروز رسانی اطلاعات با موفقیت انجام شد");
        List jsonList = convert.jsonDecode(value.body);
        if (jsonList.length > 0) {
          for (int i = 0; i <= jsonList.length; i++) {
            setState(() {
              currency.add(Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"]));
            });
          }
        }
      }
      
    }
  return value;
  }

  @override
  void initState() {
    super.initState();
    developer.log("initState", name: "wLifeCycle");
    getresponse(context);
    developer.log("getresponse", name: "wLifeCycle");
  }

  @override
  void didUpdateWidget(covariant home oldWidget) {
    super.didUpdateWidget(oldWidget);
    developer.log("didUpdateWidget", name: "wLifeCycle");
  }

  @override
  void deactivate() {
    super.deactivate();
    developer.log("deactivate", name: "wLifeCycle");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    developer.log("didChangeDependencies", name: "wLifeCycle");
  }

  @override
  void dispose() {
    super.dispose();
    developer.log("dispose", name: "wLifeCycle");
  }
// فقط خط 275
  @override
  Widget build(BuildContext context) {
    developer.log("build", name: "wLifeCycle");
    return Scaffold(
        appBar: AppBar(elevation: 0, backgroundColor: Colors.white, actions: [
          const SizedBox(
            width: 15,
          ),
          Image.asset("assets/images/icon.png"),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                "قیمت به روز ارز",
                style: Theme.of(context).textTheme.headline1,
              )),
          Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(.0),
                    child: Image.asset("assets/images/menu.png"),
                  ))),
          const SizedBox(
            width: 25,
          )
        ]),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/question.png"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("نرخ ارز آزاد چیست؟",
                          style: Theme.of(context).textTheme.headline1)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      " نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.",
                      style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 32,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                        color: Color.fromARGB(255, 130, 130, 130)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("نام آزاد ارز",
                            style: Theme.of(context).textTheme.headline2),
                        Text("قیمت",
                            style: Theme.of(context).textTheme.headline2),
                        Text("تغییر",
                            style: Theme.of(context).textTheme.headline2),
                      ],
                    ),
                  ),
                  // list
                  SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/2,
                      // height:4
                      child:listFutureBuilder(context)
                      // ListView.separated(
                      //               physics: BouncingScrollPhysics(),
                      //               itemCount: currency.length,
                      //               itemBuilder:
                      //                   (BuildContext context, int position) {
                      //                 return Padding(
                      //                   padding:
                      //                       const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      //                   child: MyItem(position, currency),
                      //                 );
                      //               },
                      //               separatorBuilder: (BuildContext context, int index) {
                      //                 if (index % 4 == 3) {
                      //                   return add();
                      //                 } else {
                      //                   return SizedBox.shrink();
                      //                 }
                      //               },
                      //             ) 

                      
                            
                      ),
                  const SizedBox(
                    height: 30,
                  ),
                  // text bottton and low part
                  Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/16,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(1000)),
                          color: Color.fromARGB(255, 232, 232, 232)),
                      child: Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height/16,
                            child: TextButton.icon(
                              onPressed: () 
                              {
                                currency.clear();
                                listFutureBuilder(context);
                      //    FutureBuilder(
                      //     future: getresponse(context),
                      //     builder: (context, snapshot) {
                      //     return snapshot.hasData?ListView.separated(
                      //               physics: BouncingScrollPhysics(),
                      //               itemCount: currency.length,
                      //               itemBuilder:
                      //                   (BuildContext context, int position) {
                      //                 return Padding(
                      //                   padding:
                      //                       const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      //                   child: MyItem(position, currency),
                      //                 );
                      //               },
                      //               separatorBuilder: (BuildContext context, int index) {
                      //                 if (index % 4 == 3) {
                      //                   return add();
                      //                 } else {
                      //                   return SizedBox.shrink();
                      //                 }
                      //               },
                      //             ) 
                      //      : Center(child: Text("fuck you"),);
                      //   }
  
                      // );
                              }
                              //  => _showSnackBar(
                              //     context, "به روز رسانی با موفقیت انجام شد")
                              ,
                              icon: const Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Icon(
                                  CupertinoIcons.refresh,
                                  color: Colors.black,
                                ),
                              ),
                              label: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Text("بروز رسانی",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 202, 193, 255)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1000))))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                            child: Text("آخرین بروز رسانی   ${_gettime()} "),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
                        future: getresponse(context),
                        builder: (context, snapshot) {
                        return snapshot.hasData?ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: currency.length,
                                  itemBuilder:
                                      (BuildContext context, int position) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: MyItem(position, currency),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    if (index % 4 == 3) {
                                      return add();
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ) 
                         : const Center(child: CircularProgressIndicator());
                      }

                    );
  }
}

String _gettime() {
  developer.log("get time", name: "wLifeCycle");
  DateTime dateTime=DateTime.now();
  return DateFormat('kk:mm:ss').format(dateTime);
}

class MyItem extends StatelessWidget {
  
  int position;
  List<Currency> currency;

  MyItem(this.position, this.currency);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[BoxShadow(blurRadius: 1, color: Colors.grey)],
          borderRadius: BorderRadius.all(Radius.circular(1000))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            currency[position].title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            currency[position].price,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            currency[position].changes,
            style: currency[position].status == "n"
                ? Theme.of(context).textTheme.headline3
                : Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
// مهم نیست
class add extends StatelessWidget {
  const add({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: const BoxDecoration(
            color: Colors.red,
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 1, color: Colors.grey)
            ],
            borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "تبلیغ",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: Theme.of(context).textTheme.bodyText1),
      backgroundColor: Colors.green));
}

String farsiNumber(String number){
 const en=['0','1','2','3','4','5','6','7','8','9'];
  const fa=['','','','','','','','','','','','',];
  return number;
}