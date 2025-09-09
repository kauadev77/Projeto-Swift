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
    var capacidadeMaxima: Int = 25
    private(set) var alunosInscritos: [String: Aluno] = [:]

    override init(nome: String, instrutor: Instrutor) {
        super.init(nome: nome, instrutor: instrutor)
    }

    func inscrever(aluno: Aluno) -> Bool {
        if alunosInscritos.count >= capacidadeMaxima {
            print("❌ Aula cheia! Capacidade máxima de \(capacidadeMaxima) atingida.")
            return false
        }

        if alunosInscritos[aluno.nome] != nil {
            print("⚠️ Aluno \(aluno.nome) já está inscrito.")
            return false
        }

        alunosInscritos[aluno.nome] = aluno
        print("✅ Aluno \(aluno.nome) inscrito com sucesso na aula \(nome).")
        return true
    }

    override func getDescricao() -> String {
        return "Aula Coletiva: \(nome), Instrutor: \(instrutor.nome), Vagas ocupadas: \(alunosInscritos.count)/\(capacidadeMaxima)"
    }
}
