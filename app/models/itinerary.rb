# == Schema Information
#
# Table name: itineraries
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  city           :string
#  name           :string
#  price          :decimal(10, 2)
#  description    :text
#  total_capacity :integer
#  spots_sold     :integer
#  start_time     :datetime
#  end_time       :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  pic_url        :string
#  date           :date
#

class Itinerary < ActiveRecord::Base
  belongs_to :host, foreign_key: "user_id", class_name: "User"
  has_many :guests, through: :itinerary_users, source: :guest, class_name: "User"
  has_many :itinerary_users, inverse_of: :itineraries, dependent: :destroy
end
