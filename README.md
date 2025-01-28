# Check Point Firewall Scripts Repository

Este repositório contém uma coleção de scripts úteis para automação, administração e troubleshooting de firewalls Check Point. Eles foram desenvolvidos para ajudar administradores de rede a gerenciar e operar ambientes Check Point de maneira mais eficiente.

## Conteúdo do Repositório

### 1. **First Time Wizard Setup**
   - **Descrição**: Automatização da criação de template e configurações iniciais do First Time Wizard na versão R81.20 *WIP*.
   - **Uso**: Criação de template de para configuração do First Time Wizard na versão R81.20 *WIP*.

### 1. **CPSIZEME 24H run**
   - **Descrição**: Automatiza a execução do comando "cpsizeme" durante 24 horas na versão R81.20.
   - **Uso**: Geração de um arquivo para dimensionamento da utilização de recursos da apliance onde for executado. Usado em assessment's juntamente com "doctorlog".
   - **Disclaimer**: PARA TESTE APENAS! CONFIGURADO ATUALMENTE PARA EXECUTAR O CPSIZEME DE 1 MINUTO - 60 SEGUNDOS

## Como Usar

1. Clone este repositório:
   ```bash
   git clone https://github.com/TrueFinal/ckp_scripts
   ```

2. Navegue até o script desejado:
   ```bash
   cd Scripts_CKP\R81.20\script_desejado
   ```

3. Leia o arquivo de documentação do script (quando aplicável) para instruções detalhadas de uso.

4. Execute o script conforme necessário.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e enviar pull requests para melhorias ou novos scripts.

## Aviso

- Teste sempre os scripts em um ambiente de homologação antes de utilizá-los em produção.
- Este repositório é fornecido "como está" e não nos responsabilizamos por quaisquer problemas decorrentes do uso.
- Considerar que esté repositório está em WIP (Work In Progress), os scripts disponíveis não estão finalizados.
