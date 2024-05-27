import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/mixins/utils_mixin.dart';
import 'package:roupaspet/src/core/mixins/validators_mixin.dart';
import 'package:roupaspet/src/features/auth/controllers/state/auth_state.dart';

import '../../../../core/ui/widgets/widgets.dart';
import '../../../../core/utils/formatters.dart';
import '../../controllers/add_account/add_account_cubit.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({super.key});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> with UtilsMixin, ValidatorsMixin {
  late AddAccountCubit _cubit;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _cubit = Modular.get<AddAccountCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    Modular.dispose<AddAccountCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: BlocListener<AddAccountCubit, AuthState>(
        bloc: _cubit,
        listener: (cxt, state) {
          if (state is AuthLoading) {
            showLoading();
          } else {
            removeLoading();
          }

          if (state is AuthError) {
            showErrorSnackbar(state.message);
          }

          if (state is AuthSuccess) {
            Navigator.of(context).pop();
            showSuccessSnackbar('Conta criada com sucesso!');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LabelWidget(
                  'Nome',
                  child: InputWidget.text(
                    controller: InputController.text(_cubit.params.name),
                    hintText: 'Digite seu nome',
                    validator: requiredValidator,
                    onChanged: (value) {
                      _cubit.params.name = value;
                    },
                  ),
                ),
                LabelWidget(
                  'Email',
                  child: InputWidget.text(
                    controller: InputController.text(_cubit.params.email),
                    hintText: 'Digite seu email',
                    validator: emailValidator,
                    onChanged: (value) {
                      _cubit.params.email = value;
                    },
                  ),
                ),
                LabelWidget(
                  'CEP',
                  child: InputWidget.text(
                    controller: InputController.text(_cubit.params.zipcode),
                    hintText: 'Digite seu CEP',
                    validator: requiredValidator,
                    formatters: [cepMask],
                    onChanged: (value) {
                      _cubit.params.zipcode = value;
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: LabelWidget(
                        'Logradouro',
                        child: InputWidget.text(
                          controller: InputController.text(_cubit.params.street),
                          hintText: 'Digite seu logradouro',
                          validator: requiredValidator,
                          onChanged: (value) {
                            _cubit.params.street = value;
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: LabelWidget(
                        'Número',
                        child: InputWidget.text(
                          controller: InputController.text(_cubit.params.houseNumber),
                          hintText: 'Digite o número da sua casa',
                          onChanged: (value) {
                            _cubit.params.houseNumber = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ).applySpacing(spacing: 8),
                LabelWidget(
                  'Bairro',
                  child: InputWidget.text(
                    controller: InputController.text(_cubit.params.neighborhood),
                    hintText: 'Digite o bairro',
                    validator: requiredValidator,
                    onChanged: (value) {
                      _cubit.params.neighborhood = value;
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: LabelWidget(
                        'Cidade',
                        child: InputWidget.text(
                          controller: InputController.text(_cubit.params.city),
                          hintText: 'Digite a cidade',
                          validator: requiredValidator,
                          onChanged: (value) {
                            _cubit.params.city = value;
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: LabelWidget(
                        'UF',
                        child: InputWidget.text(
                          controller: InputController.text(_cubit.params.state),
                          hintText: 'Digite a UF',
                          validator: requiredValidator,
                          onChanged: (value) {
                            _cubit.params.state = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ).applySpacing(spacing: 8),
                LabelWidget(
                  'Senha',
                  child: InputWidget.password(
                    controller: InputController.text(_cubit.params.password),
                    hintText: 'Digite sua senha',
                    validator: passwordValidator,
                    onChanged: (value) {
                      _cubit.params.password = value;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _cubit.addAccount();
                    }
                  },
                  child: const Text('Criar Conta'),
                ),
                const SizedBox(height: 16),
              ],
            ).applySpacing(spacing: 16),
          ),
        ),
      ),
    );
  }
}
