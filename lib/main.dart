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
      home: const CompoundInterestCalculator(),
    );
  }
}

class CompoundInterestCalculator extends StatefulWidget {
  const CompoundInterestCalculator({super.key});

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
  double ypos = 0;
  @override
  Widget build(BuildContext context) {
    // String selectedValue = "1";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compound Interest Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
                                      GestureDetector(
                                        onTapDown: (details) {
                                          var position = details.globalPosition;
                                          print(AppBar().preferredSize.height);
                                          print(position.dy);
                                          print(MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              position.dy);
                                          ypos = position.dy + 12;
                                          print(ypos);
                                          setState(() {});
                                        },
                                        onTap: () {
                                          print(index);

                                          selectedIndex = index;
                                          if (selectedIndex == index) {
                                            fields[index].isDrop =
                                                !fields[index].isDrop!;
                                          }
                                          print(fields[index].isDrop);
                                          setState(() {});
                                          if (fields[index].isDrop!) {
                                            _showOverlay(context,
                                                index: index, fields: fields);
                                          } else {
                                            overlayEntry!.remove();
                                          }
                                        },
                                        child: Container(
                                          child: const Row(
                                            children: [
                                              Text("Select Value"),
                                              Icon(Icons.arrow_drop_down)
                                            ],
                                          ),
                                        ),
                                      ),
                                      // selectedIndex == index
                                      //     ?

                                      //     //  Container(
                                      //     //     height: 200,
                                      //     //     width: 200,
                                      //     //     child: Overlay(initialEntries: [
                                      //     //       OverlayEntry(
                                      //     //           builder: (context) {
                                      //     //         return Container(
                                      //     //           height: 200,
                                      //     //           width: 200,
                                      //     //           color: Colors.red,
                                      //     //           child: ListView.builder(
                                      //     //               shrinkWrap: true,
                                      //     //               itemCount: fields[index]
                                      //     //                   .values!
                                      //     //                   .length,
                                      //     //               itemBuilder: (context,
                                      //     //                   valueIndex) {
                                      //     //                 return Container(
                                      //     //                   // width: ,
                                      //     //                   child: Text(fields[
                                      //     //                               index]
                                      //     //                           .values![
                                      //     //                       valueIndex]),
                                      //     //                 );
                                      //     //               }),
                                      //     //         );
                                      //     //       }),
                                      //     //     ]),
                                      //     //   )
                                      //     : Container()
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // _showOverlay(context, text: "fsdfsdf");
                },
                // calculateCompoundInterest,
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 16),
              Text(
                'Compound Interest: \$${result.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OverlayEntry? overlayEntry;

  void _showOverlay(BuildContext context,
      {required int index, required List<Field> fields}) async {
    OverlayState? overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(builder: (context) {
      print("sssss$ypos");
      return Positioned(
        left: MediaQuery.of(context).size.width * 0.1,
        top:
            // 166,
            ypos,
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.shade600,
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 10))
          ]),
          child: Scaffold(
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: fields[index].values!.length,
                itemBuilder: (context, valueIndex) {
                  return InkWell(
                    onTap: () {
                      // overlayState!.insert(overlayEntry);
                      overlayEntry!.remove();
                    },
                    child: Center(
                      child: Container(
                        // width: ,
                        child: Text(fields[index].values![valueIndex]),
                      ),
                    ),
                  );
                }),
          ),
        ),
      );
      // );
    });
    //  animationController!.addListener(() {
    //    overlayState!.setState(() {});
    //  });
    // inserting overlay entry
    overlayState!.insert(overlayEntry!);

    // await Future.delayed(const Duration(seconds: 3))
    //     //  .whenComplete(
    //     //   // () => animationController!.reverse()
    //     //  )
    //     // removing overlay entry after stipulated time.
    //     .whenComplete(() => overlayEntry.remove());

    // if (selectedIndex != index) {
    //   overlayEntry.remove();
    // }
  }
}
