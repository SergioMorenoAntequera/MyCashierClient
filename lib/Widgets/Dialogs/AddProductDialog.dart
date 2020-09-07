import 'package:flutter/material.dart';
import '../../Models/Product.dart';

class AddProductDialog extends StatefulWidget {
  final BuildContext context;
  final String barcodeToAdd;

  AddProductDialog({this.context, this.barcodeToAdd});

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  var newProductNameController = TextEditingController();
  var newProductPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      // title: Text(":("),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("Ayyy, justo nos falta ese producto \n ¿Podrias ayudarnos?"),
          buildTextFormField(
            "Nombre",
            "¿Como se llama el producto?",
            newProductNameController,
          ),
          buildTextFormField(
            "Precio",
            "¿Cuanto cuesta?",
            newProductPriceController,
          ),
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () => {Navigator.pop(context)},
            child: Text("No Añadir")),
        RaisedButton(onPressed: _createNewProduct, child: Text("Añadir")),
      ],
    );
  }

  buildTextFormField(title, validatorMessage, controller) {
    return Column(
      children: [
        SizedBox(height: 5),
        Text(title),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value.isEmpty) {
              return validatorMessage;
            }
            return null;
          },
        ),
      ],
    );
  }

  // Create product in database
  void _createNewProduct() async {
    var product = Product(
      id: null,
      barcode: widget.barcodeToAdd,
      name: newProductNameController.text,
      price: double.parse(newProductPriceController.text),
    );

    product = await product.create();

    Navigator.pop(context);
  }
}
