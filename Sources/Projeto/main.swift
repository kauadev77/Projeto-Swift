import Foundation

class Pessoa{
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

enum NivelAluno{
    case iniciante
    case intermediario
    case avancado
}

class Aluno:Pessoa{
    var matricula: String
    var nivel: NivelAluno
    var plano: Plano

    init(nome: String, email: String, matricula: String, plano: Plano) {
        super.init(nome: nome, email: email)

    }
    
}


// Parte 2 (Augusto)

class Plano{
    private(set) var nome: String
    init (nome: String) {
        self.nome = nome
    }
    func mensalidade() -> Double {
        return 0.0
    }
}    
class PlanoMensal: Plano{

    init(nome: String) {
        super.init(nome: "PlanoMensal")
    }
    override func calcularMensalidade() {
        return 120.0
    }
}