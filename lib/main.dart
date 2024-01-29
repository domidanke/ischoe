import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ischoe/audio.service.dart';
import 'package:ischoe/data.service.dart';

void main() {
  runApp(const Ischoe());
}

class Ischoe extends StatelessWidget {
  const Ischoe({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    DataService().loadLocalData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IschoeHomePage(),
    );
  }
}

class IschoeHomePage extends StatefulWidget {
  const IschoeHomePage({super.key});
  @override
  State<IschoeHomePage> createState() => _IschoeHomePageState();
}

class _IschoeHomePageState extends State<IschoeHomePage> {
  bool ischoeButtonDisabled = false;
  void _ischoe() async {
    if (ischoeButtonDisabled) return;
    setState(() {
      ischoeButtonDisabled = true;
    });
    AudioService().playRandomIschoe();
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      DataService().increaseIschoe();
      ischoeButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Ischö'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/ischoe.jpeg'),
            const Text(
              'Ischö wie oft gedrückt',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              '${DataService().getIschoeCount() == 0 ? '' : DataService().getIschoeCount()}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Opacity(
        opacity: ischoeButtonDisabled ? 0.4 : 1,
        child: FloatingActionButton(
          onPressed: _ischoe,
          tooltip: 'Ischoe',
          child: const Icon(Icons.mic_rounded),
        ),
      ),
    );
  }
}
