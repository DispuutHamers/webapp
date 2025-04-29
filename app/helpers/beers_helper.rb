module BeersHelper
  def rating_color(rating)
    case rating
    when 1..4
      "bg-red-100 text-red-800 dark:bg-red-600 dark:text-red-200"
    when 4..6
      "bg-yellow-100 text-yellow-800 dark:bg-yellow-500 dark:text-yellow-200"
    else
      "bg-green-100 text-green-800 dark:bg-green-600 dark:text-green-200"
    end
  end
end
