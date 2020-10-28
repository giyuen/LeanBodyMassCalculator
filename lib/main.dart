import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _acontroller = TextEditingController();
  final TextEditingController _bcontroller = TextEditingController();
  final TextEditingController _ccontroller = TextEditingController();
  final TextEditingController _dcontroller = TextEditingController();
  String gender,
      age,
      leanbodymassPeters = "-  ",
      leanbodymassBoer = "-  ",
      leanbodymassJames = "-  ",
      leanbodymassHume = "-  ",
      bodyfatPeters = "-  ",
      bodyfatBoer = "-  ",
      bodyfatJames = "-  ",
      bodyfatHume = "-  ";

  double height = 0.0,
      weight = 0.0,
      petersLBMformula = 0.0,
      boerLBMformula = 0.0,
      jamesLBMformula = 0.0,
      humeLBMformula = 0.0,
      petersBFformula = 0.0,
      boerBFformula = 0.0,
      jamesBFformula = 0.0,
      humeBFformula = 0.0,
      notnullheight = null,
      notnullweight = null;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lean Body Mass Calculator',
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/wallpaper7.jpg"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.greenAccent,
              title: Text(
                'Lean Body Mass Calculator',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            body: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Gender',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return ("Gender is required !");
                          } else if (value != "male" && value != "female") {
                            return "Please enter male or female only.";
                          } else {
                            null;
                          }
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Male/Female",
                          errorStyle: TextStyle(fontSize: 18.0),
                        ),
                        controller: _acontroller,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Age 14 or younger?',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Age 14 or younger is required !";
                          } else if (value != "yes" && value != "no") {
                            return "Please enter yes or no only.";
                          } else {
                            null;
                          }
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Yes/No",
                          errorStyle: TextStyle(fontSize: 18.0),
                        ),
                        controller: _bcontroller,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1),
                      child: Text(
                        'Height',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: TextFormField(
                        validator: (value) {
                          if (value != null) {
                            notnullheight = double.tryParse(value);

                            if (notnullheight == null) {
                              return "Height is required.";
                            } else if (notnullheight <= 0) {
                              return "Please enter positive numbers only.";
                            } else {
                              null;
                            }
                          }
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "(cm)",
                          errorStyle: TextStyle(fontSize: 18.0),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: _ccontroller,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1),
                      child: Text(
                        '\nWeight',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: TextFormField(
                        validator: (value) {
                          if (value != null) {
                            notnullweight = double.tryParse(value);

                            if (notnullweight == null) {
                              return "Weight is required.";
                            } else if (notnullweight <= 0) {
                              return "Please enter positive numbers only.";
                            } else {
                              null;
                            }
                          }
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "(kg)",
                          errorStyle: TextStyle(fontSize: 18.0),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: _dcontroller,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: RaisedButton(
                            child: Text(
                              "Calculate",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: _onPressedCalculate,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: RaisedButton(
                            child: Text(
                              "Clear",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: _onPressedClear,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text('Result', style: TextStyle(fontSize: 30)),
                      alignment: Alignment.center,
                      color: Colors.greenAccent,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Text(
                        'The lean body mass based on different formulas:',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Formula')),
                        DataColumn(label: Text('Lean Body Mass')),
                        DataColumn(label: Text('Body Fat')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('Peters\n(For Children)')),
                          DataCell(Text("$leanbodymassPeters" + " kg")),
                          DataCell(Text("$bodyfatPeters" + " %")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Boer')),
                          DataCell(Text("$leanbodymassBoer" + " kg")),
                          DataCell(Text("$bodyfatBoer" + " %")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('James')),
                          DataCell(Text("$leanbodymassJames" + " kg")),
                          DataCell(Text("$bodyfatJames" + " %")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Hume')),
                          DataCell(Text("$leanbodymassHume" + " kg")),
                          DataCell(Text("$bodyfatHume" + " %")),
                        ]),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _onPressedCalculate() {
    setState(() {
      if (_key.currentState.validate()) {
        print("Input is valid.");
      }
       else  {
        leanbodymassPeters = "-  ";
        leanbodymassBoer = "-  ";
        leanbodymassJames = "-  ";
        leanbodymassHume = "-  ";
        bodyfatPeters = "-  ";
        bodyfatBoer = "-  ";
        bodyfatJames = "-  ";
        bodyfatHume = "-  ";
      }
      gender = _acontroller.text;
      age = _bcontroller.text;
      height = double.parse(_ccontroller.text);
      weight = double.parse(_dcontroller.text);

      String genderLCinput = gender.toLowerCase();
      String ageLCinput = age.toLowerCase();

      if (height <= 0 || weight <= 0) {
        leanbodymassPeters = "-  ";
        leanbodymassBoer = "-  ";
        leanbodymassJames = "-  ";
        leanbodymassHume = "-  ";
        bodyfatPeters = "-  ";
        bodyfatBoer = "-  ";
        bodyfatJames = "-  ";
        bodyfatHume = "-  ";
        
      } 

      else if (genderLCinput == "male" && ageLCinput == "no") {
        leanbodymassPeters = ("-  ");
        bodyfatPeters = ("-  ");
        boerLBMformula = ((0.407 * weight) + (0.267 * height) - 19.2);
        jamesLBMformula =
            ((1.1 * weight) - (128 * ((weight / height) * (weight / height))));
        humeLBMformula = ((0.32810 * weight) + (0.33929 * height) - 29.5336);

        leanbodymassBoer = format(boerLBMformula);
        leanbodymassJames = format(jamesLBMformula);
        leanbodymassHume = format(humeLBMformula);

        boerBFformula = (((weight - boerLBMformula) / weight) * 100);
        jamesBFformula = (((weight - jamesLBMformula) / weight) * 100);
        humeBFformula = (((weight - humeLBMformula) / weight) * 100);

        bodyfatBoer = format1(boerBFformula);
        bodyfatJames = format1(jamesBFformula);
        bodyfatHume = format1(humeBFformula);
      } else if (genderLCinput == "female" && ageLCinput == "no") {
        leanbodymassPeters = ("-");
        bodyfatPeters = ("-");
        boerLBMformula = ((0.252 * weight) + (0.473 * height) - 48.3);
        jamesLBMformula =
            ((1.07 * weight) - (148 * ((weight / height) * (weight / height))));
        humeLBMformula = ((0.29569 * weight) + (0.41813 * height) - 43.2933);

        leanbodymassBoer = format(boerLBMformula);
        leanbodymassJames = format(jamesLBMformula);
        leanbodymassHume = format(humeLBMformula);

        boerBFformula = (((weight - boerLBMformula) / weight) * 100);
        jamesBFformula = (((weight - jamesLBMformula) / weight) * 100);
        humeBFformula = (((weight - humeLBMformula) / weight) * 100);

        bodyfatBoer = format1(boerBFformula);
        bodyfatJames = format1(jamesBFformula);
        bodyfatHume = format1(humeBFformula);
      } else if (genderLCinput == "male" && ageLCinput == "yes") {
        petersLBMformula =
            (3.8 * (0.0215 * (pow(weight, 0.6469)) * (pow(height, 0.7236))));
        boerLBMformula = ((0.407 * weight) + (0.267 * height) - 19.2);
        jamesLBMformula =
            ((1.1 * weight) - (128 * ((weight / height) * (weight / height))));
        humeLBMformula = ((0.32810 * weight) + (0.33929 * height) - 29.5336);

        leanbodymassPeters = format(petersLBMformula);
        leanbodymassBoer = format(boerLBMformula);
        leanbodymassJames = format(jamesLBMformula);
        leanbodymassHume = format(humeLBMformula);

        petersBFformula = (((weight - petersLBMformula) / weight) * 100);
        boerBFformula = (((weight - boerLBMformula) / weight) * 100);
        jamesBFformula = (((weight - jamesLBMformula) / weight) * 100);
        humeBFformula = (((weight - humeLBMformula) / weight) * 100);

        bodyfatPeters = format1(petersBFformula);
        bodyfatBoer = format1(boerBFformula);
        bodyfatJames = format1(jamesBFformula);
        bodyfatHume = format1(humeBFformula);
      } else if (genderLCinput == "female" && ageLCinput == "yes") {
        petersLBMformula =
            (3.8 * (0.0215 * (pow(weight, 0.6469)) * (pow(height, 0.7236))));
        boerLBMformula = ((0.252 * weight) + (0.473 * height) - 48.3);
        jamesLBMformula =
            ((1.07 * weight) - (148 * ((weight / height) * (weight / height))));
        humeLBMformula = ((0.29569 * weight) + (0.41813 * height) - 43.2933);

        leanbodymassPeters = format(petersLBMformula);
        leanbodymassBoer = format(boerLBMformula);
        leanbodymassJames = format(jamesLBMformula);
        leanbodymassHume = format(humeLBMformula);

        petersBFformula = (((weight - petersLBMformula) / weight) * 100);
        boerBFformula = (((weight - boerLBMformula) / weight) * 100);
        jamesBFformula = (((weight - jamesLBMformula) / weight) * 100);
        humeBFformula = (((weight - humeLBMformula) / weight) * 100);

        bodyfatPeters = format1(petersBFformula);
        bodyfatBoer = format1(boerBFformula);
        bodyfatJames = format1(jamesBFformula);
        bodyfatHume = format1(humeBFformula);
      }
    });
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  String format1(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 0);
  }

  void _onPressedClear() {
    setState(() {
      _acontroller.clear();
      _bcontroller.clear();
      _ccontroller.clear();
      _dcontroller.clear();
    });
  }
}