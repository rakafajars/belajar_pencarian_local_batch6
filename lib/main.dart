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

  void saveSearchHistory(String valueSearch) async {
    final prefs = await SharedPreferences.getInstance();

    if (valueSearch.isEmpty) {
      return;
    }

    final historySearch = await getHistory() ?? <String>[];
    historySearch.add(valueSearch);

    await prefs.setStringList('search', historySearch);
  }

  Future<List<String>?> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final listDataHistory = prefs.getStringList('search');
    return listDataHistory;
  }

  // tampungan historynya
  List<String> historySearch = [];

  void initHistory() async {
    historySearch = await getHistory() ?? <String>[];
    setState(() {});
  }

  @override
  void initState() {
    initHistory();
    super.initState();
  }

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
            if (historySearch.isNotEmpty) ...[
              Wrap(
                children: historySearch
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                        ),
                        child: Chip(
                          label: Text(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
            TextFormField(
              decoration: const InputDecoration(hintText: 'Cari Data'),
              onFieldSubmitted: (value) {
                saveSearchHistory(value);
              },
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
