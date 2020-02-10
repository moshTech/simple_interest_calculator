import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
//    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
    home: SimpleInterestForm(),
  ));
}

class SimpleInterestForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SimpleInterestFormState();
  }
}

class _SimpleInterestFormState extends State<SimpleInterestForm> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Naira', 'Dollars', 'Euro', 'Others'];
  final _minPadding = 5.0;
  var _currentItemSelected = '';

  @override
  initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalTextControlled = TextEditingController();
  TextEditingController rateTextControlled = TextEditingController();
  TextEditingController timeTextControlled = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.black12,
          child: Padding(
            padding: EdgeInsets.only(
                left: _minPadding * 2,
                right: _minPadding * 2,
                bottom: _minPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(bottom: _minPadding),
                  child: TextFormField(
                    controller: principalTextControlled,
                    validator: (String value) {
                      if (value.isEmpty) return 'Please enter principal amount';
                      return 'Please enter principal amount';
                    },
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        labelStyle: textStyle,
                        hintText: 'Enter principal e.g 1000000',
                        errorStyle: TextStyle(
                          fontSize: 15.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                  child: TextFormField(
                    controller: rateTextControlled,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter the interest rate';
                      }
                      return 'Please enter the interest rate';
                    },
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 15.0,
                        ),
                        labelText: 'Rate of Interest',
                        labelStyle: textStyle,
                        hintText: 'In percent',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: timeTextControlled,
                          validator: (String value) {
                            if (value.isEmpty) return 'Please enter the time';
                            return 'Please enter the time';
                          },
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Time',
                              errorStyle: TextStyle(
                                fontSize: 15.0,
                              ),
                              labelStyle: textStyle,
                              hintText: 'In years',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: _minPadding * 5,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String currency) {
                            return DropdownMenuItem<String>(
                              value: currency,
                              child: Text(
                                currency,
                                style: textStyle,
                              ),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String newCurrencySelected) {
                            setState(() {
                              this._currentItemSelected = newCurrencySelected;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _minPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                        color: Colors.blue,
                        elevation: 10.0,
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate())
                              this.displayResult = _calculateSimpleInterest();
//                            debugPrint(this.displayResult);
                          });
                        },
                      )),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: RaisedButton(
                        color: Colors.lightGreenAccent,
                        elevation: 10.0,
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _onReset();
                          });
                        },
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minPadding * 2, bottom: _minPadding),
                  child: Text(
                    this.displayResult,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('assets/images/simple_interest.jpeg');
    Image image = Image(
      image: assetImage,
//      width: 200.0,
//      height: 125.0,
    );

    return Container(
      child: image,
      //margin: EdgeInsets.all(_minPadding),
    );
  }

  String _calculateSimpleInterest() {
    double principal = double.parse(principalTextControlled.text);
    double rate = double.parse(rateTextControlled.text);
    double time = double.parse(timeTextControlled.text);

    double totalPayableAmt = principal + (principal * rate * time) / 100;
    // double interest = (principal * rate * time) / 100;

    int t = time.truncate();

    String result = 'After $t years, your investment will be the worth of '
        '$totalPayableAmt $_currentItemSelected';
    return result;
  }

  void _onReset() {
    principalTextControlled.text = '';
    rateTextControlled.text = '';
    timeTextControlled.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
