import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  late UserProvider _userProvider;

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorisniciPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: false,
    isRecenzijePressed: false,
    isRezervacijePressed: false,
    isUposleniciPressed: true,
      child: Row(children: [
        Container(
          child: Text("Hello, this is the user screen"),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () async {
              var data = await _userProvider.get();
              print("data: $data");
            },
            child: Text("Data"),
          ),
        )
      ],)
    );
  }
}