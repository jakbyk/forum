require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:status) { %w(public private archived).sample }
  let(:user) { FactoryBot::create(:user) }
  let(:over_two_thousand_lorem) do
    lorem = Faker::Lorem.characters(number: 255)
    7.times do
      lorem += Faker::Lorem.characters(number: 255)
    end
    lorem[0..2001]
  end

  it 'note with all proper values is valid' do
    note = described_class.new(user:   user,
                               status: status,
                               body:   Faker::Lorem.paragraph,
                               title:  Faker::Lorem.sentence)
    expect(note).to be_valid
  end

  it 'save note with all proper values' do
    note = described_class.new(user:   user,
                               status: status,
                               body:   Faker::Lorem.paragraph,
                               title:  Faker::Lorem.sentence)
    expect(note.save).to eq true
  end

  it 'don\'t provide error message when save note with all proper values' do
    note = described_class.new(user:   user,
                               status: status,
                               body:   Faker::Lorem.paragraph,
                               title:  Faker::Lorem.sentence)
    note.save
    expect(note.errors.messages).to eq({})
  end

  it 'note without user value is invalid' do
    note = described_class.new(status: status,
                               body:   Faker::Lorem.paragraph,
                               title:  Faker::Lorem.sentence)
    expect(note).to be_invalid
  end

  it 'save note without user value' do
    note = described_class.new(status: status,
                               body:   Faker::Lorem.paragraph,
                               title:  Faker::Lorem.sentence)
    expect(note.save).to eq false
  end

  it 'provide error message when save note without user value' do
    note = described_class.new(status: status,
                               body:   Faker::Lorem.paragraph,
                               title:  Faker::Lorem.sentence)
    note.save
    expect(note.errors.messages).to eq({ user: ['must exist'] })
  end

  it 'note without status value is invalid' do
    note = described_class.new(user:  user,
                               body:  Faker::Lorem.paragraph,
                               title: Faker::Lorem.sentence)
    expect(note).to be_invalid
  end

  it 'save note without status value' do
    note = described_class.new(user:  user,
                               body:  Faker::Lorem.paragraph,
                               title: Faker::Lorem.sentence)
    expect(note.save).to eq false
  end

  it 'provide error message when save note without status value' do
    note = described_class.new(user:  user,
                               body:  Faker::Lorem.paragraph,
                               title: Faker::Lorem.sentence)
    note.save
    expect(note.errors.messages).to eq({ status: ['is not included in the list'] })
  end

  it 'note without body value is invalid' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  Faker::Lorem.sentence)
    expect(note).to be_invalid
  end

  it 'save note without body value' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  Faker::Lorem.sentence)
    expect(note.save).to eq false
  end

  it 'provide error message when save note without body value' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  Faker::Lorem.sentence)
    note.save
    expect(note.errors.messages).to eq({ body: ["can't be blank", "is too short (minimum is 10 characters)"] })
  end

  it 'note without title value is invalid' do
    note = described_class.new(user:   user,
                               status: status,
                               body:   Faker::Lorem.paragraph)
    expect(note).to be_invalid
  end

  it 'save note without title value' do
    note = described_class.new(user:   user,
                               status: status,
                               body:   Faker::Lorem.paragraph)
    expect(note.save).to eq false
  end

  it 'provide error message when save note without title value' do
    note = described_class.new(user:   user,
                               status: status,
                               body:   Faker::Lorem.paragraph)
    note.save
    expect(note.errors.messages).to eq({ title: ["can't be blank", "is too short (minimum is 5 characters)", "is too long (maximum is 2000 characters)"] })
  end

  it 'note with wrong status value is invalid' do
    note = described_class.new(user:   user,
                               status: 'wrong',
                               title:  Faker::Lorem.sentence,
                               body:   Faker::Lorem.paragraph)
    expect(note).to be_invalid
  end

  it 'save note with wrong status value' do
    note = described_class.new(user:   user,
                               status: 'wrong',
                               title:  Faker::Lorem.sentence,
                               body:   Faker::Lorem.paragraph)
    expect(note.save).to eq false
  end

  it 'provide error message when save note with wrong status value' do
    note = described_class.new(user:   user,
                               status: 'wrong',
                               title:  Faker::Lorem.sentence,
                               body:   Faker::Lorem.paragraph)
    note.save
    expect(note.errors.messages).to eq({ status: ["is not included in the list"] })
  end

  it 'note with too short title value is invalid' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  's',
                               body:   Faker::Lorem.paragraph)
    expect(note).to be_invalid
  end

  it 'save note with too short title value' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  's',
                               body:   Faker::Lorem.paragraph)
    expect(note.save).to eq false
  end

  it 'provide error message when save note with too short title value' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  's',
                               body:   Faker::Lorem.paragraph)
    note.save
    expect(note.errors.messages).to eq({ title: ["is too short (minimum is 5 characters)"] })
  end

  it 'note with too long title value is invalid' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  over_two_thousand_lorem,
                               body:   Faker::Lorem.paragraph)
    expect(note).to be_invalid
  end

  it 'save note with too long title value' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  over_two_thousand_lorem,
                               body:   Faker::Lorem.paragraph)
    expect(note.save).to eq false
  end

  it 'provide error message when save note with too long title value' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  over_two_thousand_lorem,
                               body:   Faker::Lorem.paragraph)
    note.save
    expect(note.errors.messages).to eq({ title: ["is too long (maximum is 2000 characters)"] })
  end

  it 'note with too short body value is invalid' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  Faker::Lorem.sentence,
                               body:   'b')
    expect(note).to be_invalid
  end

  it 'save note with too short body value' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  Faker::Lorem.sentence,
                               body:   'b')
    expect(note.save).to eq false
  end

  it 'provide error message when save note with too short body value' do
    note = described_class.new(user:   user,
                               status: status,
                               title:  Faker::Lorem.sentence,
                               body:   'b')
    note.save
    expect(note.errors.messages).to eq({ body: ["is too short (minimum is 10 characters)"] })
  end
end
