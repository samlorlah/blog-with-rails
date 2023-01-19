require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'John',
      photo: 'http://example-photo.com',
      post_counter: 0
    )
  end

  before { subject.save }

  context 'check for valid data' do
    it 'should accept a name' do
      subject.name = 'Alfred'
      expect(subject).to be_valid
    end
    it 'should accept a post_counter that is 0 and greater' do
      subject.post_counter = 20
      expect(subject).to be_valid
    end
  end

  context 'check for invalid data' do
    it 'should not accept empty name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should not accept post_counter below 0' do
      subject.post_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should not accept post_counter that is not numerical' do
      subject.post_counter = 'post'
      expect(subject).to_not be_valid
    end
  end
end