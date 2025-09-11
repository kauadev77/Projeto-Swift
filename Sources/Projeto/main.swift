let academia = Academia(nome: "Academia POO 360")

let planoMensal = PlanoMensal()
let planoAnual = PlanoAnual()

let instrutor1 = Instrutor(nome: "Luiz Augusto", email: "augusto@acadpoo.com", especialidade: "Musculação")
let instrutor2 = Instrutor(nome: "Kauã de Jesus", email: "kaua@acadpoo.com", especialidade: "Boxe")
academia.adicionarInstrutor(instrutor1)
academia.adicionarInstrutor(instrutor2)

let aluno1 = academia.matricularAluno(nome: "Manuel Gomes", email: "canetazul@gmail.com", matricula: "A001", plano: planoMensal)
let aluno2 = academia.matricularAluno(nome: "Lebron James da Silva", email: "goatnba@gmail.com", matricula: "A002", plano: planoAnual)

let aulaPersonal = AulaPersonal(nome: "Treino de Hipertrofia", instrutor: instrutor1, aluno: aluno1)
let aulaColetiva = AulaColetiva(nome: "Boxe em Grupo", instrutor: instrutor2, capacidadeMaxima: 3)
academia.adicionarAula(aulaPersonal)
academia.adicionarAula(aulaColetiva)

_ = aulaColetiva.inscrever(aluno: aluno1)
_ = aulaColetiva.inscrever(aluno: aluno2)

let aluno3 = academia.matricularAluno(nome: "Carl Johnson", email: "cjay@gmail.com", matricula: "A003", plano: planoMensal)
_ = aulaColetiva.inscrever(aluno: aluno3)

let aluno4 = academia.matricularAluno(nome: "Davy Jones", email: "ondascerebrais@gmail.com", matricula: "A004", plano: planoMensal)
_ = aulaColetiva.inscrever(aluno: aluno4)

academia.listarAulas()
academia.listarAlunos()

let aulas: [Aula] = [aulaPersonal, aulaColetiva]
for aula in aulas {
    print(aula.getDescricao())
}

let pessoas: [Pessoa] = [aluno1, instrutor1]
for pessoa in pessoas {
    print(pessoa.getDescricao())
}

extension Academia {
    func gerarRelatorio() -> (totalAlunos: Int, totalInstrutores: Int, totalAulas: Int) {
        return (
            totalAlunos: alunosMatriculados.count,
            totalInstrutores: instrutoresContratados.count,
            totalAulas: aulasDisponiveis.count
        )
    }
}

let relatorio = academia.gerarRelatorio()
print("Relatório da Academia:")
print("Total de Alunos: \(relatorio.totalAlunos)")
print("Total de Instrutores: \(relatorio.totalInstrutores)")
print("Total de Aulas: \(relatorio.totalAulas)")
