import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vitrine_carros/models/carro.dart';
import 'package:vitrine_carros/models/user.dart';
import 'package:vitrine_carros/repositories/api_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<User?>? _currentUser;
  final input = TextEditingController();
  List<Carro> allCarros = [];
  List<Carro> filteredCarros = [];

  @override
  void initState() {
    super.initState();
    _currentUser = context.read<ApiRepositoryImpl>().fetchCurrentUser();
    _fetchCars();
  }

  _fetchCars() async {
    allCarros = await context.read<ApiRepositoryImpl>().getCarros();
    setState(() {
      filteredCarros = List.from(allCarros);
    });
  }

  formatCurrency(String currency) {
    final numberFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    double currencyValue = double.tryParse(currency) ?? 0.0;
    final formattedString = numberFormat.format(currencyValue);
    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          height: 40,
          color: Colors.white,
          child: Image.asset(
            "assets/VitrineCarros.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
      drawer: Drawer(
        child: FutureBuilder<User?>(
          future: _currentUser,
          builder: (context, snapshot) {
            final nav = Navigator.of(context);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final user = snapshot.data;
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 48.0, horizontal: 36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user?.nome ?? "Sem nome"),
                    Text(user?.email ?? "Sem email"),
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () async {
                        await context.read<ApiRepositoryImpl>().removeTokens();
                        nav.popAndPushNamed("/");
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ))
                  ],
                ),
              );
            } else {
              return const Text('Sem dados');
            }
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: input,
                decoration: const InputDecoration(
                  hintText: "Digite o modelo desejado",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  fillColor: Colors.grey,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
                onChanged: (value) {
                  setState(() {
                    filteredCarros = allCarros.where((carro) {
                      return carro.modelo
                          .toLowerCase()
                          .contains(value.toLowerCase());
                    }).toList();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: filteredCarros.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple.withOpacity(.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Image.network(
                                  filteredCarros[index].imagemUrl,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${filteredCarros[index].marca} ${filteredCarros[index].modelo} - ${formatCurrency(filteredCarros[index].preco)}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${filteredCarros[index].ano} - ${filteredCarros[index].descricao}',
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
