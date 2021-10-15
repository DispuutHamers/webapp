module FormsHelper
  def label_classes
    "block text-sm font-medium text-gray-700"
  end

  def input_classes
    "shadow-sm focus:ring-hamers-red-500 focus:border-hamers-red-500 block w-full sm:text-sm border-gray-300 rounded-md"
  end

  def select_classes
    "selectpicker mt-2 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-hamers-red-500 focus:border-hamers-red-500 sm:text-sm"
  end

  def submit_classes
    "cursor-pointer inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-hamers-red-600 hover:bg-hamers-red-700 focus:outline-none focus:ring-2 focus:ring-hamers-red-500"
  end
end
