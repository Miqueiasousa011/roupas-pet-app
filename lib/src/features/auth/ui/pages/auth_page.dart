import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/ui/styles/styles.dart';
import 'package:roupaspet/src/core/ui/widgets/widgets.dart';
import 'package:roupaspet/src/features/auth/controllers/login/login_cubit.dart';

import '../../../../app_paths.dart';
import '../../../../core/mixins/utils_mixin.dart';
import '../../../../core/mixins/validators_mixin.dart';
import '../../controllers/state/auth_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with UtilsMixin, ValidatorsMixin {
  late LoginCubit _cubit;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _cubit = Modular.get<LoginCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    Modular.dispose<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, AuthState>(
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
            Modular.to.navigate(paths.home);
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
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
                  validator: emailValidator,
                  onChanged: (value) => _cubit.email = value,
                ),
              ),
              LabelWidget(
                'Senha',
                child: InputWidget.password(
                  hintText: 'Digite sua senha',
                  onChanged: (value) => _cubit.password = value,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _cubit.loginWithCredentials();
                  }
                },
                child: const Text('Entrar'),
              ),
              OutlinedButton(
                onPressed: () => Modular.to.pushNamed(paths.createAccount),
                child: const Text('Criar Conta'),
              )
            ],
          ).applySpacing(spacing: 16).margin(const EdgeInsets.all(24)),
        ),
      ),
    );
  }
}
