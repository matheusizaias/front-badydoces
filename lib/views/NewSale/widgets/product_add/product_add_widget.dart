import 'package:badydoces/models/new_sale_model.dart';
import 'package:badydoces/models/produto.model.dart';
import 'package:badydoces/views/NewSale/new_sale_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductAddWdiget extends StatelessWidget {
  final Product productAdd;
  final int index;
  const ProductAddWdiget({Key key, this.productAdd, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.grey,
            offset: Offset(1, 4),
          ),
        ],
        border: Border.fromBorderSide(
          BorderSide(color: Colors.grey),
        ),
      ),
      height: 80,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text('#${index + 1} - ${productAdd.name}'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Quantidade: ${productAdd.amount}'),
                  ),
                ],
              ),
            ),
            Expanded(child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Valor: R\$ ${double.tryParse(productAdd.price).toStringAsFixed(2)}'),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[400],
                    ),
                    onPressed: () {
                      Provider.of<NewSaleController>(context, listen: false)
                          .removeProduct(index);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          'Venda removida com sucesso',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red[400],
                      ));
                    },
                    child: Icon(
                      Icons.close,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
