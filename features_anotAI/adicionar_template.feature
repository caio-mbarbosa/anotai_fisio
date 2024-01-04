Feature: Adicionar Template
    As a cliente cadastrado com perfil
    I want to adicionar templates à minha lista
    So that eu poderei utilizar eles nas consultas   

    Scenario: Adicionando Template com Sucesso
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    When Eu tento adicionar um template novo
    And Eu coloco os dados de cada coluna nesse template
    Then O sistema retorna uma mensagem de sucesso

    Scenario: Adicionando Template com Falha
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    When Eu tento adicionar um paciente novo
    And Eu coloco os dados de cada coluna nesse template
    And Eu coloco um valor inválido para a coluna
    Then O sistema retorna uma mensagem de erro do tipo "Valores Inválido paras o(s) campo(s) : xxx . Não use caracteres do tipo: yyy"