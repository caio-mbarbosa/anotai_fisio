Feature: Remover paciente cadastrado
    As a cliente cadastrado com perfil
    I want to remover paciente cadastrado na aplicação
    So that eu poderei me organizar com os clientes que tenho

    Scenario: Remoção de paciente com sucesso
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    When Eu interajo com a aplicação para ver meus paciente cadastrados e tento deletar um 
    And O sistema me pede uma autenticação por senha
    Then eu insiro a senha correta
    And recebo uma mensagem de "Paciente deletado com sucesso!"

    Scenario: Remoção de paciente com falha
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    When Eu interajo com a aplicação para ver meus paciente cadastrados e tento deletar um 
    And O sistema me pede uma autenticação por senha
    Then eu insiro a senha incorreta
    And recebo uma mensagem de "Senha incorreta!"
    