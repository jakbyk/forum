# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New note spec', js: true do
  let(:user) { FactoryBot::create(:user) }
  let(:over_two_thousand_lorem) do
    lorem = Faker::Lorem.characters(number: 255)
    7.times do
      lorem += Faker::Lorem.characters(number: 255)
    end
    lorem[0..2001]
  end

  before do
    login_as(user, scope: :user)
    visit new_note_path
  end

  it 'show notes link in menu' do
    expect(page).to have_link('All notes', href: notes_path)
  end

  it 'show sign out link in menu' do
    expect(page).to have_link('Sign out', href: destroy_user_session_path)
  end

  it 'show header' do
    expect(page).to have_selector('h1', text: 'New note')
  end

  it 'show title input' do
    expect(page).to have_selector("input[name='note[title]'][type='text']")
  end

  it 'show body input' do
    expect(page).to have_selector("trix-editor[input='note_body_trix_input_note'][role='textbox']")
  end

  it 'show trix toolbar' do
    expect(page).to have_selector('trix-toolbar')
  end

  it 'show status select' do
    expect(page).to have_select('note[status]', options: %w[public private archived])
  end

  it 'show submit button' do
    expect(page).to have_selector('input[type="submit"][value="Save"]')
  end

  it 'show back to notes link' do
    expect(page).to have_link('Back to notes', href: notes_path)
  end

  it 'show title errors' do
    click_button 'Save'
    ["Title can't be blank", "Title is too short (minimum is 5 characters)"].each do |text|
      expect(page).to have_selector("div.column.is-12.flex-center p span.tag.is-danger", text: text)
    end
  end

  it 'show too long title error' do
    fill_in 'note[title]', with: over_two_thousand_lorem
    click_button 'Save'
    text = "Title is too long (maximum is 2000 characters)"
    expect(page).to have_selector("div.column.is-12.flex-center p span.tag.is-danger", text: text)
  end

  it 'show body errors' do
    click_button 'Save'
    ["Body can't be blank", "Body is too short (minimum is 10 characters)"].each do |text|
      expect(page).to have_selector("div.column.is-12.flex-center p span.tag.is-danger", text: text)
    end
  end

  it 'could save new note' do
    fill_in 'note[title]', with: Faker::Lorem.paragraph
    find('trix-editor').click.set(Faker::Lorem.sentence)
    click_button 'Save'
    has_css?('.notification')
    expect(Note.count).to eq 1
  end

  it 'create new note with proper author' do
    fill_in 'note[title]', with: Faker::Lorem.paragraph
    find('trix-editor').click.set(Faker::Lorem.sentence)
    click_button 'Save'
    has_css?('.notification')
    expect(Note.first.user).to eq user
  end

  it 'create new note with proper title' do
    title = Faker::Lorem.paragraph
    fill_in 'note[title]', with: title
    find('trix-editor').click.set(Faker::Lorem.sentence)
    click_button 'Save'
    has_css?('.notification')
    expect(Note.first.title).to eq title
  end

  it 'create new note with proper body' do
    body = Faker::Lorem.sentence
    fill_in 'note[title]', with: Faker::Lorem.paragraph
    find('trix-editor').click.set(body)
    click_button 'Save'
    has_css?('.notification')
    expect(Note.first.body.to_plain_text).to eq body
  end
end
