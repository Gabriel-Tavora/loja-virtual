import 'package:flutter/material.dart';
import 'package:lojavirtual/controller/tiles/drawer_page_tile.dart';
import 'package:lojavirtual/informations/users/user_type.dart';
import 'package:lojavirtual/models/widgets/builderbody.dart';
import 'package:lojavirtual/view/pages/login.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer(this.pageController, {super.key});
  final PageController pageController;
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final hora = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          BuilderBody(
              color1: Colors.cyan.shade100, color2: Colors.cyan.shade50),
          ListView(
            padding: EdgeInsets.only(left: 25, top: 16),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 9),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                      top: 12,
                      left: 0,
                      child: Text(
                        '${hora.hour}:${hora.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    positioned(),
                    Consumer<UserType>(
                      builder: (context, user, child) {
                        return Stack(
                          children: [
                            Positioned(
                              bottom: 18,
                              left: 0,
                              child: Text(
                                user.isLoggedIn
                                    ? "OLÁ, ${user.userData["name"] ?? ""}"
                                    : "OLÁ,",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: GestureDetector(
                                onTap: () {
                                  if (!user.isLoggedIn) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => LoginScreen(),
                                      ),
                                    );
                                  } else {
                                    user.signOut();
                                  }
                                },
                                child: Text(
                                  user.isLoggedOut
                                      ? "Entre ou Cadastre-se ->"
                                      : "Sair",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", widget.pageController, 0),
              DrawerTile(Icons.list, "Produtos", widget.pageController, 1),
              DrawerTile(Icons.location_on, "Loja", widget.pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos",
                  widget.pageController, 3),
            ],
          )
        ],
      ),
    );
  }

  Positioned positioned() {
    return Positioned(
      top: 40,
      left: 0,
      child: Text(
        "MENU",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
