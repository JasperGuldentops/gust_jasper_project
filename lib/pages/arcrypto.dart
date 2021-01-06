import 'package:flutter/material.dart';
import '../widgets/armultipletargets.dart';

class ARCryptoPage extends StatefulWidget {
  @override
  _ArCryptoPageState createState() => _ArCryptoPageState();
}

class _ArCryptoPageState extends State<ARCryptoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dino's"),
      ),
      body: Center(
          // Here we load the Widget with the AR crypto experience
          child: ArMultipleTargetsWidget()),
    );
  }
}
