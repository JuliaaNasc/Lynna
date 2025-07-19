import 'package:flutter/material.dart';
import 'package:lynna/controller/tema_controller.dart';
import 'package:lynna/controller/carrossel_controller.dart';
import 'package:lynna/controller/opcoes_controller.dart';
import 'package:provider/provider.dart';


class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  int _paginaSelecionada = 0;
  final TextEditingController _pesquisaController = TextEditingController();
  final CarrosselController _carrosselController = CarrosselController();
  int _indiceSelecionado = 0;
  final Set<String> _favoritos = {};

  @override
  void initState() {
    super.initState();
    _carrosselController.iniciarCarrossel(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _pesquisaController.dispose();
    _carrosselController.dispose();
    super.dispose();
  }

  List<Widget> _paginas(OpcoesController opcoesController) => [
    _buildConteudoPrincipal(opcoesController),
    _buildTelaFavoritos(),
    const Center(child: Text('Tela 3 - Futuro conteúdo')),
  ];

  @override
  Widget build(BuildContext context) {
    final temaController = Provider.of<TemaController>(context);
    final opcoesController = Provider.of<OpcoesController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo_icone_lynna.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text(
              'Bem-Vindo à Lynna',
              style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Switch(
                value: temaController.temaEscuro,
                onChanged: (_) => temaController.alternarTema(),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),
      body: _paginas(opcoesController)[_paginaSelecionada],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaSelecionada,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _paginaSelecionada = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }

  Widget _buildConteudoPrincipal(OpcoesController opcoesController) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCampoDePesquisa(),
            const SizedBox(height: 16),
            _buildCarrosselDeImagens(),
            const SizedBox(height: 16),
            const Text(
              'Selecione a sua opção para explorar:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildOpcoesHorizontais(opcoesController),
            const SizedBox(height: 12),
            _buildQuantidadeInformacoes(opcoesController),
            const SizedBox(height: 20),
            _buildConteudoSelecionado(opcoesController),
          ],
        ),
      ),
    );
  }

  Widget _buildTelaFavoritos() {
    if (_favoritos.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Você ainda não adicionou favoritos.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children:
          _favoritos
              .map(
                (titulo) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.pink),
                    title: Text(
                      titulo,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.pink),
                      onPressed: () {
                        setState(() {
                          _favoritos.remove(titulo);
                        });
                      },
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildCampoDePesquisa() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _pesquisaController,
            decoration: const InputDecoration(
              hintText: 'Pesquisar...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            final texto = _pesquisaController.text;
            print('Pesquisando por: $texto');
          },
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
          child: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _buildCarrosselDeImagens() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _carrosselController.pageController,
        itemCount: _carrosselController.imagens.length,
        itemBuilder: (context, index) {
          return _buildItemCarrossel(_carrosselController.imagens[index]);
        },
      ),
    );
  }

  Widget _buildItemCarrossel(String caminhoImagem) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        caminhoImagem,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }

  Widget _buildOpcoesHorizontais(OpcoesController opcoesController) {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(opcoesController.opcoes.length, (index) {
            final opcao = opcoesController.opcoes[index];
            final selecionado = _indiceSelecionado == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _indiceSelecionado = index;
                  opcoesController.selecionarOpcao(opcao);
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 120,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      selecionado
                          ? Colors.pinkAccent
                          : const Color.fromARGB(255, 255, 197, 216),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink),
                ),
                child: Center(
                  child: Text(
                    opcao,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          selecionado
                              ? Colors.white
                              : Theme.of(context).brightness == Brightness.dark
                              ? Colors.pink
                              : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildQuantidadeInformacoes(OpcoesController opcoesController) {
    final quantidade = opcoesController.subopcoesSelecionadas.length;
    return Text(
      'Quantidade de informações: $quantidade',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
      ),
    );
  }

  // Componente clicável para as opções detalhadas
  Widget _buildConteudoSelecionado(OpcoesController opcoesController) {
    final subopcoes = opcoesController.subopcoesSelecionadas;

    return Column(
      children:
          subopcoes.map((sub) {
            final titulo = sub['titulo'] ?? '';
            final descricao = sub['descricao'] ?? '';
            final favorito = _favoritos.contains(titulo);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => DetalheScreen(
                          titulo: 'A Lynna está $titulo',
                          descricao: descricao,
                        ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.home_rounded,
                      size: 40,
                      color: Colors.pink,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titulo,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(descricao, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        favorito ? Icons.favorite : Icons.favorite_border,
                        color: Colors.pink,
                      ),
                      onPressed: () {
                        setState(() {
                          if (favorito) {
                            _favoritos.remove(titulo);
                          } else {
                            _favoritos.add(titulo);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}

// Nova tela para mostrar detalhes ao clicar numa opção
class DetalheScreen extends StatelessWidget {
  final String titulo;
  final String descricao;

  const DetalheScreen({
    super.key,
    required this.titulo,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(descricao, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
