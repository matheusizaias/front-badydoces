import 'package:badydoces/models/venda.model.dart';
import 'package:badydoces/repositories/venda_repository.dart';
import 'package:badydoces/views/components/bottomNaviBar/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ListSales extends StatefulWidget {
  @override
  _ListSalesState createState() => _ListSalesState();
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

class _ListSalesState extends State<ListSales> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
          opacity: .4,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Controle de vendas - R\$ ${totalString.replaceAll('\.', ',')}',
          style: GoogleFonts.ubuntu(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          dropDownMeses(),
          Divider(),
          Expanded(
            child: Consumer<SaleRepository>(
              builder: (context, value, child) {
                if (selecionado != 'Hoje' && selecionado != 'Ontem') {
                  lista_certa = value.sales.where((element) =>
                      (DateTime.parse(element.createdAt).month ==
                          lista2.indexWhere(
                                  (element) => element == selecionado) -
                              1) &&
                      (DateTime.parse(element.createdAt).year ==
                          int.parse(selecionadoAno)));
                } else if (selecionado == 'Hoje') {
                  lista_certa = value.sales.where((element) =>
                      (DateTime.parse(element.createdAt).month ==
                              int.parse(selecionadoMes) &&
                          (DateTime.parse(element.createdAt).day ==
                              int.parse(selecionadoDia)) &&
                          (DateTime.parse(element.createdAt).year ==
                              int.parse(selecionadoAno))));
                } else {
                  lista_certa = value.sales.where((element) =>
                      (DateTime.parse(element.createdAt).month ==
                              int.parse(selecionadoMes) &&
                          (DateTime.parse(element.createdAt).day ==
                              int.parse(selecionadoDia) - 1) &&
                          (DateTime.parse(element.createdAt).year ==
                              int.parse(selecionadoAno))));
                }

                lista_certa.forEach((element) {
                  var m = element.value.replaceAll("\$", '');
                  total += double.parse(m);
                });

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: lista_certa.length,
                  // ignore: missing_return
                  itemBuilder: (_, index) {
                    var vendas = lista_certa.toList()[index];

                    return Dismissible(
                      key: Key(vendas.costumer),
                      onDismissed: (direction) {
                        repositorySales.delete(vendas.idSale);
                      },
                      confirmDismiss: (direction) {
                        return confirmarExclusao(context);
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: Column(
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
                                  // decoration: BoxDecoration(
                                  //   color: Colors.white,
                                  //   borderRadius: BorderRadius.circular(8),
                                  //   border: Border.fromBorderSide(
                                  //       BorderSide(color: Colors.blue, width: 2.0)),
                                  // ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        '/infosales',
                                        arguments: vendas,
                                      );
                                    },
                                    title: Text(
                                      vendas.costumer,
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    subtitle: Text(
                                      vendas.value.toString(),
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.black,
                                      ),
                                    ),
                                    trailing: Container(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          Text(
                                            DateFormat("dd-MM-yyyy").format(
                                                DateTime.parse(
                                                    vendas.createdAt)),
                                            style: GoogleFonts.ubuntu(
                                              color: Colors.black,
                                              fontSize: 16,
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
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNaviBar(indexTela: 3),
    );
  }

//   abrirWhatsApp() async {
//     var whatsappUrl =
//         "whatsapp://send?phone=+5517991986223&text=Olá,tudo bem ?";
//
//     if (await canLaunch(whatsappUrl)) {
//       await launch(whatsappUrl);
//     } else {
//       throw 'Could not launch $whatsappUrl';
//     }
//   }

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

  Future<bool> confirmarExclusao(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Deseja excluir essa venda?"),
          actions: [
            FlatButton(
              child: Text("Sim"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: Text("Não"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
