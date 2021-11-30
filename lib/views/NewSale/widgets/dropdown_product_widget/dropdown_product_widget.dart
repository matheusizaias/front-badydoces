import 'package:badydoces/models/produto.model.dart';
import 'package:badydoces/repositories/produto_repository.dart';
import 'package:badydoces/views/NewSale/new_sale_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownProductWidget extends StatefulWidget {
  final List<Product> products;
  const DropDownProductWidget({Key key, this.products}) : super(key: key);

  @override
  _DropDownProductWidgetState createState() => _DropDownProductWidgetState();
}

class _DropDownProductWidgetState extends State<DropDownProductWidget> {
  @override
  Widget build(BuildContext context) {
    NewSaleController _newSaleController =
        Provider.of<NewSaleController>(context, listen: false);
    return Consumer<ProductRepository>(
      builder: (context, value, child) {
        if (value.filteredProducts.length < 1 ||
            value.filteredProducts == null) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.fromBorderSide(
                  BorderSide(color: Color(0xFF4360F6), width: 2.0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: new Text("Selecione um produto"),
                items: ["Selecione um produto"].map(
                  (String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text('$value'),
                    );
                  },
                ).toList(),
                onChanged: (value) {},
              ),
            ),
          );
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.fromBorderSide(
                BorderSide(color: Color(0xFF4360F6), width: 2.0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              hint: Text('Selecione o produto'),
              onChanged: (Product newValue) {
                setState(() {
                  _newSaleController.select_product = newValue;
                });
              },
              value: _newSaleController.select_product,
              items: value.filteredProducts.map((e) {
                return DropdownMenuItem<Product>(
                  value: e,
                  child: Text(e.name),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
