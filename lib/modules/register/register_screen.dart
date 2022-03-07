import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, state) {
          if(state is RegisterSuccessState){
            if(state.loginModel.status!){
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                navigateAndFinish(context, LoginScreen());
              });
            }
            else{
              showToast(
                message: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please enter your name';
                            }
                            else if(value.length < 8){
                              return 'name must be more than 8 characters';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please enter your email address';
                            }
                            else if(!RegisterCubit.get(context).legalEmail(emailController.text)){
                              return 'enter valid email';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: RegisterCubit.get(context).isPassword,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please enter your password';
                            }
                            else if(value.length < 9){
                              return 'Password must be more than 9 numbers';
                            }
                            return null;
                          },
                          label: 'Password',
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: (){
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          prefix: Icons.lock,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: confirmController,
                          type: TextInputType.visiblePassword,
                          isPassword: RegisterCubit.get(context).isConfirmPassword,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please enter your password';
                            }
                            else if(value != passwordController.text){
                              return 'Confirm password is wrong';
                            }
                            return null;
                          },
                          label: 'Confirm Password',
                          suffix: RegisterCubit.get(context).confirmSuffix,
                          suffixPressed: (){
                            RegisterCubit.get(context).changeConfirmPasswordVisibility();
                          },
                          prefix: Icons.lock,
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),

                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please enter your phone';
                            }
                            else if(value.length < 11){
                              return 'Phone must be not less than 11 numbers';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (BuildContext context) => defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                          ),
                          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
