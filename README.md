# hs2json

Projeto desenvolvido em Haskell como parte dos estudos de Programação Funcional, seguindo o tutorial educacional da LambdaGeo.

O projeto explora a representação de dados JSON por meio de tipos algébricos, a construção de funções para manipulação e renderização desses dados, a formatação de documentos e a validação de propriedades utilizando testes automatizados.

## Objetivos

- Compreender os fundamentos da linguagem Haskell.
- Representar valores JSON utilizando tipos algébricos.
- Implementar funções para manipulação e renderização de dados.
- Construir estruturas para representação e formatação de documentos.
- Praticar testes automatizados com QuickCheck.
- Analisar a cobertura de testes com HPC.

## Tecnologias utilizadas

- **Haskell** — linguagem de programação funcional.
- **GHC** — compilador Haskell.
- **Cabal** — ferramenta de configuração, compilação e gerenciamento do projeto.
- **QuickCheck** — biblioteca para testes baseados em propriedades.
- **HPC** — ferramenta de análise de cobertura de código.

## Estrutura do projeto

```text
hs2json/
├── app/
│   └── Main.hs
├── src/
│   ├── SimpleJSON.hs
│   ├── PutJSON.hs
│   ├── PrettyJSON.hs
│   ├── Prettify.hs
│   └── QuickTestes.hs
├── test/
│   ├── Main.hs
│   └── Spec.hs
├── hs2json.cabal
├── cabal.project
└── README.md
```

**Principais módulos**

- `SimpleJSON.hs`: define o tipo `JValue`, utilizado para representar valores JSON, incluindo strings, números, valores booleanos, nulo, objetos e arrays.
- `PutJSON.hs`: contém funções relacionadas à renderização e à impressão de valores JSON.
- `Prettify.hs`: define a estrutura `Doc` e funções auxiliares para construir, combinar e formatar documentos.
- `PrettyJSON.hs`: integra a representação dos valores JSON com as operações de formatação de documentos.
- `QuickTestes.hs`: contém o algoritmo de ordenação `qsort` e propriedades utilizadas para verificar seu comportamento.
- `Spec.hs`: reúne a instância Arbitrary para JValue (com controle de profundidade recursiva) e a suíte de testes automatizados para os módulos Prettify e SimpleJSON.

## Pré-requisitos

Para compilar e executar o projeto, é necessário ter instalado:

- GHC (Glasgow Haskell Compiler).
- Cabal.

O ambiente utilizado no desenvolvimento foi configurado com GHC 9.10.3.

## Como executar

Abra o PowerShell e acesse o diretório onde você salvou o projeto.

Por exemplo, se você salvou o projeto em uma pasta chamada hs2json dentro de Documentos, utilize:

```powershell
cd "$HOME\Documents\hs2json"
```

Importante: substitua o caminho do exemplo pelo local onde você salvou o projeto. O comando cd deve apontar para a pasta raiz do projeto, onde está localizado o arquivo hs2json.cabal.

### Compilar o projeto

```powershell
cabal build
```

### Executar o programa principal

```powershell
cabal run
```

O comportamento apresentado será aquele definido atualmente em `app/Main.hs`.

## Testes automatizados

O projeto utiliza QuickCheck para verificar propriedades das funções implementadas.

Para executar a suíte de testes:

```powershell
cabal test
```

Entre as propriedades verificadas no módulo `Prettify`, estão:

- `prop_empty_id`: verifica a identidade de `empty` na combinação de documentos.
- `prop_char`: verifica a construção de documentos a partir de caracteres.
- `prop_text`: verifica a construção de documentos a partir de strings.
- `prop_line`: verifica a representação de quebra de linha.
- `prop_double`: verifica a conversão de números para documentos textuais.
- `prop_hcat`: verifica a combinação horizontal de documentos.
- `prop_punctuate'`: verifica a inserção de separadores entre documentos.
- `prop_compact_text`: verifica se a compactação de um documento criado com `text` recupera a string original.

Módulo `SimpleJSON / PrettyJSON`:

- `prop_getString`: valida a extração segura de strings pelo accessor getString.
-`prop_getBool`: valida a extração segura de booleanos pelo accessor getBool.
-`prop_isNull`: valida a checagem do valor JNull.
-`prop_getArray`: valida a extração segura de listas de JValue.
-`prop_string_enclosed`: garante que a renderização de strings em JSON mantenha o encapsulamento correto entre aspas.

O QuickCheck gera entradas de teste automaticamente para avaliar as propriedades definidas.

## Cobertura de testes

A cobertura de código é analisada com HPC. Para executar os testes com instrumentação de cobertura, utilize:

```powershell
cabal test --enable-coverage
```

Após a execução, o Cabal gera um relatório HTML no diretório de resultados de compilação. No ambiente utilizado, o arquivo principal foi gerado em:

```text
dist-newstyle/build/x86_64-windows/ghc-9.10.3/
hs2json-0.1.0.0/t/hs2json-test/hpc/vanilla/html/
hpc_index.html
```

O caminho exato pode variar conforme a versão do GHC, a plataforma e a configuração de compilação.

O relatório apresenta métricas de cobertura de definições, alternativas e expressões executadas durante os testes. Uma cobertura maior indica que mais partes do código foram exercitadas, mas não garante, isoladamente, a ausência de erros.

## Aprendizados

Durante o desenvolvimento, foram trabalhados conceitos como:

- Tipos algébricos e construtores de dados.
- Definição e composição de funções.
- Manipulação de listas e strings.
- Organização de código em módulos.
- Construção de documentos por meio de uma estrutura de dados própria.
- Testes baseados em propriedades.
- Análise da cobertura de código.

## Referência

Tutorial educacional LambdaGeo — Haskell:

https://lambdageo-edu.github.io/lambdageo-tutorials/haskell/01-tour-json-ambiente/

## Autor

- **Arthur Kodart**
- **Pacelle Henrique**

Projeto acadêmico desenvolvido no contexto dos estudos de Programação Funcional — UFMA.


