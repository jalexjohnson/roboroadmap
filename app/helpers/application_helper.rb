module ApplicationHelper

  def date_format(date)
    if !date.nil?
      return date.strftime("%Y %b %d — %I:%M %p")
    else
      return nil
    end
  end

  def active_navbar(boolean)
    if boolean
      return "<li class='active'>".html_safe
    else
      return "<li>".html_safe
    end
  end

end
