import 'dart:ui' as ui;
import 'package:corona/country.dart';
import 'package:corona/infos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corona/service.dart';
import 'package:flutter/painting.dart';

enum Language { ENGLISH, TURKISH }

Language language = Language.ENGLISH;

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  TextStyle titleStyle = TextStyle(color: Colors.black, fontSize: 20.0);

  @override
  void initState() {
    // TODO: implement initState

    if (ui.window.locale.languageCode == 'tr') {
      language = Language.TURKISH;
    } else {
      language = Language.ENGLISH;
    }
  }

  @override
  Widget build(BuildContext context) {
    Helper _service = Helper();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: ClipRRect(
                      child: Image.asset(
                        'images/deee.png',
                      ),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 7.0,
                            spreadRadius: 1.0,
                          )
                        ])),
              ),
              Padding(
                padding: const EdgeInsets.all(11),
                child: FutureBuilder<List<Country>>(
                  future: _service.getAllCountry(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Country>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(


                            child: SizedBox(
                              height: 265.0,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: false,
                                  itemCount: 1,
                                  itemBuilder: (BuildContext context, index) {

                                    var _cases = snapshot.data.last.cases;
                                    var _deaths = snapshot.data.last.deaths;
                                    var _recovered =
                                        snapshot.data.last.recovered;
                                    return Column(
                                      children: <Widget>[
                                        Text(language==Language.ENGLISH?
                                            "Coronavirus Cases":"Corona Vakaları",
                                            style: TextStyle(fontSize: 35.0,color: Colors.black),
                                            textAlign: TextAlign.left),
                                        Text(_cases,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 40.0,color: Colors.blueGrey)),
                                        Text(language==Language.ENGLISH?
                                            "Deaths":"Ölümler",
                                            style: TextStyle(fontSize: 35.0,color: Colors.black),
                                            textAlign: TextAlign.left),
                                        Text(_deaths == " " ? "0" : _deaths,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 40.0,color: Colors.red)),
                                        Text(
                                            language==Language.ENGLISH?"Recovered":"Kurtarılanlar",
                                            style: TextStyle(fontSize: 35.0,color: Colors.black),
                                            textAlign: TextAlign.left),
                                        Text(
                                            _recovered == " "
                                                ? "0"
                                                : _recovered,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 40.0,color: Colors.green)),

                                      ],
                                    );
                                  }),
                            ),
                          ),
                        );

                      case ConnectionState.none:
                        return (Text("error"));
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                        return Container();
                      default:
                        return Container();
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildMaterialButton(context, 'Nasıl Önlemler Almalıyız',
                    'How to Protect Yourself'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                            spreadRadius: 2.0,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        language == Language.ENGLISH
                            ? 'Confirmed Cases and Deaths by Country, Territory, or Conveyance'
                            : "Ülkeye, Bölgeye veya Taşınmaya Göre Onaylanmış Vakalar ve Ölümler",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, bottom: 3.0, right: 8.0, top: 3.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                            language == Language.ENGLISH ? 'Country' : 'Ülke',
                            textAlign: TextAlign.left,
                            style: titleStyle),
                      ),
                      Expanded(
                          child: Text(
                              language == Language.ENGLISH ? 'Cases' : 'Hasta',
                              textAlign: TextAlign.center,
                              style: titleStyle)),
                      Expanded(
                          child: Text(
                              language == Language.ENGLISH ? 'Deaths' : 'Ölüm',
                              textAlign: TextAlign.center,
                              style: titleStyle)),
                      Expanded(
                          child: Text(
                              language == Language.ENGLISH
                                  ? 'Recovered'
                                  : 'Kurtarılan',
                              textAlign: TextAlign.center,
                              style: titleStyle))
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<Country>>(
                future: _service.getAllCountry(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Country>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFFe53935),
                                    Colors.red,
                                    Color(0xFFe53935)
                                  ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 7.0,
                                  spreadRadius: 1.0,
                                )
                              ]),
                          child: SizedBox(
                            height: 400.0,
                            child: ListView.builder(
                                shrinkWrap: false,
                                itemCount: snapshot.data.length - 1,
                                itemBuilder: (BuildContext context, index) {
                                  var _countryName =
                                      snapshot.data[index].countryName;
                                  var _cases = snapshot.data[index].cases;
                                  var _deaths = snapshot.data[index].deaths;
                                  var _recovered =
                                      snapshot.data[index].recovered;
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: Text(
                                                    _countryName == ' '
                                                        ? "unknow"
                                                        : _countryName,
                                                    style: TextStyle(
                                                        fontSize: 20.0),
                                                    textAlign: TextAlign.left)),
                                            Expanded(
                                                child: Text(_cases,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20.0))),
                                            Expanded(
                                                child: Text(
                                                    _deaths == " "
                                                        ? "0"
                                                        : _deaths,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20.0))),
                                            Expanded(
                                                child: Text(
                                                    _recovered == " "
                                                        ? "0"
                                                        : _recovered,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20.0))),
                                          ],
                                        ),
                                      ),
                                      Divider(color: Colors.black),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      );

                    case ConnectionState.none:
                      return (Text("error"));
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.active:
                      return Container();
                    default:
                      return Container();
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                            spreadRadius: 2.0,
                          )
                        ]),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            language == Language.ENGLISH
                                ? 'Corona Symptoms'
                                : "Corona Virüs Belirtileri",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            language == Language.ENGLISH ? symptoms1 : belirti1,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            language == Language.ENGLISH ? symptoms2 : belirti2,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Image.asset(language == Language.ENGLISH
                              ? 'images/symptoms.png'
                              : 'images/belirtiler.jpg'),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton buildMaterialButton(
      BuildContext context, String text, String englishText) {
    return MaterialButton(
      padding: EdgeInsets.only(bottom: 9, left: 30, right: 15, top: 9),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        showModal(context);
      },
      color: Color(0xFFe53935),
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Center(
          child: Text(
            language == Language.ENGLISH ? englishText : text,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(11.0),
            child: Container(
              height: 500,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      language == Language.ENGLISH
                          ? "Know How it Spreads"
                          : "Nasıl Yayıldığını Bilin",
                      style: bottomWindowTitleStyle,
                    ),
                    leading: Image.asset('images/sneezingwoman.png'),
                    subtitle: Text(
                      language == Language.ENGLISH ? info1 : bilgi1,
                      style: bottomWindowSubTitleStyle,
                    ),
                  ),
                  ListTile(
                    leading: Image.asset('images/protect-wash-hands.png'),
                    title: Text(
                      language == Language.ENGLISH
                          ? "Clean your hands often"
                          : "Ellerinizi sık sık temizleyin",
                      style: bottomWindowTitleStyle,
                    ),
                    subtitle: Text(
                      language == Language.ENGLISH ? info2 : bilgi2,
                      style: bottomWindowSubTitleStyle,
                    ),
                  ),
                  ListTile(
                    leading: Image.asset('images/protect-quarantine.png'),
                    title: Text(
                      language == Language.ENGLISH
                          ? "Avoid close contact"
                          : "Yakın temastan kaçının",
                      style: bottomWindowTitleStyle,
                    ),
                    subtitle: Text(
                      language == Language.ENGLISH ? info3 : bilgi3,
                      style: bottomWindowSubTitleStyle,
                    ),
                  ),
                  ListTile(
                    leading: Image.asset('images/bed.png'),
                    title: Text(
                      language == Language.ENGLISH
                          ? "Stay home if you’re sick"
                          : "Hastaysan evde kal",
                      style: bottomWindowTitleStyle,
                    ),
                    subtitle: Text(
                      language == Language.ENGLISH ? info4 : bilgi4,
                      style: bottomWindowSubTitleStyle,
                    ),
                  ),
                  ListTile(
                    leading: Image.asset('images/coverCough.png'),
                    title: Text(
                      language == Language.ENGLISH
                          ? "Cover coughs and sneezes"
                          : "Öksürük ve hapşırma",
                      style: bottomWindowTitleStyle,
                    ),
                    subtitle: Text(
                      language == Language.ENGLISH ? info5 : bilgi5,
                      style: bottomWindowSubTitleStyle,
                    ),
                  ),
                  ListTile(
                    leading: Image.asset('images/mask.png'),
                    title: Text(
                      language == Language.ENGLISH
                          ? "Wear a facemask if you are sick"
                          : "Eğer hastaysan bir yüz maskesi tak",
                      style: bottomWindowTitleStyle,
                    ),
                    subtitle: Text(
                      language == Language.ENGLISH ? info6 : bilgi6,
                      style: bottomWindowSubTitleStyle,
                    ),
                  ),
                  ListTile(
                    leading: Image.asset('images/clean.png'),
                    title: Text(
                      language == Language.ENGLISH
                          ? "Clean and disinfect"
                          : "Temizleyin ve dezenfekte edin",
                      style: bottomWindowTitleStyle,
                    ),
                    subtitle: Text(
                      language == Language.ENGLISH ? info7 : bilgi7,
                      style: bottomWindowSubTitleStyle,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
