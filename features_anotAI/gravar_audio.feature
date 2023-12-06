Feature: Gravação de Aúdio
    As a cliente cadastrado com perfil
    I want to gravar as minhas consultas
    So that elas podem ser automaticamente processadas e disponibilizadas em uma planilha

    Scenario: Gravação com sucesso
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    When Eu interajo com a aplicação para gravar um aúdio  
    Then O sistema me pede para selecionar um paciente e um template
    And após isso a gravação começa
    And eu termino a Gravação

    Scenario: Gravação com aúdio gravado errado
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    When Eu interajo com a aplicação para gravar um aúdio  
    Then O sistema me pede para selecionar um paciente e um template
    And após isso a gravação começa
    And eu termino a Gravação
    And eu deleto o aúdio gravado errado e volto para a tela de gravação
    