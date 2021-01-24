import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/constant.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
import 'package:mesa_news/core/viewmodel/ifilter_viewmodel.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  IFilterViewModel _viewModel;

  _appBar() {
    return AppBar(
      title: Text("Filtros"),
      leading: InkWell(
          onTap: () => navigatePop(),
          child: Icon(
            Icons.arrow_back_ios,
            color: colorLink,
          )),
      centerTitle: true,
      actions: [
        FlatButton(
            onPressed: () {
              _viewModel.onIsFavoriteChanged(false);
              _viewModel.onItemMenuSelected(0, isToPopDialog: false);
            },
            child: Text(
              "Limpar",
              style: TextStyle(color: colorLink, fontSize: 17),
            )),
      ],
    );
  }

  _body() {
    return Observer(builder: (_) {
      return Column(
        children: [
          InkWell(
            onTap: () => _showDateMenu(),
            child: ListTile(
              title: Text(
                "Data",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _viewModel.dateSelected,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.black),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.navigate_next)
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () => _viewModel.onIsFavoriteChanged(!_viewModel.isFavorite),
            child: ListTile(
              title: Text(
                "Apenas favoritos",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              trailing: Switch(
                  value: _viewModel.isFavorite,
                  onChanged: (value) {
                    _viewModel.onIsFavoriteChanged(value);
                  }),
            ),
          ),
          Divider(),
        ],
      );
    });
  }

  Future<void> _showDateMenu() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escolha uma opção:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _viewModel.getDateItems(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = GetIt.I<IFilterViewModel>();

    return Scaffold(appBar: _appBar(), body: _body());
  }
}
