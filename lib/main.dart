import 'package:flutter/material.dart';
import 'api_service.dart';

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
      ),
      home: const MyHomePage(title: 'My Online Bestie'),
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
  final TextEditingController myController = TextEditingController();
  final GetResult results = GetResult();
  List<String> texts = [];
  bool isReady = false;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _sendRequest() async {
    String prompt = myController.text.trim();
    if (prompt.isEmpty) return;

    setState(() {
      texts.add(prompt);
    });

    var response = await results.getResult(prompt);
    if (response != null) {
      setState(() {
        texts.add(response.responseText);
      });
    }

    setState(() {
      isReady = true;
    });

    myController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: isReady
                ? ListView.builder(
                    itemCount: texts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(
                            texts[index],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(child: Text("Start a conversation!")),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: myController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Say Something',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendRequest,
        child: const Icon(Icons.send),
      ),
    );
  }
}
