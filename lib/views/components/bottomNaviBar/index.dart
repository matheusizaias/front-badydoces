import 'package:flutter/material.dart';

class BottomNaviBar extends StatefulWidget {
  final int indexTela;

  const BottomNaviBar({Key key, this.indexTela}) : super(key: key);
  @override
  _BottomNaviBarState createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = (widget.indexTela != null) ? widget.indexTela : 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
      if (_selectedIndex == 0) {
        Navigator.of(context).pushNamed('/tela_inicial');
      } else if (_selectedIndex == 1) {
        Navigator.of(context).pushNamed('/nova_venda');
      } else if (_selectedIndex == 2) {
        Navigator.of(context).pushNamed('/estoque');
      } else if (_selectedIndex == 3) {
        Navigator.of(context).pushNamed('/listsales');
      }
    }

    return BottomNavigationBar(
      showUnselectedLabels: true,
      iconSize: 30,
      unselectedItemColor: Colors.grey[800],
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'Nova venda',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store_mall_directory_outlined),
          label: 'Estoque',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Vendas',
          backgroundColor: Colors.white,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
