require 'test/unit'
require_relative '../lib/html_injector'

class HtmlInjectorTest < Test::Unit::TestCase

  def test_source_loader
    loader = StaticSourceLoader.new
    injector = HtmlInjector.new(loader)
    assert_equal injector.html, loader.load
    loader = ModifiedSourceLoader.new
    injector = HtmlInjector.new(loader)
    assert_equal injector.html, loader.load
  end

  def test_string_loader
    injector = HtmlInjector.new('This is a string')
    assert_equal injector.html, 'This is a string'
  end

  def test_injection
    injector = HtmlInjector.new(StaticSourceLoader.new)
    injected_result = injector.inject_code(
        {
            tag: 'h1',
            css_identifier: 'h1-class',
            node_to_inject: 'h2',
            code_to_inject: 'This is a subtitle injected :)'
        },
    )
    parsed_result = Nokogiri::HTML::DocumentFragment.parse(injected_result)
    injected_node = parsed_result.at_css('h2')
    assert injected_node
    assert_equal injected_node.previous_element, parsed_result.at_css('h1')
    assert_equal injected_node.next_element, parsed_result.at_css('div')
  end

  def test_inject_and_replace
    File.delete('./inject_and_write_test.html') if File.exist?('./inject_and_write_test.html')
    injector = HtmlInjector.new(StaticSourceLoader.new)
    injector.inject_and_write_file(
        {
            tag: 'h1',
            css_identifier: 'h1-class',
            node_to_inject: 'h2',
            code_to_inject: 'This is a subtitle injected :)'
        },
        './inject_and_write_test.html'
    )
    assert File.exist?('./inject_and_write_test.html')
    file_parsed_content = Nokogiri::HTML::DocumentFragment.parse(File.read('./inject_and_write_test.html'))
    assert file_parsed_content .at_css('h2')
    File.delete('./inject_and_write_test.html')
  end

  class StaticSourceLoader
    def load
      <<-eos
        <body>
          <h1 class='h1-class'>This is a static HTML</h1>
          <div class='div-class'>Yeah! Static</div>
        </body>
      eos
    end
  end

  class ModifiedSourceLoader
    def load
      '<h1>This is modified!!!</h1>'
    end
  end
end