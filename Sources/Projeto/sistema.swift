import Foundation 

// ---------------------------
// Parte 1 - Pessoas
// ---------------------------

class Pessoa {
    var nome: String
    var email: String

    init(nome: String, email: String) {
        self.nome = nome
        self.email = email
    }

    func getDescricao() -> String {
        return "Seu nome: \(nome), e Email: \(email)"
    }
}

enum NivelAluno {
    case iniciante
    case intermediario
    case avancado
}

class Aluno: Pessoa {
    var matricula: String
    var nivel: NivelAluno = .iniciante   // valor padrão
    private(set) var plano: Plano        // restrito para alteração

    init(nome: String, email: String, matricula: String, plano: Plano) {
        self.matricula = matricula
        self.plano = plano
        super.init(nome: nome, email: email)
    }

    override func getDescricao() -> String {
        return super.getDescricao() +
               ", Matrícula: \(matricula), Nível: \(nivel), Plano: \(plano.nome) - Mensalidade: R$ \(plano.calcularMensalidade())"
    }
}

class Instrutor: Pessoa {
    var especialidade: String

    init(nome: String, email: String, especialidade: String) {
        self.especialidade = especialidade
        super.init(nome: nome, email: email)
    }

    override func getDescricao() -> String {
        return super.getDescricao() + ", Especialidade: \(especialidade)"
    }
}

// ---------------------------
// Parte 2 - Planos
// ---------------------------

class Plano {
    private(set) var nome: String
    
    init(nome: String) {
        self.nome = nome
    }

    func calcularMensalidade() -> Double {
        return 0.0
    }
}    

class PlanoMensal: Plano {
    override init(nome: String = "Plano Mensal") {
        super.init(nome: nome)
    }

    override func calcularMensalidade() -> Double {
        return 120.0
    }
}

class PlanoAnual: Plano {
    override init(nome: String = "Plano Anual (Promocional)") {
        super.init(nome: nome)
    }

    override func calcularMensalidade() -> Double {
        return (1440 * 0.8) / 12
    }
}

//--------- DIA 2------------//

// ---- Pt1 ----

protocol Manutencao {
    var nomeItem: String { get }
    var dataUltimaManutencao: String { get }

    func realizarManutencao() -> Bool
}
// ---- Pt2 ----
class Aparelho: Manutencao {
    var nomeItem: String
    private(set) var dataUltimaManutencao: String
    
    init(nomeItem: String) {
    self.nomeItem = nomeItem
    self.dataUltimaManutencao = "Nenhuma"
}

    func realizarManutencao() -> Bool {
        print("realizando manutenção...")
        dataUltimaManutencao = "20/08/2025"
        print("manutenção realizada. Ultima verificação em : \(dataUltimaManutencao)")
        return true
    }
}
// ---- Pt3 ----

class Aula {
    var nome: String
    var instrutor: Instrutor

    init(nome: String, instrutor: Instrutor) {
        self.nome = nome
        self.instrutor = instrutor
    }

    func getDescricao() -> String {
        return "Aula: \(nome), Instrutor: \(instrutor.nome)"
    }
}

class AulaPersonal: Aula {
    var aluno: Aluno

    init(nome: String, instrutor: Instrutor, aluno: Aluno) {
        self.aluno = aluno
        super.init(nome: nome, instrutor: instrutor)
    }

    override func getDescricao() -> String {
        return "Aula Particular: \(nome), Instrutor: \(instrutor.nome), Aluno: \(aluno.nome)"
    }
}

class AulaColetiva: Aula {
    var capacidadeMaxima: Int
    private(set) var alunosInscritos: [String: Aluno] = [:]

    init(nome: String, instrutor: Instrutor, capacidadeMaxima: Int) {
        self.capacidadeMaxima = capacidadeMaxima
        super.init(nome: nome, instrutor: instrutor)
    }

    func inscrever(aluno: Aluno) -> Bool {
        if alunosInscritos.count >= capacidadeMaxima {
            print("❌ Aula cheia! Capacidade máxima de \(capacidadeMaxima) atingida.")
            return false
        }

        if alunosInscritos[aluno.matricula] != nil {
            print("⚠️ Aluno \(aluno.nome) já está inscrito.")
            return false
        }

        alunosInscritos[aluno.matricula] = aluno
        print("✅ Aluno \(aluno.nome) inscrito com sucesso na aula \(nome).")
        return true
    }

    override func getDescricao() -> String {
        return "Aula Coletiva: \(nome), Instrutor: \(instrutor.nome), Vagas ocupadas: \(alunosInscritos.count)/\(capacidadeMaxima)"
    }
}


//--------- DIA 3------------//


class Academia{
    let nome: String
    private(set) var alunosMatriculados: [String: Aluno] = [:]
    private(set) var instrutoresContratados: [String: Instrutor] = [:]
    private(set) var aparelhos: [Aparelho] = []
    private(set) var aulasDisponiveis: [Aula] = []


    init(nome: String){
        self.nome = nome
    }

    func adicionarAparelho(_ aparelho: Aparelho){
        aparelhos.append(aparelho)
    }

    func adicionarAula(_ aula: Aula){
        aulasDisponiveis.append(aula)
    }

    func adicionarInstrutor(_ instrutor: Instrutor){
        instrutoresContratados[instrutor.email] = instrutor
    }
// 1º método
    func matricularAluno(_ aluno: Aluno){
        if alunosMatriculados[aluno.matricula] != nil {
            print("Erro: Aluno com matrícula \(aluno.matricula) já existe.")
        } else {
            alunosMatriculados[aluno.matricula] = aluno
            print("Sucesso: Aluno \(aluno.nome) matriculado.")
        }
    }
        
// 2º metodo
    func matricularAluno(nome: String, email: String, matricula: String, plano: Plano) -> Aluno{
        let novoAluno = Aluno(nome: nome, email: email, matricula: matricula, plano: plano)
        matricularAluno(novoAluno)
        return novoAluno
    }


    func buscarAluno(porMatricula matricula: String) -> Aluno?{
        return alunosMatriculados[matricula]
    }

    func listarAlunos() {
        print("--- Lista de Alunos Matriculados ---")
        let lista = alunosMatriculados.values.sorted { $0.nome < $1.nome }
        if lista.isEmpty {
            print("Nenhum aluno matriculado.")
        } else {
            for aluno in lista {
                print(aluno.getDescricao())
            }
        }
        print("------------------------------------")
    }

    func listarAulas() {
        print("--- Lista de Aulas Disponíveis ---")
        if aulasDisponiveis.isEmpty {
            print("Nenhuma aula cadastrada.")
        } else {
            for aula in aulasDisponiveis {
                print(aula.getDescricao())
            }
        }
        print("----------------------------------")
    }
}