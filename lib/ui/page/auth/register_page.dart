import 'package:flutter/material.dart';
import 'package:mesa_news/core/util/dialog_util.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
import 'package:mesa_news/core/viewmodel/auth_viewmodel.dart';
import 'package:mesa_news/locator.dart';
import 'package:mesa_news/ui/custom/mesa_button.dart';
import 'package:mesa_news/ui/custom/mesa_textfield.dart';
import 'package:mesa_news/core/extension/widget_extension.dart';
import 'package:mesa_news/ui/view/loading_view.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _textEditingControllerName = TextEditingController();
  final _textEditingControllerEmail = TextEditingController();
  final _textEditingControllerPassword = TextEditingController();
  final _textEditingControllerPasswordConfirm = TextEditingController();
  final _textEditingControllerBirthday = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusPasswordConfirm = FocusNode();
  final _focusBirthday = FocusNode();

  bool isRequesting = false;

  AuthViewModel _viewModel;

  _appBar() {
    return AppBar(
      leading: CloseButton(),
      title: Text(
        "Cadastrar",
        style: TextStyle(fontSize: 17),
      ),
      centerTitle: true,
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
              MesaTextField(
                label: 'Name',
                controller: _textEditingControllerName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                focusNode: _focusName,
                nextFocus: _focusEmail,
                validator: (name) => _viewModel.registerNameValidator(name),
              ).paddingTo(bottom: 10),
              MesaTextField(
                label: 'E-mail',
                controller: _textEditingControllerEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                focusNode: _focusEmail,
                nextFocus: _focusPassword,
                validator: (email) => _viewModel.emailValidator(email),
              ).paddingTo(bottom: 10),
              MesaTextField(
                label: 'Senha',
                controller: _textEditingControllerPassword,
                password: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                focusNode: _focusPassword,
                nextFocus: _focusPasswordConfirm,
                validator: (password) =>
                    _viewModel.registerPasswordValidator(password),
              ).paddingTo(bottom: 10),
              MesaTextField(
                label: 'Confirmar senha',
                controller: _textEditingControllerPasswordConfirm,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                password: true,
                focusNode: _focusPasswordConfirm,
                nextFocus: _focusBirthday,
                validator: (password) =>
                    _viewModel.registerConfirmPasswordValidator(
                        password, _textEditingControllerPassword.text),
              ).paddingTo(bottom: 10),
              MesaTextField(
                label: 'Data de nascimento - Opcional',
                controller: _textEditingControllerBirthday,
                focusNode: _focusBirthday,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: _onRegisterButtonPressed,
              ),
              isRequesting
                  ? LoadingView(text: "")
                  : MesaButton(
                      title: "Cadastrar",
                      onTap: _onRegisterButtonPressed,
                    ),
            ],
          ),
        ),
      ),
    ).paddingAll(16);
  }

  _onRegisterButtonPressed() {
    if (_formKey.currentState.validate()) {
      setState(() => isRequesting = true);

      _viewModel
          .onRegisterDoneButtonPressed(
              name: _textEditingControllerName.text,
              email: _textEditingControllerEmail.text,
              password: _textEditingControllerPassword.text,
              birthday: _textEditingControllerBirthday.text)
          .then((response) {
        setState(() => isRequesting = false);

        if (response.success) {
          showMessageDialog(
                  context: context, msg: "Cadastro realizado com sucesso!")
              .then((value) => navigatePop());
        } else {
          showMessageDialog(context: context, msg: response.msg);
        }
      });
    }
  }

  @override
  void dispose() {
    _textEditingControllerName.dispose();
    _textEditingControllerEmail.dispose();
    _textEditingControllerPassword.dispose();
    _textEditingControllerPasswordConfirm.dispose();
    _textEditingControllerBirthday.dispose();
    _focusName.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
    _focusPasswordConfirm.dispose();
    _focusBirthday.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = getServiceLocator<AuthViewModel>();

    return Scaffold(
      appBar: _appBar(),
      body: _form(),
    );
  }
}
