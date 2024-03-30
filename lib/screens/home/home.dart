import 'package:cashier/screens/home/components/appBar.dart';
import 'package:cashier/screens/home/components/button.dart';
import 'package:cashier/screens/home/components/image.dart';
import 'package:cashier/screens/scanner/scanner.dart';
import 'package:cashier/screens/scanner/scanner_interaction.dart';
import 'package:cashier/screens/scanner/scanners_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scannersController = context.watch<ScannersController>();

    double buttonWidth = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: ContainerImage(),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Button(
                        width: buttonWidth,
                        label: 'أضافة',
                        icon: Icons.add_outlined,
                        color: Colors.pink[200]!,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scanners(
                                effect: scannersController,
                                action: ScannerAction.ADD,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Button(
                        width: buttonWidth,
                        label: 'تعديل',
                        icon: Icons.edit_outlined,
                        color: Colors.teal[300]!,
                        onPressed: () {
                          SystemSound.play(SystemSoundType.alert);
                        },
                      ),
                    ),
                  ],
                ),
                Button(
                  width: buttonWidth,
                        label: 'قرأءة كود',
                        icon: Icons.qr_code_scanner_outlined,
                        color: Colors.indigo,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                        builder: (context) => Scanners(
                          effect: scannersController,
                        ),
                      ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

}
