# frozen_string_literal: true

# no doc
module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(renderer, space_after_headers: true)
    markdown.render(text)
  end

  def renderer
    options = { filter_html: true, safe_links_only: true, hard_wrap: true }
    @renderer ||= Redcarpet::Render::HTML.new(options)
  end
end
