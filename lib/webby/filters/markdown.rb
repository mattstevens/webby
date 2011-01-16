
# Render text via markdown using the RDiscount library.
if try_require('rdiscount', 'rdiscount')

  Loquacious.configuration_for(:webby) {
    desc <<-__
      An array of extensions that will be passed to RDiscount when procesing
      content through the 'markdown' filter. See the RDiscount rdoc documentation for
      the list of available extensions.
    __
    markdown_extensions []
  }

  Webby::Filters.register :markdown do |input, cursor|
    exts = ::Webby.site.markdown_extensions | (cursor.page.markdown_extensions || [])
    exts = exts.map { |e| e.to_sym }
    RDiscount.new(input, *exts).to_html
  end

# Otherwise raise an error if the user tries to use markdown
else
  Webby::Filters.register :markdown do |input, cursor|
    raise Webby::Error, "'rdiscount' must be installed to use the markdown filter"
  end
end

# EOF
