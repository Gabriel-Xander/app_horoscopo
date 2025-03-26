import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<Map<String, String>> signos = [
  {
    'nome': 'Áries',
    'descricao':
        'Hoje você vai se sentir cheio de energia e motivação para iniciar novos projetos. Aproveite essa força para resolver pendências e tomar atitudes que estavam sendo adiadas. Apenas lembre-se de respirar antes de agir impulsivamente.'
  },
  {
    'nome': 'Touro',
    'descricao':
        'Hoje é um bom dia para questões financeiras e estabilidade emocional. Sua determinação pode render bons frutos. Não se esqueça de cuidar de si mesmo e aproveitar momentos de prazer com tranquilidade.'
  },
  {
    'nome': 'Gêmeos',
    'descricao':
        'Mantenha a mente aberta, pois boas ideias podem surgir de conversas inesperadas. Sua habilidade de se comunicar será essencial para resolver conflitos e se aproximar de pessoas importantes.'
  },
  {
    'nome': 'Câncer',
    'descricao':
        'Seu lado emocional estará em evidência hoje, e isso pode trazer mais empatia às suas relações. Cuide da sua casa, família e das pessoas próximas. Um gesto de carinho pode transformar o dia de alguém.'
  },
  {
    'nome': 'Leão',
    'descricao':
        'Hora de brilhar e expressar confiança em tudo que faz. Seu magnetismo estará em alta, favorecendo conquistas pessoais e profissionais. Aproveite, mas lembre-se de ouvir os outros com atenção.'
  },
  {
    'nome': 'Virgem',
    'descricao':
        'Um dia propício para organização e planejamento. Tarefas que exigem foco e lógica serão realizadas com sucesso. Aproveite para cuidar da saúde e colocar a rotina em ordem.'
  },
  {
    'nome': 'Libra',
    'descricao':
        'Busque harmonia e equilíbrio em todas as áreas da sua vida. Evite decisões impulsivas e foque no que realmente te faz bem. Relacionamentos estarão em destaque – valorize o diálogo.'
  },
  {
    'nome': 'Escorpião',
    'descricao':
        'Dia de intensidade e transformação. Emoções profundas podem vir à tona e te ajudar a se libertar de velhos padrões. Confie na sua intuição e siga o que sente com verdade.'
  },
  {
    'nome': 'Sagitário',
    'descricao':
        'Aventure-se e expanda seus horizontes. Conhecimento, viagens e experiências novas estão favorecidos. Compartilhar o que você aprende pode inspirar outras pessoas ao seu redor.'
  },
  {
    'nome': 'Capricórnio',
    'descricao':
        'Foco e determinação para seus objetivos marcam este dia. A dedicação será recompensada, mas lembre-se de equilibrar trabalho e descanso. Confie no seu caminho e continue firme.'
  },
  {
    'nome': 'Aquário',
    'descricao':
        'Dia de inovação e ideias criativas. Sua mente está afiada e pronta para enxergar soluções fora do comum. Conecte-se com pessoas que compartilham sua visão de futuro.'
  },
  {
    'nome': 'Peixes',
    'descricao':
        'Sensibilidade e inspiração marcam o dia. Deixe a intuição te guiar e permita-se sonhar um pouco mais. Momentos de introspecção e arte podem trazer clareza para decisões importantes.'
  },
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horóscopo do Dia',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const HoroscopoHomePage(),
    );
  }
}

class HoroscopoHomePage extends StatefulWidget {
  const HoroscopoHomePage({super.key});

  @override
  State<HoroscopoHomePage> createState() => _HoroscopoHomePageState();
}

class _HoroscopoHomePageState extends State<HoroscopoHomePage> {
  String? horoscopoDoDia;
  String? signoSelecionado;

  @override
  void initState() {
    super.initState();
    _initFirebaseMessaging();
    _gerarHoroscopoDoDia();
  }

  void _gerarHoroscopoDoDia() {
    final hoje = DateTime.now();
    final indice = hoje.day % signos.length;
    setState(() {
      signoSelecionado = signos[indice]['nome'];
      horoscopoDoDia = signos[indice]['descricao'];
    });
  }

  void _initFirebaseMessaging() {
    FirebaseMessaging.instance.getToken().then((token) {
      print('Token do dispositivo: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Mensagem recebida: ${message.messageId}');
      if (message.notification != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message.notification!.body ?? ''),
            backgroundColor: Colors.deepPurple,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB388FF), Color(0xFF8C9EFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Horóscopo do Dia'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            if (horoscopoDoDia != null && signoSelecionado != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Horóscopo do Dia - $signoSelecionado',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          horoscopoDoDia!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: signos.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.white.withOpacity(0.9),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple.shade100,
                        child: Text(
                          signos[index]['nome']![0],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        signos[index]['nome']!,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SignoDetalhePage(
                              nomeSigno: signos[index]['nome']!,
                              descricaoSigno: signos[index]['descricao']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignoDetalhePage extends StatelessWidget {
  final String nomeSigno;
  final String descricaoSigno;

  const SignoDetalhePage({
    super.key,
    required this.nomeSigno,
    required this.descricaoSigno,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nomeSigno),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE1BEE7), Color(0xFFB39DDB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white.withOpacity(0.95),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      nomeSigno,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      descricaoSigno,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}