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

class FormInfoProductstWidget extends StatefulWidget {
  @override
  _FormInfoProductstWidgettWidgetState createState() =>
      _FormInfoProductstWidgettWidgetState();
}

class _FormInfoProductstWidgettWidgetState
    extends State<FormInfoProductstWidget> {
  @override
  Widget build(BuildContext context) {
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

    itens.forEach((element2) {
      infoProd.forEach((element) => {
            if (element.id_product == element2.product_id)
              {productsByIdSale.add(element)}
          });
    });

    // index = vendas.idSale;
    // sales.forEach((sales) {
    //   repositoryProduto.products.forEach((product2) {
    //     if (sales.idSale == index) {
    //       if (sales.idProduct == product2.id_product) {
    //         produtosCat(product2);
    //       }
    //     }
    //   });
    // });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 35,
                  ),
                  Column(
                    children: [
                      Text(
                        'Nome Produto',
                        style: GoogleFonts.ubuntu(fontSize: 18),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    width: 128,
                  ),
                  // SizedBox(
                  //   width: 125,
                  // ),
                  Column(
                    children: [
                      Text(
                        'Preço',
                        style: GoogleFonts.ubuntu(fontSize: 18),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: 78,
                  // ),
                  VerticalDivider(
                    width: 75,
                    color: Colors.amber,
                  ),
                  Column(
                    children: [
                      Text(
                        'Qtd',
                        style: GoogleFonts.ubuntu(fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: productsByIdSale
                        .map(
                          (e) => Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.check, color: Colors.green),
                                  SizedBox(width: 5),
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
                SizedBox(width: 100),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(width: 70),
                SingleChildScrollView(
                  child: Column(
                    children: produtosVendas
                        .map((e) => Column(
                              children: [
                                Text(
                                  e.qtd.toString(),
                                  style: GoogleFonts.ubuntu(fontSize: 22),
                                ),
                                Divider()
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
