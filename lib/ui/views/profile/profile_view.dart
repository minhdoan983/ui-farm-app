import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_farm/resources/resources.dart';
import 'package:ui_farm/ui/ui.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends BasePageState<ProfileView, ProfileBloc> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    bloc.add(const ProfileViewInitiated());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) {
        return previous.isSaveSuccess != current.isSaveSuccess ||
            previous.errorMessage != current.errorMessage;
      },
      listener: (context, state) {
        if (state.isSaveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.current.profileUpdateSuccess), backgroundColor: Colors.brown),
          );
        }
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red));
        }
      },
      buildWhen: (previous, current) {
        return previous.name != current.name ||
            previous.phone != current.phone ||
            previous.email != current.email ||
            previous.avatarUrl != current.avatarUrl ||
            previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        if (_nameController.text != state.name) {
          _nameController.text = state.name;
        }
        if (_phoneController.text != state.phone) {
          _phoneController.text = state.phone;
        }

        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18).copyWith(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: BlocBuilder<ProfileBloc, ProfileState>(
                            buildWhen: (previous, current) {
                              return previous.pickedImage != current.pickedImage ||
                                  previous.avatarUrl != current.avatarUrl;
                            },
                            builder: (context, state) {
                              if (state.pickedImage != null) {
                                return Image.file(File(state.pickedImage!.path), fit: BoxFit.cover);
                              }
                              if (state.avatarUrl.isNotEmpty) {
                                return Image.network(
                                  state.avatarUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      Assets.images.logoJpg.image(fit: BoxFit.cover),
                                );
                              }

                              return Assets.images.logoJpg.image(fit: BoxFit.cover);
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 40,
                        child: GestureDetector(
                          onTap: () => bloc.add(const ProfileAvatarPickPressed()),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.brown,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(CupertinoIcons.pencil_outline, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    state.name.isNotEmpty ? state.name : S.current.profileDefaultName,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                Text(S.current.profileNameLabel),
                const SizedBox(height: 10),
                DashedRRectBorder(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.person),
                      border: InputBorder.none,
                    ),
                    onChanged: (v) => bloc.add(ProfileNameTextFieldChanged(name: v)),
                  ),
                ),
                const SizedBox(height: 10),
                Text(S.current.profileEmailLabel),
                const SizedBox(height: 10),
                DashedRRectBorder(
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F2EE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: TextEditingController(text: state.email),
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(CupertinoIcons.mail),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(S.current.profilePhoneLabel),
                const SizedBox(height: 10),
                DashedRRectBorder(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.phone),
                      border: InputBorder.none,
                    ),
                    onChanged: (v) => bloc.add(ProfilePhoneTextFieldChanged(phone: v)),
                  ),
                ),
                const SizedBox(height: 30),
                if (state.errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () => bloc.add(const ProfileSaveButtonPressed()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: state.isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            S.current.profileSaveButton,
                            style: const TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
