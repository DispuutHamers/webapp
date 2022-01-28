module FrontendHelper
  def button_classes
    "cursor-pointer inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-hamers-red-500"
  end

  def label_classes
    "block text-sm font-medium text-gray-700"
  end

  def input_classes
    "shadow-sm focus:ring-hamers-red-500 focus:border-hamers-red-500 block w-full sm:text-sm border-gray-300 rounded-md"
  end

  def select_classes
    "cursor-pointer selectpicker mt-2 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-hamers-red-500 focus:border-hamers-red-500 sm:text-sm"
  end

  def checkbox_classes
    "focus:ring-hamers-red-500 h-4 w-4 text-hamers-red-600 border-gray-300 rounded"
  end

  def submit_classes
    "cursor-pointer inline-flex items-center px-4 py-2 border border-transparent text-sm font-bold rounded-md shadow-sm text-white bg-hamers-red-500 hover:bg-hamers-red-600 focus:outline-none focus:ring-2 focus:ring-hamers-red-500"
  end

  def user_icon_stack_image(size = 6)
    "h-#{size} w-#{size} rounded-full bg-white ring-2 ring-white inline-block"
  end
end
