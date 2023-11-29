Feature: Editar Paciente
    As a cliente cadastrado com perfil
    I want to editar paciente da minha lista
    So that eu poderei utilizar eles nas consultas   

    Scenario: Editando Paciente com Sucesso
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    And Tenho um paciente na minha lista com nome "Ckaio"
    When Eu tento editar o paciente "Ckaio"
    And Eu corrijo o nome para "Caio" e salvo
    Then O sistema retorna uma mensagem de sucesso

    Scenario: Editando Paciente com Falha
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    And Tenho um paciente na minha lista com nome "Caio" e com idade 21
    When Eu tento editar o paciente "Caio"
    And Eu corrijo a idade para "abc" e salvo
    Then O sistema retorna uma mensagem de falha dizendo "Tipo da idade incompatível. Favor revisar os dados editados!"