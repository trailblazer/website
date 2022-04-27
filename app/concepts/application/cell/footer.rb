module Application::Cell
  class Footer < Trailblazer::Cell
    def show
      render :footer
    end

    def layout
      model[:layout]
    end

    def page
      model[:page]
    end
  end
end
