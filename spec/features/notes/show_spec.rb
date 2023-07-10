# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show note spec', js: true do
  let(:user) { FactoryBot::create(:user) }
  let(:note) { FactoryBot::create(:note, user: user) }

  before do
    login_as(user, scope: :user)
    visit note_path(note)
  end

  it 'show notes link in menu' do
    expect(page).to have_link('All notes', href: notes_path)
  end

  it 'show sign out link in menu' do
    expect(page).to have_link('Sign out', href: destroy_user_session_path)
  end

  it 'show title' do
    expect(page).to have_content note.title
  end

  it 'show body' do
    expect(page).to have_content note.body.to_plain_text
  end

  it 'show data' do
    expect(page).to have_content I18n.l(note.updated_at, format: "%Y-%m-%d %H:%M:%S")
  end

  it 'show back to notes link' do
    expect(page).to have_link('Back to notes', href: notes_path)
  end

  it 'show edit this note link' do
    expect(page).to have_link('Edit this note', href: edit_note_path(note))
  end

  it 'show destroy this note link' do
    expect(page).to have_link('Destroy this note', href: note_path(note))
  end

  it 'link destroy this note text is right' do
    click_link('Destroy this note')
    text = page.driver.browser.switch_to.alert.text
    expect(text).to eq 'You want to remove this note?'
  end

  it 'link destroy this note is working' do
    click_link('Destroy this note')
    page.driver.browser.switch_to.alert.accept
    has_css?('.notification')
    expect(Note.count).to eq 0
  end

  it 'link destroy this note could be dismissed' do
    click_link('Destroy this note')
    page.driver.browser.switch_to.alert.dismiss
    expect(Note.count).to eq 1
  end
end
