import 'package:badydoces/models/produto.model.dart';
import 'package:badydoces/models/venda.model.dart';
import 'package:badydoces/models/venda_produto.model.dart';
import 'package:badydoces/repositories/produto_repository.dart';
import 'package:badydoces/repositories/venda_produto_repository.dart';
import 'package:badydoces/repositories/venda_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormInfoSalestWidget extends StatefulWidget {
  @override
  _FormInfoSalestWidgetWidgetState createState() =>
      _FormInfoSalestWidgetWidgetState();
}

class _FormInfoSalestWidgetWidgetState extends State<FormInfoSalestWidget> {
  @override
  Widget build(BuildContext context) {
    Sale vendas = ModalRoute.of(context).settings.arguments;

    var repositorySale = Provider.of<SaleRepository>(context, listen: true);
    var repositorySP =
        Provider.of<SaleProductRepository>(context, listen: true);

    var repositoryProduto =
        Provider.of<ProductRepository>(context, listen: true);

    var infoProd = repositoryProduto.products;
    var sales = repositorySale.sales;
    var itens = repositorySP.salesProducts;
    final _formKey = GlobalKey<FormState>();
    //List<SaleProduct>

    Iterable<SaleProduct> produtosVendas;
    List<Product> productsByIdSale = [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                enabled: false,
                initialValue: vendas.costumer,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Color(0xFF4360F6)),
                    labelText: 'Nome do cliente',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF4360F6), width: 2.0),
                    )),
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      enabled: false,
                      initialValue: vendas.value,
                      decoration: InputDecoration(
                          labelText: 'Valor total',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF4360F6), width: 2.0),
                          )),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      enabled: false,
                      initialValue: DateFormat("dd-MM-yyyy")
                          .format(DateTime.parse(vendas.createdAt)),
                      decoration: InputDecoration(
                          labelText: 'Data',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF4360F6), width: 2.0),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 120, 5),
                    child: Column(
                      children: [
                        Text(
                          'Nome Produto',
                          style: GoogleFonts.ubuntu(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 40, 5),
                    child: Column(
                      children: [
                        Text(
                          'Preço',
                          style: GoogleFonts.ubuntu(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 5),
                    child: Column(
                      children: [
                        Text(
                          'Qtd',
                          style: GoogleFonts.ubuntu(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Consumer<SaleProductRepository>(
              builder: (context, value, child) {
                produtosVendas = value.salesProducts
                    .where((element) => element.sale_id == vendas.idSale);

                produtosVendas.forEach((element2) {
                  infoProd.forEach((element) => {
                        if (element.id_product == element2.product_id)
                          {productsByIdSale.add(element)}
                      });
                });

                return Row(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(10, 0, 120, 5),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: productsByIdSale
                            .map(
                              (e) => Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.check, color: Colors.green),
                                      Text(
                                        e.name,
                                        style: GoogleFonts.ubuntu(fontSize: 22),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(0, 0, 60, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: produtosVendas
                            .map((e) => Column(
                                  children: [
                                    Text(
                                      e.price,
                                      style: GoogleFonts.ubuntu(fontSize: 22),
                                    ),
                                    Divider(),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: produtosVendas
                            .map((e) => Column(
                                  children: [
                                    Text(
                                      e.qtd.toString(),
                                      style: GoogleFonts.ubuntu(fontSize: 22),
                                    ),
                                    Divider(),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
