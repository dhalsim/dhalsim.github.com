module Jekyll
  module Converters
    class Markdown
      class RedcarpetParser
        module WithPygments
          def block_code(code, lang)
            Jekyll::External.require_with_graceful_fail("pygments")
            lang = lang && lang.split.first || "text"
            add_code_tags(
              Pygments.highlight(code, :lexer => lang, :options => { :encoding => 'utf-8', :linenos => "inline" }),
              lang
            )
          end
        end
      end
    end
  end
end
