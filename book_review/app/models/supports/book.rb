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

  def avarge_rate reviews
    sum = 0
    if reviews.any?
      reviews.each do |review|
        sum += review.rate
      end
      sum.to_f / reviews.count
    else
      0
    end
  end
end
