Feature: Enviar Para Planilha
    As a cliente cadastrado com perfil
    I want to acessar a planilha com os dados gerados da conversa
    So that eu poderei analisar eles após as minhas consultas

    Scenario: Envio com sucesso para planilha
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    And Gravei um aúdio de uma consulta
    When Eu interajo com a aplicação para enviar o aúdio para ser processado na planilha 
    Then O sistema retorna uma mensagem de sucesso
    And Eu consigo acessar a minha planilha com os devidos campos preenchidos.

    Scenario: Envio com falha para planilha
    Given Estou na página inicial do aplicativo
    And Estou logado no sistema
    And Gravei um aúdio de uma consulta
    When Eu interajo com a aplicação para enviar o aúdio para ser processado na planilha 
    Then O sistema retorna uma mensagem de erro dizendo "Houve algum erro no processamento dos seus dados. Tente novamente."