module ApplicationHelper
  def japanese_wday(date)
    wdays = %w[日 月 火 水 木 金 土]
    wdays[date.wday]
  end
end