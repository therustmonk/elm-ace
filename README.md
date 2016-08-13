# Ace in Elm

This package is for Ace component rendering. It is based on the [ace][] project.

[ace]: https://github.com/ajaxorg/ace

## Basic Usage

```elm
content : Html msg
content =
   Ace.toHtml
      [ Ace.theme "monokai"
      , Ace.mode "lua"
      , Ace.value ""
      ] []
```

Important: This library don't load any `ace` library and you should add it youself in the `index.html`.
