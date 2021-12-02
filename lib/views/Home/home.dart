import 'package:badydoces/models/venda.model.dart';
import 'package:badydoces/repositories/venda_produto_repository.dart';
import 'package:badydoces/repositories/venda_repository.dart';
import 'package:badydoces/views/Home/widgets/card_latest_sales/card_latest_sales.dart';
import 'package:badydoces/views/auth/AuthController.dart';
import 'package:provider/provider.dart';

import 'package:badydoces/views/Home/widgets/estoque_alerta/estoque_alerta_widget.dart';
import 'package:badydoces/views/Home/widgets/total_vendas_card/total_vendas_card_widget.dart';
import 'package:badydoces/views/components/bottomNaviBar/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/bottomNaviBar/index.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthController>(context, listen: false).autenticar();

    return Scaffold(
      appBar: AppBar(
          actions: [
            ElevatedButton(
              onPressed: () {
                Provider.of<AuthController>(context, listen: false)
                    .logout(context);
              },
              child: Text('Sair'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
            )
          ],
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Consumer<AuthController>(
            builder: (context, value, child) {
              return Text(
                '${value.user.name} - Bady Doces',
                style: GoogleFonts.ubuntu(
                  color: Colors.black,
                ),
              );
            },
          )),
      body: Column(
        children: [
          Container(
            height: 200,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Container(
                  height: 129,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/images/candy.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment(-0.9, -0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        TotalVendasCardWidget(),
                        EstoqueAlertaWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CardLatestSalesWidget(),
                ),
              ],
            ),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: 500,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    padding: EdgeInsets.all(20),
                    onSurface: Colors.black,
                    textStyle: TextStyle(
                      color: Colors.green[200],
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/relatories');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.paste,
                          size: 30,
                        ),
                      ),
                      Text(
                        'Relatório de Produto',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNaviBar(),
    );
  }
}
