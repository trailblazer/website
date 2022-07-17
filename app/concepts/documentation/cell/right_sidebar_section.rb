# frozen_string_literal: true

class Documentation::Cell::RightSidebarSection < Cell::ViewModel
  def show(index:)
    render view: :right_sidebar_section, prefixes: ["app/concepts/documentation/view"], locals: { index: index }
  end

  delegate :id, to: :model

  def chapter_title
    model.title
  end

  def menu_class
    "collapse #{expanded? ? :show : ''}"
  end

  def icon_class
    expanded? ? "" : "collapsed"
  end

  property :index
  property :items
end
