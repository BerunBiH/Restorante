import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late UserProvider _userProvider;
  bool _isLoading = true;
  late User user;

  @override
  void initState() {
    super.initState();

    _userProvider = context.read<UserProvider>();
    _loadData();
  }

Future<void> _loadData() async {
  var data = await _userProvider.getById(Info.id!);
  setState(() {
    user = data;
    _isLoading = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorisniciPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: true,
    isRecenzijePressed: false,
    isRezervacijePressed: false,
    isUposleniciPressed: false,
      child: (_isLoading) ?
      Center(child: CircularProgressIndicator()):
       _settingsPageBuilder(),
      );
  }
  
 Scaffold _settingsPageBuilder() {
    return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: Info.image !=""
                ? imageFromBase64String(Info.image!).image
                : AssetImage('assets/images/RestoranteProfilePicturePlaceholder.png') as ImageProvider,
              ),
              Positioned(
                bottom: 0,
                right: 0, 
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    
                  },
                  child: Icon(Icons.camera_alt), 
                ),
              ),
            ],
            ),
          SizedBox(height: 30),
          Card(
            elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purpleAccent),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              '${user.userName} ${user.userSurname}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Ime i prezime',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purpleAccent),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              Authorization.email!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Email',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purpleAccent),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              user.userPhone!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Telefon',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purpleAccent),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              user.userRoles![0].role!.roleName!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Uloga',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          ]
        )
      )
          ),
        ],
      ),
    ),
    );
  }
}