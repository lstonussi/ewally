import 'package:ewally/app/modules/login/controllers/login_controller.dart';
import 'package:ewally/app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCard extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Obx(
      () => Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: deviceSize.width * 0.75,
          padding: EdgeInsets.all(16),
          child: Form(
            key: controller.form,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Login'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => validatorIsEmpty(value),
                  onSaved: (value) => controller.authData['login'] = value,
                ),
                TextFormField(
                  controller: controller.passController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => validatorPass(value),
                  onSaved: (value) => controller.authData['pass'] = value,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor:
                              Theme.of(context).primaryTextTheme.button.color,
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          child: Text(
                            controller.authMode.value == AuthMode.SignUp
                                ? 'Cadastrar'
                                : 'Entrar',
                          ),
                          onPressed: controller.submit,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
