# FIXME: Should this be part of torture-server ?

Snippets.class_eval do
  def api(path)
    %(<a href="#{path}"><i class="fa fa-book" aria-hidden="true"></i> API docs</a>)
  end

  def img(_path)
    raise "Please replace `img` with `vite_image_tag`"
  end

  def code_tabs(name, **options)
    options = {collapse: :meths}.merge(options)

    nav_tabs do |tab|
      tab.(title: "Activity", active: true) do
        code(name, **options)
      end

      tab.(title: "Operation") do
        file = "operation/#{model[:file]}"

        code(name, **options.merge(file: file))
      end
    end # nav_tabs
  end
end
