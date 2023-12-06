Feature: Login do profissional
    As a cliente
    I want to acessar a aplicação por meio de Login
    So that eu posos realizar as minhas consultas e armazenar meus pacientes

    Scenario: Login com usuário cadastrado na database
    Given Estou na página inicial do aplicativo e tenho cadastro já feito na plataforma
    When Eu insiro as minhas informações para Login
    Then A minha tela muda para a tela inicial da aplicação

    Scenario: Login com usuário não cadastrado na database
    Given Estou na página inicial do aplicativo e tenho cadastro já feito na plataforma
    When Eu insiro as minhas informações para Login
    Then Aparece um mensagem "login/senha errados ou usuário não cadastrado!"