require 'simplecov'
SimpleCov.start

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do

    let(:rose) do
      rose = GildedRose.new([item])
    end

    it "does not change the name" do
      item = Item.new("foo", 0, 0)
      rose = GildedRose.new([item])
      rose.update_quality
      expect(item.name).to eq "foo"
    end

    context "for Aged Brie" do
      context "when the quality is less than 50" do
        context "and the sell in is greater than 0" do
          let(:item) do
            Item.new("Aged Brie", 10, 0)
          end

          it "should increase quality by 1" do
            expect { rose.update_quality }
            .to change { item.quality }
            .from(0)
            .to(1)
          end

          it "should decrease the sell in by 1" do
            expect { rose.update_quality }
            .to change { item.sell_in }
            .from(10)
            .to(9)
          end
        end

        context "and the sell in is less than 0" do
          let(:item) do
            Item.new("Aged Brie", -5, 0)
          end

          it "should increase the quality by 2" do
            expect { rose.update_quality }
            .to change { item.quality }
            .from(0)
            .to(2)
          end

          it "should decrease the sell in by 1" do
            expect { rose.update_quality }
            .to change { item.sell_in }
            .from(-5)
            .to(-6)
          end
        end

        context "and the sell in is 0" do
          let(:item) do
            Item.new("Aged Brie", 0, 0)
          end

          it "should increase quality by 2" do
            expect { rose.update_quality }
            .to change { item.quality }
            .from(0)
            .to(2)
          end

          it "should decrease sell in by 1" do
            expect { rose.update_quality }
            .to change { item.sell_in }
            .from(0)
            .to(-1)
          end

        end
      end

      context "when the quality is greater than 50" do
        context "and the sell in is greater than 0" do
          let(:item) do
            Item.new("Aged Brie", 5, 51)
          end

          it "should not change the quality" do
            expect { rose.update_quality }
            .not_to change { item.quality }
          end

          it "should decrease sell in by 1" do
            expect { rose.update_quality }
            .to change { item.sell_in }
            .from(5)
            .to(4)
          end
        end

        context "and the sell in is less than 0" do
          let(:item) do
            Item.new("Aged Brie", -1, 51)
          end

          it "should not change the quality" do
            expect { rose.update_quality }
            .not_to change { item.quality }
          end
          it "should decrease sell in by 1" do
            expect { rose.update_quality }
            .to change { item.sell_in }
            .from(-1)
            .to(-2)
          end
        end
      end
    end

    context "for Backstage passes to a TAFKAL80ETC concert" do
      context "when the quality is less than 50" do
        context "and the sell in is less than 11" do
          let(:item) do
            Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)
          end

          it "should increase quality by 2" do
            expect { rose.update_quality }
            .to change { item.quality }
            .from(0)
            .to(2)
          end

          it "should decrease sell in by 1" do
            expect { rose.update_quality }
            .to change { item.sell_in }
            .from(10)
            .to(9)
          end
        end

        context "and the sell in is less than 6" do
          let(:item) do
            Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)
          end

          it "should increase quality by 3" do
            expect { rose.update_quality }
            .to change { item.quality }
            .from(0)
            .to(3)
          end
        end

        context "and the sell in is less than 0" do
          let(:item) do
            Item.new("Aged Brie", -5, 0)
          end

          it "should increase the quality by 2" do
            expect { rose.update_quality }
            .to change { item.quality }
            .from(0)
            .to(2)
          end

          it "should decrease the sell in by 1" do
            expect { rose.update_quality }
            .to change { item.sell_in }
            .from(-5)
            .to(-6)
          end
        end

        context "and the sell in is 0" do
          let(:item) do
            Item.new("Aged Brie", 0, 0)
          end

          it "should increase quality by 2" do
            expect { rose.update_quality }
            .to change { item.quality }
            .from(0)
            .to(2)
          end

          it "should decrease sell in by 1" do
            expect { rose.update_quality }
            .to change { item.sell_in }
            .from(0)
            .to(-1)
          end

        end
      end

      context "when the quality is greater than 50" do
        context "and the sell in is greater than 0" do
          let(:item) do
            Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 51)
          end

          it "should not change the quality" do
            expect { rose.update_quality }
            .not_to change { item.quality }
          end

          it "should decrease sell in by 1" do
            expect { rose.update_quality }
            .to change { item.sell_in }
            .from(5)
            .to(4)
          end
        end

        context "and the sell in is less than 0" do
          let(:item) do
            Item.new("Aged Brie", -1, 51)
          end

          it "should not change the quality" do
            expect { rose.update_quality }
            .not_to change { item.quality }
          end

          it "should decrease sell in by 1" do
            expect { rose.update_quality }
            .to change { item.sell_in }
            .from(-1)
            .to(-2)
          end
        end
      end
    end

    context "for Sulfuras, Hand of Ragnaros" do
      let(:item) do
        Item.new("Sulfuras, Hand of Ragnaros", 0, 0)
      end

      it "should not change quality" do
        expect { rose.update_quality }
        .not_to change { item.quality }
      end

      it "should not change sell in" do
        expect { rose.update_quality }
        .not_to change { item.sell_in }
      end
    end

    context "for ConjuredItems" do
      context "when the sell in is not less than 0" do
        it "should decrease quality by 2" do
          item = Item.new("ConjuredItem", 10, 10)
          rose = GildedRose.new([item])
          expect { rose.update_quality }
          .to change { item.quality }
          .from(10)
          .to(8)
        end
      end

      context "when the sell in is less than 0" do
        it "should decrease quality by 4" do
          item = Item.new("ConjuredItem", -1, 10)
          rose = GildedRose.new([item])
          expect { rose.update_quality }
          .to change { item.quality }
          .from(10)
          .to(6)
        end
      end

      it "should decrease the sell in by 1" do
        item = Item.new("ConjuredItem", 10, 10)
        rose = GildedRose.new([item])
        expect { rose.update_quality }
        .to change { item.sell_in }
        .from(10)
        .to(9)
      end
    end
  end
end
