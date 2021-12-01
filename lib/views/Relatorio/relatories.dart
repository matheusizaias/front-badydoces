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
  'Ontem',
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
  'Dezembro'
];
var lista3 = ['2021', '2022'];

var selecionado = DateFormat("MMMM", "pt_BR").format(DateTime.now());
var selecionadoMes = DateFormat("MM", "pt_BR").format(DateTime.now());
var selecionadoAno = DateFormat("yyyy", "pt_BR").format(DateTime.now());
var selecionadoDia = DateFormat("dd", "pt_BR").format(DateTime.now());
var selecionadoOntem = int.parse(selecionadoDia) - 1;

class _RelatoriesState extends State<Relatories> {
  @override
  Widget build(BuildContext context) {
    var repositorySP =
        Provider.of<SaleProductRepository>(context, listen: true);

    var repositoryProduto =
        Provider.of<ProductRepository>(context, listen: true);
    var infoProd = repositoryProduto.products;
    var itens = repositorySP.salesProducts;
    var itens2 = repositorySP.salesProducts;
    //List<SaleProduct>

    Iterable<SaleProduct> produtosVendas;
    List<Product> productsByIdSale = [];
    List<Product> productsFiltre = [];

    var repositorySales = Provider.of<SaleRepository>(context, listen: true);
    var sales = repositorySales.sales;
    var top = selecionado.characters.first.toUpperCase();
    selecionado =
        selecionado.replaceFirst(selecionado.characters.first, top, 0);
    Iterable<Sale> lista_certa;
    double total;
    List<Sale> vendas = sales;
    total = 0;
    vendas.forEach((element) {
      var m = element.value.replaceAll("\$", '');
      if (DateTime.parse(element.createdAt).month ==
              lista2.indexWhere((element) => element == selecionado) - 1 &&
          (DateTime.parse(element.createdAt).year ==
              int.parse(selecionadoAno))) {
        total += double.parse(m);
      } else if ((DateTime.parse(element.createdAt).month ==
              int.parse(selecionadoMes) &&
          (DateTime.parse(element.createdAt).day ==
              int.parse(selecionadoDia)) &&
          (DateTime.parse(element.createdAt).year ==
              int.parse(selecionadoAno)) &&
          selecionado == 'Hoje')) {
        total += double.parse(m);
      } else if ((DateTime.parse(element.createdAt).month ==
              int.parse(selecionadoMes) &&
          (DateTime.parse(element.createdAt).day ==
              int.parse(selecionadoDia) - 1) &&
          (DateTime.parse(element.createdAt).year ==
              int.parse(selecionadoAno)) &&
          selecionado == 'Ontem')) {
        total += double.parse(m);
      }
    });
    String totalString = total.toStringAsFixed(2);

    itens.forEach((element) {
      itens2.remove(element);
    });

    itens2.forEach((element) {
      print(element.product_id);
    });

//     itens.forEach((element2) {
//       infoProd.forEach((element) => {
//             if (element.id_product == element2.product_id)
//               {
//                 productsByIdSale.add(element),
//               }
//           });
//     });
//
//     productsByIdSale.forEach((element) {
//       productsByIdSale.forEach((element2) {
//         if (element.name == element2.name) {
//           productsByIdSale.remove(element2);
//         }
//       });
//     });
//
//     productsByIdSale.forEach((element) {
//       print(element.name);
//     });

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
        Expanded(
          child: Consumer<SaleRepository>(
            builder: (context, value, child) {
//               if (selecionado != 'Hoje' && selecionado != 'Ontem') {
//                 lista_certa = value.sales.where((element) =>
//                     (DateTime.parse(element.createdAt).month ==
//                         lista2.indexWhere((element) => element == selecionado) -
//                             1) &&
//                     (DateTime.parse(element.createdAt).year ==
//                         int.parse(selecionadoAno)));
//               } else if (selecionado == 'Hoje') {
//                 lista_certa = value.sales.where((element) =>
//                     (DateTime.parse(element.createdAt).month ==
//                             int.parse(selecionadoMes) &&
//                         (DateTime.parse(element.createdAt).day ==
//                             int.parse(selecionadoDia)) &&
//                         (DateTime.parse(element.createdAt).year ==
//                             int.parse(selecionadoAno))));
//               } else {
//                 lista_certa = value.sales.where((element) =>
//                     (DateTime.parse(element.createdAt).month ==
//                             int.parse(selecionadoMes) &&
//                         (DateTime.parse(element.createdAt).day ==
//                             int.parse(selecionadoDia) - 1) &&
//                         (DateTime.parse(element.createdAt).year ==
//                             int.parse(selecionadoAno))));
//               }
//
//               lista_certa.forEach((element) {
//                 var m = element.value.replaceAll("\$", '');
//                 total += double.parse(m);
//               });

              itens.forEach((element) {
                print(element.product_id);
              });
              return Container();

//               return ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: itens.length,
//                 // ignore: missing_return
//                 itemBuilder: (_, index) {
//                   var products = itens.toList()[index];
//                   //var productsName = productsByIdSale.toList()[index];
//
//                   return Column(
//                     children: [
//                       Row(
//                         children: [
//                           Flexible(
//                             flex: 2,
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   left: 30, right: 0, top: 10, bottom: 8),
//                               child: Icon(
//                                 Icons.point_of_sale,
//                                 color: Colors.green,
//                                 size: 40,
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             flex: 9,
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   left: 30, right: 30, top: 5, bottom: 5),
//                               // decoration: BoxDecoration(
//                               //   color: Colors.white,
//                               //   borderRadius: BorderRadius.circular(8),
//                               //   border: Border.fromBorderSide(
//                               //       BorderSide(color: Colors.blue, width: 2.0)),
//                               // ),
//                               child: ListTile(
//                                 title: Text(
//                                   products.product_id,
//                                   style: GoogleFonts.ubuntu(
//                                     color: Colors.black,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                                 trailing: Container(
//                                   width: 100,
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         products.qtd.toString(),
//                                         style: GoogleFonts.ubuntu(
//                                           color: Colors.black,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Divider(),
//                     ],
//                   );
//                 },
//               );
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
                onChanged: (String newValue) {
                  setState(() {
                    selecionadoAno = newValue;
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
