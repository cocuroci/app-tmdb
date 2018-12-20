# App TMDB

Aplicação que lista os próximos filmes que irão estreiar no cinema.

### Resumo

- [Requerimentos](#requerimentos)
- [Instalação](#instalação)
- [TODO](#todo)

## Requerimentos

- [API Key do TMDB](https://www.themoviedb.org)
- [Xcode 10](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12)
- iOS 12.0
- [Cocoapods](https://cocoapods.org/)

## Instalação

Rodar o comando abaixo no terminal para instalar as dependências:

```
pod install
```

Criar um arquivo em Constants com o nome de ApiKey.swift com a estrutura abaixo:

```
struct ApiKey {
private init() {}

static let token = "sua_api_key"
}

```

## TODO

- Cache para funcionamento offline.
- Opção para a atualizar a lista dos filmes.
- Pesquisar por filmes.
- Invalidar configurações depois de um tempo e atualiza-las.
