part of '../register_screen.dart';

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  ///The form key.
  final _formKey = GlobalKey<FormState>();

  ///The controller of the email text field.
  final TextEditingController _emailController = TextEditingController();

  ///The controller of the password text field.
  final TextEditingController _passwordController = TextEditingController();

  ///The controller of the confirm password text field.
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
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
                return 'Por favor ingrese su contraseña';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          ///The confirm password text field.
          PasswordInput(
            controller: _confirmPasswordController,
            label: 'Confirmar contraseña',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor confirme su contraseña';
              }

              if (value != _passwordController.text) {
                return 'Las contraseñas no coinciden';
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          ///The register button.
          Consumer(builder: (context, ref, child) {
            ///The state of the login notifier.
            final isLoading =
                ref.watch(registerControllerProvider) is RegisterLoadingState;

            return GeneralButton(
              text: 'Crear cuenta',
              isLoading: isLoading,
              onPressed: () {
                ///If the form is valid.
                if (_formKey.currentState?.validate() ?? false) {
                  ///Get the login controller.
                  final registerController =
                      ref.read(registerControllerProvider.notifier);

                  ///Call the register method.
                  registerController.registerWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
