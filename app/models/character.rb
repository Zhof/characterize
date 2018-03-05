class Character < ApplicationRecord
belongs_to :user

validates :full, inclusion: { in: [true, false] }
validates :full, exclusion: { in: [nil] }
validates :name, presence: true
validates :race, presence: true
validates :class, presence: true
validates :location, presence: true

validates :trait, presence: true, unless: :full?
validates :quirk, presence: true, unless: :full?

validates :alignment, presence: true, if: :full?
validates :background, presence: true, if: :full?

private

  def full?
    full
  end

end
