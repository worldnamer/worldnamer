class Sticky < ApplicationRecord
  after_initialize :default_values

  def default_values
    self.color ||= 'yellow lighten-3'
  end
end
