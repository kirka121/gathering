require 'elasticsearch/model'
require 'mtg_helpers'

class MtgCard < ActiveRecord::Base
  include MtgHelpers
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :mtg_card_types
  has_many :mtg_types, through: :mtg_card_types
  belongs_to :mtg_set

  validates :name, presence: true
  validates :mtg_set_id,  presence: true

  alias_method :types, :mtg_types
  alias_method :set, :mtg_set

  settings index: {
      number_of_shards: 3,
      number_of_replicas: 1,
      analysis: {
        analyzer: {
          sortable: {
            tokenizer: "keyword",
            filter: [ "lowercase" ]
          }
        }
      }
    } do
    mappings dynamic: false do
      indexes :name, type: 'text', analyzer: 'english' do
        indexes :_typeahead, type: 'completion'
        indexes :_sort, analyzer: :sortable
      end

      indexes :description, type: 'text', analyzer: 'english'
      indexes :flavor, type: 'text', analyzer: 'english'
      indexes :image_url, index: :not_analyzed
      indexes :remote_image_url, index: :not_analyzed

      indexes :multiverse_id, type: 'keyword'
      indexes :mana_cost, type: 'keyword'

      indexes :converted_cost, type: 'integer'
      indexes :power, type: 'integer'
      indexes :toughness, type: 'integer'
      indexes :loyalty, type: 'integer'

      indexes :rarity, type: 'text', analyzer: 'english'
      indexes :colors, type: 'keyword'

      indexes :artist, type: 'text', analyzer: 'standard' do
        indexes :_sort, analyzer: :sortable
      end

      indexes :type_names, analyzer: :sortable
      indexes :set_name, analyzer: :sortable
      indexes :mana_cost_blank, type: 'integer'
      indexes :mana_cost_white, type: 'integer'
      indexes :mana_cost_blue, type: 'integer'
      indexes :mana_cost_red, type: 'integer'
      indexes :mana_cost_black, type: 'integer'
      indexes :mana_cost_green, type: 'integer'
      indexes :rarity_numeric, type: 'integer'
    end
  end

  def as_indexed_json(options={})
    as_json({
      only: [
        :name,
        :multiverse_id,
        :converted_cost,
        :power,
        :toughness,
        :loyalty,
        :colors,
        :artist,
        :mana_cost,
        :rarity
      ],
      methods: [
        :description,
        :flavor,
        :image_url,
        :remote_image_url,
        :type_names,
        :set_name,
        :mana_cost_blank,
        :mana_cost_white,
        :mana_cost_blue,
        :mana_cost_red,
        :mana_cost_black,
        :mana_cost_green,
        :rarity_numeric
      ]
    })
  end

  def description
    oracle_text
  end

  def flavor
    flavor_text
  end

  def remote_image_url
    gatherer_image_url
  end

  def transformed_side
    if transformed_id.present?
      MtgCard.find_by_multiverse_id(transformed_id)
    end
  end

  def type_names
    types.pluck(:name)
  end

  def set_name
    set.name
  end

  def rarity_numeric
    case rarity
      when 'Common'
        0
      when 'Uncommon'
        1
      when 'Rare'
        2
      when 'Mythic Rare'
        3
      when 'Timeshifted'
        4
      when 'Masterpiece'
        5
      else
        999
    end
  end

  def mana_cost_blank
    pattern = /\A{[(\d+)]}/i

    if pattern.match?(mana_cost)
      mana_cost.match(/\A{[(\d+)]}/i)[0].sub('{','').sub('}','').to_i
    else
      0
    end
  end

  def mana_cost_white
    mana_cost ? mana_cost.count('W') : 0
  end

  def mana_cost_blue
    mana_cost ? mana_cost.count('U') : 0
  end

  def mana_cost_red
    mana_cost ? mana_cost.count('R') : 0
  end

  def mana_cost_black
    mana_cost ? mana_cost.count('B') : 0
  end

  def mana_cost_green
    mana_cost ? mana_cost.count('G') : 0
  end

  def image_url
    prefix = using_asset_pipeline? ? asset_pipeline_prefix : "/images"
    "#{prefix}/#{set.folder_name}/#{multiverse_id}.jpg"
  end

  def set_symbol_url
    prefix = using_asset_pipeline? ? asset_pipeline_prefix : "/images"
    "#{prefix}/#{set.folder_name}/#{slugify(rarity)}_icon.jpg"
  end

end
