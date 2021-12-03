import 'package:badydoces/models/produto.model.dart';
import 'package:badydoces/models/venda.model.dart';
import 'package:badydoces/models/venda_produto.model.dart';
import 'package:badydoces/repositories/produto_repository.dart';
import 'package:badydoces/repositories/venda_produto_repository.dart';
import 'package:badydoces/repositories/venda_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InfoSales extends StatelessWidget {
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pushNamed('/listsales'),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Controle de vendas',
          style: GoogleFonts.ubuntu(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        enabled: false,
                        initialValue: vendas.costumer,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Color(0xFF4360F6)),
                            labelText: 'Nome do cliente',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF4360F6), width: 2.0),
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
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Consumer<SaleProductRepository>(
              builder: (context, value, child) {
                produtosVendas = value.salesProducts
                    .where((element) => element.sale_id == vendas.idSale);

                produtosVendas.forEach((element2) {
                  infoProd.forEach((element) => {
                        if (element.id_product == element2.product_id)
                          {productsByIdSale.add(element)}
                      });
                });

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: produtosVendas.length,
                  // ignore: missing_return
                  itemBuilder: (_, index) {
                    var produtos = produtosVendas.toList()[index];
                    var produtosNomes = productsByIdSale.toList()[index];

                    return Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 30, right: 0, top: 0, bottom: 8),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 40,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 9,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 30, right: 30, top: 0, bottom: 5),
                                child: ListTile(
                                  title: Text(
                                    produtosNomes.name,
                                    style: GoogleFonts.ubuntu(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Text(
                                    produtos.price.toString(),
                                    style: GoogleFonts.ubuntu(
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        Text(
                                          produtos.qtd.toString(),
                                          style: GoogleFonts.ubuntu(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
