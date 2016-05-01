class GildedRose

  def initialize(items)
    @items = items
    @items.map! { |item| ItemFactory.for(item) }
  end

  def update_quality()
    @items.each { |item| item.tick }
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class ItemFactory

  def self.for(item)
    case item.name
    when "Backstage passes to a TAFKAL80ETC concert"
      TAFKAL80ETC.new(item)
    when "Aged Brie"
      AgedBrie.new(item)
    when "Sulfuras, Hand of Ragnaros"
      Sulfuras.new(item)
    else
      Unknown.new(item)
    end
  end
end

class ItemDecorator
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def tick
  end
end

class AgedBrie < ItemDecorator
  def tick
    item.quality += 1 if item.quality < 50
    item.sell_in -= 1
    item.quality += 1 if item.sell_in < 0 && item.quality < 50
  end
end

class Sulfuras < ItemDecorator; end
class Unknown < ItemDecorator; end

class TAFKAL80ETC < ItemDecorator
  def tick
    item.quality += 1 if item.quality < 50
    item.quality += 1 if item.sell_in < 11 && item.quality < 50
    item.quality += 1 if item.sell_in < 6 && item.quality < 50
    item.sell_in -= 1
  end
end
