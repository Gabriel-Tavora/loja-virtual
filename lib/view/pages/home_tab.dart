import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _builderBody() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF5B86E5),
                  Color(0xFF9BC6FF),
                ]),
          ),
        );
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND
          _builderBody(),
          // CONTEÚDO
          CustomScrollView(
            slivers: [
              // APP BAR
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  "Principais",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              // FIRESTORE
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("home")
                    .orderBy("posicao")
                    .get(),
                builder: (context, snapshot) {
                  // LOADING
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }

                  // ERRO
                  if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Erro ao carregar dados",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  // DOCUMENTOS
                  final docs = snapshot.data!.docs;

                  // GRID
                  return SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      return Container(
                        height: (data["y"] * 120).toDouble(),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: data["image"],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
