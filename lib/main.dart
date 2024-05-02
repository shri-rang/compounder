import 'dart:convert';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/CompoundModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CompoundInterestCalculator(),
    );
  }
}

class CompoundInterestCalculator extends StatefulWidget {
  @override
  _CompoundInterestCalculatorState createState() =>
      _CompoundInterestCalculatorState();
}

class _CompoundInterestCalculatorState
    extends State<CompoundInterestCalculator> {
  final _formKey = GlobalKey<FormState>();
  List<Field> fields = [];
  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timesCompoundedController = TextEditingController();
  TextEditingController yearsController = TextEditingController();

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/compound.json');
    final data = await jsonDecode(response);
    // setState(() {
    //   _items = data["items"];
    // });
    print("json string $response ");
    Map<String, dynamic> jsonMap = jsonDecode(response);

    fields = List<Field>.from(jsonMap['fields'].map((x) => Field.fromJson(x)));
    setState(() {});
    // CompoundModel.fromJson(data);
    print("object $data ");
    print("object $fields ");
  }

  double result = 0;

  void calculateCompoundInterest() {
    if (_formKey.currentState!.validate()) {
      double principal = double.parse(principalController.text);
      double rate = double.parse(rateController.text) / 100;
      int timesCompounded = int.parse(timesCompoundedController.text);
      int years = int.parse(yearsController.text);

      double amount =
          principal * pow(1 + rate / timesCompounded, timesCompounded * years);
      setState(() {
        result = amount - principal;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  List dropValue = ["1", "2", "3"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // String selectedValue = "1";
    return Scaffold(
      appBar: AppBar(
        title: Text('Compound Interest Calculator'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: fields.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 56,
                            width: 300,
                            child: fields[index].type == "dropdown"
                                ? Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(index);

                                          selectedIndex = index;
                                          setState(() {});
                                        },
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Text("Select Value"),
                                              Icon(Icons.arrow_drop_down)
                                            ],
                                          ),
                                        ),
                                      ),
                                      selectedIndex == index
                                          ? Positioned.fill(
                                              top: 20,
                                              right: 200,
                                              child: Container(
                                                height: 300,
                                                width: 200,
                                                color: Colors.red,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: fields[index]
                                                        .values!
                                                        .length,
                                                    itemBuilder:
                                                        (context, valueIndex) {
                                                      return Container(
                                                        // width: ,
                                                        child: Text(
                                                            fields[index]
                                                                    .values![
                                                                valueIndex]),
                                                      );
                                                    }),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )

                                //  DropdownButton<dynamic>(
                                //     // value: fields[index].values![0],
                                //     hint: Text(fields[index].labelText!),
                                //     items: fields[index].values!.map((value) {
                                //       return DropdownMenuItem<String>(
                                //         value: value,
                                //         child: Text(
                                //           value,
                                //         ),
                                //       );
                                //     }).toList(),
                                //     onChanged: (value) {
                                //       fields[index].values![0] = value;
                                //       setState(() {});
                                //     },
                                //   )
                                : Container(),
                          ),
                        ],
                      );
                    }),
              ),

              // TextFormField(
              //   controller: principalController,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(labelText: 'Principal Amount'),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter principal amount';
              //     }
              //     return null;
              //   },
              // ),
              // TextFormField(
              //   controller: rateController,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(labelText: 'Rate of Interest (%)'),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter rate of interest';
              //     }
              //     return null;
              //   },
              // ),
              // TextFormField(
              //   controller: timesCompoundedController,
              //   keyboardType: TextInputType.number,
              //   decoration:
              //       InputDecoration(labelText: 'No. of Times Compounded'),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter number of times compounded';
              //     }
              //     return null;
              //   },
              // ),
              // TextFormField(
              //   controller: yearsController,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(labelText: 'No. of Years'),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter number of years';
              //     }
              //     return null;
              //   },
              // ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: calculateCompoundInterest,
                child: Text('Calculate'),
              ),
              SizedBox(height: 16),
              Text(
                'Compound Interest: \$${result.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
