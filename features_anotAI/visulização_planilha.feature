Feature: Visualizar planilha resultado
    As a cliente cadastrado com perfil
    I want to visualizar os resultados do processamento da minha consulta
    So that eu poderei verificar a qualidade dos resultado e fazer alterações possíveis

    Scenario: Planilha sem erros no processamento
    Given Estou na página após a gravação do aúdio
    When Eu interajo com a aplicação para enviar o aúdio para processamento 
    And O sistema me dá um feedback indicando que está sendo processado
    Then Eu sou direcionado para uma visualização da planilha resultado
    And Eu verifico os resultados e vejo que está tudo de acordo

    Scenario: Planilha com erros e precisando de correção do profissional
    Given Estou na página após a gravação do aúdio
    When Eu interajo com a aplicação para enviar o aúdio para processamento 
    And O sistema me dá um feedback indicando que está sendo processado
    Then Eu sou direcionado para uma visualização da planilha resultado
    And Eu verifico os resultados e vejo que preciso corrigir
    And Eu corrijo os campos necessários na própria aplicação.
    