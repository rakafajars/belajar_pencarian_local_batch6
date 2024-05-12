import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<String> dataList = [
    "Raka",
    "Ray",
    "Arba",
    "Naubil",
    "Yazid",
    "Levian",
    "Nissa",
    "Afflah",
    "Givari",
    "Al Akbar",
    "Aulia Heppy",
  ];

  List<String> searchDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Cari Data'),
              onChanged: (String value) {
                searchDataList.clear();
                setState(() {});
                if (value.isEmpty) {
                  setState(() {});
                  return;
                }

                for (var element in dataList) {
                  if (element.contains(value)) {
                    searchDataList.add(element);
                  }
                }
                setState(() {});
              },
            ),
            const SizedBox(height: 24),
            if (searchDataList.isNotEmpty) ...[
              Column(
                children: List.generate(
                  searchDataList.length,
                  (index) => ListTile(
                    title: Text(
                      searchDataList[index],
                    ),
                  ),
                ),
              )
            ] else if (dataList.isNotEmpty) ...[
              Column(
                children: List.generate(
                  dataList.length,
                  (index) => ListTile(
                    title: Text(
                      dataList[index],
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
