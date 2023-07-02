require 'rails_helper'

RSpec.describe User, type: :model do
  it 'user with all proper values is valid' do
    user = described_class.new(email:    Faker::Internet.email,
                    password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    expect(user).to be_valid
  end

  it 'save user with all proper values' do
    user = described_class.new(email:    Faker::Internet.email,
                    password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    expect(user.save).to eq true
  end

  it 'don\'t provide error message when save user with all proper values' do
    user = described_class.new(email:    Faker::Internet.email,
                    password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    user.save
    expect(user.errors.messages).to eq({})
  end

  it 'user without email value is invalid' do
    user = described_class.new(password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    expect(user).to be_invalid
  end

  it 'don\'t save user without email value' do
    user = described_class.new(password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    expect(user.save).to eq false
  end

  it 'provide error message when save user without email value' do
    user = described_class.new(password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    user.save
    expect(user.errors.messages).to eq({ email: ["can't be blank"] })
  end

  it 'user without password value is invalid' do
    user = described_class.new(email:    Faker::Internet.email,
                    nickname: Faker::Name.name)
    expect(user).to be_invalid
  end

  it 'don\'t save user without password value' do
    user = described_class.new(email:    Faker::Internet.email,
                    nickname: Faker::Name.name)
    expect(user.save).to eq false
  end

  it 'provide error message when save user without password value' do
    user = described_class.new(email:    Faker::Internet.email,
                    nickname: Faker::Name.name)
    user.save
    expect(user.errors.messages).to eq({ password: ["can't be blank"] })
  end

  it 'user without nickname value is invalid' do
    user = described_class.new(email:    Faker::Internet.email,
                    password: Faker::Internet.password)
    expect(user).to be_invalid
  end

  it 'don\'t save user without nickname value' do
    user = described_class.new(email:    Faker::Internet.email,
                    password: Faker::Internet.password)
    expect(user.save).to eq false
  end

  it 'provide error message when save user without nickname value' do
    user = described_class.new(email:    Faker::Internet.email,
                    password: Faker::Internet.password)
    user.save
    expect(user.errors.messages).to eq({ nickname: ["can't be blank"] })
  end

  it 'user with wrong email value is invalid' do
    user = described_class.new(email:    'wrong',
                    password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    expect(user).to be_invalid
  end

  it 'don\'t save user with wrong email value' do
    user = described_class.new(email:    'wrong',
                    password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    expect(user.save).to eq false
  end

  it 'provide error message when save user with wrong email value' do
    user = described_class.new(email:    'wrong',
                    password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    user.save
    expect(user.errors.messages).to eq({ email: ["is invalid"] })
  end

  it 'user with wrong password value is invalid' do
    user = described_class.new(email:    Faker::Internet.email,
                    password: 'wrong',
                    nickname: Faker::Name.name)
    expect(user).to be_invalid
  end

  it 'don\'t save user with wrong password value' do
    user = described_class.new(email:    Faker::Internet.email,
                    password: 'wrong',
                    nickname: Faker::Name.name)
    expect(user.save).to eq false
  end

  it 'provide error message when save user with wrong password value' do
    user = described_class.new(email:    Faker::Internet.email,
                    password: 'wrong',
                    nickname: Faker::Name.name)
    user.save
    expect(user.errors.messages).to eq({ password: ["is too short (minimum is 6 characters)"] })
  end

  it 'user with duplicated email value is invalid' do
    email = Faker::Internet.email
    described_class.new(email:    email,
             password: Faker::Internet.password,
             nickname: Faker::Name.name).save
    user = described_class.new(email:    email,
                    password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    expect(user).to be_invalid
  end

  it 'don\'t save user with duplicated email value' do
    email = Faker::Internet.email
    described_class.new(email:    email,
             password: Faker::Internet.password,
             nickname: Faker::Name.name).save
    user = described_class.new(email:    email,
                    password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    expect(user.save).to eq false
  end

  it 'provide error message when save user with duplicated email value' do
    email = Faker::Internet.email
    described_class.new(email:    email,
             password: Faker::Internet.password,
             nickname: Faker::Name.name).save
    user = described_class.new(email:    email,
                    password: Faker::Internet.password,
                    nickname: Faker::Name.name)
    user.save
    expect(user.errors.messages).to eq({ email: ["has already been taken"] })
  end

  it 'user with duplicated nickname value is invalid' do
    nickname = Faker::Name.name
    described_class.new(email:    Faker::Internet.email,
             password: Faker::Internet.password,
             nickname: nickname).save
    user = described_class.new(email:    Faker::Internet.email,
                    password: Faker::Internet.password,
                    nickname: nickname)
    expect(user).to be_invalid
  end

  it 'don\'t save user with duplicated nickname value' do
    nickname = Faker::Name.name
    described_class.new(email:    Faker::Internet.email,
             password: Faker::Internet.password,
             nickname: nickname).save
    user = described_class.new(email:    Faker::Internet.email,
                    password: Faker::Internet.password,
                    nickname: nickname)
    expect(user.save).to eq false
  end

  it 'provide error message when save user with duplicated nickname value' do
    nickname = Faker::Name.name
    described_class.new(email:    Faker::Internet.email,
             password: Faker::Internet.password,
             nickname: nickname).save
    user = described_class.new(email:    Faker::Internet.email,
                    password: Faker::Internet.password,
                    nickname: nickname)
    user.save
    expect(user.errors.messages).to eq({ nickname: ["has already been taken"] })
  end
end
