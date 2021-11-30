import 'package:badydoces/views/Home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalVendasCardWidget extends StatelessWidget {
  const TotalVendasCardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeController>(context, listen: false).allSales();
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[800],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.grey,
              offset: Offset(1, 4),
            ),
          ]),
      width: 220,
      height: 126,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Total de Vendas',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<HomeController>(
                  builder: (context, value, child) {
                    if (value.sales != null) {
                      double totalVendas = 0.0;
                      value.sales.forEach((element) {
                        totalVendas += double.tryParse(
                                element.value.replaceAll(new RegExp(r'\$'), ''))
                            .toDouble();
                      });
                      String totalVendasString = totalVendas.toStringAsFixed(2);

                      return Text(
                        "R\$${totalVendasString.replaceAll('\.', ',')}",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      );
                    }
                    return Text(
                      "R\$ 0.00",
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
