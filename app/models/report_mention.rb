class ReportMention < ApplicationRecord
  belongs_to :mentioning
  belongs_to :mentioned
end
