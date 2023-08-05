import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Shared Preferences'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var savedData = "";
  // ignore: constant_identifier_names
  static const String KEYNAME = "name";
  var nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blue[50],
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 300,
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                label: const Text(
                  "Name",
                  style: TextStyle(fontSize: 20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var name = nameController.text.toString();
              var prefs = await SharedPreferences.getInstance();
              prefs.setString(KEYNAME, name);
              savedData = name;
              setState(() {});
            },
            child: const Text("Save"),
          ),
          Text(savedData),
        ]),
      ),
    );
  }

  void getName() async {
    var prefs = await SharedPreferences.getInstance();
    savedData = prefs.getString(KEYNAME).toString();
    setState(() {});
  }
}
