import 'package:badydoces/models/venda.model.dart';
import 'package:badydoces/repositories/venda_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CardLatestSalesWidget extends StatelessWidget {
  final Sale items;

  const CardLatestSalesWidget({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Color.fromARGB(500, 243, 210, 221),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '--------- Última venda realizada ---------',
                  style: GoogleFonts.ubuntu(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<SaleRepository>(builder: (context, saleRepo, child) {
                  if (saleRepo.sales.length < 1) {
                    return CircularProgressIndicator();
                  }
                  List<Widget> items = [];
                  saleRepo.sales.forEach((e) {
                    items.add(Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.grey,
                              offset: Offset(1, 4),
                            ),
                          ]),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 20,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Cliente: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: '${e.costumer}')
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 20,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Data da venda: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(
                                        DateTime.tryParse(e.createdAt),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 20,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Valor total: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: 'R${e.value}')
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ));
                  });
                  return items[0];
                }),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 280,
                  child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/listsales');
                      },
                      child: Text(
                        'Ver todas as vendas',
                        style: GoogleFonts.ubuntu(
                          fontSize: 20,
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
