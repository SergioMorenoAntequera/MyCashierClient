import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Cart.dart';
import '../../Models/Bundle.dart';
import '../../Models/Product.dart';

class AddProductDialog extends StatefulWidget {
  final BuildContext context;
  final String barcodeToAdd;
  final Function notifier;

  AddProductDialog({this.context, this.barcodeToAdd, this.notifier});

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ayyy, justo nos falta ese producto ¿Podrias ayudarnos? \n",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              buildNameFormField(),
              buildPriceFormField(),
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () => {Navigator.pop(context)},
            child: Text("No Añadir")),
        RaisedButton(onPressed: _createNewProduct, child: Text("Añadir")),
      ],
    );
  }

  // Product Name Input
  var newProductNameController = TextEditingController();
  buildNameFormField() {
    return Column(
      children: [
        Text("Nombre"),
        TextFormField(
          controller: newProductNameController,
          validator: (value) {
            if (value.isEmpty) {
              return "Introduce un nombre por favor";
            }
            return null;
          },
        ),
      ],
    );
  }

  // Product price Input
  static var newProductPriceController = TextEditingController();
  buildPriceFormField() {
    return Column(
      children: [
        Text("Precio"),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: newProductPriceController,
          validator: (value) {
            if (value.isEmpty) {
              return "¿Cuando cuesta?";
            }
            if (value.contains(",")) {
              newProductPriceController.text = value.replaceAll(",", ".");
            }
            return null;
          },
        ),
      ],
    );
  }

  // Create product in database
  void _createNewProduct() async {
    if (!_formKey.currentState.validate()) {
      return null;
    }

    var newProduct = Product(
      id: null,
      barcode: widget.barcodeToAdd,
      name: newProductNameController.text,
      price: double.parse(newProductPriceController.text),
    );
    newProduct = await newProduct.create();

    Bundle newBundle = new Bundle(product: newProduct, amount: 1);
    Provider.of<Cart>(context, listen: true).addBundle(newBundle);

    // widget.notifier();
    Navigator.pop(context);
  }
}
