require 'rails_helper'

RSpec.describe AshevillePark, type: :model do
  describe "relationships" do
    it { should have_many(:trails) }
  end
end
