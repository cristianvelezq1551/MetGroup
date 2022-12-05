part of '../login_screen.dart';

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  ///The key of the form.
  final _formKey = GlobalKey<FormState>();

  ///The controller of the email text field.
  final TextEditingController _emailController = TextEditingController();

  ///The controller of the password text field.
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: [
            ///The email text field.
            GeneralInput(
              controller: _emailController,
              label: 'Correo electrónico',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su correo electrónico';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            ///The password text field.
            PasswordInput(
              controller: _passwordController,
              label: 'Contraseña',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una contraseña';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            ///The forgot password button.
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text('¿Olvidaste tu contraseña?',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ),

            const SizedBox(height: 20),

            ///The login button.
            Consumer(builder: (context, ref, child) {
              ///The state of the login notifier.
              final isLoading =
                  ref.watch(loginControllerProvider) is LoginLoadingState;

              return GeneralButton(
                text: 'Iniciar sesión',
                isLoading: isLoading,
                onPressed: () {
                  ///If the form is valid.
                  if (_formKey.currentState?.validate() ?? false) {
                    ///Get the login controller.
                    final loginController =
                        ref.read(loginControllerProvider.notifier);

                    ///Call the login method.
                    loginController.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                  }
                },
              );
            }),

            const SizedBox(height: 20),

            ///The register button.
            TextButton(
              onPressed: () async {
                ///Navigate to the register screen.
                ///The result of the navigation is the result of the register.
                ///If the result is true, the user was registered successfully.
                bool? object = await Navigator.of(context)
                    .pushNamed(AppRoutes.register) as bool?;

                ///If the user was registered successfully.
                if (object != null) {
                  ///If the widget is mounted.
                  if (!mounted) return;

                  ///Show a success dialog.
                  AppDialogs.uiSuccessDialog(context,
                      title: 'Registro exitoso',
                      message: 'Se ha registrado correctamente');
                }
              },
              child: Text('¿No tienes una cuenta? Regístrate',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
