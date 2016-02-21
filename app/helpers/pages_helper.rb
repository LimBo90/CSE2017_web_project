module PagesHelper

  def get_results_page(position, results_per_page)
    if position % results_per_page == 0
      position / 10
    else
      (position / 10 + 1)
    end
  end

end
