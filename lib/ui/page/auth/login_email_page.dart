import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/constant.dart';
import 'package:mesa_news/core/util/dialog_util.dart';
import 'package:mesa_news/core/viewmodel/iauth_viewmodel.dart';
import 'package:mesa_news/ui/custom/mesa_button.dart';
import 'package:mesa_news/ui/custom/mesa_textfield.dart';
import 'package:mesa_news/core/store/keyboard_store.dart';
import 'package:mesa_news/core/extension/widget_extension.dart';
import 'package:mesa_news/ui/view/loading_view.dart';

class LoginEmailPage extends StatefulWidget {
  @override
  _LoginEmailPageState createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _textEditingControllerEmail = TextEditingController();
  final _textEditingControllerPassword = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool isRequesting = false;

  IAuthViewModel _viewModel;

  _appBar() {
    return AppBar(
      leading: CloseButton(),
      title: Text(
        "Entrar com e-mail",
        style: TextStyle(fontSize: 17),
      ),
      centerTitle: true,
    );
  }

  _body() {
    return Observer(
      builder: (_) {
        return Stack(
          children: [
            Container(color: Colors.white),
            _form(),
            GetIt.I<KeyboardStore>().keyboardState ? Container() : _bottom(),
          ],
        ).paddingAll(16);
      },
    );
  }

  _form() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _img(),
              MesaTextField(
                label: 'E-mail',
                hint: 'Digite seu e-mail',
                controller: _textEditingControllerEmail,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                focusNode: _focusEmail,
                nextFocus: _focusPassword,
                validator: (email) => _viewModel.emailValidator(email),
              ),
              SizedBox(height: 10.0),
              MesaTextField(
                label: 'Senha',
                hint: 'Digite sua senha',
                controller: _textEditingControllerPassword,
                password: true,
                icon: Icons.lock,
                focusNode: _focusPassword,
                onFieldSubmitted: _onLoginButtonPressed,
                validator: (password) => _viewModel.passwordValidator(password),
              ),
              isRequesting ? LoadingView(text: "") : MesaButton(
                title: "Login",
                onTap: _onLoginButtonPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onLoginButtonPressed() {
    if(_formKey.currentState.validate()) {

      setState(() => isRequesting = true);

      _viewModel.onLoginDoneButtonPressed(
        email: _textEditingControllerEmail.text,
        password: _textEditingControllerPassword.text,
      ).then((response) {
        setState(() => isRequesting = false);

        if(!response.success) {
          showMessageDialog(context: context, msg: response.msg);
        }
      });
    }
  }

  _img() {
    return Image(
      height: 130.0,
      image: AssetImage('assets/images/register.png'),
      fit: BoxFit.scaleDown,
    ).paddingAll(40);
  }

  _bottom() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MesaButton(
          title: "Entrar com facebook",
          onTap: _viewModel.onFacebookButtonPressed,
          textColor: colorPrimary,
          borderColor: colorPrimary,
          backgroundColor: Colors.white,
        ).paddingTo(bottom: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Não tenho conta. ", style: TextStyle(color: colorPrimary)),
            InkWell(
              onTap: _viewModel.onRegisterButtonPressed,
              child: Text("Cadastrar",
                  style: TextStyle(
                      color: colorLink,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ).paddingAll(8),
      ],
    );
  }

  @override
  void dispose() {
    _textEditingControllerEmail.dispose();
    _textEditingControllerPassword.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _viewModel = GetIt.I<IAuthViewModel>();

    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }
}
