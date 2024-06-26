import 'package:cashier/screens/add_product/add_product_controller.dart';
import 'package:cashier/screens/add_product/components/input.dart';
import 'package:cashier/widget/AppBar.dart';
import 'package:cashier/widget/show_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddProductController>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setLabel(label);
    });

    return Scaffold(
      appBar: AppbarBack(
        title: RichText(
          text: TextSpan(
            text: " اضافه منتج جديد ",
            style: TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: '$label',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.7,
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Input(
                  labelText: 'أسم العنصر',
                  validator: controller.validate,
                  onChanged: (value) {},
                  controller: controller.title,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                Input(
                  labelText: 'السعر',
                  validator: controller.validate,
                  onChanged: (value) {},
                  controller: controller.price,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                ),
                Input(
                  labelText: 'الكمية',
                  validator: controller.validate,
                  onChanged: (value) {},
                  controller: controller.much,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).add(
                    EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      controller.saveProduct().then((state) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          showSnackBar(state.getTitle(), onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          }),
                        );
                      });
                    },
                    height: 60.0,
                    minWidth: double.infinity,
                    child: Text(
                      'حفظ',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
