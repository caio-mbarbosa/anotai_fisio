Feature: Remover template cadastrado
    As a cliente cadastrado com perfil
    I want to remover template cadastrado na aplicação
    So that eu poderei me organizar com os templates que tenho

    Scenario: Remoção de template com sucesso
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    When Eu interajo com a aplicação para ver meus templates cadastrados e tento deletar um 
    And O sistema me pede uma autenticação por senha
    Then eu insiro a senha correta
    And recebo uma mensagem de "Paciente deletado com sucesso!"

    Scenario: Remoção de template com falha
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    When Eu interajo com a aplicação para ver meus templates cadastrados e tento deletar um 
    And O sistema me pede uma autenticação por senha
    Then eu insiro a senha incorreta
    And recebo uma mensagem de "Senha incorreta!"
    