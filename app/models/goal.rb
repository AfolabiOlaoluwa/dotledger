class Goal < ActiveRecord::Base
  GOAL_PERIODS = %w(Month Fortnight Week)

  FORTNIGHT_MULTIPLIER = Rational(13, 6)

  WEEK_MULTIPLIER = Rational(13, 3)

  belongs_to :category

  validates :category, presence: true

  validates :amount, presence: true

  validates :period, presence: true, inclusion: GOAL_PERIODS

  delegate :name, :type, to: :category, prefix: true

  def month_amount
    case period
    when 'Month'
      amount
    when 'Fortnight'
      (amount * FORTNIGHT_MULTIPLIER).to_f
    when 'Week'
      (amount * WEEK_MULTIPLIER).to_f
    end
  end
end
