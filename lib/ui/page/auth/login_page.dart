import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/constant.dart';
import 'package:mesa_news/core/viewmodel/iauth_viewmodel.dart';
import 'package:mesa_news/ui/custom/mesa_button.dart';
import 'package:mesa_news/ui/view/loading_view.dart';

class LoginPage extends StatelessWidget {

  _img() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 116,
            child: Image.asset("assets/images/logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 16,
              child: Image.asset("assets/images/news.png"),
            ),
          ),
        ],
      ),
    );
  }

  _buttons() {
    IAuthViewModel viewModel = GetIt.I<IAuthViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MesaButton(
          title: "Entrar com facebook",
          onTap: viewModel.onFacebookButtonPressed,
          textColor: colorLink,
          backgroundColor: Colors.white,
        ),
        MesaButton(
          title: "Entrar com e-mail",
          onTap: viewModel.onEmailButtonPressed,
        ),
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Não tenho conta. ", style: TextStyle(color: Colors.white)),
              InkWell(
                onTap: viewModel.onRegisterButtonPressed,
                child: Text("Cadastrar",
                    style: TextStyle(
                        color: colorLink, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetIt.I<IAuthViewModel>().checkUserExist(),
        builder: (_, snap) {
          if (!snap.hasData) {
            return Scaffold(
                body: Container(
                    color: colorPrimary,
                    child: LoadingView(
                      text: "",
                      backgroundColor: Colors.white,
                    )));
          }

          return Scaffold(
            body: Stack(
              children: [
                Container(color: colorPrimary),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _img(),
                      _buttons(),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
