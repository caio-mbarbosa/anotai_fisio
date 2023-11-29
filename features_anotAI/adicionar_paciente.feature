Feature: Adicionar Paciente
    As a cliente cadastrado com perfil
    I want to adicionar pacientes à minha lista
    So that eu poderei realizar consultas   

    Scenario: Adicionando Paciente com Sucesso
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    When Eu tento adicionar um paciente novo
    And Eu coloco os dados do paciente nos campos correspondentes
    Then O sistema retorna uma mensagem de sucesso

    Scenario: Adicionando Paciente com Falha
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    When Eu tento adicionar um paciente novo
    And Eu coloco os dados do paciente nos campos correspondentes
    And Eu coloco um valor Inválido com o tipo esperado
    Then O sistema retorna uma mensagem de erro do tipo "Valores Inválido paras o(s) campo(s) : idade"