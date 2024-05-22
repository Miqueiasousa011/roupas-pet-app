import 'package:flutter/material.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';

import '../../../../core/ui/widgets/widgets.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LabelWidget(
              'Nome',
              child: InputWidget.text(
                hintText: 'Digite seu nome',
              ),
            ),
            LabelWidget(
              'Email',
              child: InputWidget.text(
                hintText: 'Digite seu email',
              ),
            ),
            LabelWidget(
              'CEP',
              child: InputWidget.text(
                hintText: 'Digite seu CEP',
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: LabelWidget(
                    'Logradouro',
                    child: InputWidget.text(
                      hintText: 'Digite seu logradouro',
                    ),
                  ),
                ),
                Flexible(
                  child: LabelWidget(
                    'Número',
                    child: InputWidget.text(
                      hintText: 'Digite o número da sua casa',
                    ),
                  ),
                ),
              ],
            ).applySpacing(spacing: 8),
            LabelWidget(
              'Bairro',
              child: InputWidget.text(
                hintText: 'Digite o bairro',
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: LabelWidget(
                    'Cidade',
                    child: InputWidget.text(
                      hintText: 'Digite a cidade',
                    ),
                  ),
                ),
                Flexible(
                  child: LabelWidget(
                    'UF',
                    child: InputWidget.text(
                      hintText: 'Digite a UF',
                    ),
                  ),
                ),
              ],
            ).applySpacing(spacing: 8),
            LabelWidget(
              'Senha',
              child: InputWidget.password(
                hintText: 'Digite sua senha',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Criar Conta'),
            ),
          ],
        ).applySpacing(spacing: 16),
      ),
    );
  }
}
