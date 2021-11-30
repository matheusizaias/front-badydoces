import 'package:badydoces/models/categoria.model.dart';
import 'package:badydoces/repositories/categoria_repository.dart';
import 'package:badydoces/repositories/produto_repository.dart';
import 'package:badydoces/views/NewSale/new_sale_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownCategoryWidget extends StatefulWidget {
  const DropDownCategoryWidget({
    Key key,
  }) : super(key: key);

  @override
  _DropDownCategoryWidgetState createState() => _DropDownCategoryWidgetState();
}

class _DropDownCategoryWidgetState extends State<DropDownCategoryWidget> {
  Categoria selectedCategory;
  List<Categoria> categorias;

  @override
  Widget build(BuildContext context) {
    CategoryRepository _repoCategory = Provider.of<CategoryRepository>(context);
    ProductRepository _repoProduct = Provider.of<ProductRepository>(context);
    NewSaleController _newSaleController =
        Provider.of<NewSaleController>(context, listen: false);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.fromBorderSide(
              BorderSide(color: Color(0xFF4360F6), width: 2.0)),
        ),
        child: DropdownButtonHideUnderline(child: Consumer<CategoryRepository>(
          builder: (context, value, child) {
            return DropdownButton(
              isExpanded: true,
              hint: Text('Selecione uma categoria'),
              onChanged: (Categoria value) {
                _newSaleController.select_product = null;
                _repoProduct.fetchProductByCategory(
                    category: value.category_name);

                setState(() {
                  selectedCategory = value;
                });
              },
              value: selectedCategory,
              items: value.categorias.map((e) {
                return DropdownMenuItem<Categoria>(
                  value: e,
                  child: Text(e.category_name),
                );
              }).toList(),
            );
          },
        )));
  }
}
