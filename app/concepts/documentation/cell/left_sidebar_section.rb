# frozen_string_literal: true

class Documentation::Cell::LeftSidebarSection < Cell::ViewModel
  delegate :id, to: :model

  def show
    render view: :left_sidebar_section, prefixes: ["app/concepts/documentation/view"]
  end

  def expanded?
    !!@options[:expanded]
  end

  def menu_class
    "collapse #{expanded? ? :show : ''}"
  end

  def icon_class
    expanded? ? "" : "collapsed"
  end

  property :title
  property :items
end
