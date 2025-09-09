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
