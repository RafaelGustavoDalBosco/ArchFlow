# ArchFlow

ArchFlow é uma aplicação para **gestão de projetos e obras arquitetônicas**, projetada para **economizar tempo** e trazer mais organização e eficiência para profissionais da arquitetura e construção.

## 🚀 Funcionalidades Principais
- 📋 Gerenciamento de obras e projetos
- ✅ Controle de tarefas e etapas
- 🗂️ Gestão de documentos e arquivos do projeto
- ⏱️ Otimização de tempo com automações e alertas
- 📊 Relatórios e acompanhamento de progresso

## 🔧 Tecnologias Utilizadas
- 🖥️ Delphi (VCL).
- 🗄️ PostgreSQL 16. 
- 🌐 APIs (Google Drive, Google Email, Google Calendar).
- ☁️ Integrações com nuvem (AWS).
- 🗜️ DevExpress.

## 📦 Estrutura de Pastas
 - 📁 Source
    - 📁 Units
          - 📁 Common
          - 📁 Classes
          - 📁 Objects
               - 📁 Entity
          - 📁 System
               - 📁 Connection
               - 📁 Controller
               - 📁 Engine
               - 📁 Thread
    - 📁 Forms
       - 📁 System
            - 📁 Ancestral
            - 📁 Application
       - 📁Common
            - 📁 Cadastros
              - 📁 Root
            - 📁 CRUD
            - 📁 Frames
            - 📁 Custom
            - 📁 Selection
            - 📁 View
 - 📁 Resources
 - 📁 Install
 - 📁 Project

 ## 💡 ##
 - 📝 Padrão de comentários na aplicaçao
     - 💡 "// -> Exemplo de comentário "
  - 📝 Padrão de Summary em todos os métodos
     - 💡 Utilizar o summary nos métodos para identificação facilitada depois
        - 💡Functions 
             - 💡 Descritivo da função exemplificado o seu retorno
             - Exemplo: 
               // <summary>
               ///    Return CustomAttribute = [TFieldCurrency]
               /// </summary>
        - 💡Procedures
             - 💡Descritivo da procedure, com detalhamento se possível
  -  📝 Padrão de Params em todos os métodos    
     - 💡Utilizar o Param nos métodos para identificação facilitada depois.
     -  Exemplo:
          /// <param name="AProperty">
          ///   Define a propriedade da Classe que será inspecionada 
          /// </param>
  - Padrão de header das units:
     {********************************************************}
     { © Dal Bosco Systems Ltda. Todos os direitos reservados.}       
     {********************************************************}
 - Variavéis locais devem começar por regra com a letra L.
 - Variavéis globais devem começar por regra com as letras gv (global variable).
 - Condições de IF devem por regra iniciar a finalizar com parentêses if (condição) then.
 - Constantes devem começar com a primeira letra do tipo (Ex.: String = SField_Id, se caso for Inteiro = ITipoAlgo).