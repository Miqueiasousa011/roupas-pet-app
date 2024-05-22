import 'package:flutter/material.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/ui/styles/styles.dart';
import 'package:roupaspet/src/core/ui/widgets/widgets.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppIcons.logo,
            height: 100,
          ),
          Text(
            'Roupas Pet',
            textAlign: TextAlign.center,
            style: context.textTheme.headlineSmall?.copyWith(
              color: context.colors.main,
            ),
          ).margin(const EdgeInsets.only(bottom: 16)),
          LabelWidget(
            'Email',
            child: InputWidget.text(
              hintText: 'Digite seu email',
            ),
          ),
          LabelWidget(
            'Senha',
            child: InputWidget.password(
              hintText: 'Digite sua senha',
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Entrar')),
          OutlinedButton(onPressed: () {}, child: const Text('Criar Conta'))
        ],
      ).applySpacing(spacing: 16).margin(const EdgeInsets.all(24)),
    );
  }
}
