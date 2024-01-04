Feature: Editar Template
    As a cliente cadastrado com perfil
    I want to editar templates da minha lista
    So that eu poderei utilizar elas nas consultas   

    Scenario: Editando Template com Sucesso
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    And Tenho um template na minha lista com nome "Template1"
    When Eu tento editar o template "Template1"
    And Eu corrijo os nomes dos campos existentes e salvo
    Then O sistema retorna uma mensagem de sucesso

    Scenario: Editando Template com Falha
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    And Tenho um template na minha lista com nome "Template2"
    When Eu tento editar o paciente "Template"
    And Eu tento deletar todos os campos do template
    Then O sistema retorna uma mensagem de falha dizendo "O template precisa ter ao menos um campo! Caso deseje, remova o template na página anterior para excluir ele."