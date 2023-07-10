require 'rails_helper'

RSpec.describe Doctor, type: :model do
  it { should validate_uniqueness_of(:last_name).scoped_to(:first_name, :faculty) }
end
