module BeersHelper
  def rating_color(rating)
    case rating
    when 1..4
      "bg-red-100 text-red-800"
    when 4..6
      "bg-yellow-100 text-yellow-800"
    else
      "bg-green-100 text-green-800"
    end
  end
end
