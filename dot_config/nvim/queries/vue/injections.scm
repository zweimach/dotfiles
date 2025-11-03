;; extends

((element
    (start_tag
      (tag_name) @_name
      (attribute
        (attribute_name) @_lang
        (quoted_attribute_value (attribute_value) @_json)))
    (#eq? @_name "i18n")
    (#eq? @_lang "lang")
    (#eq? @_json "json")
    (text) @json))

((element
    (start_tag
      (tag_name) @_name
      (attribute
        (attribute_name) @_lang
        (quoted_attribute_value (attribute_value) @_yaml)))
    (#eq? @_name "i18n")
    (#eq? @_lang "lang")
    (#eq? @_yaml "yaml")
    (text) @yaml))
