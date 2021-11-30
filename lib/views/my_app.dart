import 'package:badydoces/repositories/admin_repository.dart';
import 'package:badydoces/repositories/categoria_repository.dart';
import 'package:badydoces/repositories/produto_repository.dart';
import 'package:badydoces/repositories/venda_produto_repository.dart';
import 'package:badydoces/repositories/venda_repository.dart';
import 'package:badydoces/views/Home/home.dart';
import 'package:badydoces/views/Home/home_controller.dart';
import 'package:badydoces/views/Login/index.dart';
import 'package:badydoces/views/NewSale/new_sale.dart';
import 'package:badydoces/views/NewSale/new_sale_controller.dart';
import 'package:badydoces/views/Stock/form_stock/stock.dart';
import 'package:badydoces/views/auth/AuthController.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'Stock/form_stock/add_products.dart';
import 'Stock/form_stock/edit_products.dart';
import 'components/bottomNaviBar/ListSale/info_sales.dart';
import 'components/bottomNaviBar/ListSale/listSales.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>.value(
          value: AuthController(),
        ),
        ChangeNotifierProvider<HomeController>.value(value: HomeController()),
        ChangeNotifierProvider(
          create: (context) => NewSaleController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => SaleProductRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => SaleRepository(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.grey,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Login(),
          '/tela_inicial': (context) => Home(),
          '/nova_venda': (context) => NewSale(),
          '/estoque': (context) => Stock(),
          '/add_product': (context) => AddProduct(),
          '/edit_product': (context) => EditProduct(),
          '/listsales': (context) => ListSales(),
          '/infosales': (context) => InfoSales(),
        },
        initialRoute: '/',
      ),
    );
  }
}
