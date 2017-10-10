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
          ngram: {
            tokenizer: "ngram"
          }
        },
        tokenizer: {
          ngram: {
            type: 'ngram',
            min_gram: 2,
            max_gram: 10,
            token_chars: ['letter']
          }
        }
      }
    } do
    mappings dynamic: false do
      indexes :name, type: 'text', analyzer: 'english' do
        indexes :_typeahead, analyzer: 'ngram'
      end

      indexes :_types, index: :not_analyzed
      indexes :_set, index: :not_analyzed
    end
  end

  def as_indexed_json(options={})
    as_json({
      only: [ :name ],
      methods: [ :_types, :_set ]
    })
  end

  def _types
    types.pluck(:name)
  end

  def _set
    set.name
  end

  def transformed_side
    if transformed_id.present?
      MtgCard.find_by_multiverse_id(transformed_id)
    end
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
