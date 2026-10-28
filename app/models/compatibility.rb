class Compatibility
  Item = Struct.new(:title, :mine, :theirs, :score, keyword_init: true)

  def initialize(me, other, listing = nil)
    @mine = me&.preference
    @theirs = other&.preference
    @listing = listing
  end

  def available?
    @mine.present? && @theirs.present?
  end

  def items
    return [] unless available?

    @items ||= [
      budget_item,
      yes_no_item("Курение", :smoking),
      yes_no_item("Животные", :pets),
      scale_item("Чистота", :cleanliness, Preference::CLEANLINESS),
      schedule_item,
      scale_item("Гости", :guests, Preference::GUESTS),
      scale_item("Шум", :noise, Preference::NOISE),
      scale_item("Алкоголь", :alcohol, Preference::ALCOHOL),
      yes_no_item("Общие продукты", :shared_food)
    ].compact
  end

  def percent
    return 0 if items.empty?

    (items.sum(&:score) / items.size * 100).round
  end

  def matches_count
    items.count { |item| item.score == 1 }
  end

  private

  def yes_no_item(title, field)
    mine = @mine.public_send(field)
    theirs = @theirs.public_send(field)
    Item.new(title: title, mine: yes_no(mine), theirs: yes_no(theirs), score: mine == theirs ? 1.0 : 0.0)
  end

  def scale_item(title, field, scale)
    mine = @mine.public_send(field)
    theirs = @theirs.public_send(field)
    return if mine.blank? || theirs.blank?

    distance = (scale.index(mine).to_i - scale.index(theirs).to_i).abs
    score = { 0 => 1.0, 1 => 0.5 }.fetch(distance, 0.0)
    Item.new(title: title, mine: mine, theirs: theirs, score: score)
  end

  def schedule_item
    mine = @mine.schedule
    theirs = @theirs.schedule
    return if mine.blank? || theirs.blank?

    score = (mine == theirs || [ mine, theirs ].include?("свободный")) ? 1.0 : 0.0
    Item.new(title: "График", mine: mine, theirs: theirs, score: score)
  end

  def budget_item
    budget = @mine.budget
    rent = @listing&.rent
    return if budget.blank? || rent.blank?

    score = if rent <= budget then 1.0
            elsif rent <= budget * 1.2 then 0.5
            else 0.0
            end
    Item.new(title: "Бюджет", mine: "до #{budget} ₽", theirs: "#{rent} ₽", score: score)
  end

  def yes_no(value)
    value ? "да" : "нет"
  end
end
