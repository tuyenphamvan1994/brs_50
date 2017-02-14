class Supports::Book
  attr_reader :book

  def initialize book
    @book = book
  end

  def categories
    @categories = Category.all
  end

  def category name
    @category = Category.find_by name: name
  end
end
