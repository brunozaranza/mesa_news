import 'package:flutter/material.dart';
import 'package:mesa_news/core/constant.dart';
import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/user.dart';
import 'package:mesa_news/core/util/dialog_util.dart';
import 'package:mesa_news/core/viewmodel/auth_viewmodel.dart';
import 'package:mesa_news/locator.dart';
import 'package:mesa_news/ui/custom/mesa_button.dart';
import 'package:mesa_news/ui/view/loading_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthViewModel _viewModel;
  bool isFacebookLoading = false;

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

  _onFacebookButtonPressed() async {
    setState(() => isFacebookLoading = true);
    ApiResponse<User> response = await _viewModel.onFacebookButtonPressed();
    if (!response.success) {
      if (response.msg.isNotEmpty)
        showMessageDialog(context: context, msg: response.msg);
    }
    setState(() => isFacebookLoading = false);
  }

  _buttons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        isFacebookLoading ? LoadingView(backgroundColor: Colors.white,) : MesaButton(
          title: "Entrar com facebook",
          onTap: () => _onFacebookButtonPressed(),
          textColor: colorLink,
          backgroundColor: Colors.white,
        ),
        MesaButton(
          title: "Entrar com e-mail",
          onTap: _viewModel.onEmailButtonPressed,
        ),
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Não tenho conta. ", style: TextStyle(color: Colors.white)),
              InkWell(
                onTap: _viewModel.onRegisterButtonPressed,
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
    _viewModel = getServiceLocator<AuthViewModel>();

    return FutureBuilder(
        future: _viewModel.checkUserExist(),
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
