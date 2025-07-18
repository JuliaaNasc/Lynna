import 'package:flutter/material.dart';
import 'package:lynna/controller/tema_controller.dart';
import 'package:lynna/controller/carrossel_controller.dart';
import 'package:lynna/controller/opcoes_controller.dart';
import 'package:provider/provider.dart';

class TelaPrincipalScreen extends StatefulWidget {
  const TelaPrincipalScreen({super.key});

  @override
  State<TelaPrincipalScreen> createState() => _TelaPrincipalScreenState();
}

class _TelaPrincipalScreenState extends State<TelaPrincipalScreen> {
  // Controle do menu rodapé
  int _paginaSelecionada = 0;

  final TextEditingController _pesquisaController = TextEditingController();
  final CarrosselController _carrosselController = CarrosselController();
  final OpcoesController _opcoesController = OpcoesController();
  int _indiceSelecionado = 0;

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

  // Lista das páginas para o menu inferior
  List<Widget> get _paginas => [
        _buildConteudoPrincipal(),
        Center(child: Text('Tela 2 - Futuro conteúdo')),
        Center(child: Text('Tela 3 - Futuro conteúdo')),
      ];

  @override
  Widget build(BuildContext context) {
    final temaController = Provider.of<TemaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 8),
            Text(
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
      body: _paginas[_paginaSelecionada],
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Opções',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }

  Widget _buildConteudoPrincipal() {
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
            _buildOpcoesHorizontais(),
            const SizedBox(height: 12),
            _buildQuantidadeInformacoes(),
            const SizedBox(height: 20),
            _buildConteudoSelecionado(),
          ],
        ),
      ),
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

  Widget _buildOpcoesHorizontais() {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_opcoesController.opcoes.length, (index) {
            final opcao = _opcoesController.opcoes[index];
            final selecionado = _indiceSelecionado == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _indiceSelecionado = index;
                });
              },
              child: Container(
                width: 120,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: selecionado
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
                      color: selecionado
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

  Widget _buildQuantidadeInformacoes() {
    final quantidade = _opcoesController
        .subopcoesSelecionadas
        .length; // Subopções da opção selecionada
    return Text(
      'Quantidade de informações: $quantidade',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    );
  }

  Widget _buildConteudoSelecionado() {
    final opcaoPrincipal = _opcoesController.opcoes[_indiceSelecionado];
    _opcoesController.selecionarOpcao(opcaoPrincipal);
    final subopcoes = _opcoesController.subopcoesSelecionadas;

    return Column(
      children: subopcoes.map((sub) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              const Icon(
                Icons.person,
                size: 40,
                color: Colors.pink,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sub['titulo'] ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      sub['descricao'] ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
