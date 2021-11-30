import 'package:badydoces/models/categoria.model.dart';
import 'package:badydoces/models/produto.model.dart';
import 'package:badydoces/repositories/categoria_repository.dart';
import 'package:badydoces/repositories/produto_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FormNewProductWidget extends StatefulWidget {
  @override
  _FormNewProductWidgetState createState() => _FormNewProductWidgetState();
}

class _FormNewProductWidgetState extends State<FormNewProductWidget> {
  Categoria itemSelecionado;

  @override
  Widget build(BuildContext context) {
    var repository = Provider.of<CategoryRepository>(context, listen: true);
    var repositoryP = Provider.of<ProductRepository>(context, listen: true);
    var categorias = repository.categorias;
    final _formKey = GlobalKey<FormState>();

    var product = Product();

    Future<bool> confirmarAdd(BuildContext context) async {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("Produto cadastrado!"),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () => Navigator.of(context).pushNamed('/estoque'),
              ),
              FlatButton(
                child: Text("Mais"),
                onPressed: () =>
                    Navigator.of(context).pushNamed('/add_product'),
              ),
            ],
          );
        },
      );
    }

    Future<void> onSave(
        BuildContext context, ProductRepository repositoryP) async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        product.name_category = itemSelecionado.category_name;
        if (await repositoryP.create(product)) {
          confirmarAdd(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Falha no cadastro"),
            ),
          );
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: dropDownCAtegoria(categorias),
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                enabled: (itemSelecionado == null) ? false : true,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Color(0xFF4360F6)),
                    labelText: 'Digite o nome do produto',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF4360F6), width: 2.0),
                    )),

                // The validator receives the text that the user has entered.
                onSaved: (value) => product.name = value,
                validator: (value) =>
                    value.isEmpty ? "Campo obrigatório" : null,
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
                      enabled: (itemSelecionado == null) ? false : true,
                      decoration: InputDecoration(
                          labelText: 'Digite o preço',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF4360F6), width: 2.0),
                          )),

                      // The validator receives the text that the user has entered.
                      onSaved: (value) => product.price = (value),

                      validator: (value) =>
                          value.isEmpty ? "Campo obrigatório" : null,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 16, left: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      enabled: (itemSelecionado == null) ? false : true,
                      decoration: InputDecoration(
                          labelText: 'Qtd',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF4360F6), width: 2.0),
                          )),

                      // The validator receives the text that the user has entered.

                      onSaved: (value) => product.amount = int.parse(value),
                      validator: (value) =>
                          value.isEmpty ? "Campo obrigatório" : null,
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  onSurface: Colors.black,
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Icon(Icons.add_circle),
                    ),
                    Text('Adicionar Produto'),
                  ],
                ),
                onPressed: () => onSave(context, repositoryP),
              ),
            ),
          ],
        ),
      ),
    );
  }

//------------------------------------------------------------------------------------
  Container dropDownCAtegoria(List<Categoria> categorias) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.fromBorderSide(
            BorderSide(color: Color(0xFF4360F6), width: 2.0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: (itemSelecionado == null)
              ? itemSelecionado
              : itemSelecionado.category_name,
          hint: Text(
            'Selecione a categoria',
            style: GoogleFonts.ubuntu(
              color: Colors.black,
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            size: 30,
          ),
          isExpanded: true,
          style: TextStyle(color: Colors.black, fontSize: 16),
          items: categorias.map<DropdownMenuItem<String>>((Categoria value) {
            return DropdownMenuItem<String>(
              value: value.category_name,
              child: Text(value.category_name),
            );
          }).toList(),
          onChanged: (var newValue) {
            setState(() {
              itemSelecionado =
                  categorias.firstWhere((cat) => cat.category_name == newValue);
            });
          },
        ),
      ),
    );
  }
}
