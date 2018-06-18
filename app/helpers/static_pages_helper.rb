module StaticPagesHelper
  def full_title(page_title = "")
    base_title = "THT E-Learning"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
