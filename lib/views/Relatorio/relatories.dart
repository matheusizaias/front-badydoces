import 'dart:html';
import 'dart:math';

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
import 'form_info_products_widget.dart';

class Relatories extends StatefulWidget {
  @override
  _RelatoriesState createState() => _RelatoriesState();
}

var lista2 = [
  'Hoje',
  'Janeiro',
  'Fevereiro',
  'Março',
  'Abril',
  'Maio',
  'Junho',
  'Julho',
  'Agosto',
  'Setembro',
  'Outubro',
  'Novembro',
  'Dezembro',
  'Mais Vendido Anual',
  'Mais Vendido Total'
];
var lista3 = ['2021', '2022'];

var selecionado = DateFormat("MMMM", "pt_BR").format(DateTime.now());
var selecionadoMes = DateFormat("MM", "pt_BR").format(DateTime.now());
var selecionadoAno = DateFormat("yyyy", "pt_BR").format(DateTime.now());
var selecionadoDia = DateFormat("dd", "pt_BR").format(DateTime.now());
var selecionadoOntem = int.parse(selecionadoDia) - 1;

class _RelatoriesState extends State<Relatories> {
  List<int> idSalesUsed;
  List<String> idProductOrder;
  var block;
  @override
  Widget build(BuildContext context) {
    var repositorySP =
        Provider.of<SaleProductRepository>(context, listen: true);

    var repositoryProduto =
        Provider.of<ProductRepository>(context, listen: true);
    var infoProd = repositoryProduto.products;
    var itens = repositorySP.salesProducts;

    block = false;

    List<Product> productsByIdSale = [];
    List<SaleProduct> produtosVendas = [];
    List<SaleProduct> produtosVendas2 = [];
    idSalesUsed = [];
    idProductOrder = [];

    var repositorySales = Provider.of<SaleRepository>(context, listen: true);
    var sales = repositorySales.sales;
    var top = selecionado.characters.first.toUpperCase();
    selecionado =
        selecionado.replaceFirst(selecionado.characters.first, top, 0);
    Iterable<Sale> lista_certa;

    if (selecionado == 'Mais Vendido Total') {
      lista_certa = sales.where((element) => (true));
      setState(() {
        idSalesUsed = [];
        idProductOrder = [];
        block = true;
      });
    } else if (selecionado == 'Mais Vendido Anual') {
      lista_certa = sales.where((element) =>
          (DateTime.parse(element.createdAt).year ==
              int.parse(selecionadoAno)));
      setState(() {
        idSalesUsed = [];
        idProductOrder = [];
        block = false;
      });
    } else if (selecionado != 'Hoje' &&
        selecionado != 'Mais Vendido Anual' &&
        selecionado != 'Mais Vendido Total') {
      lista_certa = sales.where((element) =>
          (DateTime.parse(element.createdAt).month ==
              lista2.indexWhere((element) => element == selecionado)) &&
          (DateTime.parse(element.createdAt).year ==
              int.parse(selecionadoAno)));

      setState(() {
        idSalesUsed = [];
        idProductOrder = [];
        block = false;
      });
    } else if (selecionado == 'Hoje') {
      lista_certa = sales.where((element) =>
          (DateTime.parse(element.createdAt).month ==
                  int.parse(selecionadoMes) &&
              (DateTime.parse(element.createdAt).day ==
                  int.parse(selecionadoDia)) &&
              (DateTime.parse(element.createdAt).year ==
                  int.parse(selecionadoAno))));
      setState(() {
        idSalesUsed = [];
        idProductOrder = [];
        block = false;
      });
    } else {
      lista_certa = sales.where((element) =>
          (DateTime.parse(element.createdAt).month ==
                  int.parse(selecionadoMes) &&
              (DateTime.parse(element.createdAt).day ==
                  int.parse(selecionadoDia) - 1) &&
              (DateTime.parse(element.createdAt).year ==
                  int.parse(selecionadoAno))));
      setState(() {
        idSalesUsed = [];
        idProductOrder = [];
        block = false;
      });
    }

    itens.forEach((element) {
      lista_certa.forEach((e) {
        if (element.sale_id == e.idSale) {
          setState(() {
            produtosVendas2.add(element);
          });
        }
      });
    });

    itens.forEach((element) {
      int cont = 0;

      if (produtosVendas.isEmpty) {
        lista_certa.forEach((e) {
          if (element.sale_id == e.idSale) {
            setState(() {
              produtosVendas.add(element);
              cont = 1;
            });
          }
        });
      } else {
        produtosVendas.forEach((element2) {
          if (element.product_id == element2.product_id) {
            cont = 1;
          }
        });
      }
      if (cont == 0) {
        lista_certa.forEach((e) {
          if (element.sale_id == e.idSale) {
            setState(() {
              produtosVendas.add(element);
            });
          }
        });
      }
    });

    produtosVendas.forEach((produtosFiltrados) {
      int cont = 0;
      var idP = "";
      cont = produtosFiltrados.qtd;
      idP = produtosFiltrados.product_id;

      produtosVendas2.forEach((produtosFiltradosMes) {
        if (produtosFiltrados.product_id == produtosFiltradosMes.product_id &&
            produtosFiltrados.sale_id != produtosFiltradosMes.sale_id) {
          cont += produtosFiltradosMes.qtd;
        }
      });

      setState(() {
        idSalesUsed.add(cont);
        idProductOrder.add(idP);
      });
    });

    for (int i = 1; i < produtosVendas.length; i++) {
      for (int j = 0; j < i; j++) {
        if (produtosVendas[i].qtd > produtosVendas[j].qtd) {
          var temp = produtosVendas[i];
          produtosVendas[i] = produtosVendas[j];
          produtosVendas[j] = temp;
        }
      }
    }

    for (int i = 1; i < idSalesUsed.length; i++) {
      for (int j = 0; j < i; j++) {
        if (idSalesUsed[i] > idSalesUsed[j]) {
          int temp = idSalesUsed[i];
          idSalesUsed[i] = idSalesUsed[j];
          idSalesUsed[j] = temp;

          var id = idProductOrder[i];
          idProductOrder[i] = idProductOrder[j];
          idProductOrder[j] = id;
        }
      }
    }

    idProductOrder.forEach((element2) {
      infoProd.forEach((element) => {
            if (element.id_product == element2)
              {
                setState(() {
                  productsByIdSale.add(element);
                })
              }
          });
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pushNamed('/tela_inicial'),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Relatório de Produtos',
          style: GoogleFonts.ubuntu(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(children: [
        dropDownMeses(),
        Divider(),
        Container(
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 120,
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
              VerticalDivider(
                width: 25,
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
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: produtosVendas.length,
            // ignore: missing_return
            itemBuilder: (_, index) {
              var products = idSalesUsed.toList()[index];
              var productsName = productsByIdSale.toList()[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 30, right: 0, top: 10, bottom: 8),
                          child: Icon(
                            Icons.point_of_sale,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 9,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 30, right: 30, top: 5, bottom: 5),
                          child: ListTile(
                            title: Text(
                              productsName.name,
                              style: GoogleFonts.ubuntu(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              "Categoria: " + productsName.name_category,
                              style: GoogleFonts.ubuntu(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            trailing: Container(
                              width: 30,
                              child: Row(
                                children: [
                                  Text(
                                    products.toString(),
                                    style: GoogleFonts.ubuntu(
                                        color: Colors.black, fontSize: 20),
                                  )
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
          ),
        ),
      ]),
    );
  }

  Row dropDownMeses() {
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 0, 20),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.fromBorderSide(
                  BorderSide(color: Colors.grey[700], width: 2.0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: selecionado,
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
                isExpanded: true,
                style: TextStyle(color: Colors.black, fontSize: 16),
                items: lista2.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    selecionado = newValue;
                  });
                },
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.fromBorderSide(
                  BorderSide(color: Colors.grey[700], width: 2.0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: selecionadoAno,
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
                isExpanded: true,
                style: TextStyle(color: Colors.black, fontSize: 16),
                items: lista3.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (block == true)
                    ? null
                    : (String newValue) {
                        setState(() {
                          selecionadoAno = newValue;
                          idSalesUsed = [];
                          idProductOrder = [];
                        });
                      },
              ),
            ),
          ),
        )
      ],
    );
  }
}
