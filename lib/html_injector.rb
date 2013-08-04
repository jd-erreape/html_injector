require_relative './html_injector/version'
require 'nokogiri'

class HtmlInjector
  attr_reader :html

  def initialize(html_source)
    @html = html_source.respond_to?(:load) ? html_source.load : html_source
  end

  def inject_code(options)
    tag = options[:tag]
    css_identifier = options[:css_identifier]
    code_to_inject = options[:code_to_inject]
    node_to_inject = options[:node_to_inject]

    doc = Nokogiri::HTML::DocumentFragment.parse(html)
    node_injected = Nokogiri::XML::Node.new(node_to_inject, doc)
    node_injected.content = code_to_inject
    node = doc.at_css("#{tag},#{css_identifier}")
    node.add_next_sibling(node_injected)
    doc.to_html
  end

  def inject_and_write_file(options, file_path)
    file = File.open(file_path, 'w')
    file.puts(inject_code(options))
    file.close
  end
end